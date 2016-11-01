//
//  Asset.swift
//  Silkscreen
//
//  Created by James Campbell on 4/26/16.
//  Copyright © 2016 SK. All rights reserved.
//

import MobileCoreServices
import UIKit

struct Asset: PasteboardWriting {
    let path: NSURL
    
    func writeToPasteboard(pasteboard: UIPasteboard) {
        pasteboard.setValue(path, forPasteboardType: kUTTypeURL as String)
    }
}
