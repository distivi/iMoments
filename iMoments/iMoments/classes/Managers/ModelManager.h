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


//------------ Insert --------------
- (void)addVideoWithVideoUrlString:(NSString *) videoUrlString title:(NSString *) title;
- (void)addVideo:(Video *) video;


//------------ Delete --------------
- (void)deleteVideo:(Video *) video;



@end
