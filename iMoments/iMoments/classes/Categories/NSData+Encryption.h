//
//  NSData+Encryption.h
//  iMoments
//
//  Created by Stas Dymedyuk on 3/5/13.
//  Copyright (c) 2013 Stas Dymedyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Encryption)
//get from http://stackoverflow.com/questions/11482470/ios-5-data-encryption-aes-256-encryptwithkey-not-found

- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;

@end
