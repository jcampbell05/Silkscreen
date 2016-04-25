//
//  TimelineCollectionViewLayout.swift
//  Silkscreen
//
//  Created by James Campbell on 4/23/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

let TimelineElementKindTimeMarker = "TimelineElementKindTimeMarker"
let TimelineElementKindTrackHeader = "TimelineElementKindTrackHeader"
private let TimelineElementKindHeader = "TimelineElementKindHeader"
private let TimelineElementKindTrack = "TimelineElementKindTrack"

// - Implement Layout Attribute for time offset

class TimelineCollectionViewLayout: UICollectionViewLayout {
    
    private let TimelineHeaderHeight: CGFloat = 30
    private let TimelineTrackHeight: CGFloat = 60
    private let TimelineTrackHeaderWidth: CGFloat = 100
    private let TimelineTimeMarkerWidth: CGFloat = 50
    
    override class func layoutAttributesClass() -> AnyClass {
        return TimelineCollectionViewLayoutAttributes.self
    }
    
    override init() {
        super.init()
        
        registerClass(TimelineHeaderDecorationView.self, forDecorationViewOfKind: TimelineElementKindHeader)
        registerClass(TimelineTrackDecorationView.self, forDecorationViewOfKind: TimelineElementKindTrack)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
 
    override func collectionViewContentSize() -> CGSize {
        let numberOfTracks = CGFloat(collectionView?.numberOfSections() ?? 0)
        return CGSize(width: CGFloat.max, height: TimelineTrackHeight * numberOfTracks)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var items: [UICollectionViewLayoutAttributes] = []

        if let headerAttributes = layoutAttributesForDecorationViewOfKind(TimelineElementKindHeader, atIndexPath: NSIndexPath(forRow: 0, inSection: 0)) {
            items += [headerAttributes]
        }
        
        items += layoutAttributesForTimeMarkersInRect(rect)
        items += layoutAttributesForTracksInRect(rect)
        items += layoutAttributesForTrackHeadersInRect(rect)
        
        return items
    }
    
    private func layoutAttributesForTimeMarkersInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes] {
        
        guard let collectionView = collectionView else {
            return []
        }
        
        let timeMarkersPerScreen = Int(rect.width / TimelineTimeMarkerWidth)
        let screenNumber = Int((collectionView.contentOffset.x - TimelineTrackHeaderWidth) / rect.width)
        let offset = (screenNumber * Int(rect.width))
        
        let attributes: [UICollectionViewLayoutAttributes] = (0...(timeMarkersPerScreen * 2)).enumerate().map {
            
            let attribute = TimelineCollectionViewLayoutAttributes(forSupplementaryViewOfKind: TimelineElementKindTimeMarker, withIndexPath: NSIndexPath(forRow: $0.index, inSection: 0))
            
            let x = CGFloat(($0.element * Int(TimelineTimeMarkerWidth)) + offset)
            
            //Figure out how to calculate this.
            attribute.time = Double($0.element + offset)
            attribute.frame = CGRect(x: x + TimelineTrackHeaderWidth, y: collectionView.contentOffset.y + collectionView.contentInset.top, width: TimelineTimeMarkerWidth, height:  TimelineHeaderHeight)
            attribute.zIndex = 2
            
            return attribute
        }
            
        return attributes
    }
    
    private func layoutAttributesForTracksInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes] {
        
        guard let collectionView = collectionView else {
            return []
        }
        
        let attributes: [UICollectionViewLayoutAttributes] = (0...(collectionView.numberOfSections() - 1)).enumerate().map {
            
            let attribute = UICollectionViewLayoutAttributes(forDecorationViewOfKind: TimelineElementKindTrack, withIndexPath: NSIndexPath(forRow: 0, inSection: $0.element))
            
            let y = CGFloat(($0.element * Int(TimelineTrackHeight)))
            
            //Figure out how to calculate this.
            attribute.frame = CGRect(x: collectionView.contentOffset.x, y: y + collectionView.contentInset.top, width: rect.width, height:  TimelineTrackHeight)
            
            return attribute
        }
        
        return attributes
    }
    
    private func layoutAttributesForTrackHeadersInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes] {
        
        guard let collectionView = collectionView else {
            return []
        }
        
        let attributes: [UICollectionViewLayoutAttributes] = (0...(collectionView.numberOfSections() - 1)).enumerate().map {
            
            let attribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: TimelineElementKindTrackHeader, withIndexPath: NSIndexPath(forRow: 0, inSection: $0.element))
            
            let y = CGFloat(($0.element * Int(TimelineTrackHeight)))
            
            //Figure out how to calculate this.
            attribute.frame = CGRect(x: collectionView.contentOffset.x, y: y + collectionView.contentInset.top, width: TimelineTrackHeaderWidth, height:  TimelineTrackHeight)
            
            return attribute
        }
        
        return attributes
    }
    
    override func layoutAttributesForDecorationViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        if let collectionView = collectionView {

            let attribute = UICollectionViewLayoutAttributes(forDecorationViewOfKind: elementKind, withIndexPath: indexPath)
            attribute.frame = CGRect(x: collectionView.contentOffset.x, y: collectionView.contentOffset.y + collectionView.contentInset.top, width: collectionView.frame.width, height: TimelineHeaderHeight)
            attribute.zIndex = 1
            
            return attribute
        }
        
        return nil
    }
}