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
    
    override func prepare() {
        
        let numberOfSections = collectionView?.numberOfSections ?? 0

        #if os(iOS) || os(watchOS) || os(tvOS)
        for (section, _) in (0..<numberOfSections).enumerated() {
            
            let itemCount = collectionView?.numberOfItems(inSection: section) ?? 0
            let indexPath = NSIndexPath(item: 0, section: section)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
        }
        #endif
        
        // - Iterate rows and create a pile for each section
    }
    
    // - Method for Cell
}
