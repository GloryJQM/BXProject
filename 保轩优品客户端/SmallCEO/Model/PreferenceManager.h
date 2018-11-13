//
//  PreferenceManager.h
//  MobileOffice
//
//  Created by pan on 13-10-28.
//  Copyright (c) 2013年 wuxiaohui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@interface PreferenceManager : NSObject
{
    FMDatabase *_db;
}

+ (PreferenceManager *)sharedManager;
+ (void)cleanUp;

- (void)setPreference:(id)value forKey:(id)key;
- (id)preferenceForKey:(id)key;
- (id)allData;

@end
