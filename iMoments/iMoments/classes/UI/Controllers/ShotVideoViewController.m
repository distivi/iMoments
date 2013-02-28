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
  [[[Engine sharedInstants] videoRecordingManager] startSession];
  [[[Engine sharedInstants] videoRecordingManager] setDelegate:self];
}

- (void)viewWillDisappear:(BOOL)animated {
  [[[Engine sharedInstants] videoRecordingManager] stopSession];
}

#pragma mark - BaseUIProtocol

- (void)setCustomSetings {

}

- (void)createUI {
    
}

- (void)updateUI {
  
}

- (void)deleteUI {
  
}

#pragma mark - VideoRecordingManagerDelegate

- (void)captureVideoImageOutput:(UIImage *) outputImage {
  _videoImageView.image = outputImage;
}


@end
