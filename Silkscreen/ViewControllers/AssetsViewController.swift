//
//  AssetsViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/22/16.
//  Copyright © 2016 SK. All rights reserved.
//

import CoreDragon
import MobileCoreServices
import UICollectionViewLeftAlignedLayout
import UIKit

// - Fix layout issue cause by collection view
// - Use Diff
// - Simplify datasource
// - UIDocumentInteractionController Support
class AssetsViewController: UICollectionViewController, DragonDelegate {
    
    var editorContext: EditorContext? = nil {
        didSet {
            assetsDidChangeSlot = editorContext?.assetsDidChangeSignal.addSlot() {
                self.collectionView?.reloadData()
            }
        }
    }
    
    private var assetsDidChangeSlot: Slot? = nil
    
    lazy var addButton: UIBarButtonItem = {
       return UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(didPressAdd))
    }()
    
    init() {
        
        let layout = UICollectionViewLeftAlignedLayout()
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSizeMake(100, 100)

        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        title = NSLocalizedString("Assets", comment: "")
        navigationItem.leftBarButtonItem = addButton
        
        collectionView?.registerClass(AssetCollectionViewCell.self, forCellWithReuseIdentifier: String(AssetCollectionViewCell))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc private func didPressAdd() {

        // - Move to custom presentation 
        // - Form sheet with blurred background
        let viewController = AddAssetViewController()
        viewController.modalPresentationStyle = .FullScreen
        
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return editorContext?.assets.count ?? 0
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(AssetCollectionViewCell), forIndexPath: indexPath)
        
        if let cell = cell as? AssetCollectionViewCell {
            cell.asset = editorContext?.assets[indexPath.row]
        }
        
        // - Fix bug with multiple windows in PR to CoreDragon
        // - Add ability to remove highlight.
        registerDragSource(cell, delegate:self)
        
        return cell
    }
    
    func beginDragOperation(info: DragonInfo, fromView: UIView) {
        info.pasteboard.setValue("Hey", forPasteboardType:kUTTypePlainText as String)
    }
}