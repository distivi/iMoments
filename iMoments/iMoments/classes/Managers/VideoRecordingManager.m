//
//  VideoRecordingManager.m
//  iMoments
//
//  Created by Stas Dymedyuk on 2/28/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "VideoRecordingManager.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoRecordingManager()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureDevice *captureDevice;
@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput;
//@property (nonatomic, strong) AVCaptureStillImageOutput *imageOutput;
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoDataOutput;
@property (nonatomic, strong) CIContext *context;

@end

@implementation VideoRecordingManager

- (id)init {
  if (self = [super init]) {
    _session = [[AVCaptureSession alloc] init];
    _session.sessionPreset = AVCaptureSessionPreset640x480;
    
    _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    _deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_captureDevice error:nil];
    
    _videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    _videoDataOutput.videoSettings = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA]
                                                                 forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    [_videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    
    [_session addInput:_deviceInput];
    [_session addOutput:_videoDataOutput];
  }
  return self;
}

- (CIContext *)context {
  if (!_context) {
    _context = [CIContext contextWithOptions:nil];
  }
  return _context;
}

- (void)startSession {
  [_session startRunning];
}

- (void)stopSession {
  [_session stopRunning];  
}


#pragma mark - AVCaptureAudioDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection {
  NSLog(@"captureOutput called");
  CVPixelBufferRef pb = CMSampleBufferGetImageBuffer(sampleBuffer);
  CIImage *ciImage = [CIImage imageWithCVPixelBuffer:pb];
  
  CGImageRef ref = [self.context createCGImage:ciImage fromRect:ciImage.extent];
  UIImage *outputImage = [UIImage imageWithCGImage:ref scale:1.0 orientation:UIImageOrientationRight];
  CGImageRelease(ref);
  
  if (_delegate && [_delegate respondsToSelector:@selector(captureVideoImageOutput:)]) {
    [_delegate captureVideoImageOutput:outputImage];
  }
}




@end
