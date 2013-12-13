//
//  MyLibUtil.h
//  MyLib
//
//  Created by ou on 2013/12/06.
//  Copyright (c) 2013年 adore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyUtil : NSObject

//簡単なアラートメッセージを表示
+ (void)alert:(NSString *)msg title:(NSString *)title;

//OSバージョンを取得
+ (float)osVersion;

//APPバージョンを取得
+ (NSString *)appVersion;

//APPバージョンを取得(Build)
+ (NSString *)appVersionBuild;

//画面サイズを取得
+ (CGRect)screenRect;

//Jailbreakの検知
+ (BOOL)isJailBroken;

//UUID作成
+ (NSString *)createUUID;

//NSData → NSString 変換
+ (NSString *)NSDataToNSString:(NSData *)data;

//NSString → NSData 変換
+ (NSData *)NSStringToNSData:(NSString *)str;

//NSString → NSNumber 変換
+ (NSNumber *)NSStringToNSNumber:(NSString *)str;

//現在の日時を取得
+ (NSString *)dateTime:(NSString *)format;

//現在のタイムスタンプを取得
+ (double)currentTimestamp;

//文字列をtrimする（スペースと改行を取り除く)
+ (NSString *)trim:(NSString *)str;

// ランダム文字列作成
+ (NSString *)randomString:(int)length;

// 文字列含むの判断
+ (BOOL)hasSubString:(NSString *)subStr string:(NSString *)fullStr;

//テキストをクリップボードにコピーする
+ (void)copyToClipboard:(NSString *)str;

// UserDefaultsでON/OFF設定保存
+ (void)setUserDefaultsBool:(NSString *)key value:(BOOL)value;

// UserDefaultsでON/OFF設定取得
+ (BOOL)getUserDefaultsBool:(NSString *)key default:(BOOL)defaultValue;

// UserDefaultsで整数設定保存
+ (void)setUserDefaultsInteger:(NSString *)key value:(NSInteger)value;

// UserDefaultsで整数設定取得
+ (NSInteger)getUserDefaultsInteger:(NSString *)key default:(NSInteger)defaultValue;

// UserDefaultsで文字列設定保存
+ (void)setUserDefaultsString:(NSString *)key value:(NSString *)value;

// UserDefaultsで文字列設定取得
+ (NSString *)getUserDefaultsString:(NSString *)key default:(NSString *)defaultValue;

// URLエンコード
+ (NSString *)urlEncode:(NSString *)urlStr;

// URLデコード
+ (NSString *)urlDecode:(NSString *)urlStr;

// ディクショナリをコピーする
+ (NSMutableDictionary *) deepCopyDictionary:(NSDictionary *)dict;

// アプリ使用言語を指定
+ (void)setAppLangCode:(NSString *)langCode;

// App内指定言語で文字列を翻訳
+ (NSString *)translate:(NSString *)key;

@end
