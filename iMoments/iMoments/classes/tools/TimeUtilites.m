//
//  TimeUtilites.m
//  iMoments
//
//  Created by Stas Dymedyuk on 3/7/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "TimeUtilites.h"

@implementation TimeUtilites

+ (NSString *)timeStringFromTime:(NSTimeInterval ) time {
  NSInteger hours, minutes, seconds, milliseconds;
  
  hours = (int)floorf(time / 3600);
  minutes = (int)floorf((time - (hours * 3600)) / 60);
  seconds = (int)(time - hours*3600 - minutes*60);
  milliseconds = (int)(time * 1000) % 1000;
  
  NSString *timeString = [NSString stringWithFormat:@"%c%d:%c%d:%c%d:%c%c%d",
                          (hours >= 10)?0:'0',hours,
                          (minutes >= 10)?0:'0',minutes,
                          (seconds >= 10)?0:'0',seconds,
                          (milliseconds > 100)?0:'0',(milliseconds > 10)?0:'0',milliseconds];  
  return timeString;
}

+ (NSString *)timeStringWithShortStyleFromTime:(NSTimeInterval ) time {
  NSString *timeString = [self timeStringFromTime:time];
  NSString *outputTime = nil;
  
  if (time <= 60) {
    outputTime = [timeString substringFromIndex:6];
  } else if (time <= 3600) {
    outputTime = [timeString substringFromIndex:3];
  } else {
    outputTime = timeString;
  }
  timeString = nil;
  
  return outputTime;
}


@end
