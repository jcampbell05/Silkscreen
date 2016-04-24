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
        
        guard let collectionView = collectionView else {
            return []
        }
        
        let attributes: [UICollectionViewLayoutAttributes] = collectionView.contentOffset.x.stride(to: rect.width, by: 5)
            .enumerate()
            .map {
                let attribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: TimelineElementKindTimeMarker, withIndexPath: NSIndexPath(forRow: $0.index, inSection: 0))
                attribute.frame = CGRect(x: $0.element * 50, y: 0, width: 50, height:  50)
                attribute.zIndex = 1
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