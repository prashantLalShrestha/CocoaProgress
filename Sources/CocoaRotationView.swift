//
//  CocoaRotationView.swift
//  CocoaProgress
//
//  Created by Prashant Shrestha on 5/19/20.
//  Copyright © 2020 Inficare. All rights reserved.
//

import UIKit
import UserNotifications

class CocoaRotationView: CocoaProgressBaseView {
    
    private let rotationAnimationKeyPath = "transform.rotation"
    private let rotationAnimationKey = "rotation"
    
    private let radialLayer = CAShapeLayer()
    
    private var logoView: UIImageView = {
        let view = UIImageView()
        view.image = CocoaProgress.config.logoImage
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func configureView() {
        super.configureView()
 
        radialLayer.makeAnimationsPersistent()
        
        let config = CocoaProgress.config
        
        let condition = config.width == config.height
        assert(condition, "RotationView width and height should always be equal!")
        
        self.addSubview(logoView)
        
        let x = logoView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let y = logoView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let w = logoView.widthAnchor.constraint(equalToConstant: config.logoImageSize.width)
        let h = logoView.heightAnchor.constraint(equalToConstant: config.logoImageSize.height)
        
        NSLayoutConstraint.activate([x, y, w, h])
        
        self.setupRadialLayer()
        self.animateRadialLayerInfinitely()
    }
    
    private func setupRadialLayer() {
        let config = CocoaProgress.config
        let radialWidth = config.circleRadius * 2
        
        let condition = radialWidth <= (config.width - config.circleBorderWidth)
        assert(condition,
               "Rotating circle width \(radialWidth) should be less than the HUD width \(config.width)!")
        
        
        let circlePath = UIBezierPath(
            arcCenter: .zero,
            radius: radialWidth/2, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0),
            clockwise: true)
        
        radialLayer.path = circlePath.cgPath
        radialLayer.fillColor = UIColor.clear.cgColor
        radialLayer.lineCap = CAShapeLayerLineCap.round
        radialLayer.strokeColor = config.circleBorderColor.cgColor
        radialLayer.lineWidth = config.circleBorderWidth
        radialLayer.strokeEnd = config.circleArcPercentage
        radialLayer.frame.origin = CGPoint(x: config.width/2, y: config.width/2)
        layer.addSublayer(radialLayer)
        
        /// Setting radialLayer animations persistent on application pause/resume
        radialLayer.makeAnimationsPersistent()
    }
    
    private func animateRadialLayerInfinitely() {
        let rotation = CABasicAnimation(keyPath: rotationAnimationKeyPath)
        rotation.byValue = 2 * Double.pi
        rotation.duration = CocoaProgress.config.circleAnimationDuration
        rotation.repeatCount = Float.infinity
        
        radialLayer.add(rotation, forKey: rotationAnimationKey)
    }
    
    override func stopAnimation() {
        self.radialLayer.removeAnimation(forKey: rotationAnimationKey)
    }
}
