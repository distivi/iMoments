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
  
  switch (deviceOrientation) {
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

+ (UIInterfaceOrientation)interfaceOrientationFromDeviceOrientation:(UIDeviceOrientation) deviceOrientation {
  UIInterfaceOrientation currentInterfaceOrientation;

  switch (deviceOrientation) {
    case UIDeviceOrientationPortrait: {
      currentInterfaceOrientation = UIInterfaceOrientationPortrait;
      break;
    }
      
    case UIDeviceOrientationLandscapeLeft: {
      currentInterfaceOrientation = UIInterfaceOrientationLandscapeRight;
      break;
    }
      
    case UIDeviceOrientationLandscapeRight: {
      currentInterfaceOrientation = UIInterfaceOrientationLandscapeLeft;
      break;
    }
      
    case UIDeviceOrientationPortraitUpsideDown: {
      currentInterfaceOrientation = UIInterfaceOrientationPortraitUpsideDown;
      break;
    }
      
    default: {
      currentInterfaceOrientation = -1;
      break;
    }
  } 
  
  return currentInterfaceOrientation;
}

+ (AVCaptureVideoOrientation)captureVideoOrientationFromDeviceOrientation:(UIDeviceOrientation) deviceOrientation {
  UIInterfaceOrientation currentInterfaceOrientation = [OrientationsTool interfaceOrientationFromDeviceOrientation:deviceOrientation];
  AVCaptureVideoOrientation currentVideoOrientation;
    
  switch (currentInterfaceOrientation) {
    case UIInterfaceOrientationPortrait: {
      currentVideoOrientation = AVCaptureVideoOrientationPortrait;

      break;
    }
    case UIInterfaceOrientationPortraitUpsideDown: {
      currentVideoOrientation = AVCaptureVideoOrientationPortraitUpsideDown;

      break;
    }
    case UIInterfaceOrientationLandscapeLeft: {
      currentVideoOrientation = AVCaptureVideoOrientationLandscapeLeft;

      break;
    }
    case UIInterfaceOrientationLandscapeRight: {
      currentVideoOrientation = AVCaptureVideoOrientationLandscapeRight;

      break;
    }
  }
    
  return currentVideoOrientation;
}

+ (NSInteger)degreesForInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation {
  NSInteger degrees = 0;
  
  switch (interfaceOrientation) {
    case UIInterfaceOrientationPortrait: {
      degrees = 0;
      break;
    }
      
    case UIInterfaceOrientationPortraitUpsideDown: {
      degrees = 180;
      break;
    }
      
    case UIInterfaceOrientationLandscapeLeft: {
      degrees = -90;
      break;
    }
      
    case UIInterfaceOrientationLandscapeRight: {
      degrees = 90;
      break;
    }
      
    default:
      degrees = 0;
      break;
  }
  return degrees;
}

+ (CGFloat)radiansForInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation {
  return degreesToRadians([OrientationsTool degreesForInterfaceOrientation:interfaceOrientation]);  
}

@end
