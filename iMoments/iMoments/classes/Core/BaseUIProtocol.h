//
//  BaseUIProtocol.h
//  iMoments
//
//  Created by Stas Dymedyuk on 2/20/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseUIProtocol <NSObject>

- (void)setCustomSetings;
- (void)createUI;
- (void)updateUI;
- (void)updateUIWithInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation;
- (void)deleteUI;

@end
