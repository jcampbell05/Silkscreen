//
//  EditorContext.swift
//  Silkscreen
//
//  Created by James Campbell on 4/24/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit
import AVFoundation

class EditorContext {
    
    init () {
        
        (1...5).enumerate().forEach {
            _ in
            addTrack()
        }
    }
    
    //MARK:- Media
    
    lazy var composition = AVMutableComposition()
    
    lazy var videoComposition: AVMutableVideoComposition = {
        
        let videoComposition = AVMutableVideoComposition()
        
        videoComposition.instructions = []
        videoComposition.frameDuration = CMTimeMake(1, 30)
        videoComposition.renderSize = CGSizeMake(500, 500)
        
        return videoComposition
    }()
 
    lazy var playerItem: AVPlayerItem = {

        let item = AVPlayerItem(asset: self.composition)
        item.videoComposition = self.videoComposition
        
        return item
    }()
    
    //MARK:- Tracks
    
    private(set) var tracks = Frozen<[Track]>(value: [])
    
    func addTrack() {
        
        let videoTrack = self.composition.addMutableTrackWithMediaType(AVMediaTypeVideo, preferredTrackID: kCMPersistentTrackID_Invalid)
        let audioTrack = self.composition.addMutableTrackWithMediaType(AVMediaTypeAudio, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        let track = Track(editorContext: self, videoTrack: videoTrack, audioTrack: audioTrack)
        
        track.itemsDidChangeSignal.addSlot { _ in
            self.trackItemsDidChangeSignal.trigger()
        }
        
        tracks = tracks.append(track)
    }
    
    //MARK:- Assets
    
    private(set) var assets = Frozen<[Asset]>(value: []) {
        didSet {
            assetsDidChangeSignal.trigger()
        }
    }
    
    private(set) lazy var assetsDidChangeSignal: Signal<EditorContext> = {
        return Signal(sender: self)
    }()
    
    func addAsset(path: NSURL) {
        assets = assets.append(Asset(path: path))
    }
    
    //MARK:- Items
    
    private(set) lazy var trackItemsDidChangeSignal: Signal<EditorContext> = {
        return Signal(sender: self)
    }()
}
