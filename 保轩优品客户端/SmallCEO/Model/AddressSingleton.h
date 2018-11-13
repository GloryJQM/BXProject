//
//  AddressSingleton.h
//  Lemuji
//
//  Created by Cai on 15-7-28.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "AddressModel.h"

typedef enum
{
    Province,
    City,
    Area
}AddressType;

@interface AddressSingleton : AddressModel

+ (instancetype)sharedManager;

- (void)createAddressModel:(NSArray *)addressArray;

- (BOOL)didCreateAddressModel;

@end
