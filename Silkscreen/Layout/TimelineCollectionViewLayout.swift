//
//  TimelineCollectionViewLayout.swift
//  Silkscreen
//
//  Created by James Campbell on 4/23/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class TimelineCollectionViewLayout: UICollectionViewLayout {
 
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: CGFloat.max, height: 10)
    }
}