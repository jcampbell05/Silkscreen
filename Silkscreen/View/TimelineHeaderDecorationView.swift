//
//  TimelineHeaderDecorationView.swift
//  Silkscreen
//
//  Created by James Campbell on 4/23/16.
//  Copyright © 2016 SK. All rights reserved.
//

#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
#endif

class TimelineHeaderDecorationView: UICollectionReusableView {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
      
      #if os(iOS) || os(watchOS) || os(tvOS)
        backgroundColor = UIColor.darkGrayColor()
      #endif
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
