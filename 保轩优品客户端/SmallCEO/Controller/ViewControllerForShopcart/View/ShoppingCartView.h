//
//  ShoppingCartView.h
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/13.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartView : UIView
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UILabel *sumMoneyLable;
@property (nonatomic, strong) UILabel *priceLable;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *headerLabel;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, copy) void (^finishBlock) (NSString *name) ;

- (instancetype)initWithY:(CGFloat)y block:(void (^) (NSString *name))block;
@end
