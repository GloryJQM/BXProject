//
//  HeaderModel.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/28.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "HeaderModel.h"
#import "ShopCartModel.h"
@implementation HeaderModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.goodsArray = [NSMutableArray array];
        self.supplier_name = [NSString stringWithFormat:@"%@", dict[@"supplier_name"]];
        
        NSArray *list = dict[@"list"];
        for (NSDictionary *goodsDic in list) {
            ShopCartModel *shopCartModel = [[ShopCartModel alloc] initWithDict:goodsDic];
            [self.goodsArray addObject:shopCartModel];
        }
    }
    return self;
}
@end
