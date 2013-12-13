//
//  LuckyLocalData.m
//  LuckyDigger
//
//  Created by ou on 2013/02/26.
//  Copyright (c) 2013年 ou. All rights reserved.
//

#import "MySqliteData.h"

@implementation MySqliteData

// インスタンス初期化
- (id)init
{
    self = [super init];
    if(self) {
        _dbm = [[SQLiteManager alloc] initWithDatabaseNamed:@"AppData.db"];
        if(![self isTableExists:@"key_values"]) {
            [self initDb];
        }
    }
    return self;
}

// DBマネージャーを取得
- (SQLiteManager *)dbManager
{
    return _dbm;
}

// 文字列をescape
- (NSString *)escape:(NSString *)str
{
    return [str stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
}

// DB初期化
- (void)initDb
{
    //NSLog(@"initDb");
    NSArray *sqlArr = [NSArray
        arrayWithObjects:@"DROP TABLE IF EXISTS key_values;",
                      @"CREATE TABLE IF NOT EXISTS key_values (key VARCHAR(128) PRIMARY KEY, value TEXT);",
                      nil];
    
    for(NSString *sql in sqlArr){
        if (sql == nil) {
            break;
        }
        NSError *error = [_dbm doQuery:sql];
        if (error != nil) {
            NSLog(@"Error: %@",[error localizedDescription]);
        }
    }
}

// テーブル存在チェック
- (BOOL)isTableExists:(NSString *)table
{
    NSString *sql = [NSString stringWithFormat:@"SELECT name FROM sqlite_master WHERE type='table' AND name='%@';", table];
    NSArray *result = [_dbm getRowsForQuery:sql];

    return ([result count] == 0) ? NO : YES;
}

// Key -> Valueを保存
- (BOOL)setValueForKey:(NSString *)key value:(NSString *)value
{
    NSString *sql = nil;
    NSString *oldValue = [self getValueForKey:key defaultValue:nil];
    //NSLog(@"oldValue: %@", oldValue);
    NSString *newValue = [self escape:[NSString stringWithFormat:@"%@", value]];
    if (oldValue == nil) {
        sql = [NSString stringWithFormat:@"INSERT INTO key_values(key, value) VALUES('%@','%@');", key, newValue];
    } else {
        sql = [NSString stringWithFormat:@"UPDATE key_values SET value='%@' WHERE key = '%@';", newValue, key];
    }
    //NSLog(@"sql: %@", sql);
    NSError *error = [_dbm doQuery:sql];
    if (error != nil) {
        NSLog(@"Error: %@",[error localizedDescription]);
        return NO;
    }
    return YES;
}

// 指定KeyのValueを取得
- (NSString *)getValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue
{
    NSString *sql = [NSString stringWithFormat:@"SELECT value FROM key_values WHERE key = '%@';", key];
    NSArray *result = [_dbm getRowsForQuery:sql];

    if (result == nil || [result count] == 0) {
        return defaultValue;
    }
    return [result[0] valueForKey:@"value"];
}

// Keyを削除
- (BOOL)deleteKey:(NSString *)key
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM key_values WHERE key = '%@';", key];
    NSError *error = [_dbm doQuery:sql];
    if (error != nil) {
        NSLog(@"Error: %@",[error localizedDescription]);
        return NO;
    }
    return YES;
}

// Key先頭文字列(一部)指定でValueを取得
- (NSDictionary *)getValuesByKeyPrefix:(NSString *)prefix
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM key_values WHERE key LIKE '%@%@';", prefix, @"%"];
    NSArray *dataList = [_dbm getRowsForQuery:sql];
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    for(int i=0; i<[dataList count]; i++){
        NSDictionary *data = dataList[i];
        [info setObject:[data valueForKey:@"value"] forKey:[data valueForKey:@"key"]];
    }
    return info;
}


@end
