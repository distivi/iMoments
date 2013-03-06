//
//  EditVideoInfoViewController.m
//  iMoments
//
//  Created by Stas Dymedyuk on 3/6/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "EditVideoInfoViewController.h"

@interface EditVideoInfoViewController ()

@end

@implementation EditVideoInfoViewController


#pragma mark - IBActions

- (IBAction)addVideoToDB:(id)sender {
  if (_videoURL && ![_titleTF.text isEqualToString:@""]) {
    NSLog(@"_videoURL :%@",[_videoURL absoluteString]);
    NSLog(@"title :%@",_titleTF.text);
    
    [[[Engine sharedInstants] modelManager] addVideoWithVideoUrlString:[_videoURL absoluteString]
                                                                 title:_titleTF.text];
    [self performSegueWithIdentifier:@"Pop to Videos" sender:nil];
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
  [super deleteUI];
  
}



- (void)viewDidUnload {
  [self setTitleTF:nil];
  [super viewDidUnload];
}
@end
