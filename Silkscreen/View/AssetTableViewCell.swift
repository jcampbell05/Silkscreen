//
//  AssetTableViewCell.swift
//  Silkscreen
//
//  Created by James Campbell on 4/26/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Photos
import UIKit

// - Come up with way to load assets
// - Come up with good Arch
class AssetTableViewCell: UITableViewCell {
    
    var asset: Asset? = nil {
        didSet {
            if let path = asset?.path {
                
                let asset = PHAsset.fetchAssetsWithALAssetURLs([path], options: nil).firstObject
                
                if let asset = asset as? PHAsset,
                   let resource = PHAssetResource.assetResourcesForAsset(asset).first {
                    
                    textLabel?.text = resource.originalFilename
                    
                    let manager = PHImageManager.defaultManager()
                    let option = PHImageRequestOptions()
                    
                    option.synchronous = true
                    
                    manager.requestImageForAsset(asset, targetSize: CGSize(width: 100.0, height: 100.0), contentMode: .AspectFit, options: option, resultHandler: {(result, info)->Void in
                       
                        guard let result = result else {
                            return
                        }
                        
                        self.imageView?.contentMode = .ScaleAspectFill
                        self.imageView?.image = result
                        self.setNeedsLayout()
                    })
                }
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}