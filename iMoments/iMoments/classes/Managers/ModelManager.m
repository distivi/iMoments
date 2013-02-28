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

- (NSArray *)allVideos {
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Video class])];
  NSError *error = nil;

  NSArray *videos = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
  if (error) {
    NSLog(@"%@ Error executing all videos: %@", [self class], [error localizedDescription]);
    return nil;
  }
  return videos;
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
