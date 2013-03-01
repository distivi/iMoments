//
//  OrientationsTool.m
//  iMoments
//
//  Created by Stas Dymedyuk on 3/1/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "OrientationsTool.h"

@implementation OrientationsTool

+ (UIImageOrientation)imageOrientationFromDeviceOrientation:(UIDeviceOrientation) deviceOrientation {
  
  NSString *deviceOrientationStr = nil;
  UIImageOrientation currentImageOrientation;
//  
//  currentImageOrientation = UIImageOrientationUp;
//  currentImageOrientation = UIImageOrientationDown;
//  currentImageOrientation = UIImageOrientationLeft;
//  currentImageOrientation = UIImageOrientationRight;
//  currentImageOrientation = UIImageOrientationUpMirrored;
//  currentImageOrientation = UIImageOrientationDownMirrored;
//  currentImageOrientation = UIImageOrientationLeftMirrored;
//  currentImageOrientation = UIImageOrientationRightMirrored;
  
  currentImageOrientation = UIImageOrientationRight;
  
  switch ([[UIDevice currentDevice] orientation]) {
    case UIDeviceOrientationUnknown: {
      deviceOrientationStr = @"UIDeviceOrientationUnknown";
      break;
    }
      
    case UIDeviceOrientationPortrait: {
      deviceOrientationStr = @"UIDeviceOrientationPortrait";
      currentImageOrientation = UIImageOrientationRight;
      break;
    }
      
    case UIDeviceOrientationPortraitUpsideDown: {
      deviceOrientationStr = @"UIDeviceOrientationPortraitUpsideDown";
      currentImageOrientation = UIImageOrientationLeft;
      break;
    }
      
    case UIDeviceOrientationLandscapeLeft: {
      deviceOrientationStr = @"UIDeviceOrientationLandscapeLeft";
      currentImageOrientation = UIImageOrientationUp;
      break;
    }
      
    case UIDeviceOrientationLandscapeRight: {
      deviceOrientationStr = @"UIDeviceOrientationLandscapeRight";
      currentImageOrientation = UIImageOrientationDown;
      break;
    }
      
    case UIDeviceOrientationFaceUp: {
      deviceOrientationStr = @"UIDeviceOrientationFaceUp";
      break;
    }
      
    case UIDeviceOrientationFaceDown: {
      deviceOrientationStr = @"UIDeviceOrientationFaceDown";
      break;
    }      
  }
  
  //NSLog(@"Current device orientation: %@",deviceOrientationStr);
  return currentImageOrientation;
}


+ (AVCaptureVideoOrientation)captureVideoOrientationFromStatusBarOrientation {
  AVCaptureVideoOrientation currentVideoOrientation;
  NSString *logOrientation = nil;
  
  switch([[UIApplication sharedApplication] statusBarOrientation]) {
    case UIInterfaceOrientationPortrait: {
      currentVideoOrientation = AVCaptureVideoOrientationPortrait;
      logOrientation = @"AVCaptureVideoOrientationPortrait";
      break;
    }
    case UIInterfaceOrientationPortraitUpsideDown: {
      currentVideoOrientation = AVCaptureVideoOrientationPortraitUpsideDown;
      logOrientation = @"AVCaptureVideoOrientationPortraitUpsideDown";
      break;
    }
    case UIInterfaceOrientationLandscapeLeft: {
      currentVideoOrientation = AVCaptureVideoOrientationLandscapeLeft;
      logOrientation = @"AVCaptureVideoOrientationLandscapeLeft";
      break;
    }
    case UIInterfaceOrientationLandscapeRight: {
      currentVideoOrientation = AVCaptureVideoOrientationLandscapeRight;
      logOrientation = @"AVCaptureVideoOrientationLandscapeRight";
      break;
    }
  }
  
  NSLog(@"%@ : %@",NSStringFromSelector(@selector(_cmd)),logOrientation);
  
  return currentVideoOrientation;
}

@end
