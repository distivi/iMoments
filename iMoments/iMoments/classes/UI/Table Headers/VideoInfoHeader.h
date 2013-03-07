//
//  VideoInfoHeader.h
//  iMoments
//
//  Created by Stas Dymedyuk on 3/6/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoInfoHeader;

@protocol VideoInfoHeaderDelegate <NSObject>

- (void)videoInfoHeaderEditInfo:(VideoInfoHeader *) videoInfoHeader;
- (void)videoInfoHeaderWatchVideo:(VideoInfoHeader *) videoInfoHeader;
- (void)videoInfoHeaderSelectMoment:(VideoInfoHeader *) videoInfoHeader;


@end

@interface VideoInfoHeader : UIView

@property (weak, nonatomic) IBOutlet UILabel *videoTitlelabel;

@property (nonatomic, weak) id<VideoInfoHeaderDelegate> delegate;

- (IBAction)editVideoInfo:(id)sender;
- (IBAction)watchVideo:(id)sender;
- (IBAction)selectMoment:(id)sender;

+ (CGFloat)height;


@end
