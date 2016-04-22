//
//  DividableViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 18/01/2016.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class DividableViewController: UIViewController {
    
    private let stackView = UIStackView(arrangedSubviews: [])
    
    var axis: UILayoutConstraintAxis = .Vertical {
        didSet {
            updateStackViewProperties()
        }
    }

    init(arrangedSubviewControllers: [UIViewController] = []) {
        super.init(nibName: nil, bundle: nil)
        arrangedSubviewControllers.forEach(addArrangedChildViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        updateStackViewProperties()
        view = stackView
    }
    
    func addArrangedChildViewController(viewController: UIViewController) {
        
        viewController.beginAppearanceTransition(true, animated: false)
        viewController.willMoveToParentViewController(self)
        addChildViewController(viewController)
        stackView.addArrangedSubview(viewController.view)
        viewController.endAppearanceTransition()
    }
    
    private func updateStackViewProperties() {
        
        stackView.axis = axis
        stackView.distribution = .Fill
        stackView.alignment = .Fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
}