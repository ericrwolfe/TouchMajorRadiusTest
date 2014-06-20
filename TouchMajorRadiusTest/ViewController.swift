//
//  ViewController.swift
//  TouchMajorRadiusTest
//
//  Created by Eric Wolfe on 6/20/14.
//  Copyright (c) 2014 Eric Wolfe. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    var currentTouches: Dictionary<UITouch, UIView> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.multipleTouchEnabled = true
    }
}

extension ViewController {
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        super.touchesBegan(touches, withEvent: event)
        
        for touch in touches.allObjects as UITouch[] {
            createTouchView(touch)
        }
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
        super.touchesMoved(touches, withEvent: event)
        
        for touch in touches.allObjects as UITouch[] {
            updateTouchView(touch)
        }
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        super.touchesEnded(touches, withEvent: event)
        
        for touch in touches.allObjects as UITouch[] {
            removeTouchView(touch)
        }
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        super.touchesCancelled(touches, withEvent: event)
        
        for touch in touches.allObjects as UITouch[] {
            removeTouchView(touch)
        }
    }
}

extension ViewController {
    func createTouchView(touch: UITouch) {
        var touchView = UIView()
        
        touchView.backgroundColor = UIColor.redColor()
        touchView.layer.borderColor = UIColor.blackColor().CGColor
        touchView.userInteractionEnabled = false
        
        view.addSubview(touchView)
        
        currentTouches[touch] = touchView
        
        updateTouchView(touch)
    }
    
    func updateTouchView(touch: UITouch) {
        if let touchView = currentTouches[touch] {
            touchView.center = touch.locationInView(view)
            touchView.bounds = CGRect(x: 0, y: 0, width: touch.majorRadius * 2, height: touch.majorRadius * 2)
            touchView.layer.cornerRadius = touch.majorRadius
            touchView.layer.borderWidth = touch.majorRadiusTolerance
        }
    }
    
    func removeTouchView(touch: UITouch) {
        var touchView = currentTouches[touch]
        touchView?.removeFromSuperview()
    }
}

