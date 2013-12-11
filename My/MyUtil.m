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
+ (void)alert:(NSString *)msg title:(NSString *)title {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
	[alert show];
}

//OSバージョンを取得
+ (float)osVersion {
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

//APPバージョンを取得
+ (NSString *)appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

//APPバージョンを取得(Build)
+ (NSString *)appVersionBuild {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

//画面サイズを取得
+ (CGRect)screenRect {
    return [[UIScreen mainScreen] bounds];
}

//Jailbreakの検知
+ (BOOL)isJailBroken {
    return [[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"];
}

//UUID作成
+ (NSString *)createUUID {
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    
    NSString *uuid = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
    CFRelease(uuidRef);
    
    return uuid;
}

//NSData → NSString 変換
+ (NSString *)NSDataToNSString:(NSData *)data {
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

//NSString → NSData 変換
+ (NSData *)NSStringToNSData:(NSString *)str {
    return [str dataUsingEncoding:NSUTF8StringEncoding];
}

//NSString → NSNumber 変換
+ (NSNumber *)NSStringToNSNumber:(NSString *)str {
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setNumberStyle:NSNumberFormatterDecimalStyle];
    return [fmt numberFromString:str];
}

//現在の日時を取得
+ (NSString *)dateTime:(NSString *)format {
    if(format == nil) {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

// 文字列をtrimする（スペースと改行を取り除く)
+ (NSString *)trim:(NSString *)str {
    return [str stringByTrimmingCharactersInSet:
     [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//テキストをクリップボードにコピーする
+ (void)copyToClipboard:(NSString *)text {
    [[UIPasteboard generalPasteboard] setString:text];
}

// UserDefaultsでON/OFF設定保存
+ (void)userDefaultsBoolSet:(NSString *)key value:(BOOL)value {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:value forKey:key];
    [defaults synchronize];
}

// UserDefaultsでON/OFF設定取得
+ (BOOL)userDefaultsBoolGet:(NSString *)key default:(BOOL)defaultValue {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults stringForKey:key] == nil) {
        return defaultValue;
    }
    return [defaults boolForKey:key];
}

// UserDefaultsで整数設定保存
+ (void)userDefaultsIntegerSet:(NSString *)key value:(NSInteger)value {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:value forKey:key];
    [defaults synchronize];
}

// UserDefaultsで整数設定取得
+ (NSInteger)userDefaultsIntegerGet:(NSString *)key default:(NSInteger)defaultValue {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults stringForKey:key] == nil) {
        return defaultValue;
    }
    return [defaults integerForKey:key];
}

// UserDefaultsで文字列設定保存
+ (void)userDefaultsStringSet:(NSString *)key value:(NSString *)value {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

// UserDefaultsで文字列設定取得
+ (NSString *)userDefaultsStringGet:(NSString *)key default:(NSString *)defaultValue {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [defaults stringForKey:key];
    if (value == nil) {
        return defaultValue;
    }
    return value;
}

// URLエンコード
+ (NSString *)urlEncode:(NSString *)urlstr {
    return [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

// URLデコード
+ (NSString *)urlDecode:(NSString *)urlstr {
    return [urlstr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

// メモリ使用量
vm_size_t usedMemory(void) {
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    return (kerr == KERN_SUCCESS) ? info.resident_size : 0; // size in bytes
}

// 残りのメモリ
vm_size_t freeMemory(void) {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    
    host_page_size(host_port, &pagesize);
    (void) host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    return vm_stat.free_count * pagesize;
}

// メモリ使用状況をログに出す
+ (void)logMemUsage {
    // compute memory usage and log if different by >= 100k
    static long prevMemUsage = 0;
    long curMemUsage = usedMemory();
    long memUsageDiff = curMemUsage - prevMemUsage;
    
    if (memUsageDiff > 100000 || memUsageDiff < -100000) {
        prevMemUsage = curMemUsage;
        NSLog(@"Memory used %7.1f (%+5.0f), free %7.1f kb", curMemUsage/1000.0f, memUsageDiff/1000.0f, freeMemory()/1000.0f);
    }
}

@end
