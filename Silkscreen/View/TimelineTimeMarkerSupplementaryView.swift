//
//  TimelineTimeMarkerSupplementaryView.swift
//  Silkscreen
//
//  Created by James Campbell on 4/24/16.
//  Copyright © 2016 SK. All rights reserved.
//

#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
#endif
import Darwin

class TimelineTimeMarkerSupplementaryView: UICollectionReusableView {
    
    fileprivate let textLabel = UILabel()
    
    var time: TimeInterval = 0 {
        didSet {
            textLabel.text = "\(time)"
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubview(textLabel)
       
        textLabel.frame = bounds
        textLabel.text = "0:00"
        textLabel.textColor = UIColor.lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        
        super.apply(layoutAttributes)
        
        if let layoutAttributes = layoutAttributes as? TimelineCollectionViewLayoutAttributes {
            time = layoutAttributes.time
        }
    }
}
