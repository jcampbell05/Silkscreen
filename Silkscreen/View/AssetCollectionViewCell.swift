//
//  AssetCollectionViewCell.swift
//  Silkscreen
//
//  Created by James Campbell on 4/26/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Photos
#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
#endif

// - Come up with way to load assets
// - Come up with good Arch for asset loading
class AssetCollectionViewCell: UICollectionViewCell {
    
    var asset: PHAsset? = nil {
        didSet {
            if let asset = asset {
            
                let manager = PHImageManager.defaultManager()
                let option = PHImageRequestOptions()
                
                option.synchronous = true
                
                manager.requestImageForAsset(asset, targetSize: CGSize(width: 100.0, height: 100.0), contentMode: .AspectFit, options: option, resultHandler: {(result, info)->Void in
                   
                    guard let result = result else {
                        return
                    }
                    
                    self.imageView.contentMode = .ScaleAspectFill
                    self.imageView.image = result
                    self.setNeedsLayout()
                })
            }
        }
    }
    
    lazy var imageView: UIImageView = {
        return UIImageView(frame: self.bounds)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
