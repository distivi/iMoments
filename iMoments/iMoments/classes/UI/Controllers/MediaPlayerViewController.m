//
//  MediaPlayerViewController.m
//  iMoments
//
//  Created by Stas Dymedyuk on 3/5/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "MediaPlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "TimeUtilites.h"

@interface MediaPlayerViewController () {
  UILabel *startMomentTimelabel;
  UILabel *endMomentTimelabel;
  NSTimeInterval startMomentTime;
  NSTimeInterval endMomentTime;
}

- (void)setTimesToNull;
- (void)createPlayerWithMoment:(Moment *) moment;
- (BOOL)isHaveErrorWithSelectedTimesIsShowError:(BOOL) isShowError;

- (void)moviePlayBackDidFinish:(NSNotification*)notification;
- (void)moviePlayBackDidChange:(NSNotification*)notification;
- (void)playerIsAirPlayVideoActiveDidChangeNotification:(NSNotification*)notification;
- (void)playerReadyForDisplayDidChangeNotification:(NSNotification*)notification;

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
  [_moviePlayer pause];
  
  if (_delegate) {
    switch (_mediaPlayerType) {
      case mediaPlayerTypeConfirmVideo: {
        if ([_delegate respondsToSelector:@selector(mediaPlayerViewController:didFinishWithUrl:)]) {
          [_delegate mediaPlayerViewController:self didFinishWithUrl:_videoURL];
        }
        break;
      }
        
      case mediaPlayerTypeSelectMoment: {   
        
        if ([self isHaveErrorWithSelectedTimesIsShowError:YES]) {
          [self setTimesToNull];
          return;
        }
        
        if ([_delegate respondsToSelector:@selector(mediaPlayerViewController:didSelectMomentWithStartTime:endTime:)]) {
          [_delegate mediaPlayerViewController:self
                  didSelectMomentWithStartTime:startMomentTime
                                       endTime:endMomentTime];
        }
        break;
      }
        
      default:
        break;
    }
  }

  
  [[self presentingViewController] dismissModalViewControllerAnimated:YES];  
}

- (IBAction)fixStartMomentTime:(id)sender {
  startMomentTime = _moviePlayer.currentPlaybackTime;
  startMomentTimelabel.text = [NSString stringWithFormat:@"Start time: %@",[TimeUtilites timeStringFromTime:startMomentTime]];
}

- (IBAction)fixEndMomentTime:(id)sender {
  endMomentTime = _moviePlayer.currentPlaybackTime;
  endMomentTimelabel.text = [NSString stringWithFormat:@"End time: %@",[TimeUtilites timeStringFromTime:endMomentTime]];
}

#pragma mark - base UI protocol

- (void)setCustomSetings {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
  [super setCustomSetings]; 
}

- (void)createUI {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
  
  [self createPlayerWithMoment:_moment];
  
  CGFloat bottomHeightForPlayer = CGRectGetHeight(_toolBar.frame);
  
  switch (_mediaPlayerType) {
    case mediaPlayerTypeSimpleWathicng: {
      [_saveBarButton setEnabled:NO];
      break;
    }
      
    case mediaPlayerTypeConfirmVideo: {
      [_saveBarButton setEnabled:YES];
      break;
    }
      
    case mediaPlayerTypeSelectMoment: {
      [_saveBarButton setEnabled:YES];
      bottomHeightForPlayer += CGRectGetHeight(_selectMomentView.frame);
      
      startMomentTimelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 25)];
      startMomentTimelabel.backgroundColor = [UIColor clearColor];
      startMomentTimelabel.textColor = [UIColor yellowColor];
      [_moviePlayer.view addSubview:startMomentTimelabel];
      
      endMomentTimelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, 200, 25)];
      endMomentTimelabel.backgroundColor = [UIColor clearColor];
      endMomentTimelabel.textColor = [UIColor yellowColor];
      [_moviePlayer.view addSubview:endMomentTimelabel];
      
      [self setTimesToNull];
      break;
    }
      
    case mediaPlayerTypePlayMoment: {
      [_saveBarButton setEnabled:NO];
      if (_moment) {
        _moviePlayer.initialPlaybackTime = [_moment.startTime doubleValue];
        _moviePlayer.endPlaybackTime = [_moment.startTime doubleValue] + [_moment.duration doubleValue];
      }
      break;
    }
      
    default:
      break;
  }
  
  _moviePlayer.view.frame = CGRectMake(0,
                                       CGRectGetMaxY(_toolBar.frame),
                                       CGRectGetWidth(self.view.frame),
                                       CGRectGetHeight(self.view.frame) - bottomHeightForPlayer);
  
  
//  if (_videoURL) {
//    _moviePlayer =  [[MPMoviePlayerController alloc] initWithContentURL:_videoURL];
//    [_moviePlayer prepareToPlay];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(moviePlayBackDidFinish:)
//                                                 name:MPMoviePlayerPlaybackDidFinishNotification
//                                               object:_moviePlayer];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(moviePlayBackDidChange:)
//                                                 name:MPMoviePlayerNowPlayingMovieDidChangeNotification
//                                               object:_moviePlayer];
//        
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(playerIsAirPlayVideoActiveDidChangeNotification:)
//                                                 name:MPMoviePlayerIsAirPlayVideoActiveDidChangeNotification
//                                               object:_moviePlayer];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(playerReadyForDisplayDidChangeNotification:)
//                                                 name:MPMoviePlayerReadyForDisplayDidChangeNotification
//                                               object:_moviePlayer];
//        
//    _moviePlayer.controlStyle = MPMovieControlStyleDefault;
//    _moviePlayer.shouldAutoplay = NO;
//    _moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    
//    [self.view addSubview:_moviePlayer.view];
//    [_moviePlayer setFullscreen:YES animated:YES];
//  }
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
  [self setSaveBarButton:nil];
  [self setSelectMomentView:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:MPMoviePlayerPlaybackDidFinishNotification
                                                object:_moviePlayer];
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:MPMoviePlayerNowPlayingMovieDidChangeNotification
                                                object:_moviePlayer];
 

  
  [super deleteUI];
}

#pragma mark - Private methods

- (void)setTimesToNull {
  startMomentTime = 0;
  endMomentTime = 0;
  startMomentTimelabel.text = [NSString stringWithFormat:@"Start time: %@",[TimeUtilites timeStringFromTime:startMomentTime]];
  endMomentTimelabel.text = [NSString stringWithFormat:@"End time: %@",[TimeUtilites timeStringFromTime:endMomentTime]];
}

- (void)createPlayerWithMoment:(Moment *) moment {
  if (_videoURL) {
    _moviePlayer = nil;
    _moviePlayer =  [[MPMoviePlayerController alloc] initWithContentURL:_videoURL];
    [_moviePlayer prepareToPlay];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:_moviePlayer];  
    
    _moviePlayer.controlStyle = MPMovieControlStyleDefault;
    _moviePlayer.shouldAutoplay = NO;
    _moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    if (moment) {
      _moviePlayer.initialPlaybackTime = [moment.startTime doubleValue];
      _moviePlayer.endPlaybackTime = [moment.startTime doubleValue] + [moment.duration doubleValue];
    } 
    
    [self.view addSubview:_moviePlayer.view];
    [_moviePlayer setFullscreen:YES animated:YES];
  }

}

- (BOOL)isHaveErrorWithSelectedTimesIsShowError:(BOOL) isShowError {
  NSString *errorMsg = nil;
  if (abs(startMomentTime - endMomentTime) < 2) {
    errorMsg = @"Selected moment is to short, duration should be longer than 2 second";
  } else if (endMomentTime < startMomentTime) {
    errorMsg = @"you mix the beginning to the end";
  }
  if (errorMsg) {
    if (isShowError) {
      [[[UIAlertView alloc] initWithTitle:@"ERROR"
                                  message:errorMsg
                                 delegate:nil
                        cancelButtonTitle:@"OK"
                        otherButtonTitles:nil] show];
    }
    return YES;
  }
  return NO;
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
  NSLog(@"\n\n\n%@\n\n\n",NSStringFromSelector(_cmd));

  [[NSNotificationCenter defaultCenter]
   removeObserver:self
   name:MPMoviePlayerPlaybackDidFinishNotification
   object:_moviePlayer];
  
  if ([_moviePlayer
       respondsToSelector:@selector(setFullscreen:animated:)])
  {
    [_moviePlayer.view removeFromSuperview];
  }
  
  [self createPlayerWithMoment:nil];
}

- (void)moviePlayBackDidChange:(NSNotification*)notification {
  NSLog(@"\n\n\n%@\n\n\n",NSStringFromSelector(_cmd));
}

- (void)playerIsAirPlayVideoActiveDidChangeNotification:(NSNotification*)notification {
  NSLog(@"\n\n\n%@\n\n\n",NSStringFromSelector(_cmd));
}

- (void)playerReadyForDisplayDidChangeNotification:(NSNotification*)notification {
  NSLog(@"\n\n\n%@\n\n\n",NSStringFromSelector(_cmd));
}

@end
