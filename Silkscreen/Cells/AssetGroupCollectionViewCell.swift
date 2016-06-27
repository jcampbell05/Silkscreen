//
//  AssetGroupCollectionViewCell.swift
//  Silkscreen
//
//  Created by James Campbell on 6/22/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class AssetGroupCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.frame = bounds
        
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
