//
//  MyLibUtil.m
//  MyLib
//
//  Created by ou on 2013/12/06.
//  Copyright (c) 2013年 adore. All rights reserved.
//

#import "MyUtil.h"
#import "mach/mach.h"

@implementation MyUtil

//簡単なアラートメッセージを表示
+ (void)alert:(NSString *)msg title:(NSString *)title
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
	[alert show];
}

//OSバージョンを取得
+ (float)osVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

//APPバージョンを取得
+ (NSString *)appVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

//APPバージョンを取得(Build)
+ (NSString *)appVersionBuild
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

//画面サイズを取得
+ (CGRect)screenRect
{
    return [[UIScreen mainScreen] bounds];
}

//Jailbreakの検知
+ (BOOL)isJailBroken
{
    return [[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"];
}

//UUID作成
+ (NSString *)createUUID
{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    
    NSString *uuid = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
    CFRelease(uuidRef);
    
    return uuid;
}

//NSData → NSString 変換
+ (NSString *)NSDataToNSString:(NSData *)data
{
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

//NSString → NSData 変換
+ (NSData *)NSStringToNSData:(NSString *)str
{
    return [str dataUsingEncoding:NSUTF8StringEncoding];
}

//NSString → NSNumber 変換
+ (NSNumber *)NSStringToNSNumber:(NSString *)str
{
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setNumberStyle:NSNumberFormatterDecimalStyle];
    return [fmt numberFromString:str];
}

//現在の日時を取得
+ (NSString *)dateTime:(NSString *)format
{
    if(format == nil) {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

//現在のタイムスタンプを取得
+ (double)currentTimestamp
{
    return [[NSDate date] timeIntervalSince1970];
}

// 文字列をtrimする（スペースと改行を取り除く)
+ (NSString *)trim:(NSString *)str
{
    return [str stringByTrimmingCharactersInSet:
     [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

// ランダム文字列作成
+ (NSString *)randomString:(int)length
{
    char data[length];
    for (int x=0; x<length; data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:length encoding:NSUTF8StringEncoding];
}

// 文字列含むの判断
+ (BOOL)hasSubString:(NSString *)subStr string:(NSString *)fullStr
{
   return ([fullStr rangeOfString:subStr].location != NSNotFound);
}

//テキストをクリップボードにコピーする
+ (void)copyToClipboard:(NSString *)text
{
    [[UIPasteboard generalPasteboard] setString:text];
}

// UserDefaultsでON/OFF設定保存
+ (void)setUserDefaultsBool:(NSString *)key value:(BOOL)value
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:value forKey:key];
    [defaults synchronize];
}

// UserDefaultsでON/OFF設定取得
+ (BOOL)getUserDefaultsBool:(NSString *)key default:(BOOL)defaultValue
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults stringForKey:key] == nil) {
        return defaultValue;
    }
    return [defaults boolForKey:key];
}

// UserDefaultsで整数設定保存
+ (void)setUserDefaultsInteger:(NSString *)key value:(NSInteger)value
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:value forKey:key];
    [defaults synchronize];
}

// UserDefaultsで整数設定取得
+ (NSInteger)getUserDefaultsInteger:(NSString *)key default:(NSInteger)defaultValue
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults stringForKey:key] == nil) {
        return defaultValue;
    }
    return [defaults integerForKey:key];
}

// UserDefaultsで文字列設定保存
+ (void)setUserDefaultsString:(NSString *)key value:(NSString *)value
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

// UserDefaultsで文字列設定取得
+ (NSString *)getUserDefaultsString:(NSString *)key default:(NSString *)defaultValue
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [defaults stringForKey:key];
    if (value == nil) {
        return defaultValue;
    }
    return value;
}

// URLエンコード
+ (NSString *)urlEncode:(NSString *)urlStr
{
    return [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

// URLデコード
+ (NSString *)urlDecode:(NSString *)urlStr
{
    return [urlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

// NSDictionaryをコピーする
+ (NSMutableDictionary *)deepCopyDictionary:(NSDictionary *)dict
{
    return (NSMutableDictionary *)CFBridgingRelease(CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (CFDictionaryRef)dict, kCFPropertyListMutableContainers));
}

// アプリ使用言語を指定
+ (void)setAppLangCode:(NSString *)langCode
{
    [self setUserDefaultsString:@"app.LangCode" value:langCode];
}

// App内指定言語で文字列を翻訳
+ (NSString *)translate:(NSString *)key
{
    NSString *langCode = [self getUserDefaultsString:@"app.LangCode" default:@"en"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:langCode ofType:@"lproj"];
	
    NSBundle* languageBundle = [NSBundle bundleWithPath:path];
    return [languageBundle localizedStringForKey:key value:@"" table:nil];;
}

@end
