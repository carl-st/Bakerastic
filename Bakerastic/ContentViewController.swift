//
//  ContentViewController.swift
//  Bakerastic
//
//  Created by Karol Stępień on 27.02.2017.
//  Copyright © 2017 carlst. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate  {

    var viewModel: ContentViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.primaryColor
        
        ContentServices.sharedInstance.getContent(completion: {_, _ -> Void in})
        
        self.viewModel = ContentViewModel(reload: { () -> Void in
            let halfSizeOfView = 25.0
            let insetSize = self.view.bounds.insetBy(dx: CGFloat(Int(2 * halfSizeOfView)), dy: CGFloat(Int(2 * halfSizeOfView))).size

            if let viewModel = self.viewModel {

                for kitten in (viewModel.content.first?.images)! {
                    let pointX = CGFloat(UInt(arc4random() %
                            UInt32(UInt(insetSize.width))))
                    let pointY = CGFloat(UInt(arc4random() %
                            UInt32(UInt(insetSize.height))))
                    let newView = DraggableView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                    newView.frame = CGRect(x: pointX, y: pointY, width: 50, height: 50)
                    
                    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//                    imageView.contentMode = .scaleAspectFit
                    ContentServices.sharedInstance.getImage(url: URL(string: kitten.imageUrl)!, completion: {
                        success, data in
                        if success {
                            let image = data as! UIImage
                            imageView.image = self.maskImage(image: image, withMask: #imageLiteral(resourceName: "Star"))
                        } else {
                            print(data)
                        }
                    })
                    newView.content = kitten
                    newView.addSubview(imageView)
                    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(recognizer:)))
                    tapGestureRecognizer.delegate = self
                    newView.gestureRecognizers?.append(tapGestureRecognizer)
                    self.view.addSubview(newView)
                }
            }


            print("images reloaded")
        }, persistence: PersistenceManager.sharedInstance)


    }
    
    func handleTap(recognizer: UIGestureRecognizer) {
        let tappedView = recognizer.view as! DraggableView
        if let info = tappedView.content.info {
            let alert = UIAlertController(title: "Alert", message: "Description: \(info.descriptionText)\n\nTimestamp: \(info.timestamp)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    func maskImage(image: UIImage, withMask maskImage: UIImage) -> UIImage {
        
        let maskRef = maskImage.cgImage
        
        let mask = CGImage(
            maskWidth: maskRef!.width,
            height: maskRef!.height,
            bitsPerComponent: maskRef!.bitsPerComponent,
            bitsPerPixel: maskRef!.bitsPerPixel,
            bytesPerRow: maskRef!.bytesPerRow,
            provider: maskRef!.dataProvider!,
            decode: nil,
            shouldInterpolate: false)
        
        let masked = image.cgImage!.masking(mask!)
        let maskedImage = UIImage(cgImage: masked!)
        
        return maskedImage
        
    }


}

