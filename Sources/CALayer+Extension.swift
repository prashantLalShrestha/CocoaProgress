//
//  CALayer+Extension.swift
//  CocoaProgress
//
//  Created by Prashant Shrestha on 5/19/20.
//  Copyright © 2020 Inficare. All rights reserved.
//

import UIKit

struct AssociatedKeys {
    public static var animationPersistence = 999
}

public extension CALayer {
    
    var isAnimationsPaused: Bool {
        return speed == 0.0
    }
    
    func pauseAnimations() {
        if !isAnimationsPaused {
            let currentTime = CACurrentMediaTime()
            let pausedTime = convertTime(currentTime, from: nil)
            speed = 0.0
            timeOffset = pausedTime
        }
    }
    
    func resumeAnimations() {
        let pausedTime = timeOffset
        speed = 1.0
        timeOffset = 0.0
        beginTime = 0.0
        let currentTime = CACurrentMediaTime()
        let timeSincePause = convertTime(currentTime, from: nil) - pausedTime
        beginTime = timeSincePause
    }
    
    func makeAnimationsPersistent() {
        var object = objc_getAssociatedObject(self, &AssociatedKeys.animationPersistence)
        if object == nil {
            object = CocoaProgressLayerAnimationPersistence(with: self)
            let nonatomic = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            objc_setAssociatedObject(self, &AssociatedKeys.animationPersistence, object, nonatomic)
        }
    }
}
