//
//  TimelineViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/22/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class TimelineViewController: UICollectionViewController {
    
    let layout = TimelineCollectionViewLayout()
    
    init() {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = UIView(frame: CGRect(x: 200, y:0, width:50, height: 50))
        view.backgroundColor = UIColor.redColor()
        collectionView?.addSubview(view)
    }
}