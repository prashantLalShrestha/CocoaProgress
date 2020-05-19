//
//  CocoaProgressBackgroundView.swift
//  CocoaProgress
//
//  Created by Prashant Shrestha on 5/19/20.
//  Copyright © 2020 Inficare. All rights reserved.
//

import UIKit

class CocoaProgressBackgroundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        backgroundColor = CocoaProgress.config.backgroundColor
    }
}
