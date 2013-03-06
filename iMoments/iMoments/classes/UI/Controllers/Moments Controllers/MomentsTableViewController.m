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

@interface MomentsTableViewController ()<VideoInfoHeaderDelegate>

@end

@implementation MomentsTableViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"show video"]) {
    NSURL *videoUrl = [NSURL URLWithString:_video.videoURL];
    [(MediaPlayerViewController *)segue.destinationViewController setVideoURL:videoUrl];
  }
}


#pragma mark - BaseUIProtocol

- (void)setCustomSetings {
  
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

#pragma mark -  VideoInfoHeaderDelegate

- (void)videoInfoHeaderEditInfo:(VideoInfoHeader *) videoInfoHeader {
  
}

- (void)videoInfoHeaderWatchVideo:(VideoInfoHeader *) videoInfoHeader {
  [self performSegueWithIdentifier:@"show video" sender:nil];  
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return [VideoInfoHeader height];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  VideoInfoHeader *header = [[VideoInfoHeader alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), [VideoInfoHeader height])];
  header.delegate = self;
  header.videoTitlelabel.text = _video.title;
  NSLog(@"video URL: %@",_video.videoURL);
  return header;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifier = @"momentsCellIdentifier";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:cellIdentifier];
  }
  
  
  cell.textLabel.text = @"moments";
  
  return cell;
}

@end
