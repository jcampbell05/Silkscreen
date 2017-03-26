//
//  PHAsset+PasteboardWriting.swift
//  Silkscreen
//
//  Created by James Campbell on 3/26/17.
//  Copyright © 2017 SK. All rights reserved.
//

import Photos

extension PHAsset: PasteboardWriting {
  func writeToPasteboard(pasteboard: UIPasteboard) {
    pasteboard.string = self.localIdentifier
  }
}
