//
//  HeaderModel.h
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/28.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeaderModel : NSObject
@property (strong,nonatomic) NSString *supplier_name;//商品图片
@property (nonatomic, strong) NSMutableArray *goodsArray;
@property(assign,nonatomic) BOOL selectState;//是否选中状态

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
