//
//  Engine.h
//  iMoments
//
//  Created by Stas Dymedyuk on 2/25/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelManager.h"
#import "VideoRecordingManager.h"

@interface Engine : NSObject

@property (nonatomic, strong) ModelManager *modelManager;
@property (nonatomic, strong) VideoRecordingManager *videoRecordingManager;

+ (Engine *)sharedInstants;

@end
