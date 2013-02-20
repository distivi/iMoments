//
//  ShotVideoViewController.h
//  iMoments
//
//  Created by Stas Dymedyuk on 2/20/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "BaseViewController.h"

@interface ShotVideoViewController : BaseViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
  UIImagePickerController *picker;
}

@end
