//
//  VideoLibraryTableViewController.m
//  iMoments
//
//  Created by Stas Dymedyuk on 3/4/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import "VideoLibraryTableViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>

#import "AssetBrowserItem.h"
#import "MediaPlayerViewController.h"

@interface VideoLibraryTableViewController () {
  NSMutableArray *assetItems;
  MPMoviePlayerViewController *moviePlayerViewController;
}

- (void)updateAssetsLibrary;
- (void)videoPlayBackDidFinish:(NSNotification *) notification;
- (void)showVideoWithUrl:(NSURL *) videoUrl;


@end

@implementation VideoLibraryTableViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.destinationViewController respondsToSelector:@selector(setVideoURL:)]) {
    AssetBrowserItem *tmpItem = (AssetBrowserItem *)assetItems[[self.tableView indexPathForSelectedRow].row];
    [(MediaPlayerViewController *)segue.destinationViewController setVideoURL:tmpItem.URL];
  }
}


#pragma mark - BaseUIProtocol

- (void)setCustomSetings {
  [super setCustomSetings];
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
}

- (void)createUI {
  [super createUI];
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));  
}

- (void)updateUI {
  [super updateUI];
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
  [self updateAssetsLibrary];
}

- (void)deleteUI {
  [super deleteUI];
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
  assetItems = nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return assetItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifier = @"videoCellIdentifier";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:cellIdentifier];
  }
  
  AssetBrowserItem *tmpItem = (AssetBrowserItem *)assetItems[indexPath.row];
  cell.textLabel.text = tmpItem.title;
  cell.imageView.image = tmpItem.placeHolderImage;
  [cell setNeedsDisplay];
  
  return cell;
}

#pragma mark - Private Methods;

- (void)updateAssetsLibrary {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
	assetItems = nil;
  assetItems = [NSMutableArray arrayWithCapacity:0];
	ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
	
	[assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
    if (group) {
      [group setAssetsFilter:[ALAssetsFilter allVideos]];
      [group enumerateAssetsUsingBlock:
       ^(ALAsset *asset, NSUInteger index, BOOL *stop)
       {
         if (asset) {
           ALAssetRepresentation *defaultRepresentation = [asset defaultRepresentation];
           NSString *uti = [defaultRepresentation UTI];
           NSURL *URL = [[asset valueForProperty:ALAssetPropertyURLs] valueForKey:uti];
           NSString *title = [NSString stringWithFormat:@"%@ %i", NSLocalizedString(@"Video", nil), [assetItems count]+1];
           AssetBrowserItem *item = [[AssetBrowserItem alloc] initWithURL:URL title:title];
           
           [assetItems addObject:item];
         }
       }];
    } else {
      [self.tableView reloadData];
    }
    
	} failureBlock:^(NSError *error) {
    NSLog(@"error enumerating AssetLibrary groups %@\n", error);
  }];
}

- (void)videoPlayBackDidFinish:(NSNotification *) notification {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
}


- (void)showVideoWithUrl:(NSURL *) videoUrl {
  NSLog(@"call %@ in %@",NSStringFromSelector(_cmd),NSStringFromClass(self.class));
  
//  moviePlayerViewController = nil;
//  moviePlayerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:videoUrl];
//  [[moviePlayerViewController moviePlayer] prepareToPlay];
//  [[moviePlayerViewController moviePlayer] setShouldAutoplay:NO];
//  [[moviePlayerViewController moviePlayer] setControlStyle:MPMovieControlStyleFullscreen];  
//  [[moviePlayerViewController moviePlayer] setInitialPlaybackTime:(NSTimeInterval)5];
//  [[moviePlayerViewController moviePlayer] setEndPlaybackTime:(NSTimeInterval)10];
//  [[moviePlayerViewController moviePlayer] setRepeatMode:MPMovieRepeatModeNone];
//  
//  [[NSNotificationCenter defaultCenter] addObserver:self
//                                           selector:@selector(videoPlayBackDidFinish:)
//                                               name:MPMoviePlayerPlaybackDidFinishNotification
//                                             object:moviePlayerViewController];
//  [self presentMoviePlayerViewControllerAnimated:moviePlayerViewController];
}


@end
