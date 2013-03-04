//
//  OrientationsTool.h
//  iMoments
//
//  Created by Stas Dymedyuk on 3/1/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrientationsTool : NSObject

+ (UIImageOrientation)imageOrientationFromDeviceOrientation:(UIDeviceOrientation) deviceOrientation;
+ (AVCaptureVideoOrientation)captureVideoOrientationFromStatusBarOrientation;
+ (UIInterfaceOrientation)interfaceOrientationFromDeviceOrientation:(UIDeviceOrientation) deviceOrientation;
+ (AVCaptureVideoOrientation)captureVideoOrientationFromDeviceOrientation:(UIDeviceOrientation) deviceOrientation;
+ (NSInteger)degreesForInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation;
+ (CGFloat)radiansForInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation;

@end
