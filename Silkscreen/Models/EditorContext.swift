//
//  EditorContext.swift
//  Silkscreen
//
//  Created by James Campbell on 4/24/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit
import AVFoundation

// - Figure out a basic demo context to test player
class EditorContext {
    
    init () {
        
        (1...5).enumerate().forEach {
            _ in
            addTrack()
        }
    }
    
    //MARK- Player Item
 
    lazy var playerItem: AVPlayerItem = {
        
        let mutableComposition = AVMutableComposition()
        let videoTrack = mutableComposition.addMutableTrackWithMediaType(AVMediaTypeVideo, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        let mutableVideoComposition = AVMutableVideoComposition()
        mutableVideoComposition.instructions = []
        mutableVideoComposition.frameDuration = CMTimeMake(1, 30)
        mutableVideoComposition.renderSize = CGSizeMake(500, 500)

        let item = AVPlayerItem(asset: mutableComposition)
        item.videoComposition = mutableVideoComposition
        
        return item
    }()
    
    //MARK:- Tracks
    
    private(set) var internalTracks = Frozen<[Track]>(value: [])
    
    func addTrack() {
        let newTrack = Track()
        internalTracks = Frozen(value: internalTracks.value + [newTrack])
    }
}