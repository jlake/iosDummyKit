//
//  SHKConfigurator.m
//  otaq-ios
//
//  Created by ou on 2014/01/22.
//  Copyright (c) 2014年 Adore. All rights reserved.
//

#import "SHKConfigurator.h"

@implementation SHKConfigurator


- (NSString*)appName {
	//return @"otaq";
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

- (NSString*)appURL {
	return @"http://earsea.com/otaq/";
}

- (NSString *)facebookAppId
{
    return @"719849204705693";
}

- (NSString*)facebookLocalAppId {
	return @"";
}

- (NSArray*)facebookWritePermissions {
    return [NSArray arrayWithObjects:@"publish_actions", nil];
}

- (NSArray*)facebookReadPermissions {
    return nil;
}


- (NSNumber*)forcePreIOS6FacebookPosting {
	return [NSNumber numberWithBool:true];
}

- (NSNumber*)forcePreIOS5TwitterAccess {
	return [NSNumber numberWithBool:true];
}


- (NSString*)twitterConsumerKey {
	return @"EhP0fJzv5tz9JKlLWGLw";
}

- (NSString*)twitterSecret {
	return @"lnfTkjUQIv5JaPQPGxdlTgQDCKlj0EKh2sijPlltRUk";
}

- (NSString*)twitterCallbackUrl {
	return @"http://earsea.com/otaq/";
    //return @"oob";
}

/*
 UI Configuration : Advanced
 ---------------------------
 */
- (NSNumber*)usePlaceholders {
	return [NSNumber numberWithBool:false];
}

/*
 Advanced Configuration
 ----------------------
 */
- (NSString*)sharersPlistName {
	return @"MySHKSharers.plist";
}

- (NSArray*)defaultFavoriteImageSharers {
    return [NSArray arrayWithObjects:@"SHKTwitter", @"SHKFacebook", nil];
}

- (NSNumber*)showActionSheetMoreButton {
    return [NSNumber numberWithBool:false];
}

- (NSNumber*)maxFavCount {
	return [NSNumber numberWithInt:5];
}

- (NSString*)favsPrefixKey {
	return @"SHK_FAVS_";
}

- (NSString*)authPrefix {
	return @"SHK_AUTH_";
}

- (NSNumber*)allowOffline {
	return [NSNumber numberWithBool:true];
}

- (NSNumber*)allowAutoShare {
	return [NSNumber numberWithBool:true];
}


@end
