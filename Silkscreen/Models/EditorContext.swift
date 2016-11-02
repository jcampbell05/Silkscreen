//
//  EditorContext.swift
//  Silkscreen
//
//  Created by James Campbell on 4/24/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class EditorContext {
    
    init () {
        
        (1...5).enumerate().forEach {
            _ in
            addTrack()
        }
    }
    
    //MARK:- Tracks
    
    private(set) var tracks = Frozen<[Track]>(value: [])
    
    func addTrack() {
        
        let track = Track()
        
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
