//
//  AssetGroupsCollectionViewLayout.swift
//  Silkscreen
//
//  Created by James Campbell on 6/27/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

// - Implement Pile Layout With Bigger Images
class AssetGroupsCollectionViewLayout: UICollectionViewLayout {
    
    override func prepareLayout() {
        
        let numberOfSections = collectionView?.numberOfSections() ?? 0

        for (section, _) in (0..<numberOfSections).enumerate() {
            
            let itemCount = collectionView?.numberOfItemsInSection(section) ?? 0
            let indexPath = NSIndexPath(forItem: 0, inSection: section)
          
            let attributes = layoutAttributesForItemAtIndexPath(indexPath)
        }
        
        // - Iterate rows and create a pile for each section
    }
}