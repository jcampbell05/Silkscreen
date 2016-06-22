//
//  PhotoLibraryAssetImportSource.swift
//  Silkscreen
//
//  Created by James Campbell on 4/29/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation
import Photos

class PhotoLibraryAssetImportSource: AssetImportSource {
    
    var name: String {
        return NSLocalizedString("Photo Library", comment: "")
    }
    
    var numberOfAlbums: Int {
        
        PHPhotoLibrary.requestAuthorization {
            _ in
        }
        
        let collections = PHAssetCollection.fetchAssetCollectionsWithType(.Moment, subtype: .Any, options: nil)
        return collections.count
    }
}