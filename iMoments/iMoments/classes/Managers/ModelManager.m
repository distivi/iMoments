//
//  ModelManager.m
//  iMoments
//
//  Created by Stas Dymedyuk on 2/28/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "ModelManager.h"

@interface ModelManager()

- (NSManagedObjectContext *)managedObjectContext;

@end

@implementation ModelManager

- (void)saveContext {
  NSError *error = nil;
  // Save the object to persistent store
  if (![[self managedObjectContext] save:&error]) {
    NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
  }  
}

#pragma mark - Select

- (NSArray *)allVideos {
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Video class])];
  NSError *error = nil;

  NSArray *videosFromDB = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
  if (error) {
    NSLog(@"%@ Error executing all videos: %@", [self class], [error localizedDescription]);
    return nil;
  }
  
  NSMutableArray *existingVideo = nil;
  
  for (Video *tmpVideo in videosFromDB) {
    NSLog(@"video: %@",tmpVideo.title);
    BOOL isExistVideo = [[[Engine sharedInstants] fileManager] assetVideoExistAtPath:tmpVideo.videoURL];
    NSLog(@"%@",(isExistVideo)?@"EXIST":@"NO");
    
    if (isExistVideo) {
      if (!existingVideo) {
        existingVideo = [NSMutableArray array];
      }
      [existingVideo addObject:tmpVideo];
    } else {
      [self deleteVideo:tmpVideo];
    }
  }
  videosFromDB = nil;
  
  return existingVideo;
}


- (NSArray *)allMomentsForVideo:(Video *) video {
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Moment class])];
  NSPredicate *prediate = [NSPredicate predicateWithFormat:@"video.videoURL == %@",video.videoURL];
  [fetchRequest setPredicate:prediate];
  
  NSError *error = nil;
  NSArray *moments = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
  
  if (error) {
    NSLog(@"%@ Error executing all videos: %@", [self class], [error localizedDescription]);
    return nil;
  }
  
  return moments;
}

#pragma mark - Instert

- (void)addVideoWithVideoUrlString:(NSString *) videoUrlString title:(NSString *) title duration:(CGFloat) durationInSeconds {
  
  Video *newVideo = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Video class])
                                                  inManagedObjectContext:[self managedObjectContext]];
  newVideo.videoURL = videoUrlString;
  newVideo.title = title;
  newVideo.duration = @(durationInSeconds);
  
  [self saveContext];  
}


- (void)addVideo:(Video *) video {
  if (video) {
    [self addVideoWithVideoUrlString:video.videoURL title:video.title duration:[video.duration floatValue]];
  }
}

- (void)addMomentFromVideo:(Video *) video
                 withTitle:(NSString *) momentsTitle
                 startTime:(NSNumber *) startTime
                  duration:(NSNumber *) duration {
  Moment *newMoment = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Moment class])
                                                    inManagedObjectContext:[self managedObjectContext]];
  newMoment.video = video;
  newMoment.title = momentsTitle;
  newMoment.startTime = startTime;
  newMoment.duration = duration;
  
  [self saveContext];
  
}

- (void)addMomentFromVideo:(Video *) video
                withMoment:(Moment *) moment {
  [self addMomentFromVideo:video withTitle:moment.title startTime:moment.startTime duration:moment.duration];
}

#pragma mark - Delete

- (void)deleteVideo:(Video *) video {
  if (video) {
    NSManagedObjectContext *context = [self managedObjectContext];
    [context deleteObject:video];
    [self saveContext];
  }
}

#pragma mark - Private methods

- (NSManagedObjectContext *)managedObjectContext {
  NSManagedObjectContext *context = nil;
  id delegate = [[UIApplication sharedApplication] delegate];
  if ([delegate respondsToSelector:@selector(managedObjectContext)]) {
    context = [delegate managedObjectContext];
  }
  return context;
}


@end
