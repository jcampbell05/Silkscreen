//
//  EditorContext.swift
//  Silkscreen
//
//  Created by James Campbell on 4/24/16.
//  Copyright © 2016 SK. All rights reserved.
//

#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
#endif
import Photos

class EditorContext {
    
    init () {
        
        (1...5).enumerated().forEach {
            _ in
            addTrack()
        }
    }
    
    //MARK:- Tracks
    
    fileprivate(set) var tracks = Frozen<[Track]>(value: [])
    
    func addTrack() {
        
        let track = Track()
        
        track.itemsDidChangeSignal.addSlot { _ in
            self.trackItemsDidChangeSignal.trigger()
        }
        
        tracks = tracks.append(track)
    }
    
    //MARK:- Assets
    
    fileprivate(set) var assets = Frozen<[PHAsset]>(value: []) {
        didSet {
            assetsDidChangeSignal.trigger()
        }
    }
    
    fileprivate(set) lazy var assetsDidChangeSignal: Signal<EditorContext> = {
        return Signal(sender: self)
    }()
    
    func addAsset(_ asset: PHAsset) {
        assets = assets.append(asset)
    }
    
    //MARK:- Items
    
    fileprivate(set) lazy var trackItemsDidChangeSignal: Signal<EditorContext> = {
        return Signal(sender: self)
    }()
}
