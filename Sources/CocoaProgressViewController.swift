//
//  CocoaProgressViewController.swift
//  CocoaProgress
//
//  Created by Prashant Shrestha on 5/19/20.
//  Copyright © 2020 Inficare. All rights reserved.
//

import UIKit

class CocoaProgressViewController: UIViewController {

    var background: CocoaProgressBackgroundView = {
        let bg = CocoaProgressBackgroundView()
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    var indicator: CocoaActivityIndicatorView = {
        let indicator = CocoaActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    var rotationView: CocoaRotationView = {
        let rotationView = CocoaRotationView()
        rotationView.translatesAutoresizingMaskIntoConstraints = false
        return rotationView
    }()
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(background)
        
        
        let x = background.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let y = background.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let w = background.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0)
        let h = background.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0)
        
        NSLayoutConstraint.activate([x, y, w, h])
        
        self.addProgressHudView()
    }
    
    private func addProgressHudView() {
        switch CocoaProgress.config.hudType {
        case .activityIndicator:
            background.addSubview(indicator)
            self.setupConstraint(indicator)
        case .radial:
            background.addSubview(rotationView)
            self.setupConstraint(rotationView)
        }
    }
    
    private func setupConstraint(_ view: CocoaProgressBaseView) {
        let config = CocoaProgress.config
        
        let x = view.centerXAnchor.constraint(equalTo: background.centerXAnchor)
        let y = view.centerYAnchor.constraint(equalTo: background.centerYAnchor, constant: -config.hudYOffset)
        let w = view.widthAnchor.constraint(equalToConstant: config.width)
        let h = view.heightAnchor.constraint(equalToConstant: config.height)
        
        NSLayoutConstraint.activate([x, y, w, h])
    }
    
    public func stopAnimations() {
        switch CocoaProgress.config.hudType {
        case .activityIndicator:
            self.indicator.stopAnimation()
        case .radial:
            self.rotationView.stopAnimation()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        super.loadViewIfNeeded()
    }
    
    internal override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let rootViewController = UIApplication.shared.delegate?.window??.rootViewController {
            return rootViewController.supportedInterfaceOrientations
        } else {
            return UIInterfaceOrientationMask.portrait
        }
    }
    
    internal override var preferredStatusBarStyle: UIStatusBarStyle {
        if let rootViewController = UIApplication.shared.delegate?.window??.rootViewController {
            return rootViewController.preferredStatusBarStyle
        } else {
            return CocoaProgress.config.preferredStatusBarStyle
        }
    }
    
    internal override var prefersStatusBarHidden: Bool {
        if let rootViewController = UIApplication.shared.delegate?.window??.rootViewController {
            return rootViewController.prefersStatusBarHidden
        } else {
            return CocoaProgress.config.prefersStatusBarHidden
        }
    }
    
    internal override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        if let rootViewController = UIApplication.shared.delegate?.window??.rootViewController {
            return rootViewController.preferredStatusBarUpdateAnimation
        } else {
            return .none
        }
    }
    
    internal override var shouldAutorotate: Bool {
        if let rootViewController = UIApplication.shared.delegate?.window??.rootViewController {
            return rootViewController.shouldAutorotate
        } else {
            return false
        }
    }
}
