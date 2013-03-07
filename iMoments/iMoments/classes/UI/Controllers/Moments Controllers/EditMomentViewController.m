//
//  EditMomentViewController.m
//  iMoments
//
//  Created by Stas Dymedyuk on 3/7/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "EditMomentViewController.h"

@interface EditMomentViewController ()

@end

@implementation EditMomentViewController

#pragma mark - IBActions


- (IBAction)confirmInfo:(id)sender {
  if (![_momentTitleLabel.text isEqualToString:@""]) {
    [[[Engine sharedInstants] modelManager] addMomentFromVideo:_video
                                                     withTitle:_momentTitleLabel.text
                                                     startTime:_startTime
                                                      duration:_duration];
    [self.navigationController popViewControllerAnimated:YES];
  }
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

#pragma mark - Base UI protocol

- (void)setCustomSetings {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
  [super setCustomSetings];
}

- (void)createUI {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
  [super createUI];
}

- (void)updateUI {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
  [super updateUI];
}

- (void)updateUIWithInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
  [super updateUIWithInterfaceOrientation:interfaceOrientation];
}

- (void)deleteUI {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
  _momentTitleLabel = nil;
  [super deleteUI];  
}


@end
