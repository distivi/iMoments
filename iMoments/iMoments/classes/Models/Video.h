//
//  Video.h
//  iMoments
//
//  Created by Stas Dymedyuk on 2/28/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BaseVideoInterface.h"

@class Moment;

@interface Video : BaseVideoInterface

@property (nonatomic, retain) NSSet *moments;
@end

@interface Video (CoreDataGeneratedAccessors)

- (void)addMomentsObject:(Moment *)value;
- (void)removeMomentsObject:(Moment *)value;
- (void)addMoments:(NSSet *)values;
- (void)removeMoments:(NSSet *)values;

@end
