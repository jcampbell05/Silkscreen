//
//  Track.swift
//  Silkscreen
//
//  Created by James Campbell on 4/25/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation

class Track {
    
    private(set) var items = Frozen<[(Asset, Int)]>(value: []) {
        didSet {
            itemsDidChangeSignal.trigger()
        }
    }
    
    private(set) lazy var itemsDidChangeSignal: Signal<Track> = {
        return Signal(sender: self)
    }()
    
    func addItem(asset: Asset, time: Int) {
        items = items.append((asset, time))
    }
}
