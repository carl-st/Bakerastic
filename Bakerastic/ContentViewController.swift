//
//  ContentViewController.swift
//  Bakerastic
//
//  Created by Karol Stępień on 27.02.2017.
//  Copyright © 2017 carlst. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var viewModel: ContentViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.primaryColor
        ContentServices.sharedInstance.getContent(completion: {_, _ -> Void in})
        
        self.viewModel = ContentViewModel(reload: { () -> Void in
            let halfSizeOfView = 25.0
            let insetSize = self.view.bounds.insetBy(dx: CGFloat(Int(2 * halfSizeOfView)), dy: CGFloat(Int(2 * halfSizeOfView))).size

            if let viewModel = self.viewModel {

                for starImage in (viewModel.content.first?.images)! {
                    let pointX = CGFloat(UInt(arc4random() %
                            UInt32(UInt(insetSize.width))))
                    let pointY = CGFloat(UInt(arc4random() %
                            UInt32(UInt(insetSize.height))))
                    let newView = DraggableView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                    newView.frame = CGRect(x: pointX, y: pointY, width: 50, height: 50)
                    
                    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                    imageView.contentMode = .scaleAspectFit
                    ContentServices.sharedInstance.getImage(url: URL(string: starImage.imageUrl)!, completion: {
                        success, data in
                        if success {
                            let image = data as! UIImage
                            imageView.image = self.maskImage(image: image, withMask: #imageLiteral(resourceName: "Star"))
                        } else {
                            print(data)
                        }
                    })
                    
                    newView.addSubview(imageView)
                    self.view.addSubview(newView)
                }
            }


            print("images reloaded")
        }, persistence: PersistenceManager.sharedInstance)


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

