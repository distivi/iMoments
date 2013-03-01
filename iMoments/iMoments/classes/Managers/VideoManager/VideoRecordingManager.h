//
//  VideoRecordingManager.h
//  iMoments
//
//  Created by Stas Dymedyuk on 2/28/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVCamRecorder.h"


@class VideoRecordingManager;

@protocol VideoRecordingManagerDelegate <NSObject>

- (void)captureVideoImageOutput:(UIImage *) outputImage;
- (UIView *)videoPreviewView;
- (void)videoRecordingManager:(VideoRecordingManager *)captureManager didFailWithError:(NSError *)error;
- (void)videoRecordingManagerRecordingBegan:(VideoRecordingManager *) videoRecordingManager;
- (void)videoRecordingManagerRecordingFinished:(VideoRecordingManager *) videoRecordingManager;

@end

@interface VideoRecordingManager : NSObject<AVCamRecorderDelegate>

@property (nonatomic, strong) AVCamRecorder *recorder;
@property (nonatomic, assign) UIBackgroundTaskIdentifier backgroundRecordingID;
@property (nonatomic, weak) id<VideoRecordingManagerDelegate> delegate;

- (void)startSession;
- (void)stopSession;

- (void)startRecordingVideo;
- (void)pauseRecordingVideo;
- (void)finishRecordingVideo;

@end
