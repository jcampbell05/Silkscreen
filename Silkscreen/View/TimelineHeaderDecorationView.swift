//
//  TimelineHeaderDecorationView.swift
//  Silkscreen
//
//  Created by James Campbell on 4/23/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class TimelineHeaderDecorationView: UICollectionReusableView {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        backgroundColor = UIColor.grayColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}