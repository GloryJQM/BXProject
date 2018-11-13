//
//  LabelImageView.h
//  SmallCEO
//
//  Created by 任成龙 on 2017/5/31.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelImageView : UIView
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) void (^finishBlock)(NSInteger index, NSArray *array);
- (instancetype)initWithY:(CGFloat)y dataDic:(NSDictionary *)dataDic block:(void(^)(NSInteger index, NSArray *array))block;
@end
