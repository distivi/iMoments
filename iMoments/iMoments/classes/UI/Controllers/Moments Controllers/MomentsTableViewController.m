//
//  MomentsTableViewController.m
//  iMoments
//
//  Created by Stas Dymedyuk on 3/6/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "MomentsTableViewController.h"
#import "VideoInfoHeader.h"
#import "MediaPlayerViewController.h"
#import "EditMomentViewController.h"
#import "TimeUtilites.h"

#define kStartTime @"kStartTime"
#define kDuration @"kDuration"

@interface MomentsTableViewController ()<VideoInfoHeaderDelegate,MediaPlayerViewControllerDelegate> {
  NSMutableArray *moments;
}

@end

@implementation MomentsTableViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  moments = nil;
  moments = [NSMutableArray arrayWithArray:[[[Engine sharedInstants] modelManager] allMomentsForVideo:_video]];
  [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"show video"] ||
      [segue.identifier isEqualToString:@"select moment"] ||
      [segue.identifier isEqualToString:@"Play moment"]) {
    
    BOOL isGoToMediaPlayerToSelectMoment = [segue.identifier isEqualToString:@"select moment"];
    BOOL isOnlyPlayMoment = [segue.identifier isEqualToString:@"Play moment"];
    
    NSURL *videoUrl = [NSURL URLWithString:_video.videoURL];
    MediaPlayerViewController *nextVC = segue.destinationViewController;
    
    NSInteger mediaType = 0;
    if (isGoToMediaPlayerToSelectMoment) {
      mediaType = mediaPlayerTypeSelectMoment;
    } else if (isOnlyPlayMoment) {
      mediaType = mediaPlayerTypePlayMoment;
      nextVC.moment = moments[[self.tableView indexPathForSelectedRow].row];
    } else {
      mediaType = mediaPlayerTypeSimpleWathicng;
    }
    
    [nextVC setMediaPlayerType:mediaType];    
    [nextVC setDelegate:self];
    [nextVC setVideoURL:videoUrl];
    
  } else if ([segue.identifier isEqualToString:@"Add moment"]) {
    EditMomentViewController *nextVC = segue.destinationViewController;
    nextVC.video = _video;
    nextVC.startTime = (NSNumber *)[(NSDictionary *)sender objectForKey:kStartTime];
    nextVC.duration = (NSNumber *)[(NSDictionary *)sender objectForKey:kDuration];
  }
}


#pragma mark - BaseUIProtocol

- (void)setCustomSetings {
  [super setCustomSetings];  
}

- (void)createUI {
  [super createUI];
}

- (void)updateUI {
  [super updateUI]; 
  
}

- (void)deleteUI {
  [super deleteUI];
}

#pragma mark - MediaPlayerViewControllerDelegate

- (void)mediaPlayerViewController:(MediaPlayerViewController *) mediaPlayer
     didSelectMomentWithStartTime:(NSTimeInterval) startTime
                          endTime:(NSTimeInterval) endTime {
  NSDictionary *timeDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:startTime],kStartTime,
                                  [NSNumber numberWithDouble:(endTime - startTime)],kDuration, nil];
  [self performSegueWithIdentifier:@"Add moment" sender:timeDictionary];
}

#pragma mark -  VideoInfoHeaderDelegate

- (void)videoInfoHeaderEditInfo:(VideoInfoHeader *) videoInfoHeader {
  
}

- (void)videoInfoHeaderWatchVideo:(VideoInfoHeader *) videoInfoHeader {
  [self performSegueWithIdentifier:@"show video" sender:nil];  
}

- (void)videoInfoHeaderSelectMoment:(VideoInfoHeader *) videoInfoHeader {
  [self performSegueWithIdentifier:@"select moment" sender:nil];
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return [VideoInfoHeader height];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  VideoInfoHeader *header = [[VideoInfoHeader alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), [VideoInfoHeader height])];
  header.delegate = self;
  header.videoTitlelabel.text = _video.title;
  return header;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return moments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifier = @"momentsCellIdentifier";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:cellIdentifier];
  }
  
  Moment *currentMoment = moments[indexPath.row];
  
  cell.textLabel.text = currentMoment.title;
  cell.detailTextLabel.text = [NSString stringWithFormat:@"Moment duration: %@",[TimeUtilites timeStringFromTime:[currentMoment.duration floatValue]]];
  
  return cell;
}

@end
