//
//  BaseTabBarController.m
//  iMoments
//
//  Created by Stas Dymedyuk on 3/4/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "BaseTabBarController.h"
#import "OrientationsTool.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

// Older versions of iOS (deprecated) if supporting iOS < 5
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
  
  NSNumber *interfaceOrientation = [NSNumber numberWithInteger:[OrientationsTool interfaceOrientationFromDeviceOrientation:[[UIDevice currentDevice] orientation]]];
  
  NSNotification *notification = [NSNotification notificationWithName:kNotification_DeviceRotation
                                                               object:self
                                                             userInfo:@{kInterfaceOrientation: interfaceOrientation}];
  
  [[NSNotificationCenter defaultCenter] postNotification:notification];
  return NO;
}

// iOS6
- (BOOL)shouldAutorotate {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));  
  NSNumber *interfaceOrientation = [NSNumber numberWithInteger:[OrientationsTool interfaceOrientationFromDeviceOrientation:[[UIDevice currentDevice] orientation]]];
  
  NSNotification *notification = [NSNotification notificationWithName:kNotification_DeviceRotation
                                                               object:self
                                                             userInfo:@{kInterfaceOrientation: interfaceOrientation}];
  
  [[NSNotificationCenter defaultCenter] postNotification:notification];

  return NO;
}

// iOS6
- (NSUInteger)supportedInterfaceOrientations {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
  return UIInterfaceOrientationMaskLandscape | UIInterfaceOrientationMaskPortrait;
}

@end
