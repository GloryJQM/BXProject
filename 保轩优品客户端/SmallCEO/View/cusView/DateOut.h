//
//  DateOut.h
//  gongfubao
//
//  Created by chensanli on 15/6/5.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateOut : NSObject
@property (nonatomic,assign)int year;
@property (nonatomic,assign)int month;
@property (nonatomic,assign)int day;
@property (nonatomic,assign)int week;

-(int)allDayInYear:(int)year;
-(int)allDayInYear:(int)year andMonth:(int)month;
-(int)theFirstDayIsInYear:(int)year andMonth:(int)month;
-(int)theLastDayInLastMonth:(int)year and:(int)month;
-(NSArray *)dayAllDayInYear:(int)year withMonth:(int)month;
@end
