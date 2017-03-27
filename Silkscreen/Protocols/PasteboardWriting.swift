//
//  PasteboardWriting.swift
//  Silkscreen
//
//  Created by James Campbell on 11/1/16.
//  Copyright © 2016 SK. All rights reserved.
//

#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
#endif

protocol PasteboardWriting {
    func writeToPasteboard(pasteboard: UIPasteboard)
}
