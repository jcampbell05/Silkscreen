//
//  PreviewViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/22/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit
import GPUImage
import Photos

// - Apple TV Support
// - Fullscreen Support
// - Picture In Picture ?
// - Build Render Engine 
// - With Asset Manager
class PreviewViewController: UIViewController {
    
    let imageView = GPUImageView()

    var editorContext: EditorContext? = nil {
        didSet {
           // self.render()
            
            editorContext?.trackItemsDidChangeSignal.addSlot { _ in
                self.render()
            }
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = imageView
    }
    
    func render() {
        
        guard let ast = editorContext?.tracks[0].items.value.first?.0 else {
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
                pictureSource.addTarget(self.imageView)
                pictureSource.processImage()
            })
        }
    }
}
