//
//  VideoInfoHeader.m
//  iMoments
//
//  Created by Stas Dymedyuk on 3/6/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "VideoInfoHeader.h"

@implementation VideoInfoHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                                    owner:self
                                                  options:nil];
      [self addSubview:[nibs objectAtIndex:0]];
    }
    return self;
}

+ (CGFloat)height {
  return 200;
}

- (IBAction)editVideoInfo:(id)sender {
  if (_delegate && [_delegate respondsToSelector:@selector(videoInfoHeaderEditInfo:)]) {
    [_delegate videoInfoHeaderEditInfo:self];
  }
}

- (IBAction)watchVideo:(id)sender {
  if (_delegate && [_delegate respondsToSelector:@selector(videoInfoHeaderWatchVideo:)]) {
    [_delegate videoInfoHeaderWatchVideo:self];
  }
}

@end
