//
//  LuckyLocalData.h
//  LuckyDigger
//
//  Created by ou on 2013/02/26.
//  Copyright (c) 2013年 ou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLiteManager.h"


@interface MySqliteData : NSObject {
    SQLiteManager *_dbm;
}

// DBマネージャーを取得
- (SQLiteManager *)dbManager;

// 文字列をescape
- (NSString *)escape:(NSString *)str;

// DB初期化
- (void)initDb;

// テーブル存在チェック
- (BOOL)isTableExists:(NSString *)table;

// Key -> Valueを保存
- (BOOL)setValueForKey:(NSString *)key value:(NSString *)value;

// 指定KeyのValueを取得
- (NSString *)getValueForKey:(NSString *)key defaultValue:(NSString *)value;

// Keyを削除
- (BOOL)deleteKey:(NSString *)key;

// Key先頭文字列(一部)指定でValueを取得
- (NSDictionary *)getValuesByKeyPrefix:(NSString *)prefix;

@end
