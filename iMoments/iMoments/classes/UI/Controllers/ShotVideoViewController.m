//
//  ShotVideoViewController.m
//  iMoments
//
//  Created by Stas Dymedyuk on 2/20/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "ShotVideoViewController.h"

@interface ShotVideoViewController ()

@end

@implementation ShotVideoViewController


- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES animated:animated];
  [[[Engine sharedInstants] videoRecordingManager] setDelegate:self];
  [[[Engine sharedInstants] videoRecordingManager] startSession];
}

- (void)viewWillDisappear:(BOOL)animated {
  [self.navigationController setNavigationBarHidden:NO animated:animated];
  [[[Engine sharedInstants] videoRecordingManager] stopSession];
}

#pragma mark - BaseUIProtocol

- (void)setCustomSetings {

}

- (void)createUI {  
  [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"UIApplicationSupportedInterfaceOrientationsIsEnabled"];
}

- (void)updateUI {
  
}

- (void)deleteUI {
  
}

#pragma mark - IBActions 

- (IBAction)back:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
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

- (void)captureVideoImageOutput:(UIImage *) outputImage {
//  _videoImageView.image = outputImage;
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
