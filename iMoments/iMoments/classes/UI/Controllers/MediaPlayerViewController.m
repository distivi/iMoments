//
//  MediaPlayerViewController.m
//  iMoments
//
//  Created by Stas Dymedyuk on 3/5/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "MediaPlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MediaPlayerViewController ()

- (void) moviePlayBackDidFinish:(NSNotification*)notification;

@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;

@end

@implementation MediaPlayerViewController

#pragma mark - IBActions

- (IBAction)cancel:(id)sender {
  [_moviePlayer stop];
  [[self presentingViewController] dismissModalViewControllerAnimated:YES];
  if (_delegate && [_delegate respondsToSelector:@selector(mediaPlayerViewControllerDidCancel:)]) {
    [_delegate mediaPlayerViewControllerDidCancel:self];
  }
}

- (IBAction)save:(id)sender {
  [_moviePlayer stop];
  [[self presentingViewController] dismissModalViewControllerAnimated:YES];
  if (_delegate && [_delegate respondsToSelector:@selector(mediaPlayerViewController:didFinishWithUrl:)]) {
    [_delegate mediaPlayerViewController:self didFinishWithUrl:_videoURL];
  }
}

#pragma mark - base UI protocol

- (void)setCustomSetings {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
}

- (void)createUI {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
  
  if (_videoURL) {
    _moviePlayer =  [[MPMoviePlayerController alloc]
                     initWithContentURL:_videoURL];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:_moviePlayer];
    
    _moviePlayer.controlStyle = MPMovieControlStyleDefault;
    _moviePlayer.shouldAutoplay = NO;
//    [_moviePlayer setInitialPlaybackTime:5.0];
//    [_moviePlayer setEndPlaybackTime:10.0];
    
    _moviePlayer.view.frame = CGRectMake(0,
                                         CGRectGetMaxY(_toolBar.frame),
                                         CGRectGetWidth(self.view.frame),
                                         CGRectGetHeight(self.view.frame) - CGRectGetHeight(_toolBar.frame));
    _moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_moviePlayer.view];
    [_moviePlayer setFullscreen:YES animated:YES];
  }
}

- (void)updateUI {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
}

- (void)updateUIWithInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
}

- (void)deleteUI {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
  _moviePlayer = nil;
  _toolBar = nil;
  [super deleteUI];
}

#pragma mark - Private methods

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
  MPMoviePlayerController *player = [notification object];
  [_moviePlayer setInitialPlaybackTime:-1];
  [_moviePlayer setEndPlaybackTime:-1];
  /*[[NSNotificationCenter defaultCenter]
   removeObserver:self
   name:MPMoviePlayerPlaybackDidFinishNotification
   object:player];
  
  if ([player
       respondsToSelector:@selector(setFullscreen:animated:)])
  {
    [player.view removeFromSuperview];
  }*/
}

@end
