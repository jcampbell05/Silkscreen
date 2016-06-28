//
//  AssetGroupsViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/29/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit
import Photos

// - UI for autenticiation
// - UI for albums and assets
// - Swiftify the Cell API (Look online how others did it)
// - Rename AssetSourceGroupsPickerViewController
// - Multi Asset Picker
class AssetGroupsViewController: UICollectionViewController {
    
    let assetImportSource: AssetImportSource
    
    init(assetImportSource: AssetImportSource) {
        
        self.assetImportSource = assetImportSource
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
        super.init(collectionViewLayout: flowLayout)
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerClass(AssetGroupCollectionViewCell.self, forCellWithReuseIdentifier: String(AssetGroupCollectionViewCell))
        collectionView?.alwaysBounceVertical = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return assetImportSource.numberOfAlbums
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection: Int) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(AssetGroupCollectionViewCell), forIndexPath: indexPath) as! AssetGroupCollectionViewCell
        let thumbnail = assetImportSource.thumbnailForAsset(forIndexPath: indexPath)
        
        cell.imageView.image = thumbnail
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let thumbnail = assetImportSource.thumbnailForAsset(forIndexPath: indexPath)
        
        return thumbnail.size
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let viewController = AssetGroupViewController()
        viewController.useLayoutToLayoutNavigationTransitions = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}