//
//  RenderTrack.swift
//  Silkscreen
//
//  Created by James Campbell on 11/2/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation
import GPUImage
import Photos

class RenderTrack: GPUImageFilter {
    
    func render(track: Track) {
        
        guard let ast = track.items.value.first?.0 else {
            return
        }
        
        // - Can we move this elsewhere ? Also what does all this shit do ? its so verbose !!
        let asset = PHAsset.fetchAssetsWithALAssetURLs([ast.path], options: nil).firstObject
        
        if let asset = asset as? PHAsset {
            
            let manager = PHImageManager.defaultManager()
            let option = PHImageRequestOptions()
            
            option.synchronous = true
            
            manager.requestImageForAsset(asset, targetSize: CGSize(width: 100.0, height: 100.0), contentMode: .AspectFit, options: option, resultHandler: {(result, info)->Void in
                
                guard let result = result else {
                    return
                }
                
                let pictureSource = GPUImagePicture(image: result)
                pictureSource.addTarget(self)
                pictureSource.processImage()
            })
        }
    }
}
