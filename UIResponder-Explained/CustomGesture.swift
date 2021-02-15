//
//  CustomGesture.swift
//  UIResponder-Explained
//
//  Created by Hossam on 3/19/20.
//  Copyright © 2020 Hossam. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass
class MarkGesture : UIGestureRecognizer{
    enum StrokeState {
        case notStarted
        case intialPoint
        case downRight
        case upTop
    }
    
    var strokeState : StrokeState = .notStarted
    var startPoint = CGPoint.zero
    var trackedTouch : UITouch?
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        guard self.trackedTouch == nil else {  touches.filter{$0 != trackedTouch}.forEach{self.ignore($0, for: event)} ; return}
        guard touches.count == 1 else {self.state = .failed ; return}
        self.trackedTouch = touches.first
        self.strokeState  = .intialPoint
        self.startPoint = touches.first!.location(in: self.view)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        if touches.first != self.trackedTouch {
            self.state = .failed
        }
        let newPoint = touches.first?.location(in: self.view)
        let previousPoint = touches.first?.previousLocation(in: self.view)
        if self.strokeState == .intialPoint {
            if  newPoint!.x >= startPoint.x && newPoint!.y >= startPoint.y {
                
                self.strokeState = .downRight
            }
            else {
                self.state = .failed
            }
        }
        else if self.strokeState == .downRight {
            if newPoint!.x >= previousPoint!.x  {
                if newPoint!.y <= previousPoint!.y{
                self.strokeState = .upTop
                    
                    
                }
            }else {
                
                self.state = .failed
            }
        }
        else if self.strokeState == .upTop {
            if newPoint!.x < previousPoint!.x || newPoint!.y > previousPoint!.y {
                self.state = .failed
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        if touches.first == trackedTouch {
          

            let newPoint = touches.first!.previousLocation(in: self.view)
            if self.strokeState == .upTop  && self.state == .possible && newPoint.y < startPoint.y{
                
                self.state = .recognized
            }
            
        }else {
            self.state = .failed
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
       super.touchesCancelled(touches, with: event)
       self.startPoint = CGPoint.zero
       self.strokeState = .notStarted
       self.trackedTouch = nil
       self.state = .cancelled
    }
     
    override func reset() {
       super.reset()
       self.startPoint = CGPoint.zero
       self.strokeState = .notStarted
       self.trackedTouch = nil
     
    }
}
