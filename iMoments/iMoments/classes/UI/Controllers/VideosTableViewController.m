//
//  VideosTableViewController.m
//  iMoments
//
//  Created by Stas Dymedyuk on 2/28/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "VideosTableViewController.h"

@interface VideosTableViewController ()

@end

@implementation VideosTableViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self.navigationController setNavigationBarHidden:NO animated:animated];
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



#pragma mark - Actions

- (void)addNewVideo {
  [self performSegueWithIdentifier:@"Make new video" sender:nil];
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 70)];
  header.backgroundColor = [UIColor lightGrayColor];
  
  UIButton *addVideoButton = [UIButton buttonWithType:UIButtonTypeCustom];
  addVideoButton.frame = CGRectMake(30, 10, 260, 50);
  addVideoButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  addVideoButton.backgroundColor = [UIColor greenColor];
  [addVideoButton setTitle:@"ADD VIDEO" forState:UIControlStateNormal];
  [addVideoButton addTarget:self action:@selector(addNewVideo) forControlEvents:UIControlEventTouchDown];
  [header addSubview:addVideoButton];
  
  return header;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifier = @"videoCellIdentifier";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:cellIdentifier];
  }
  
  cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
  
  return cell;
}

@end
