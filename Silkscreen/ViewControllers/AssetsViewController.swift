//
//  AssetsViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/22/16.
//  Copyright © 2016 SK. All rights reserved.
//

#if os(iOS) || os(watchOS) || os(tvOS)
  import MobileCoreServices
  import UICollectionViewLeftAlignedLayout
  import UIKit
#endif

class AssetsViewController: UICollectionViewController {
    
    var editorContext: EditorContext? = nil {
        didSet {
            editorContext?.assetsDidChangeSignal.addSlot() {
                _ in
                self.collectionView?.reloadData()
            }
        }
    }
    
    lazy var longPressToDragGestureRecognizer: UILongPressGestureRecognizer = {
        return UILongPressGestureRecognizer(target: self, action: #selector(longPressToDragGestureDidUpdate))
    }()
    
    override init() {
      
      #if os(iOS) || os(watchOS) || os(tvOS)
        let layout = UICollectionViewLeftAlignedLayout()
      #else
        let layout = UICollectionViewFlowLayout()
      #endif
        
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSizeMake(100
            , 50)
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)

        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.darkGrayColor()
        collectionView?.addGestureRecognizer(longPressToDragGestureRecognizer)
        collectionView?.registerClass(AssetCollectionViewCell.self, forCellWithReuseIdentifier: String(AssetCollectionViewCell))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
      
      #if os(iOS) || os(watchOS) || os(tvOS)
        navigationController?.setNavigationBarHidden(false, animated: animated)
      #endif
    }
    
    @objc private func longPressToDragGestureDidUpdate(gestureRecognizer: UIGestureRecognizer) {
        
        guard gestureRecognizer.state == .Began else {
            return
        }
        
        let location = gestureRecognizer.locationInView(collectionView)
        
        guard let indexPath = collectionView?.indexPathForItemAtPoint(location) else {
            return
        }
        
        guard let cell = collectionView?.cellForItemAtIndexPath(indexPath) else {
            return
        }
      
      #if os(iOS) || os(watchOS) || os(tvOS)
        
        guard let asset = editorContext?.assets[indexPath.row] else {
            return
        }
      
        let renderer = UIGraphicsImageRenderer(size: cell.bounds.size)
        
        let image = renderer.imageWithActions { _ in
            cell.drawViewHierarchyInRect(cell.bounds, afterScreenUpdates: false)
        }
        
        let draggingItem = DraggingItem(pasteboardWriter: asset)
        draggingItem.setDraggingFrame(cell.bounds, image: image)
        beginDraggingSession(with: draggingItem, location: gestureRecognizer.locationInView(view))
      
      #endif
    }
  
  #if os(iOS) || os(watchOS) || os(tvOS)
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return editorContext?.assets.count ?? 0
    }
  
  #endif
  
  
  #if os(iOS) || os(watchOS) || os(tvOS)
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(AssetCollectionViewCell), forIndexPath: indexPath)
        
        if let cell = cell as? AssetCollectionViewCell {
            cell.asset = editorContext?.assets[indexPath.row]
        }
        
        return cell
    }
  #endif
}
