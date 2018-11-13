//
//  ShopCartModel.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/28.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "ShopCartModel.h"
@implementation ShopCartModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.imageName = [NSString stringWithFormat:@"%@", dict[@"goods_img"]];
        self.goodsTitle = [NSString stringWithFormat:@"%@", dict[@"goods_name"]];
        self.goodsPrice = [NSString stringWithFormat:@"%@", dict[@"goods_price"]];
        self.goodsNum = [NSString stringWithFormat:@"%@", dict[@"goods_number"]];
        self.goodsType = [NSString stringWithFormat:@"%@", dict[@"goods_attr_str"]];
        self.idStr = [NSString stringWithFormat:@"%@", dict[@"id"]];
        self.relate_id = [NSString stringWithFormat:@"%@", dict[@"relate_id"]];
        self.goods_id = [NSString stringWithFormat:@"%@", dict[@"goods_id"]];
        self.status = [NSString stringWithFormat:@"%@", dict[@"status"]];
        self.status_info = [NSString stringWithFormat:@"%@", dict[@"status_info"]];
    }
    return self;
}
@end
