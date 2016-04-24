//
//  EditorContext.swift
//  Silkscreen
//
//  Created by James Campbell on 4/24/16.
//  Copyright © 2016 SK. All rights reserved.
//

import AVFoundation

// - Figure out a basic demo context to test player
class EditorContext {
 
    lazy var player: AVPlayer = {
        let player = AVPlayer()
        
        let mutableComposition = AVMutableComposition()
        
        let audioTrack = mutableComposition.addMutableTrackWithMediaType(AVMediaTypeAudio, preferredTrackID: kCMPersistentTrackID_Invalid)
        let videoTrack = mutableComposition.addMutableTrackWithMediaType(AVMediaTypeVideo, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        let mutableVideoComposition = AVMutableVideoComposition()
        mutableVideoComposition.instructions = []
        mutableVideoComposition.frameDuration = CMTimeMake(1, 30)
        mutableVideoComposition.renderSize = CGSizeMake(640, 940)
        
        let item = AVPlayerItem(asset: mutableComposition)
        item.videoComposition = mutableVideoComposition
        
        player.replaceCurrentItemWithPlayerItem(item)
        
        return player
    }()
}