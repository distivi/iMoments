//
//  VideoRecordingManager.h
//  iMoments
//
//  Created by Stas Dymedyuk on 2/28/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VideoRecordingManagerDelegate <NSObject>

- (void)captureVideoImageOutput:(UIImage *) outputImage;

@end

@interface VideoRecordingManager : NSObject

@property (nonatomic, weak) id<VideoRecordingManagerDelegate> delegate;

- (void)startSession;
- (void)stopSession;

@end
