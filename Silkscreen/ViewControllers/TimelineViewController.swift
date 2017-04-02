//
//  TimelineViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/22/16.
//  Copyright © 2016 SK. All rights reserved.
//

#if os(iOS) || os(watchOS) || os(tvOS)
  import MobileCoreServices
  import UIKit
#endif

import Photos

// - Add Timebar and playback / fullscreen options to the navigation bar.
// - Implement
class TimelineViewController: UICollectionViewController, DraggingDestination, TimelineCollectionViewLayoutDelegate {
    
    var editorContext: EditorContext? = nil {
        didSet {
            collectionView?.reloadData()
            
            editorContext?.trackItemsDidChangeSignal.addSlot { _ in
                self.collectionView?.reloadData()
            }
        }
    }
    
    let layout = TimelineCollectionViewLayout()
    
    init() {
        
        super.init(collectionViewLayout: layout)
      
      #if os(iOS) || os(watchOS) || os(tvOS)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: nil, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 45))
        label.text = "0:00:00"
        label.textAlignment = .center
        
        navigationItem.titleView = label
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Fullscreen", style: .plain, target: nil, action: nil)
        
        installsStandardGestureForInteractiveMovement = true
        
      #endif
        
        // Re-enable when layout supports it
        collectionView?.isPrefetchingEnabled = false
        collectionView?.isDirectionalLockEnabled = true
        collectionView?.alwaysBounceVertical = true
        collectionView?.alwaysBounceHorizontal = true
        
        collectionView?.backgroundColor = UIColor.darkGray
        collectionView?.register(TimelineTimeMarkerSupplementaryView.self, forSupplementaryViewOfKind: TimelineElementKindTimeMarker, withReuseIdentifier: TimelineElementKindTimeMarker)
        collectionView?.register(TimelineTrackHeaderSupplementaryView.self, forSupplementaryViewOfKind: TimelineElementKindTrackHeader, withReuseIdentifier: TimelineElementKindTrackHeader)
        collectionView?.register(AssetCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: AssetCollectionViewCell.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
      
      #if os(iOS) || os(watchOS) || os(tvOS)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.barTintColor = UIColor.lightGray
      #endif
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kind, for: indexPath)
        
        switch view  {
        case let view as TimelineTrackHeaderSupplementaryView:
            view.trackID = indexPath.section + 1
            break
        default:
            break
        }
        
        return view
    }
  
  #if os(iOS) || os(watchOS) || os(tvOS)
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return editorContext?.tracks.count ?? 0
    }
  
  #endif
  
  #if os(iOS) || os(watchOS) || os(tvOS)
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let track = editorContext?.tracks[section]
        return track?.items.count ?? 0
    }
  
  #endif
  
  #if os(iOS) || os(watchOS) || os(tvOS)
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AssetCollectionViewCell.self), for: indexPath as IndexPath) as! AssetCollectionViewCell
        
        cell.asset = editorContext!.tracks[indexPath.section].items[indexPath.row].0
        
        return cell
    }
  
  #endif
    
    func shouldAllowDrag(_ draggingInfo: DraggingInfo) -> Bool {
        let pasteBoard = draggingInfo.draggingPasteboard
        return pasteBoard.hasStrings
    }
    
    func draggingEntered(_ sender: DraggingInfo) {
    }
    
    func draggingUpdated(_ sender: DraggingInfo) {
    }
    
    func draggingExited(_ sender: DraggingInfo) {
    }
    
    func draggingEnded(_ sender: DraggingInfo) {
      
      #if os(iOS) || os(watchOS) || os(tvOS)
      
        var location = view.convert(sender.draggingLocation, from: sender.destinationWindow)
        location.x -= sender.draggingImage.size.width / 2
        
        let time = layout.timeIdAtPoint(location)
        
        guard let track = editorContext?.tracks[layout.trackIdAtPoint(location)] else {
            return
        }
        
        guard let localIdentifier = sender.draggingPasteboard.string else {
            return
        }
        
        let fetchResult = PHAsset.fetchAssets(withLocalIdentifiers: [localIdentifier], options: nil)
      
        if let asset = fetchResult.firstObject {
          track.addItem(asset, time: time)
        }
      
      #endif
    }
    
    // - <TimelineCollectionViewLayoutDelegate>
    
    func timeForItem(_ indexPath: IndexPath) -> Int {
        return editorContext!.tracks[indexPath.section].items[indexPath.row].1
    }
}
