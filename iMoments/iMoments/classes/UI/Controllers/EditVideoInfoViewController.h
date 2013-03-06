//
//  EditVideoInfoViewController.h
//  iMoments
//
//  Created by Stas Dymedyuk on 3/6/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "BaseViewController.h"

@interface EditVideoInfoViewController : BaseViewController<UITextFieldDelegate>

@property (nonatomic,strong) NSURL *videoURL;

@property (weak, nonatomic) IBOutlet UITextField *titleTF;

- (IBAction)addVideoToDB:(id)sender;

@end
