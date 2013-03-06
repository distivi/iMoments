//
//  Moment.h
//  iMoments
//
//  Created by Stas Dymedyuk on 3/6/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BaseVideoInterface.h"

@class Video;

@interface Moment : BaseVideoInterface

@property (nonatomic, retain) NSNumber * startTime;
@property (nonatomic, retain) Video *video;

@end
