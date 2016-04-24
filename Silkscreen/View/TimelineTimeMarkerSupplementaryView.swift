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
    
    private let textLabel = UILabel()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubview(textLabel)
       
        textLabel.frame = bounds
        textLabel.text = "0:00"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}