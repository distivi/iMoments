//
//  ModelManager.h
//  iMoments
//
//  Created by Stas Dymedyuk on 2/28/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Video.h"
#import "Moment.h"

@interface ModelManager : NSObject

- (void)saveContext;

//------------ Select --------------
- (NSArray *)allVideos;
- (NSArray *)allMomentsForVideo:(Video *) video;


//------------ Insert --------------
- (void)addVideoWithVideoUrlString:(NSString *) videoUrlString title:(NSString *) title;
- (void)addVideo:(Video *) video;

- (void)addMomentFromVideo:(Video *) video
                 withTitle:(NSString *) momentsTitle
                 startTime:(NSNumber *) startTime
                  duration:(NSNumber *) duration;

- (void)addMomentFromVideo:(Video *) video
                withMoment:(Moment *) moment;


//------------ Delete --------------
- (void)deleteVideo:(Video *) video;



@end
