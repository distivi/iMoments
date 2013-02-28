//
//  Engine.m
//  iMoments
//
//  Created by Stas Dymedyuk on 2/25/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "Engine.h"

@implementation Engine

+ (Engine *)sharedInstants {
  static Engine *_sharedInstants;
  
  static dispatch_once_t onceToken;  
  dispatch_once(&onceToken, ^{
    if (!_sharedInstants) {
      _sharedInstants = [[Engine alloc] init];
    }
  });
  return _sharedInstants;
}

- (ModelManager *)modelManager {
  if (!_modelManager) {
    _modelManager = [[ModelManager alloc] init];
  }
  return _modelManager;
}

- (VideoRecordingManager *)videoRecordingManager {
  if (!_videoRecordingManager) {
    _videoRecordingManager = [[VideoRecordingManager alloc] init];
  }
  return _videoRecordingManager;
}

@end
