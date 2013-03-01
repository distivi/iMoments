//
//  BaseTableViewController.h
//  iMoments
//
//  Created by Stas Dymedyuk on 2/28/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUIProtocol.h"
#import "CustomImageView.h"

@interface BaseTableViewController : UITableViewController<BaseUIProtocol>

@property (nonatomic, strong) CustomImageView *mainBackgroundImageView;

@end
