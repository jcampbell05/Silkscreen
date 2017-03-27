//
//  UIKit+Aliases.swift
//  Silkscreen
//
//  Created by James Campbell on 3/27/17.
//  Copyright © 2017 SK. All rights reserved.
//

import Foundation
import AppKit

typealias PHAsset = Asset
typealias NSObject = AppKit.NSObject
typealias UIBlurEffectStyle = BlurEffectStyle
typealias UIColor = NSColor
typealias UICollectionReusableView = UXCollectionReusableView
typealias UICollectionView = UXCollectionView
typealias UICollectionViewCell = UXCollectionViewCell
typealias UICollectionViewController = UXCollectionViewController
typealias UICollectionViewLayoutAttributes = UXCollectionViewLayoutAttributes
typealias UIBarButtonItem = UXBarButtonItem
typealias UIEdgeInsets = NSEdgeInsets
typealias UIImage = NSImage
typealias UIImageView = UXImageView
typealias UIGestureRecognizerDelegate = AppKit.NSGestureRecognizerDelegate
typealias UIPasteboard = NSPasteboard
typealias UIPercentDrivenInteractiveTransition = PercentDrivenInteractiveTransition
typealias UIPresentationController = PresentationController
typealias UIPanGestureRecognizer = NSPanGestureRecognizer
typealias UINavigationControllerDelegate = UXNavigationControllerDelegate
typealias UITapGestureRecognizer = NSClickGestureRecognizer
typealias UILabel = UXLabel
typealias UIStackView = NSStackView
typealias UIViewControllerContextTransitioning = UXViewControllerContextTransitioning
typealias UIViewController = UXViewController
typealias UIViewPropertyAnimator = ViewPropertyAnimator
typealias UIVisualEffectView = NSVisualEffectView
typealias UIWindow = NSWindow

func UIEdgeInsetsMake(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> UIEdgeInsets {
  return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
}

func UIEdgeInsetsInsetRect(rect: CGRect, insets: UIEdgeInsets) -> CGRect {
  var rect = rect
  rect.origin.x	+= insets.left;
  rect.origin.y	+= insets.top;
  rect.size.width  -= (insets.left + insets.right);
  rect.size.height -= (insets.top  + insets.bottom);
  return rect;
}

enum ViewAnimationCurve : Int {
  
  
  case easeInOut // slow at beginning and end
  
  case easeIn // slow at beginning
  
  case easeOut // slow at end
  
  case linear
}

class Asset {
  
  static func fetchAssetsWithLocalIdentifiers(identifiers:[String], options: AnyObject?) -> FetchResult {
    return FetchResult()
  }
}

class PercentDrivenInteractiveTransition {
 
  func updateInteractiveTransition(progress: CGFloat) {
    
  }
  
  func finishInteractiveTransition() {
    
  }
  
  func cancelInteractiveTransition() {
    
  }
}

class FetchResult {
  var firstObject: AnyObject? = nil
}

class PresentationController {
  
  var containerView: UXView! = nil
  var presentedViewController: UXViewController! = nil
  
  func frameOfPresentedViewInContainerView() -> CGRect {
    return CGRect.zero
  }
  
  func presentationTransitionWillBegin() {
  }
  
  func presentationTransitionDidEnd(completed: Bool) {
  }
  
  func dismissalTransitionDidEnd(completed: Bool) {
  }
}

class ViewPropertyAnimator {
  
  var fractionComplete: CGFloat = 0.0
  var reversed: Bool = false
  
  init(duration: Double, curve: ViewAnimationCurve, animations: (() -> Swift.Void)? = nil) {
    
  }
  
  func startAnimation() {
    
  }
  
  func pauseAnimation() {
    
  }
}

public enum BlurEffectStyle : Int {
  
  
  case extraLight
  
  case light
  
  case dark
  
  
  @available(iOS 10.0, *)
  case regular // Adapts to user interface style
  
  @available(iOS 10.0, *)
  case prominent // Adapts to user interface style
}

class VisualEffect {
}

class UIBlurEffect : VisualEffect {
  
  private let style: BlurEffectStyle
  
  init(style: BlurEffectStyle) {
    self.style = style
  }
}

extension NSPasteboard {
  
  var string: String? {
    set {
      
    }
    
    get {
      return nil
    }
  }
  
  var hasStrings: Bool {
    return false
  }
  
  convenience init?(name: String, create: Bool) {
    self.init()
  }
}

extension NSVisualEffectView {
  
  var effect: VisualEffect? {
    set {
      
    }
    
    get {
      return nil
    }
  }
  
  convenience init(effect: VisualEffect?) {
    self.init(frame: NSRect.zero)
    
    self.effect = effect
  }
}

extension UXViewController {
  func beginAppearanceTransition(begin: Bool, animated: Bool) {
    
  }
  
  func endAppearanceTransition(begin: Bool, animated: Bool) {
    
  }
}
