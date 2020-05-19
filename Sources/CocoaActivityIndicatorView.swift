//
//  CocoaActivityIndicatorView.swift
//  CocoaProgress
//
//  Created by Prashant Shrestha on 5/19/20.
//  Copyright © 2020 Inficare. All rights reserved.
//

import UIKit

class CocoaActivityIndicatorView: CocoaProgressBaseView {

    let activityIndicatorView: UIActivityIndicatorView = {
        let config = CocoaProgress.config
        let activity = UIActivityIndicatorView(style: config.activityIndicatorStyle)
        activity.color = config.activityIndicatorColor
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    override func configureView() {
        super.configureView()
        
        activityIndicatorView.startAnimating()
        addSubview(activityIndicatorView)
        
        let x = activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let y = activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        NSLayoutConstraint.activate([x, y])
    }
    
    override func stopAnimation() {
        self.activityIndicatorView.stopAnimating()
    }
}
