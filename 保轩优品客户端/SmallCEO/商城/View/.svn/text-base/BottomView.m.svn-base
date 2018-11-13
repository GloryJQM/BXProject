//
//  BottomView.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/7.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "BottomView.h"
#import "UIButton+ImageTitleSpacing.h"
@implementation BottomView
- (instancetype)initWithBlock:(void (^)(NSString *titleString))block is_point_type:(NSInteger)is_point_type {
    CGFloat height = 64;
    self = [super initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT - height, UI_SCREEN_WIDTH, height)];
    if (self) {
        
        self.finishBlock = block;
        [self creationView:is_point_type];
    }
    return self;
}

- (void)creationView:(NSInteger)point {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 64)];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    
    [backView addLineWithY:0];
    
    UIButton *shopCart = [UIButton buttonWithType:UIButtonTypeCustom];
    shopCart.frame = CGRectMake(15, 10, 40, 44);
    [shopCart setTitle:@"购物车" forState:UIControlStateNormal];
    shopCart.titleLabel.font = [UIFont systemFontOfSize:11];
    [shopCart addTarget:self action:@selector(shopCart:) forControlEvents:UIControlEventTouchUpInside];
    [shopCart setTitleColor:[UIColor colorFromHexCode:@"#3C3C3E"] forState:UIControlStateNormal];
    [shopCart setImage:[UIImage imageNamed:@"CartIcon@2x"] forState:UIControlStateNormal];
    [backView addSubview:shopCart];
    [shopCart layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
    
    self.redPointLabel = [[UILabel alloc] initWithFrame:CGRectMake(shopCart.frame.size.width - 18, -6, 20, 20)];
    self.redPointLabel.textAlignment = NSTextAlignmentCenter;
    self.redPointLabel.font = [UIFont boldSystemFontOfSize:13];
    self.redPointLabel.textColor = [UIColor  whiteColor];
    self.redPointLabel.layer.cornerRadius = 10;
    self.redPointLabel.layer.backgroundColor = [ColorD0011B CGColor];
    _redPointLabel.hidden = YES;
    [shopCart addSubview:self.redPointLabel];
    
    self.collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _collectButton.frame = CGRectMake(shopCart.maxX + 20, 10, 40, 44);
    [_collectButton setTitle:@"收藏" forState:UIControlStateNormal];
    _collectButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [_collectButton addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchUpInside];
    [_collectButton setTitleColor:[UIColor colorFromHexCode:@"#3C3C3E"] forState:UIControlStateNormal];
    [_collectButton setImage:[UIImage imageNamed:@"Icon@2x"] forState:UIControlStateNormal];
    [_collectButton setImage:[UIImage imageNamed:@"icon_collection_1"] forState:UIControlStateSelected];
    [backView addSubview:_collectButton];
    [_collectButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:15];
    
    NSArray *titleAry;
    if (point == 0) {
        titleAry = @[@"立即购买", @"加入购物车"];
    }else {
        titleAry = @[@"立即兑换", @"加入购物车"];
    }
    CGFloat space = 10;
    CGFloat width = (UI_SCREEN_WIDTH - _collectButton.maxX - 30) / 2;
    for (int i = 0; i < titleAry.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(_collectButton.maxX + space + i * (width + space), 7, width, 50);
        button.layer.cornerRadius = 2;
        button.layer.masksToBounds = YES;
        [button setTitle:titleAry[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:button];
        if (i == 0) {
            button.layer.borderColor = App_Main_Color.CGColor;
            button.layer.borderWidth = 1;
            [button setTitleColor:App_Main_Color forState:UIControlStateNormal];
            button.backgroundColor = [UIColor whiteColor];
        }else {
            button.backgroundColor = App_Main_Color;
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.backgroundColor = App_Main_Color;
        }
    }
}

- (void)setCountStr:(NSString *)countStr {
    if ([countStr isEqualToString:@"0"]){
        self.redPointLabel.hidden = YES;
        self.redPointLabel.text = @"";
    }else {
        self.redPointLabel.hidden = NO;
        if (![self.redPointLabel.text isEqualToString:countStr] &&
            ![self.redPointLabel.text isEqualToString:@"0"]) {
            [UIView animateWithDuration:0.5 animations:^{
                self.redPointLabel.transform = CGAffineTransformMakeScale(1.5f, 1.5f);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.5 animations:^{
                    self.redPointLabel.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                } completion:^(BOOL finished) {
                }];
            }];
        }
        self.redPointLabel.text = countStr;
    }
}

- (void)setIsCollect:(BOOL)isCollect {
    self.collectButton.selected = isCollect;
}

- (void)shopCart:(UIButton *)sender {
    if (self.finishBlock) {
        self.finishBlock(@"购物车");
    }
}

- (void)collect:(UIButton *)sender {
    if (self.finishBlock) {
        NSString *title;
        if (!sender.selected) {
            title = @"收藏";
        }else {
            title = @"取消收藏";
        }
        self.finishBlock(title);
    }
}

- (void)handleButton:(UIButton *)sender {
    if (self.finishBlock) {
        self.finishBlock([sender currentTitle]);
    }
}

@end
