//
//  PhotoLibraryAssetImportSource.swift
//  Silkscreen
//
//  Created by James Campbell on 4/29/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation
import Photos

// - Better way of asking for permission
// - Implement better way of dispensing assets
// - Better way of dispensing albums
class PhotoLibraryAssetImportSource: AssetImportSource {
    
    private let collections = PHAssetCollection.fetchAssetCollectionsWithType(.Moment, subtype: .Any, options: nil)
    
    var name: String {
        return NSLocalizedString("Photo Library", comment: "")
    }
    
    var numberOfAlbums: Int {
        
        PHPhotoLibrary.requestAuthorization {
            _ in
        }
        
        return collections.count
    }
    
    func assetGroup(atIndex index: Int) -> AnyObject {
        return collections[index]
    }
    
    func assetsForAssetGroup(atIndex index: Int) -> PHFetchResult? {
        
        guard let collection = assetGroup(atIndex: index) as? PHAssetCollection else {
            return nil
        }
        
        return PHAsset.fetchAssetsInAssetCollection(collection, options: nil)
    }
    
    func thumbnailForAsset(forIndexPath indexPath: NSIndexPath) -> UIImage {
    
        let assets = assetsForAssetGroup(atIndex: indexPath.section)
        let manager = PHImageManager.defaultManager()
       
        let option = PHImageRequestOptions()
        option.synchronous = true
        
        var thumbnail = UIImage()
        
        // - How to resize images
        if let asset = assets?.objectAtIndex(indexPath.row) as? PHAsset {
            manager.requestImageForAsset(asset, targetSize: CGSize(width: 100.0, height: 100.0), contentMode: .AspectFit, options: option, resultHandler: {(result, info)->Void in
                thumbnail = result!
            })
        }
        
        return thumbnail
    }
}