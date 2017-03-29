//
//  ContentViewController.swift
//  Bakerastic
//
//  Created by Karol Stępień on 27.02.2017.
//  Copyright © 2017 carlst. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet private weak var kittenView: UIView!
    private var viewModel: ContentViewModel?
    private let kittenViewSize: CGFloat = 80

    override func viewDidLoad() {
        super.viewDidLoad()
        self.kittenView.backgroundColor = Colors.primaryColor

        ContentServices.sharedInstance.getContent(completion: { _, _ -> Void in })

        self.viewModel = ContentViewModel(reload: { () -> Void in
            let halfSizeOfView = 25.0
            let insetSize = self.kittenView.bounds.insetBy(dx: CGFloat(Int(2 * halfSizeOfView)), dy: CGFloat(Int(2 * halfSizeOfView))).size

            if let viewModel = self.viewModel {

                if let images = viewModel.content.first?.images {
                    for kitten in images {
                        let pointX = CGFloat(UInt(arc4random() %
                                UInt32(UInt(insetSize.width))))
                        let pointY = CGFloat(UInt(arc4random() %
                                UInt32(UInt(insetSize.height))))

                        let newView = DraggableView(frame: CGRect(x: pointX, y: pointY, width: self.kittenViewSize, height: self.kittenViewSize))

                        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.kittenViewSize, height: self.kittenViewSize))
                        imageView.alpha = 0.0

                        guard let url = URL(string: kitten.imageUrl) else { return }
                        ContentServices.sharedInstance.getImage(url: url, completion: {
                            success, data in
                            if success {
                                if let image = data as? UIImage {
                                    imageView.image = self.maskImage(image: image, withMask: #imageLiteral(resourceName:"Star"))
                                    imageView.layer.shadowColor = UIColor.black.cgColor
                                    imageView.layer.shadowOpacity = 1
                                    imageView.layer.shadowOffset = CGSize.zero
                                    imageView.layer.shadowRadius = 7
                                    
                                    UIView.animate(withDuration: 1.0, animations: {
                                        imageView.alpha = 1.0
                                    })
                                }
                            } else {
                                print(data)
                            }
                        })
                        newView.content = kitten
                        newView.addSubview(imageView)
                        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(recognizer:)))
                        tapGestureRecognizer.delegate = self
                        newView.gestureRecognizers?.append(tapGestureRecognizer)
                        self.kittenView.addSubview(newView)
                    }
                }
            }
        }, persistence: PersistenceManager.sharedInstance)
    }

    dynamic private func handleTap(recognizer: UIGestureRecognizer) {
        guard let tappedView = recognizer.view as? DraggableView else { return }
        if let info = tappedView.content.info {
            let alert = UIAlertController(title: "Image details", message: "Description: \(info.descriptionText)\n\nRaw Timestamp: \(info.timestamp)\n\nFormatted Timestamp: \(info.timestamp.string(with: .longTimeAndDate))", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    private func maskImage(image: UIImage, withMask maskImage: UIImage) -> UIImage {

        guard let maskRef = maskImage.cgImage, let dataProvider = maskRef.dataProvider, let mask = CGImage(
                maskWidth: maskRef.width,
                height: maskRef.height,
                bitsPerComponent: maskRef.bitsPerComponent,
                bitsPerPixel: maskRef.bitsPerPixel,
                bytesPerRow: maskRef.bytesPerRow,
                provider: dataProvider,
                decode: nil,
                shouldInterpolate: false) else { return UIImage() }

        if let masked = image.cgImage?.masking(mask) {
            let maskedImage = UIImage(cgImage: masked)
            return maskedImage
        }

        return UIImage()
    }


}

