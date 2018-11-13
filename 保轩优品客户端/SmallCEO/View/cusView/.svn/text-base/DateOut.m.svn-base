//
//  DateOut.m
//  gongfubao
//
//  Created by chensanli on 15/6/5.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "DateOut.h"

@implementation DateOut

-(int)allDayInYear:(int)year
{
    if(year%4 == 0 && year%100 !=0)
    {
        return 366;
    }else
    {
        return 365;
    }
}

-(int)allDayInYear:(int)year andMonth:(int)month
{
    if([self allDayInYear:year]==366)
    {
        if(month==1 || month==3 || month==5 || month==7 ||month==8 || month== 10 || month==12)
        {
            return 31;
        }else if(month==4 || month==6 || month==9 || month==11)
        {
            return 30;
        }else if(month == 2)
        {
            return 29;
        }else
        {
            return 0;
        }
    }else if([self allDayInYear:year]==365)
    {
        if(month==1 || month==3 || month==5 || month==7 ||month==8 || month== 10 || month==12)
        {
            return 31;
        }else if(month==4 || month==6 || month==9 || month==11)
        {
            return 30;
        }else if(month == 2)
        {
            return 28;
        }else
        {
            return 0;
        }
    }
    return 0;
}

-(int)theFirstDayIsInYear:(int)year andMonth:(int)month
{
    int Zyear = 1970;
    //int Zweek = 4;
    int allDay = 0;
    for(Zyear = 1970;Zyear<year;Zyear++)
    {
        allDay = allDay + [self allDayInYear:Zyear];
    }
    for(int i = 1;i<month;i++)
    {
        allDay = allDay + [self allDayInYear:year andMonth:i];
    }
    int week = (allDay+1+3)%7;
    return week+1;
}

-(int)theLastDayInLastMonth:(int)year and:(int)month
{
    if(month-1>0)
    {
        return [self allDayInYear:year andMonth:month-1];
    }else
    {
        return [self allDayInYear:year-1 andMonth:12];
    }
}
-(NSArray *)dayAllDayInYear:(int)year withMonth:(int)month
{
    if([self allDayInYear:year]==366)
    {
        if(month==1 || month==3 || month==5 || month==7 ||month==8 || month== 10 || month==12)
        {
            NSArray * array =  @[@"全部",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", @"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"];
            return array;
        }else if(month==4 || month==6 || month==9 || month==11)
        {
            return @[@"全部",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", @"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30"];
        }else if(month == 2)
        {
            return @[@"全部",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", @"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29"];
        }else
        {
            return 0;
        }
    }else if([self allDayInYear:year]==365)
    {
        if(month==1 || month==3 || month==5 || month==7 ||month==8 || month== 10 || month==12)
        {
            return @[@"全部",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", @"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"];
        }else if(month==4 || month==6 || month==9 || month==11)
        {
            return @[@"全部",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", @"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30"];
        }else if(month == 2)
        {
            return @[@"全部",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", @"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28"];
        }else
        {
            return 0;
        }
    }
    return 0;
    
    
}

@end
