//
//  TimelineViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/22/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class TimelineViewController: UICollectionViewController {
    
    let layout = TimelineCollectionViewLayout()
    
    init() {
        super.init(collectionViewLayout: layout)
        
        collectionView?.registerClass(TimelineTimeMarkerSupplementaryView.self, forSupplementaryViewOfKind: TimelineElementKindTimeMarker, withReuseIdentifier: String(TimelineTimeMarkerSupplementaryView.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}