//
//  ShotVideoViewController.m
//  iMoments
//
//  Created by Stas Dymedyuk on 2/20/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "ShotVideoViewController.h"

@interface ShotVideoViewController ()

@end

@implementation ShotVideoViewController

#pragma mark - BaseUIProtocol

- (void)setCustomSetings {
  
}

- (void)createUI {
  picker = [[UIImagePickerController alloc] init];
  picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
  picker.videoQuality = UIImagePickerControllerQualityTypeMedium;
  picker.wantsFullScreenLayout = YES;
 
  picker.showsCameraControls = YES;
  picker.navigationBarHidden = YES;
  picker.toolbarHidden = YES;
  picker.delegate = self;
  
  [self addChildViewController:picker];
  [picker didMoveToParentViewController:self];
  [self.view addSubview:picker.view];
}

- (void)updateUI {
  
}

- (void)deleteUI {
  
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
  NSLog(@"didFinishPickingImage");
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  NSLog(@"didFinishPickingMediaWithInfo: %@",info);


}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  NSLog(@"imagePickerControllerDidCancel");
}

@end
