//
//  EditMomentViewController.h
//  iMoments
//
//  Created by Stas Dymedyuk on 3/7/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "BaseViewController.h"

@interface EditMomentViewController : BaseViewController<UITextFieldDelegate>

@property (nonatomic, strong) Video *video;
@property (nonatomic, strong) NSNumber *startTime;
@property (nonatomic, strong) NSNumber *duration;

@property (weak, nonatomic) IBOutlet UITextField *momentTitleLabel;
- (IBAction)confirmInfo:(id)sender;

@end
