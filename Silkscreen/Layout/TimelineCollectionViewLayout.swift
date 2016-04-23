//
//  TimelineCollectionViewLayout.swift
//  Silkscreen
//
//  Created by James Campbell on 4/23/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

private let TimelineElementKindHeader = "TimelineElementKindHeader"

class TimelineCollectionViewLayout: UICollectionViewLayout {
    
    override init() {
        super.init()
        
        // Do time indicators at the top.
        // - Time Marker
        
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
        
        let items = [
            layoutAttributesForDecorationViewOfKind(TimelineElementKindHeader, atIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        ]
        .flatMap({$0})
        
        return items
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