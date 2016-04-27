//
//  CollectionType.swift
//  Silkscreen
//
//  Created by James Campbell on 4/25/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation

extension Frozen where T: CollectionType {
    
    subscript(index: T.Index) -> T.Generator.Element {
        get {
            return value[index]
        }
    }
    
    var count: T.Index.Distance {
        return value.count
    }
}

extension Frozen where T: RangeReplaceableCollectionType {
    
    func append(element: T.Generator.Element) -> Frozen {
        var newValue = value
        newValue.append(element)
        return Frozen(value: newValue)
    }
    
    func appendContentsOf<S: SequenceType where S.Generator.Element == T.Generator.Element>(newElements: S) -> Frozen {
        return Frozen(value: value + newElements)
    }
}