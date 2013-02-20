//
//  VideosViewController.m
//  iMoments
//
//  Created by Stas Dymedyuk on 2/20/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "VideosViewController.h"

@interface VideosViewController ()

- (void)addNewVideo;

@end

@implementation VideosViewController

#pragma mark - BaseUIProtocol

- (void)setCustomSetings {
  
}

- (void)createUI {
  
}

- (void)updateUI {
  
}

- (void)deleteUI {
  
}


#pragma mark - UITableView DataSources

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifier = @"videoCellIdentifier";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
  
  cell.textLabel.text = [NSString stringWithFormat:@"video: #%d",indexPath.row];
  
  return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 70)];
  header.backgroundColor = [UIColor lightGrayColor];
  
  UIButton *addVideoButton = [UIButton buttonWithType:UIButtonTypeCustom];
  addVideoButton.frame = CGRectMake(30, 10, 260, 50);
  addVideoButton.backgroundColor = [UIColor greenColor];
  [addVideoButton setTitle:@"ADD VIDEO" forState:UIControlStateNormal];
  [addVideoButton addTarget:self action:@selector(addNewVideo) forControlEvents:UIControlEventTouchDown];
  [header addSubview:addVideoButton];
  
  return header;
}

#pragma mark - Actions

- (void)addNewVideo { 
  [self performSegueWithIdentifier:@"ShotViewSegue" sender:nil];
}




@end
