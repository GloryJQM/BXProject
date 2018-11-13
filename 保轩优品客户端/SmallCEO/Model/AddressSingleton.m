//
//  AddressSingleton.m
//  Lemuji
//
//  Created by Cai on 15-7-28.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "AddressSingleton.h"

@interface AddressSingleton()

@property (nonatomic, assign) BOOL didCreateModel;

@end

@implementation AddressSingleton

+ (instancetype)sharedManager
{
    static AddressSingleton *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[AddressSingleton alloc] init];
    });
    
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.parentAddress = nil;
        self.majorID = @"0";
        self.name = @"root";
        self.didCreateModel = NO;
    }
    
    return self;
}

- (void)createAddressModel:(NSArray *)addressArray;
{
    self.didCreateModel = YES;
    [self createProviceModel:addressArray];
}

- (BOOL)didCreateAddressModel
{
    return self.didCreateModel;
}

#pragma mark - Create Address Structure
- (void)createProviceModel:(NSArray *)provinceArray
{
    for (NSDictionary *provinceDic in provinceArray)
    {
        AddressModel *model = [[AddressModel alloc] init];
        model.name = [provinceDic objectForKey:@"province"];
        model.majorID = [provinceDic objectForKey:@"provinceID"];
        model.parentAddress = self;
        [self.sonAddressArray addObject:model];
        [self createCityModel:[provinceDic objectForKey:@"citylist"] withProvinceModel:model];
    }
}

- (void)createCityModel:(NSArray *)cityArray withProvinceModel:(AddressModel *)province
{
    for (int i = 0; i < cityArray.count; i++)
    {
        AddressModel *model = [[AddressModel alloc] init];
        model.name = [[cityArray objectAtIndex:i] objectForKey:@"city"];
        model.majorID = [[cityArray objectAtIndex:i] objectForKey:@"cityID"];
        model.parentAddress = province;
        [province.sonAddressArray addObject:model];
        [self createAreaModel:[[cityArray objectAtIndex:i] objectForKey:@"arealist"] withCityModel:model];
    }
}

- (void)createAreaModel:(NSArray *)areaArray withCityModel:(AddressModel *)city
{
    for (NSDictionary *areaDic in areaArray)
    {
        AddressModel *model = [[AddressModel alloc] init];
        model.name = [areaDic objectForKey:@"area"];
        model.majorID = [areaDic objectForKey:@"areaID"];
        model.parentAddress = city;
        [city.sonAddressArray addObject:model];
    }
}

@end
