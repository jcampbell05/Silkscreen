//
//  TimelineCollectionViewLayout.swift
//  Silkscreen
//
//  Created by James Campbell on 4/23/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

let TimelineElementKindTimeMarker = "TimelineElementKindTimeMarker"
private let TimelineElementKindHeader = "TimelineElementKindHeader"

// - Implement Layout Attribute for time offset

class TimelineCollectionViewLayout: UICollectionViewLayout {
    
    override class func layoutAttributesClass() -> AnyClass {
        return TimelineCollectionViewLayoutAttributes.self
    }
    
    override init() {
        super.init()
        
        registerClass(TimelineHeaderDecorationView.self, forDecorationViewOfKind: TimelineElementKindHeader)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
 
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: CGFloat.max, height: 10)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var items: [UICollectionViewLayoutAttributes] = []

        if let headerAttributes = layoutAttributesForDecorationViewOfKind(TimelineElementKindHeader, atIndexPath: NSIndexPath(forRow: 0, inSection: 0)) {
            items += [headerAttributes]
        }
        
        items += layoutAttributesForTimeMarkersInRact(rect)
        
        return items
    }
    
    private func layoutAttributesForTimeMarkersInRact(rect: CGRect) -> [UICollectionViewLayoutAttributes] {
        
        guard let collectionView = collectionView else {
            return []
        }
        
        let timeMarkersPerScreen = Int(rect.width / 50)
        let screenNumber = Int(collectionView.contentOffset.x / rect.width)
        let offset = (screenNumber * Int(rect.width))
        
        let attributes: [UICollectionViewLayoutAttributes] = (0...(timeMarkersPerScreen * 2)).enumerate().map {
            
            let attribute = TimelineCollectionViewLayoutAttributes(forSupplementaryViewOfKind: TimelineElementKindTimeMarker, withIndexPath: NSIndexPath(forRow: $0.index, inSection: 0))
            
            //Figure out how to calculate this.
            attribute.time = Double($0.element + offset)
            attribute.frame = CGRect(x: ($0.element * 50) + offset, y: 0, width: 50, height:  30)
            attribute.zIndex = 1
            
            return attribute
        }
            
        return attributes
    } 
    
    override func layoutAttributesForDecorationViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        if let collectionView = collectionView {

            let attribute = UICollectionViewLayoutAttributes(forDecorationViewOfKind: elementKind, withIndexPath: indexPath)
            attribute.frame = CGRect(x: collectionView.contentOffset.x, y: collectionView.contentOffset.y, width: collectionView.frame.width, height: 30)
            
            return attribute
        }
        
        return nil
    }
}