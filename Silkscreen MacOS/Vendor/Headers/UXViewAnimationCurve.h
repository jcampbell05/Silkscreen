//
//  UXViewAnimationCurve.h
//  Silkscreen
//
//  Created by James Campbell on 3/28/17.
//  Copyright © 2017 SK. All rights reserved.
//

#ifndef UXViewAnimationCurve_h
#define UXViewAnimationCurve_h

typedef NS_ENUM(NSInteger, UXViewAnimationCurve) {
  UXViewAnimationCurveEaseInOut,         // slow at beginning and end
  UXViewAnimationCurveEaseIn,            // slow at beginning
  UXViewAnimationCurveEaseOut,           // slow at end
  UXViewAnimationCurveLinear,
};

#endif /* UXViewAnimationCurve_h */
