//
//  TimeUtilites.h
//  iMoments
//
//  Created by Stas Dymedyuk on 3/7/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeUtilites : NSObject

+ (NSString *)timeStringFromTime:(NSTimeInterval ) time;
+ (NSString *)timeStringWithShortStyleFromTime:(NSTimeInterval ) time;

@end
