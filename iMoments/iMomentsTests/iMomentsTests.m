//
//  iMomentsTests.m
//  iMomentsTests
//
//  Created by Stas Dymedyuk on 2/20/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "iMomentsTests.h"
#import "TimeUtilites.h"

@implementation iMomentsTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testTimeToString {
  NSArray *rightValues =  @[@"00:00:00:000",
  @"00:00:01:000",
  @"00:00:02:000",
  @"00:00:03:000",
  @"00:00:04:000",
  @"00:00:05:000",
  @"00:00:06:000",
  @"00:00:07:000",
  @"00:00:08:000",
  @"00:00:09:000",
  @"00:00:10:000",
  @"00:00:11:000",
  @"00:00:12:000",
  @"00:00:13:000",
  @"00:00:14:000",
  @"00:00:15:000",
  @"00:00:16:000",
  @"00:00:17:000",
  @"00:00:18:000",
  @"00:00:19:000",
  @"00:00:20:000",
  @"00:00:21:000",
  @"00:00:22:000",
  @"00:00:23:000",
  @"00:00:24:000",
  @"00:00:25:000",
  @"00:00:26:000",
  @"00:00:27:000",
  @"00:00:28:000",
  @"00:00:29:000",
  @"00:00:30:000",
  @"00:00:31:000",
  @"00:00:32:000",
  @"00:00:33:000",
  @"00:00:34:000",
  @"00:00:35:000",
  @"00:00:36:000",
  @"00:00:37:000",
  @"00:00:38:000",
  @"00:00:39:000",
  @"00:00:40:000",
  @"00:00:41:000",
  @"00:00:42:000",
  @"00:00:43:000",
  @"00:00:44:000",
  @"00:00:45:000",
  @"00:00:46:000",
  @"00:00:47:000",
  @"00:00:48:000",
  @"00:00:49:000",
  @"00:00:50:000",
  @"00:00:51:000",
  @"00:00:52:000",
  @"00:00:53:000",
  @"00:00:54:000",
  @"00:00:55:000",
  @"00:00:56:000",
  @"00:00:57:000",
  @"00:00:58:000",
  @"00:00:59:000",
  @"00:01:00:000"];
  
  
  for (int i = 0; i < rightValues.count; i++) {
    NSString *value_1 = rightValues[i];
    NSString *value_2 = [TimeUtilites timeStringFromTime:i];
    NSLog(@"%@ ? %@",value_1,value_2);
    STAssertEqualObjects(value_1, value_2, @"Time string in't correct");
  }
}

- (void)testExample
{
//    STFail(@"Unit tests are not implemented yet in iMomentsTests");
}

@end
