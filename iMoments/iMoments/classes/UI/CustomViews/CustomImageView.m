//
//  CustomImageView.m
//  iMoments
//
//  Created by Stas on 01.03.13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "CustomImageView.h"

@interface CustomImageView()

- (void)setSettigns;

@end

@implementation CustomImageView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setSettigns];
  }
  return self;
}

- (void)awakeFromNib {
  [self setSettigns];
}

- (void)setImage:(UIImage *)image {
  self.backgroundColor = [UIColor colorWithPatternImage:image];
  super.image = nil;
}

#pragma mark - Private

- (void)setSettigns {
  self.backgroundColor = [UIColor colorWithPatternImage:self.image];
  self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  super.image = nil;
}

@end
