//
//  SimpleButton.m
//  iMoments
//
//  Created by Stas Dymedyuk on 3/7/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "SimpleButton.h"

@implementation SimpleButton

- (void)awakeFromNib {
  int buttonStates[6] = {UIControlStateNormal,
    UIControlStateHighlighted,
    UIControlStateDisabled,
    UIControlStateSelected,
    UIControlStateApplication,
    UIControlStateReserved};
  
  for (int i = 0; i < 6; i++) {
    UIImage *tmpImage = [self backgroundImageForState:buttonStates[i]];
    if (tmpImage) {
      [self setBackgroundImage:tmpImage
                      forState:buttonStates[i]];

    }
  }
}

- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state {
  CGSize imageSize = image.size;
  [super setBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(imageSize.height/2,
                                                                                imageSize.width/2,
                                                                                imageSize.height/2,
                                                                                imageSize.width/2)]
                   forState:state];
}



@end