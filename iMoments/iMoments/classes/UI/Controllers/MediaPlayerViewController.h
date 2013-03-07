//
//  MediaPlayerViewController.h
//  iMoments
//
//  Created by Stas Dymedyuk on 3/5/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "BaseViewController.h"

enum MediaPlayerType {
  mediaPlayerTypeSimpleWathicng = 0,
  mediaPlayerTypeConfirmVideo,
  mediaPlayerTypeSelectMoment,
  mediaPlayerTypePlayMoment
};

@class MediaPlayerViewController;

@protocol MediaPlayerViewControllerDelegate <NSObject>
@optional
- (void)mediaPlayerViewController:(MediaPlayerViewController *) mediaPlayer didFinishWithUrl:(NSURL *) videoUrl;
- (void)mediaPlayerViewControllerDidCancel:(MediaPlayerViewController *) mediaPlayer;
- (void)mediaPlayerViewController:(MediaPlayerViewController *) mediaPlayer
     didSelectMomentWithStartTime:(NSTimeInterval) startTime
                          endTime:(NSTimeInterval) endTime;

@end

@interface MediaPlayerViewController : BaseViewController

@property (nonatomic) NSInteger mediaPlayerType;
@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic, strong) Moment *moment;

@property (nonatomic, weak) id<MediaPlayerViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBarButton;
@property (weak, nonatomic) IBOutlet UIView *selectMomentView;


- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

- (IBAction)fixStartMomentTime:(id)sender;
- (IBAction)fixEndMomentTime:(id)sender;

@end
