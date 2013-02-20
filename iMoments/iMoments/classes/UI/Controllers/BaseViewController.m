//
//  BaseViewController.m
//  iMoments
//
//  Created by Stas Dymedyuk on 2/20/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


- (void)viewDidLoad {
  [super viewDidLoad];
  [self createUI];
  [self setCustomSetings];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self updateUI];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
  [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
  [self updateUI];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  [self deleteUI];
  // Dispose of any resources that can be recreated.
}


- (void)setCustomSetings {
  NSLog(@"call setCustomSetings in BaseViewController");
}

- (void)createUI {
  NSLog(@"call createUI in BaseViewController");
}

- (void)updateUI {
  NSLog(@"call updateU in BaseViewController");
}

- (void)deleteUI {
  NSLog(@"call deleteUI in BaseViewController");
}



@end
