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
          #if os(iOS) || os(watchOS) || os(tvOS)
            if let asset = asset {
            
                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()
                
                option.isSynchronous = true
                
                manager.requestImage(for: asset, targetSize: CGSize(width: 100.0, height: 100.0), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                   
                    guard let result = result else {
                        return
                    }
                    
                    self.imageView.contentMode = .scaleAspectFill
                    self.imageView.image = result
                    self.setNeedsLayout()
                })
            }
          #endif
        }
    }
    
    lazy var imageView: UIImageView = {
        return UIImageView(frame: self.bounds)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      
      #if os(iOS) || os(watchOS) || os(tvOS)
        clipsToBounds = true
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
        addSubview(imageView)
      #endif
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
