//
//  TimelineViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/22/16.
//  Copyright © 2016 SK. All rights reserved.
//

import MobileCoreServices
import UIKit

// - Add Timebar and playback / fullscreen options to the navigation bar.
// - Implement
class TimelineViewController: UICollectionViewController, DraggingDestination {
    
    var draggingCell: UICollectionViewCell? = nil
    
    var editorContext: EditorContext? = nil {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    let layout = TimelineCollectionViewLayout()
    
    init() {
        
        super.init(collectionViewLayout: layout)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Play, target: nil, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 45))
        label.text = "0:00:00"
        label.textAlignment = .Center
        
        navigationItem.titleView = label
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Fullscreen", style: .Plain, target: nil, action: nil)
        
        installsStandardGestureForInteractiveMovement = true
        
        // Reenable when layout supports it
        collectionView?.prefetchingEnabled = false
        collectionView?.directionalLockEnabled = true
        collectionView?.alwaysBounceVertical = true
        collectionView?.alwaysBounceHorizontal = true
        
        collectionView?.backgroundColor = UIColor.darkGrayColor()
        collectionView?.registerClass(TimelineTimeMarkerSupplementaryView.self, forSupplementaryViewOfKind: TimelineElementKindTimeMarker, withReuseIdentifier: TimelineElementKindTimeMarker)
        collectionView?.registerClass(TimelineTrackHeaderSupplementaryView.self, forSupplementaryViewOfKind: TimelineElementKindTrackHeader, withReuseIdentifier: TimelineElementKindTrackHeader)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.tintColor = UIColor.blackColor()
        navigationController?.navigationBar.barTintColor = UIColor.lightGrayColor()
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
        return editorContext?.tracks.count ?? 0
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func shouldAllowDrag(draggingInfo: DraggingInfo) -> Bool {
        let pasteBoard = draggingInfo.draggingPasteboard
        return pasteBoard.hasURLs
    }
    
    func draggingEntered(sender: DraggingInfo) {

        let cell = UICollectionViewCell()
        
        collectionView?.addSubview(cell)
        draggingCell = cell
    }
    
    func draggingUpdated(sender: DraggingInfo) {
        
        let location = view.convertPoint(sender.draggingLocation, fromView: sender.destinationWindow)
        var item = TimelineItem()
        
        item.trackId = layout.trackIdAtPoint(location)
        item.time = layout.timeIdAtPoint(location)
        
        let attributes = layout.layoutAttributesForTimelineItem(item)

        draggingCell?.frame = attributes.frame
        draggingCell?.layer.zPosition = CGFloat(attributes.zIndex)
        draggingCell?.backgroundColor = UIColor.redColor()
    }
    
    func draggingExited(sender: DraggingInfo?) {
        draggingCell?.removeFromSuperview()
        draggingCell = nil
    }
    
    func draggingEnded(sender: DraggingInfo) {
        
        draggingCell?.removeFromSuperview()
        draggingCell = nil
        
        let location = view.convertPoint(sender.draggingLocation, fromView: sender.destinationWindow)
        let time = layout.timeIdAtPoint(location)
        
        guard let track = editorContext?.tracks[layout.trackIdAtPoint(location)] else {
            return
        }
        
        guard let url = sender.draggingPasteboard.URL else {
            return
        }
        
        let asset = Asset(path: url)
        track.addItem(asset, time: time)
    }
}
