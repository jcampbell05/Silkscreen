//
//  AssetImportSource.swift
//  Silkscreen
//
//  Created by James Campbell on 4/29/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation
import UIKit

protocol AssetImportSource {
    
    var name: String { get }
    
    // - Number Of Asset Groups
    var numberOfAlbums: Int { get }
    
    // - Assets for asset groups
    // - Authenticate ()
    
    func thumbnailForAsset(forIndexPath indexPath: NSIndexPath) -> UIImage
}