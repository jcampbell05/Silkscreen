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
    
    func assetsForAssetGroup(atIndex index: Int) -> AnyObject? {
        
        guard let collection = assetGroup(atIndex: index) as? PHAssetCollection else {
            return nil
        }
        
        return PHAsset.fetchAssetsInAssetCollection(collection, options: nil)
    }
}