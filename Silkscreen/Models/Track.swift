//
//  Track.swift
//  Silkscreen
//
//  Created by James Campbell on 4/25/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation
import AVFoundation
import Photos

// - Implement correct composition generator system (similar to Xcake) ?
// - Remove this out of the model :)
class Track {
    
    let editorContext: EditorContext
    let videoTrack: AVMutableCompositionTrack
    let audioTrack: AVMutableCompositionTrack
    
    private(set) var items = Frozen<[(Asset, Int)]>(value: []) {
        didSet {
            itemsDidChangeSignal.trigger()
        }
    }
    
    private(set) lazy var itemsDidChangeSignal: Signal<Track> = {
        return Signal(sender: self)
    }()
    
    init(editorContext: EditorContext, videoTrack: AVMutableCompositionTrack, audioTrack: AVMutableCompositionTrack) {
        self.editorContext = editorContext
        self.videoTrack = videoTrack
        self.audioTrack = audioTrack
    }
    
    func addItem(asset: Asset, time: Int) {
        items = items.append((asset, time))
        
        let sourceAsset = AVURLAsset(URL: asset.path)
        let editRange = CMTimeRangeMake(CMTimeMake(0, 600), CMTimeMake(sourceAsset.duration.value, sourceAsset.duration.timescale));
        
        
        // - Can we move this elsewhere ? Also what does all this shit do ? its so verbose !!
        let asset = PHAsset.fetchAssetsWithALAssetURLs([asset.path], options: nil).firstObject
        
        if let asset = asset as? PHAsset {
            
            let manager = PHImageManager.defaultManager()
            let option = PHImageRequestOptions()
            
            option.synchronous = true
            
            manager.requestImageForAsset(asset, targetSize: CGSize(width: 100.0, height: 100.0), contentMode: .AspectFit, options: option, resultHandler: {(result, info)->Void in
                
                guard let result = result else {
                    return
                }
                
                let layer = CALayer()
                layer.contents = result.CGImage
                layer.frame = CGRectMake(5, 25, 57, 57) //Needed for proper display. We are using the app icon (57x57). If you use 0,0 you will not see it
                layer.opacity = 0.65; //Feel free to alter the alpha here
                
                let videoSize = self.editorContext.videoComposition.renderSize
                let parentLayer = CALayer()
                let videoLayer = CALayer()
                parentLayer.frame = CGRectMake(0, 0, videoSize.width, videoSize.height);
                videoLayer.frame = CGRectMake(0, 0, videoSize.width, videoSize.height);
                
                parentLayer.addSublayer(videoLayer)
                parentLayer.addSublayer(layer)
                
                self.editorContext.videoComposition.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: videoLayer, inLayer: parentLayer);
                let instruction = AVMutableVideoCompositionInstruction()
                instruction.timeRange = CMTimeRangeMake(kCMTimeZero, CMTimeMake(5, 1));
                let videoTrack = self.editorContext.composition.tracksWithMediaType(AVMediaTypeVideo).first!
                let layerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack)
               
                instruction.layerInstructions = [layerInstruction]
                self.editorContext.videoComposition.instructions = [instruction]
                self.videoTrack.insertEmptyTimeRange(CMTimeRangeMake(kCMTimeZero, CMTimeMake(5, 1)))
                
                self.editorContext.composition.insertEmptyTimeRange(CMTimeRangeMake(kCMTimeZero, CMTimeMake(5, 1)))
            })
        }
    }
}
