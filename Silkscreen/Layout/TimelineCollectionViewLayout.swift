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

class TimelineCollectionViewLayout: UICollectionViewLayout {
    
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
        
        let attributes: [UICollectionViewLayoutAttributes] = (1...10).enumerate().map {
            let attribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: TimelineElementKindTimeMarker, withIndexPath: NSIndexPath(forRow: $0.0, inSection: 0))
            attribute.frame = CGRect(x: $0.0 * 50, y: 50, width: 50, height:  50)
            return attribute
        }
        
        return attributes
    }
    
    override func layoutAttributesForDecorationViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        if let collectionView = collectionView {

            let attribute = UICollectionViewLayoutAttributes(forDecorationViewOfKind: elementKind, withIndexPath: indexPath)
            attribute.frame = CGRect(x: collectionView.contentOffset.x, y: collectionView.contentOffset.y, width: collectionView.frame.width, height: 50)
            
            return attribute
        }
        
        return nil
    }
}