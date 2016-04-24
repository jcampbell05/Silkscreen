//
//  TimelineTimeMarkerSupplementaryView.swift
//  Silkscreen
//
//  Created by James Campbell on 4/24/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit
import Darwin

class TimelineTimeMarkerSupplementaryView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        backgroundColor = UIColor(colorLiteralRed: Float(arc4random_uniform(255)) / 255.0, green:  Float(arc4random_uniform(255)) / 255.0, blue:  Float(arc4random_uniform(255)) / 255.0, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}