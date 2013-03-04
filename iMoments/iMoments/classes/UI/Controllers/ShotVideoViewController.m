//
//  ShotVideoViewController.m
//  iMoments
//
//  Created by Stas Dymedyuk on 2/20/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "ShotVideoViewController.h"
#import "OrientationsTool.h"

@interface ShotVideoViewController () {
  AVCaptureTorchMode currentTorchMode;
  AVCaptureDevicePosition currentDevicePosition;
}

@end

@implementation ShotVideoViewController


- (void)viewWillAppear:(BOOL)animated {
  [self.navigationController setNavigationBarHidden:YES animated:animated];
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [[[Engine sharedInstants] videoRecordingManager] setDelegate:self];
  [[[Engine sharedInstants] videoRecordingManager] startSession];
}

- (void)viewWillDisappear:(BOOL)animated {
  [self.navigationController setNavigationBarHidden:NO animated:animated];
  [super viewWillDisappear:animated];
  [[[Engine sharedInstants] videoRecordingManager] stopSession];
}

#pragma mark - BaseUIProtocol

- (void)setCustomSetings {

}

- (void)createUI {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
//  [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"UIApplicationSupportedInterfaceOrientationsIsEnabled"];
}

- (void)updateUI {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
}

- (void)updateUIWithInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation {
  for (id button in self.view.subviews) {
    if ([button isKindOfClass:[UIButton class]]) {
      [UIView animateWithDuration:0.3
                       animations:^{
                         [(UIButton *)button setTransform:CGAffineTransformMakeRotation([OrientationsTool radiansForInterfaceOrientation:interfaceOrientation])];
                       }];
    }  
  }
}

- (void)deleteUI {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
}

#pragma mark - IBActions 

- (IBAction)back:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)turnOnOffTorch:(id)sender {
  AVCaptureTorchMode nextTorchMode;
  
  switch (currentTorchMode) {
    case AVCaptureTorchModeOn: {
      nextTorchMode = AVCaptureTorchModeOff;
      break;
    }
    
    case AVCaptureTorchModeOff: {
      nextTorchMode = AVCaptureTorchModeOn;
      break;
    }
      
    default:
      nextTorchMode = AVCaptureTorchModeOff;
      break;
  }
  
  [[[Engine sharedInstants] videoRecordingManager] setTorchMode:nextTorchMode];
}

- (IBAction)changeCamera:(id)sender {
  AVCaptureDevicePosition nextDevicePosition;
  
  switch (currentDevicePosition) {
    case AVCaptureDevicePositionBack: {
      nextDevicePosition = AVCaptureDevicePositionFront;
      break;
    }
      
    case AVCaptureDevicePositionFront: {
      nextDevicePosition = AVCaptureDevicePositionBack;
      break;
    }
      
    default:
      nextDevicePosition = AVCaptureDevicePositionBack;
      break;
  }
  
  [[[Engine sharedInstants] videoRecordingManager] changeDevicePosition:nextDevicePosition];
  
}

- (IBAction)startPauseRecord:(id)sender {
  if (![[[[Engine sharedInstants] videoRecordingManager] recorder] isRecording]) {
    [[[Engine sharedInstants] videoRecordingManager] startRecordingVideo];
  } else {
    [[[Engine sharedInstants] videoRecordingManager] finishRecordingVideo];
  }
}

#pragma mark - VideoRecordingManagerDelegate

- (UIView *)videoPreviewView {
  return _videoImageView;
}

- (void)videoRecordingManager:(VideoRecordingManager *)captureManager hasTorch:(BOOL) hasTorch {
  _turnLightButton.enabled = hasTorch;
}

- (void)videoRecordingManager:(VideoRecordingManager *)captureManager hasFrontCamera:(BOOL) hasFrontCamera {
  _changeDeviceInputButton.enabled = hasFrontCamera;
}

- (void)videoRecordingManager:(VideoRecordingManager *)captureManager torchDidSetMode:(AVCaptureTorchMode) torchMode {
   NSLog(@"%@",NSStringFromSelector(_cmd));
  currentTorchMode = torchMode;
  switch (torchMode) {
    case AVCaptureTorchModeOff: {
      [_turnLightButton setTitle:@"OFF" forState:UIControlStateNormal];
      break;
    }
      
    case AVCaptureTorchModeOn: {
      [_turnLightButton setTitle:@"ON" forState:UIControlStateNormal];
      break;
    }
      
    case AVCaptureTorchModeAuto: {
      [_turnLightButton setTitle:@"Auto" forState:UIControlStateNormal];
      break;
    }
  }
}

- (void)videoRecordingManager:(VideoRecordingManager *)captureManager deviceDidChangePosition:(AVCaptureDevicePosition) devicePosition {
   NSLog(@"%@",NSStringFromSelector(_cmd));
  currentDevicePosition = devicePosition;
  
  switch (currentDevicePosition) {
    case AVCaptureDevicePositionBack: {
      [_changeDeviceInputButton setTitle:@"FRONT" forState:UIControlStateNormal];
      break;
    }
      
    case AVCaptureDevicePositionFront: {
      [_changeDeviceInputButton setTitle:@"BACK" forState:UIControlStateNormal];
      break;
    }
      
    default:
      [_changeDeviceInputButton setTitle:@"FRONT" forState:UIControlStateNormal];
      break;
  }
}


- (void)videoRecordingManager:(VideoRecordingManager *)captureManager didFailWithError:(NSError *)error {
  NSLog(@"%@",NSStringFromSelector(_cmd));
  NSLog(@"%@",[error localizedDescription]);
}

- (void)videoRecordingManagerRecordingBegan:(VideoRecordingManager *) videoRecordingManager {
  NSLog(@"%@",NSStringFromSelector(_cmd));
  [_startPauseButton setTitle:@"pause" forState:UIControlStateNormal];
  
}

- (void)videoRecordingManagerRecordingFinished:(VideoRecordingManager *) videoRecordingManager {
  NSLog(@"%@",NSStringFromSelector(_cmd));
  [_startPauseButton setTitle:@"start" forState:UIControlStateNormal];  
}


@end
