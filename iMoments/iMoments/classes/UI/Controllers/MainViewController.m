//
//  MainViewController.m
//  iMoments
//
//  Created by Stas Dymedyuk on 2/20/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

#pragma mark - IBActions

- (IBAction)showListOfVideos:(id)sender {
  [self performSegueWithIdentifier:@"videoSegue" sender:nil];
}

@end
