//
//  PopSegue.m
//  iMoments
//
//  Created by Stas Dymedyuk on 3/6/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "PopSegue.h"

@implementation PopSegue

- (void) perform {
  UIViewController *src = (UIViewController *) self.sourceViewController;
  
  NSInteger neededIndex = 0;
  
  for (UIViewController *currentVC in src.navigationController.viewControllers) {
    if ([currentVC isKindOfClass:[self.destinationViewController class]]) {
      neededIndex = [src.navigationController.viewControllers indexOfObject:currentVC];
    }
  }
  [src.navigationController popToViewController:[src.navigationController.viewControllers objectAtIndex:neededIndex] animated:YES];
}

@end
