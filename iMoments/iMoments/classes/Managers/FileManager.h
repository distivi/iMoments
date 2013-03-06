//
//  FileManager.h
//  iMoments
//
//  Created by Stas Dymedyuk on 3/6/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

//typedef void (^FacebookRequestResult)(id result, NSError *error);
//
//typedef void (^CheckExistingAssetVideos)(NSArray *existingVideos, NSArray *notExistingVideos);
//
//- (BOOL)isExistFileWithURLString:(NSString *) fileUrlString;
//
//- (void)sortExistingAssetVideos:(NSArray *) videos
//            completitionHandler:(CheckExistingAssetVideos) completitionHandler;

- (BOOL)assetVideoExistAtPath:(NSString *)assetsPath;


@end
