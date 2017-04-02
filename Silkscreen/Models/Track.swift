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

class Track {
    
    fileprivate(set) var items = Frozen<[(PHAsset, Int)]>(value: []) {
        didSet {
            itemsDidChangeSignal.trigger()
        }
    }
    
    fileprivate(set) lazy var itemsDidChangeSignal: Signal<Track> = {
        return Signal(sender: self)
    }()
    
    func addItem(_ asset: PHAsset, time: Int) {
        items = items.append((asset, time))
    }
}
