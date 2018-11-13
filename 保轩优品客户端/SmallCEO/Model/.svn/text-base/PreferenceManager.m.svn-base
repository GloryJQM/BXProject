//
//  PreferenceManager.m
//  MobileOffice
//
//  Created by pan on 13-10-28.
//  Copyright (c) 2013年 wuxiaohui. All rights reserved.
//

#import "PreferenceManager.h"

static PreferenceManager *sharedManager = nil;

#define KEY         @"data"

@implementation PreferenceManager

+(PreferenceManager *)sharedManager
{
    if (sharedManager == nil) {
        sharedManager = [[self alloc] init];
    }
    return sharedManager;
}

+ (void)cleanUp
{
    [sharedManager cleanUp];
    sharedManager = nil;
}

- (void)cleanUp
{
    [_db close];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        NSString *dbPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"preference.db"];
        _db = [[FMDatabase alloc] initWithPath:dbPath];
        [_db open];
        
        NSString *sql = @"CREATE TABLE IF NOT EXISTS preference(cfg text)";
        [_db executeUpdate:sql];
        
        if ([_db intForQuery:@"SELECT COUNT(cfg) FROM preference"] == 0) {
            sql = @"Insert INTO preference (cfg) VALUES ('')";
            [_db executeUpdate:sql];
        }

    }
    return self;
}


- (void)setPreference:(id)value forKey:(id)key
{
//    NSString *temp=( NSString *)value;
//    if ([temp length]<=0) {
//        return;
//    }
    NSMutableDictionary *newCfgs = [[NSMutableDictionary alloc] init];

    NSData *dbData = [_db dataForQuery:@"SELECT cfg FROM preference"];
    if (dbData.length > 3) {
        NSDictionary *dict = convertDataToObj(dbData);
        [newCfgs addEntriesFromDictionary:dict];
    }
    [newCfgs setValue:value forKey:key];
    
    NSData *data = convertObjToData(newCfgs);
    [_db executeUpdate:@"UPDATE preference SET cfg = ? where rowid = 1", data];
    [newCfgs removeAllObjects];
}

- (id)preferenceForKey:(NSString *)key
{
    id value = nil;
    NSData *data = [_db dataForQuery:@"SELECT cfg FROM preference"];
    if (data.length > 3) {
        NSDictionary *dict = convertDataToObj(data);
        value = [dict objectForKey:key];
    }
    return value;
}


- (id)allData
{
    NSData *data = [_db dataForQuery:@"SELECT * FROM preference"];
    NSDictionary *dict = convertDataToObj(data);
    return dict;
}

id convertObjToData(id obj)
{
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:obj forKey:KEY];
    [archiver finishEncoding];
    
    return data;
}

id convertDataToObj(NSData *data)
{
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id obj = [unarchiver decodeObjectForKey:KEY];
    [unarchiver finishDecoding];
    
    return obj;
}

@end
