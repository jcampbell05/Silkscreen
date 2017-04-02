//
//  CollectionType.swift
//  Silkscreen
//
//  Created by James Campbell on 4/25/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation

extension Frozen where T: Collection {
    
    subscript(index: T.Index) -> T.Iterator.Element {
        get {
            return value[index]
        }
    }
    
    var count: T.IndexDistance {
        return value.count
    }
}

extension Frozen where T: RangeReplaceableCollection {
    
    func append(_ element: T.Iterator.Element) -> Frozen {
        var newValue = value
        newValue.append(element)
        return Frozen(value: newValue)
    }
    
    func appendContentsOf<S: Sequence>(_ newElements: S) -> Frozen where S.Iterator.Element == T.Iterator.Element {
        return Frozen(value: value + newElements)
    }
}
