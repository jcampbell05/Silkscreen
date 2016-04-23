//
//  TimelineCollectionViewLayout.swift
//  Silkscreen
//
//  Created by James Campbell on 4/23/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class TimelineCollectionViewLayout: UICollectionViewLayout {
    
    override init() {
        super.init()
        
        // Do time indicators at the top.
       // registerClass(<#T##viewClass: AnyClass?##AnyClass?#>, forDecorationViewOfKind: <#T##String#>)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: CGFloat.max, height: 10)
    }
}