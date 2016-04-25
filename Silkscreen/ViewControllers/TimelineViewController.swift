//
//  TimelineViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/22/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

// - Manually Add Navigation Bar VC or in a super VC
class TimelineViewController: UICollectionViewController {
    
    var editorContext: EditorContext? = nil {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    let layout = TimelineCollectionViewLayout()
    
    init() {
        
        super.init(collectionViewLayout: layout)
        
        title = NSLocalizedString("Untitled Project", comment: "")
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.registerClass(TimelineTimeMarkerSupplementaryView.self, forSupplementaryViewOfKind: TimelineElementKindTimeMarker, withReuseIdentifier: TimelineElementKindTimeMarker)
        collectionView?.registerClass(TimelineTrackHeaderSupplementaryView.self, forSupplementaryViewOfKind: TimelineElementKindTrackHeader, withReuseIdentifier: TimelineElementKindTrackHeader)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: kind, forIndexPath: indexPath)
        
        switch view  {
        case let view as TimelineTrackHeaderSupplementaryView:
            view.trackID = indexPath.section + 1
            break
        default:
            break
        }
        
        return view
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return editorContext?.internalTracks.count ?? 0
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
}