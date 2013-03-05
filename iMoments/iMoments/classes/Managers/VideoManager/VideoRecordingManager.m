//
//  VideoRecordingManager.m
//  iMoments
//
//  Created by Stas Dymedyuk on 2/28/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "VideoRecordingManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureOutput.h>

#import "OrientationsTool.h"

@interface VideoRecordingManager() {
  UIImageOrientation imageOrientationDuringRecording;
}

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureDevice *captureDevice;
@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput;
@property (nonatomic, strong) CIContext *context;

- (BOOL)isSupportFrontCamera;
- (AVCaptureDevice *)captureDeviceWithPosition:(AVCaptureDevicePosition) devicePosition;
- (BOOL)isSupportTorchForCaptureDevice:(AVCaptureDevice *) captureDevice;
- (void)setCuptureDeviceToSession:(AVCaptureDevice *) captureDevice;
- (void)removeAllInputsFromSession;

@end

@implementation VideoRecordingManager

- (id)init {
  if (self = [super init]) {
    _session = [[AVCaptureSession alloc] init];
    _session.sessionPreset = AVCaptureSessionPreset640x480;
    
    _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    _deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_captureDevice error:nil];
    
    if ([_session canAddInput:_deviceInput]) {
      [_session addInput:_deviceInput];
    } else {
      NSLog(@"Can't add Capture device input to session");
    }
            
    NSURL *outputFileURL = [self tempFileURL];
    _recorder = [[AVCamRecorder alloc] initWithSession:_session outputFileURL:outputFileURL];
    [_recorder setDelegate:self];    
  }
  return self;
}

- (void)setDelegate:(id<VideoRecordingManagerDelegate>)delegate {
  _delegate = delegate;
  if (_delegate) {
    if ([_delegate respondsToSelector:@selector(videoPreviewView)]) {
      UIView *previewView = [_delegate videoPreviewView];
      
      for (CALayer *tmpLayer in previewView.layer.sublayers) {
        if ([tmpLayer isKindOfClass:[AVCaptureVideoPreviewLayer class]]) {
          [tmpLayer removeFromSuperlayer];
        }
      }
      
      AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
      captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;      
      captureVideoPreviewLayer.frame = previewView.bounds;
      captureVideoPreviewLayer.needsDisplayOnBoundsChange = YES;
      
      [previewView.layer addSublayer:captureVideoPreviewLayer];
    }
    
    if ([_delegate respondsToSelector:@selector(videoRecordingManager:hasTorch:)]) {
      [_delegate videoRecordingManager:self hasTorch:[self isSupportTorchForCaptureDevice:_captureDevice]];
    }
    
    if ([_delegate respondsToSelector:@selector(videoRecordingManager:hasFrontCamera:)]) {
      [_delegate videoRecordingManager:self hasFrontCamera:[self isSupportFrontCamera]];
    }
    
    if ([_delegate respondsToSelector:@selector(videoRecordingManager:torchDidSetMode:)]) {
      [_delegate videoRecordingManager:self torchDidSetMode:_captureDevice.torchMode];
    }
    
    if ([_delegate respondsToSelector:@selector(videoRecordingManager:deviceDidChangePosition:)]) {
      [_delegate videoRecordingManager:self deviceDidChangePosition:_captureDevice.position];
    }
  }
}

- (CIContext *)context {
  if (!_context) {
    _context = [CIContext contextWithOptions:nil];
  }
  return _context;
}

- (void)startSession {
  if (![_session isRunning]) {
    [_session startRunning];
  }
}

- (void)stopSession {
  if ([_session isRunning]) {
    [_session stopRunning];
  }
}

- (void)changeDevicePosition:(AVCaptureDevicePosition) devicePosition {
  AVCaptureDevice *newCaptureDevice = [self captureDeviceWithPosition:devicePosition];
  [self setCuptureDeviceToSession:newCaptureDevice];
  if (_delegate) {
    if ([_delegate respondsToSelector:@selector(videoRecordingManager:deviceDidChangePosition:)]) {
      [_delegate videoRecordingManager:self deviceDidChangePosition:devicePosition];
    }
    
    if ([_delegate respondsToSelector:@selector(videoRecordingManager:hasTorch:)]) {
      [_delegate videoRecordingManager:self hasTorch:[self isSupportTorchForCaptureDevice:newCaptureDevice]];
    }
  }
  
}

- (void)startRecordingVideo {
  //imageOrientationDuringRecording = [OrientationsTool imageOrientationFromDeviceOrientation:[[UIDevice currentDevice] orientation]];
  NSLog(@"%@",NSStringFromSelector(_cmd));
  
  if ([[UIDevice currentDevice] isMultitaskingSupported]) {
    // Setup background task. This is needed because the captureOutput:didFinishRecordingToOutputFileAtURL: callback is not received until AVCam returns
		// to the foreground unless you request background execution time. This also ensures that there will be time to write the file to the assets library
		// when AVCam is backgrounded. To conclude this background execution, -endBackgroundTask is called in -recorder:recordingDidFinishToOutputFileURL:error:
		// after the recorded file has been saved.
    [self setBackgroundRecordingID:[[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{}]];
  }

  [self removeFile:[[self recorder] outputFileURL]];
  [_recorder startRecordingWithOrientation:[OrientationsTool captureVideoOrientationFromDeviceOrientation:[[UIDevice currentDevice] orientation]]];
}

- (void)finishRecordingVideo {
  NSLog(@"%@",NSStringFromSelector(_cmd));
  [_recorder stopRecording];
}

#pragma mark - AVCamRecorderDelegate

- (void)recorderRecordingDidBegin:(AVCamRecorder *)recorder {
  NSLog(@"%@",NSStringFromSelector(_cmd));
  if ([[self delegate] respondsToSelector:@selector(videoRecordingManagerRecordingBegan:)]) {
    [[self delegate] videoRecordingManagerRecordingBegan:self];
  }
}

-(void)recorder:(AVCamRecorder *)recorder recordingDidFinishToOutputFileURL:(NSURL *)outputFileURL error:(NSError *)error {
	if ([[self recorder] recordsAudio] && ![[self recorder] recordsVideo]) {
		// If the file was created on a device that doesn't support video recording, it can't be saved to the assets
		// library. Instead, save it in the app's Documents directory, whence it can be copied from the device via
		// iTunes file sharing.
		[self copyFileToDocuments:outputFileURL];
    
		if ([[UIDevice currentDevice] isMultitaskingSupported]) {
			[[UIApplication sharedApplication] endBackgroundTask:[self backgroundRecordingID]];
		}
    
		if ([[self delegate] respondsToSelector:@selector(videoRecordingManagerRecordingAudioFinished:)]) {
			[[self delegate] videoRecordingManagerRecordingAudioFinished:self];
		}
	}
	else {
		ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
		[library writeVideoAtPathToSavedPhotosAlbum:outputFileURL
                                completionBlock:^(NSURL *assetURL, NSError *error) {
                                  if (error) {
                                    if ([[self delegate] respondsToSelector:@selector(videoRecordingManager:didFailWithError:)]) {
                                      [[self delegate] videoRecordingManager:self didFailWithError:error];
                                    }
                                  } else {
                                    if ([[UIDevice currentDevice] isMultitaskingSupported]) {
                                      [[UIApplication sharedApplication] endBackgroundTask:[self backgroundRecordingID]];
                                    }
                                    
                                    if ([[self delegate] respondsToSelector:@selector(videoRecordingManagerRecordingVideoFinished:withFileURL:)]) {
                                      [[self delegate] videoRecordingManagerRecordingVideoFinished:self withFileURL:assetURL];
                                    }
                                  }
                                }];
		library = nil;
	}
}




#pragma mark - Private methods

+ (AVCaptureConnection *)connectionWithMediaType:(NSString *)mediaType fromConnections:(NSArray *)connections;
{
  for ( AVCaptureConnection *connection in connections ) {
    for ( AVCaptureInputPort *port in [connection inputPorts] ) {
      if ( [[port mediaType] isEqual:mediaType] ) {
        return connection;
      }
    }
  }
  return nil;
}

- (NSURL *) tempFileURL {  
  NSString *outputPath = [[NSString alloc] initWithFormat:@"%@%@", NSTemporaryDirectory(), @"temp_output.mov"];
  NSURL *outputURL = [[NSURL alloc] initFileURLWithPath:outputPath];
  NSFileManager *fileManager = [NSFileManager defaultManager];
  if ([fileManager fileExistsAtPath:outputPath]) {
    NSLog(@"file saved");
  }
  outputPath = nil;
  return outputURL;
}

- (void) removeFile:(NSURL *)fileURL
{
  NSString *filePath = [fileURL path];
  NSFileManager *fileManager = [NSFileManager defaultManager];
  if ([fileManager fileExistsAtPath:filePath]) {
    NSError *error;
    if ([fileManager removeItemAtPath:filePath error:&error] == NO) {
      if ([[self delegate] respondsToSelector:@selector(videoRecordingManager:didFailWithError:)]) {
        [[self delegate] videoRecordingManager:self didFailWithError:error];
      }
    }
  }
}

- (void) copyFileToDocuments:(NSURL *)fileURL
{
	NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd_HH-mm-ss"];
	NSString *destinationPath = [documentsDirectory stringByAppendingFormat:@"/output_%@.mov", [dateFormatter stringFromDate:[NSDate date]]];
	dateFormatter = nil;
	NSError	*error;
	if (![[NSFileManager defaultManager] copyItemAtURL:fileURL toURL:[NSURL fileURLWithPath:destinationPath] error:&error]) {
		if ([[self delegate] respondsToSelector:@selector(videoRecordingManager:didFailWithError:)]) {
      [[self delegate] videoRecordingManager:self didFailWithError:error];
    }
	}
}

- (BOOL)isSupportFrontCamera {
  NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
  for (AVCaptureDevice *device in devices) {
    if ([device position] == AVCaptureDevicePositionFront) {
      return YES;
    }
  }
  return NO;
}

- (AVCaptureDevice *)captureDeviceWithPosition:(AVCaptureDevicePosition) devicePosition {
  NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
  for (AVCaptureDevice *device in devices) {
    if ([device position] == devicePosition) {
      return device;
    }
  }
  return nil;
}

- (BOOL)isSupportTorchForCaptureDevice:(AVCaptureDevice *) captureDevice {
  return [captureDevice hasTorch];
}

- (void)setTorchMode:(AVCaptureTorchMode) torchMode {
  Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
  if (captureDeviceClass != nil) {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch] && [device isFlashModeSupported:torchMode]){
      [device lockForConfiguration:nil];
      [device setTorchMode:torchMode];
      [device unlockForConfiguration];
      if (_delegate && [_delegate respondsToSelector:@selector(videoRecordingManager:torchDidSetMode:)]) {
        [_delegate videoRecordingManager:self torchDidSetMode:torchMode];
      }
    }
  }
}



- (void)setCuptureDeviceToSession:(AVCaptureDevice *) captureDevice {
  [_session stopRunning];
  [self removeAllInputsFromSession];
  _captureDevice = nil;
  _captureDevice = captureDevice;
  
  NSError *error = nil;
  AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:_captureDevice error:&error];
  if (!input) {
    // Handle the error appropriately.
    NSLog(@"ERROR: trying to open camera: %@", error);
  } else {
    [_session addInput:input];
  }
  [_session startRunning];
}

- (void)removeAllInputsFromSession {
  for (AVCaptureDeviceInput *tmpInput in _session.inputs) {
    [_session removeInput:tmpInput];
  }
}

@end
