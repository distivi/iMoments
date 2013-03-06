//
//  FileManager.m
//  iMoments
//
//  Created by Stas Dymedyuk on 3/6/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "FileManager.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation FileManager

//- (BOOL)isExistFileWithURLString:(NSString *) fileUrlString {
//  NSLog(@"fileUrlString = %@",fileUrlString);
//  
//  ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
//  
//  [assetLibrary assetForURL:[NSURL URLWithString:fileUrlString] resultBlock:^(ALAsset *asset)
//   {
//     if (asset) {
//       NSLog(@"File exist");
//       // Type your code here for successful
//     } else {
//       NSLog(@"File NOT exist");
//       // Type your code here for not existing asset
//     }
//     
// 
//   } failureBlock:^(NSError *err) {
//     NSLog(@"Error: %@",[err localizedDescription]);
//   }];
//  
//  return YES;
//}
//
//- (void)sortExistingAssetVideos:(NSArray *) videos
//            completitionHandler:(CheckExistingAssetVideos) completitionHandler {
//
//  __block NSMutableArray *existingVideos = nil;
//  __block NSMutableArray *notExistingVideos = nil;
//  ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
//  for (Video *tmpVideo in videos) {
//    [assetLibrary assetForURL:[NSURL URLWithString:tmpVideo.videoURL] resultBlock:^(ALAsset *asset)
//     {
//       if (asset) {
//         NSLog(@"File exist");
//         if (!existingVideos) {
//           existingVideos = [NSMutableArray array];
//         }
//         [existingVideos addObject:asset];
//         
//
//         // Type your code here for successful
//       } else {
//         NSLog(@"File NOT exist");
//         // Type your code here for not existing asset
//       }
//       
//       
//     } failureBlock:^(NSError *err) {
//       NSLog(@"Error: %@",[err localizedDescription]);
//     }];
//  }
//}


- (BOOL)assetVideoExistAtPath:(NSString *)assetsPath {
  __block BOOL imageExist = YES;
  dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
  dispatch_async(queue, ^{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library assetForURL:[NSURL URLWithString:assetsPath] resultBlock:^(ALAsset *asset) {
      if (asset) {
        dispatch_semaphore_signal(semaphore);
      } else {
        imageExist = NO;
        dispatch_semaphore_signal(semaphore);
      }
    } failureBlock:^(NSError *error) {
      NSLog(@"Error %@", error);
    }];
  });
  dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
  return imageExist;
}



@end
