//
//  AssetGroupsCollectionViewLayout.swift
//  Silkscreen
//
//  Created by James Campbell on 6/27/16.
//  Copyright © 2016 SK. All rights reserved.
//

#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
#endif

// - Implement Pile Layout With Bigger Images
// - Profit :)
class AssetGroupsCollectionViewLayout: UICollectionViewLayout {
    
    override func prepareLayout() {
        
        let numberOfSections = collectionView?.numberOfSections() ?? 0

        for (section, _) in (0..<numberOfSections).enumerate() {
            
            let itemCount = collectionView?.numberOfItemsInSection(section) ?? 0
            let indexPath = NSIndexPath(forItem: 0, inSection: section)
          
            let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        }
        
        // - Iterate rows and create a pile for each section
    }
    
    // - Method for Cell
}
