//
//  VideoRecordingManager.m
//  iMoments
//
//  Created by Stas Dymedyuk on 2/28/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "VideoRecordingManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureOutput.h>

#import "OrientationsTool.h"

@interface VideoRecordingManager()<AVCaptureVideoDataOutputSampleBufferDelegate> {
  UIImageOrientation imageOrientationDuringRecording;
}

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureDevice *captureDevice;
@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput;

@property (nonatomic, strong) CIContext *context;

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
    
    
    AVCaptureVideoDataOutput *videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    videoDataOutput.videoSettings = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA]
                                                                forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    [videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];    
    
    if ([_session canAddOutput:videoDataOutput]) {
      [_session addOutput:videoDataOutput];
    } else {
      videoDataOutput = nil;
      NSLog(@"Can't add Video data otput to session");
    }
        
    NSURL *outputFileURL = [self tempFileURL];
    _recorder = [[AVCamRecorder alloc] initWithSession:_session outputFileURL:outputFileURL];
    [_recorder setDelegate:self];
    
  }
  return self;
}

- (void)setDelegate:(id<VideoRecordingManagerDelegate>)delegate {
  _delegate = delegate;
  if (_delegate && [_delegate respondsToSelector:@selector(videoPreviewView)]) {
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    UIView *previewView = [_delegate videoPreviewView];
    captureVideoPreviewLayer.frame = previewView.bounds;
    captureVideoPreviewLayer.needsDisplayOnBoundsChange = YES;
    
    [previewView.layer addSublayer:captureVideoPreviewLayer];
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
  [_recorder startRecordingWithOrientation:[OrientationsTool captureVideoOrientationFromStatusBarOrientation]];
}

- (void)pauseRecordingVideo {
  NSLog(@"%@",NSStringFromSelector(_cmd));

}

- (void)finishRecordingVideo {
  NSLog(@"%@",NSStringFromSelector(_cmd));
  [_recorder stopRecording];
}


#pragma mark - AVCaptureAudioDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection {
  
  CVPixelBufferRef pb = CMSampleBufferGetImageBuffer(sampleBuffer);
  CIImage *ciImage = [CIImage imageWithCVPixelBuffer:pb];
  
  CGImageRef ref = [self.context createCGImage:ciImage fromRect:ciImage.extent];
  
  UIImageOrientation currentImageOrientation;
  if (_recorder.isRecording) {
    currentImageOrientation = imageOrientationDuringRecording;
  } else {
    currentImageOrientation = [OrientationsTool imageOrientationFromDeviceOrientation:[[UIDevice currentDevice] orientation]];
  }
  
  UIImage *outputImage = [UIImage imageWithCGImage:ref scale:1.0 orientation:currentImageOrientation];
  CGImageRelease(ref);
  
  if (_delegate && [_delegate respondsToSelector:@selector(captureVideoImageOutput:)]) {
    [_delegate captureVideoImageOutput:outputImage];
  }
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
    
		if ([[self delegate] respondsToSelector:@selector(videoRecordingManagerRecordingFinished:)]) {
			[[self delegate] videoRecordingManagerRecordingFinished:self];
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
                                  }
                                  
                                  if ([[UIDevice currentDevice] isMultitaskingSupported]) {
                                    [[UIApplication sharedApplication] endBackgroundTask:[self backgroundRecordingID]];
                                  }
                                  
                                  if ([[self delegate] respondsToSelector:@selector(videoRecordingManagerRecordingFinished:)]) {
                                    [[self delegate] videoRecordingManagerRecordingFinished:self];
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

@end
