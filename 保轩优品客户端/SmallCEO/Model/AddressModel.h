//
//  AddressModel.h
//  Lemuji
//
//  Created by Cai on 15-7-28.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject

@property (nonatomic, strong) NSString *majorID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) AddressModel *parentAddress;
@property (nonatomic, strong) NSMutableArray *sonAddressArray;

@end
