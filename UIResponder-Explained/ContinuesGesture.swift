//
//  ContinuesGesture.swift
//  UIResponder-Explained
//
//  Created by Hossam on 3/19/20.
//  Copyright © 2020 Hossam. All rights reserved.
//

import UIKit
class ShakeMe : UIGestureRecognizer {
    enum TrackState {
        case notStarted
        case started
        case firtsLineRightToLeft
        case secondLineLeftToRight
        case thirdLineRightToLeft
        case forthLineLast
    }
    var touche : UITouch?
    var trackState = TrackState.notStarted
    var inY : ClosedRange<CGFloat> = 0...0
    var startPoint = CGFloat.zero
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        print(touches.count)
        if touche == nil {
            self.touche = touches.first
            self.trackState = .firtsLineRightToLeft
            self.inY = (touches.first!.location(in: self.view).y) ... (touches.first?.location(in: self.view).y)!+40
            self.startPoint = touches.first!.location(in: self.view).x
        }else {
            if touches.first != self.touche {
                self.ignore(touches.first!, for: event)
            }
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        if touches.first != self.touche {
            self.state = .failed
        }else {
            let previous = touches.first!.precisePreviousLocation(in: self.view)
            let current = touches.first!.preciseLocation(in: self.view)
            print(current.x , self.startPoint)
            if current.x > touches.first!.previousLocation(in: self.view).x {
                switch self.trackState {
                case .firtsLineRightToLeft:
                    print("first")
                    self.state = .changed
                    self.trackState = .secondLineLeftToRight
                case .thirdLineRightToLeft:
                    print("third")
                    self.state = .changed
                    self.trackState = .forthLineLast
                    
                    
                default:
                    if abs(startPoint - current.x) > 120 || !self.inY.contains(current.y) {
                        print("FA")
                        self.state = .failed
                    }
                }
            }else {
                               switch self.trackState {
                               case .secondLineLeftToRight:
                                print("second")
                                   self.state = .changed
                                   self.trackState = .thirdLineRightToLeft
                               case .forthLineLast:
                                   self.state = .changed
                                   if self.startPoint > current.x{
                                    self.state = .ended
                                    
                                   }
                                print("fourth")
                               default:
                                if abs(startPoint - current.x) > 120 || !self.inY.contains(current.y) {
                                    print("FA")
                                    self.state = .failed
                                }
                               }
                           
            }
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        print("ENDEDXXXX")
        reset()
    }
   
    override func reset() {
        super.reset()
        self.touche = nil
        self.trackState = .notStarted
    }
    
}
