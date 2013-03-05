//
//  VideoRecordingManager.h
//  iMoments
//
//  Created by Stas Dymedyuk on 2/28/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "AVCamRecorder.h"

@class VideoRecordingManager;

@protocol VideoRecordingManagerDelegate <NSObject>

- (UIView *)videoPreviewView;

- (void)videoRecordingManager:(VideoRecordingManager *)captureManager hasTorch:(BOOL) hasTorch;
- (void)videoRecordingManager:(VideoRecordingManager *)captureManager hasFrontCamera:(BOOL) hasFrontCamera;
- (void)videoRecordingManager:(VideoRecordingManager *)captureManager torchDidSetMode:(AVCaptureTorchMode) torchMode;
- (void)videoRecordingManager:(VideoRecordingManager *)captureManager deviceDidChangePosition:(AVCaptureDevicePosition) devicePosition;

- (void)videoRecordingManager:(VideoRecordingManager *)captureManager didFailWithError:(NSError *)error;
- (void)videoRecordingManagerRecordingBegan:(VideoRecordingManager *) videoRecordingManager;
- (void)videoRecordingManagerRecordingAudioFinished:(VideoRecordingManager *) videoRecordingManager;
- (void)videoRecordingManagerRecordingVideoFinished:(VideoRecordingManager *) videoRecordingManager
                                        withFileURL:(NSURL *) videoUrl;

@end

@interface VideoRecordingManager : NSObject<AVCamRecorderDelegate>

@property (nonatomic, strong) AVCamRecorder *recorder;
@property (nonatomic, assign) UIBackgroundTaskIdentifier backgroundRecordingID;
@property (nonatomic, weak) id<VideoRecordingManagerDelegate> delegate;

- (void)startSession;
- (void)stopSession;

- (void)setTorchMode:(AVCaptureTorchMode) torchMode;
- (void)changeDevicePosition:(AVCaptureDevicePosition) devicePosition;

- (void)startRecordingVideo;
- (void)finishRecordingVideo;

@end
