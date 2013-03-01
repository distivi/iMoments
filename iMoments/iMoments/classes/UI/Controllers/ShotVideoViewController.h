//
//  ShotVideoViewController.h
//  iMoments
//
//  Created by Stas Dymedyuk on 2/20/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "BaseViewController.h"
#import "VideoRecordingManager.h"

@interface ShotVideoViewController : BaseViewController<VideoRecordingManagerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UIButton *startPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *changeDeviceInputButton;
@property (weak, nonatomic) IBOutlet UIButton *turnLightButton;
@property (weak, nonatomic) IBOutlet UIButton *openVideoLibrary;

- (IBAction)back:(id)sender;
- (IBAction)startPauseRecord:(id)sender;

@end
