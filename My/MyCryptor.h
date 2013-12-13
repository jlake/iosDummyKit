//
//  MyCryptor.h
//  otaq-ios
//
//  Created by ou on 2013/12/13.
//  Copyright (c) 2013年 Adore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCryptor : NSObject

+ (NSString *)sha256:(NSString *)str withSalt:(NSString *)salt;

+ (NSData *)AES256EncryptData:(NSData *)data key:(NSString *)key;
+ (NSData *)AES256DecryptData:(NSData *)data key:(NSString *)key;

+ (NSString *)AES256EncryptString:(NSString *)str key:(NSString *)key;
+ (NSString *)AES256DecryptString:(NSString *)str key:(NSString *)key;

@end
