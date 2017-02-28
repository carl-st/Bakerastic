//
//  DraggableView.swift
//  Bakerastic
//
//  Created by Karol Stępień on 28.02.2017.
//  Copyright © 2017 carlst. All rights reserved.
//

import UIKit

class DraggableView: UIView {

    var lastLocation: CGPoint = CGPoint(x:0, y:0)
//    @IBOutlet weak var imageView: UIImageView!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(detectPan(recognizer:)))
        self.gestureRecognizers = [panRecognizer]
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func detectPan(recognizer:UIPanGestureRecognizer) {
        let translation  = recognizer.translation(in: self.superview!)
        self.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        // Promote the touched view
        self.superview?.bringSubview(toFront: self)

        // Remember original location
        lastLocation = self.center
    }

}
