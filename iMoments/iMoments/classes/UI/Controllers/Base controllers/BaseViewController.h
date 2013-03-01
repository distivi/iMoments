//
//  BaseViewController.h
//  iMoments
//
//  Created by Stas Dymedyuk on 2/20/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "BaseUIProtocol.h"
#import "CustomImageView.h"

@interface BaseViewController : UIViewController<BaseUIProtocol>

@property (nonatomic, strong) CustomImageView *mainBackgroundImageView;

@end
