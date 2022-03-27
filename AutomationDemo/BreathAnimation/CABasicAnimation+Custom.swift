//
//  CABasicAnimation+Custom.swift
//  AutomationDemo
//
//  Created by Iraniya Naynesh on 27/03/22.
//

import Foundation
import QuartzCore

extension CABasicAnimation {
    
    enum Custom {
        
        static let duration = 3.85
        static let timingFunction: CAMediaTimingFunction = .init(controlPoints: 0.43, 0.00, 0.57, 1.00)
        static let animationCount: Float = 2.0
        
        enum ScaleDownAndReverse {
            static let key = "ScaleDownAndReverse"
            static var animation: CABasicAnimation {
                let transformScale = CABasicAnimation(keyPath: "transform.scale")
                transformScale.fromValue = 1.0
                transformScale.toValue = 0.25
                transformScale.fillMode = CAMediaTimingFillMode.forwards
                transformScale.duration = CABasicAnimation.Custom.duration
                transformScale.repeatCount = CABasicAnimation.Custom.animationCount
                transformScale.timingFunction = CABasicAnimation.Custom.timingFunction
                transformScale.isRemovedOnCompletion = false
                transformScale.autoreverses = true
                return transformScale
            }
        }
        
        enum RotateAndReverse {
            static let key = "RotateAndReverse"
            static var animation: CABasicAnimation {
                let transformRotate = CABasicAnimation(keyPath: "transform.rotation")
                transformRotate.fromValue = 0.0
                transformRotate.toValue = -CGFloat.pi * 0.75
                transformRotate.duration = CABasicAnimation.Custom.duration
                transformRotate.repeatCount = CABasicAnimation.Custom.animationCount
                transformRotate.timingFunction = CABasicAnimation.Custom.timingFunction
                transformRotate.autoreverses = true
                return transformRotate
            }
        }
        
        enum MoveAndReverse {
            static let key = "MoveAndReverse"
            static func animation(from fromValue: CGPoint, to toValue: CGPoint) -> CABasicAnimation {
                let movePosition = CABasicAnimation(keyPath: "position")
                movePosition.fromValue = fromValue
                movePosition.toValue = toValue
                movePosition.duration = CABasicAnimation.Custom.duration
                movePosition.repeatCount = CABasicAnimation.Custom.animationCount
                movePosition.timingFunction = CABasicAnimation.Custom.timingFunction
                movePosition.autoreverses = true
                return movePosition
            }
        }
    }
}

