//
//  MediaPlayerViewController.h
//  iMoments
//
//  Created by Stas Dymedyuk on 3/5/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "BaseViewController.h"

@class MediaPlayerViewController;

@protocol MediaPlayerViewControllerDelegate <NSObject>

- (void)mediaPlayerViewController:(MediaPlayerViewController *) mediaPlayer didFinishWithUrl:(NSURL *) videoUrl;
- (void)mediaPlayerViewControllerDidCancel:(MediaPlayerViewController *) mediaPlayer;

@end

@interface MediaPlayerViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBarButton;

@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic, weak) id<MediaPlayerViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
