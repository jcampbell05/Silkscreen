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
    
    private let textLabel = UILabel()
    
    var time: NSTimeInterval = 0 {
        didSet {
            textLabel.text = "\(time)"
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubview(textLabel)
       
        textLabel.frame = bounds
        textLabel.text = "0:00"
        textLabel.textColor = UIColor.lightGrayColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        
        super.applyLayoutAttributes(layoutAttributes)
        
        if let layoutAttributes = layoutAttributes as? TimelineCollectionViewLayoutAttributes {
            time = layoutAttributes.time
        }
    }
}
