//
//  TimelineTrackHeaderSupplementaryView.swift
//  Silkscreen
//
//  Created by James Campbell on 4/25/16.
//  Copyright © 2016 SK. All rights reserved.
//

#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
#endif

class TimelineTrackHeaderSupplementaryView: UICollectionReusableView {
    
    private let textLabel = UILabel()
    
    var trackID: Int = 0 {
        didSet {
            textLabel.text = "Track \(trackID)"
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubview(textLabel)
        
        backgroundColor = UIColor.grayColor()
        
        textLabel.frame = bounds
        textLabel.textAlignment = .Center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
