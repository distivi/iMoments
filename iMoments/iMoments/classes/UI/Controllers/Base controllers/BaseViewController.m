//
//  BaseViewController.m
//  iMoments
//
//  Created by Stas Dymedyuk on 2/20/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

- (void)interfaceOrientationFromNotification:(NSNotification *) notification;

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
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(interfaceOrientationFromNotification:)
                                               name:kNotification_DeviceRotation
                                             object:nil];
  [self updateUI];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  [self deleteUI];
  // Dispose of any resources that can be recreated.
}

#pragma mark - base UI protocol

- (void)setCustomSetings {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
}

- (void)createUI {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
  _mainBackgroundImageView = [[CustomImageView alloc] initWithFrame:self.view.bounds];  
  [_mainBackgroundImageView setImage:[UIImage imageNamed:@"real_cf"]];
  [self.view addSubview:_mainBackgroundImageView];
}

- (void)updateUI {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
}

- (void)updateUIWithInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
}

- (void)deleteUI {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
  _mainBackgroundImageView = nil;
}

#pragma mark - Private methods

- (void)interfaceOrientationFromNotification:(NSNotification *) notification {
  NSDictionary *userInfo = notification.userInfo;
  NSNumber *interfaceOrientation = [userInfo objectForKey:kInterfaceOrientation];
  
  [self updateUIWithInterfaceOrientation:[interfaceOrientation integerValue]];
}



@end
