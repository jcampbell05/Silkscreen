//
//  TimelineCollectionViewLayout.swift
//  Silkscreen
//
//  Created by James Campbell on 4/23/16.
//  Copyright © 2016 SK. All rights reserved.
//

#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
#endif

let TimelineElementKindTimeMarker = "TimelineElementKindTimeMarker"
let TimelineElementKindTrackHeader = "TimelineElementKindTrackHeader"
private let TimelineElementKindHeader = "TimelineElementKindHeader"
private let TimelineElementKindTrack = "TimelineElementKindTrack"

protocol TimelineCollectionViewLayoutDelegate {
    func timeForItem(_ indexPath: IndexPath) -> Int
}

// - Implement Layout Attribute for time offset
// - layoutAttributesForInteractivelyMovingItemAtIndexPath for drag and drop
// - Tidy this up and correctly implement layoutAttributesForItemAtIndexPath etc methods

class TimelineCollectionViewLayout: UICollectionViewLayout {
    
    fileprivate let TimelineHeaderHeight: CGFloat = 30
    fileprivate let TimelineTrackHeight: CGFloat = 60
    fileprivate let TimelineTrackHeaderWidth: CGFloat = 100
    fileprivate let TimelineTimeMarkerWidth: CGFloat = 50
    
//    class func layoutAttributesClass() -> AnyClass {
//        return TimelineCollectionViewLayoutAttributes.self
//    }
    
    var layoutAttributesClass: AnyClass {
        return TimelineCollectionViewLayoutAttributes.self
    }
    
    override init() {
        super.init()
        
        register(TimelineHeaderDecorationView.self, forDecorationViewOfKind: TimelineElementKindHeader)
        register(TimelineTrackDecorationView.self, forDecorationViewOfKind: TimelineElementKindTrack)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func shouldUpdateVisibleCellLayoutAttributes() -> Bool {
      return false
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
 
//    func collectionViewContentSize() -> CGSize {
//        let numberOfTracks = CGFloat(collectionView?.numberOfSections ?? 0)
//        return CGSize(width: CGFloat.greatestFiniteMagnitude, height: TimelineTrackHeight * numberOfTracks)
//    }
    
    override var collectionViewContentSize: CGSize {
        let numberOfTracks = CGFloat(collectionView?.numberOfSections ?? 0)
        return CGSize(width: CGFloat.greatestFiniteMagnitude, height: TimelineTrackHeight * numberOfTracks)
    }
  
  #if os(iOS) || os(watchOS) || os(tvOS)
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var items: [UICollectionViewLayoutAttributes] = []

        if let headerAttributes = layoutAttributesForDecorationViewOfKind(elementKind: TimelineElementKindHeader, atIndexPath: NSIndexPath(row: 0, section: 0)){
            items += [headerAttributes]
        }
        
        items += layoutAttributesForTimeMarkersInRect(rect)
        items += layoutAttributesForTracksInRect(rect)
        items += layoutAttributesForTrackHeadersInRect(rect)
        
        let sectionCount = collectionView?.numberOfSections ?? 0
        
        for section in 0..<sectionCount {
            
            let rowCount = collectionView?.numberOfItems(inSection: section) ?? 0
            
            for row in 0..<rowCount {
                let indexPath = NSIndexPath(row: row, section: section)
                if let item = layoutAttributesForItem(at: indexPath as IndexPath) {
                    items += [item]
                }
            }
        }
        
        return items
    }
  
  #endif
    
    fileprivate func layoutAttributesForTimeMarkersInRect(_ rect: CGRect) -> [UICollectionViewLayoutAttributes] {
        
        guard let collectionView = collectionView else {
            return []
        }
        
        let timeMarkersPerScreen = Int(rect.width / TimelineTimeMarkerWidth)
        let screenNumber = Int((collectionView.contentOffset.x - TimelineTrackHeaderWidth) / rect.width)
        let offset = (screenNumber * Int(rect.width))
      
      #if os(iOS) || os(watchOS) || os(tvOS)
        let attributes: [UICollectionViewLayoutAttributes] = (0...(timeMarkersPerScreen * 2)).enumerated().map {
            
            let attribute = TimelineCollectionViewLayoutAttributes(forSupplementaryViewOfKind: TimelineElementKindTimeMarker, with: IndexPath(row: $0.element, section: 0))

            let x = CGFloat(($0.element * Int(TimelineTimeMarkerWidth)) + offset)
            
            //Figure out how to calculate this.
            attribute.time = Double($0.element + offset)
            attribute.frame = CGRect(x: x + TimelineTrackHeaderWidth, y: collectionView.contentOffset.y + collectionView.contentInset.top, width: TimelineTimeMarkerWidth, height:  TimelineHeaderHeight)
            attribute.zIndex = 2
            
            return attribute
        }
            
        return attributes
      
      #else
        return []
      #endif
    }
    
    fileprivate func layoutAttributesForTracksInRect(_ rect: CGRect) -> [UICollectionViewLayoutAttributes] {
        
        guard let collectionView = collectionView else {
            return []
        }
      
      #if os(iOS) || os(watchOS) || os(tvOS)
        
        let attributes: [UICollectionViewLayoutAttributes] = (0...(collectionView.numberOfSections - 1)).enumerated().map {
            
            let attribute = UICollectionViewLayoutAttributes(forDecorationViewOfKind: TimelineElementKindTrack, with: NSIndexPath(row: 0, section: $0.element) as IndexPath)
            let y: CGFloat = yForTrackID($0.element)
            
            //Figure out how to calculate this.
            attribute.frame = CGRect(x: collectionView.contentOffset.x, y: y, width: rect.width, height:  TimelineTrackHeight)
            
            return attribute
        }
        
        return attributes
      
      #else
      
        return []
      
      #endif
    }
    
    fileprivate func layoutAttributesForTrackHeadersInRect(_ rect: CGRect) -> [UICollectionViewLayoutAttributes] {
        
        guard let collectionView = collectionView else {
            return []
        }
      
      #if os(iOS) || os(watchOS) || os(tvOS)
        
        let attributes: [UICollectionViewLayoutAttributes] = (0...(collectionView.numberOfSections - 1)).enumerated().map {
            
            let attribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: TimelineElementKindTrackHeader, with: NSIndexPath(row: 0, section: $0.element) as IndexPath)
            let y: CGFloat = CGFloat(($0.element * Int(TimelineTrackHeight))) + TimelineHeaderHeight
            
            //Figure out how to calculate this.
            attribute.frame = CGRect(x: collectionView.contentOffset.x, y: y, width: TimelineTrackHeaderWidth, height:  TimelineTrackHeight)
            attribute.zIndex = 1
            
            return attribute
        }
        
        return attributes
      
      #else
        
        return []
      
      #endif
    }
  
  #if os(iOS) || os(watchOS) || os(tvOS)
    
    func layoutAttributesForDecorationViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        if let collectionView = collectionView {

            let attribute = UICollectionViewLayoutAttributes(forDecorationViewOfKind: elementKind, with: indexPath as IndexPath)
            attribute.frame = CGRect(x: collectionView.contentOffset.x, y: collectionView.contentOffset.y + collectionView.contentInset.top, width: collectionView.frame.width, height: TimelineHeaderHeight)
            attribute.zIndex = 1
            
            return attribute
        }
        
        return nil
    }
    
    func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        let delegate = collectionView?.delegate as? TimelineCollectionViewLayoutDelegate
        let time = delegate?.timeForItem(indexPath as IndexPath) ?? 0
        
        let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
        attribute.frame = CGRect(x: TimelineTrackHeaderWidth + CGFloat(max(time, 0)), y: yForTrackID(indexPath.section), width: 100, height: TimelineTrackHeight)
        
        return attribute
    }
  
  #endif
    
    func layoutAttributesForTimelineItem(_ trackId: Int, time: Int) -> UICollectionViewLayoutAttributes {
        
        let attribute = UICollectionViewLayoutAttributes()
        attribute.frame = CGRect(x: TimelineTrackHeaderWidth + CGFloat(max(time, 0)), y: yForTrackID(trackId), width: 100, height: TimelineTrackHeight)
        attribute.zIndex = 1
        
        return attribute
    }
    
    func trackIdAtPoint(_ point: CGPoint) -> Int {
        return min(Int((point.y - TimelineHeaderHeight) / TimelineTrackHeight), (collectionView?.numberOfSections ?? 1) - 1)
    }
    
    func timeIdAtPoint(_ point: CGPoint) -> Int {
        return Int((point.x - TimelineTrackHeaderWidth) + (collectionView?.contentOffset.x ?? 0))
    }
    
    fileprivate func yForTrackID(_ trackID: Int) -> CGFloat {
        return TimelineHeaderHeight + (CGFloat(trackID) * TimelineTrackHeight)
    }
}
