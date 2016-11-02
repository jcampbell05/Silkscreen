//
//  PreviewViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/22/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit
import GPUImage

// - Apple TV Support
// - Fullscreen Support
// - Picture In Picture ?
class PreviewViewController: UIViewController {
    
    let imageView = GPUImageView()
    let renderEngine = RenderEngine()

    var editorContext: EditorContext? = nil {
        didSet {
            if let editorContext = editorContext {
               renderEngine.render(editorContext)
            }
            
            editorContext?.trackItemsDidChangeSignal.addSlot { editorContext in
                self.renderEngine.render(editorContext)
            }
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        renderEngine.addTarget(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = imageView
    }
}
