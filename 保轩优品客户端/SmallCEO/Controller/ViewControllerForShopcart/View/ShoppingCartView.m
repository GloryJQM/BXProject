//
//  ShoppingCartView.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/13.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "ShoppingCartView.h"

@implementation ShoppingCartView
- (instancetype)initWithY:(CGFloat)y block:(void (^) (NSString *name))block {
    self = [super initWithFrame:CGRectMake(0, y, UI_SCREEN_WIDTH, 87)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.finishBlock = block;
        [self cretaionView];
    }
    return self;
}

- (void)cretaionView {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 32)];
    _headerView.backgroundColor = [UIColor colorFromHexCode:@"#FFF9F0"];
    [self addSubview:_headerView];
    
    self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 6, UI_SCREEN_WIDTH - 24, 20)];
    _headerLabel.textColor = Color74828B;
    _headerLabel.font = [UIFont systemFontOfSize:14];
    _headerLabel.textAlignment = NSTextAlignmentLeft;
    [_headerView addSubview:_headerLabel];
    
    self.selectButton = [[UIButton alloc] initWithFrame:CGRectMake(15, _headerView.maxY + 18, 20, 20)];
    [_selectButton setImage:[UIImage imageNamed:@"button-weixuanzhong@2x"] forState:UIControlStateNormal];
    [_selectButton setImage:[UIImage imageNamed:@"button-xuanzhong@2x"] forState:UIControlStateSelected];
    [_selectButton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_selectButton];
    
    self.sumMoneyLable=[[UILabel alloc] initWithFrame:CGRectMake(_selectButton.maxX + 8, _selectButton.minY, 100, 20)];
    _sumMoneyLable.font=[UIFont boldSystemFontOfSize:15];
    _sumMoneyLable.textAlignment = NSTextAlignmentLeft;
    _sumMoneyLable.textColor = Color3D4E56;
    _sumMoneyLable.text = @"已选 (0)";
    [self addSubview:_sumMoneyLable];
    
    self.priceLable=[[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 120 - 16 - 100, _selectButton.minY, 100, 20)];
    _priceLable.font=[UIFont boldSystemFontOfSize:15];
    _priceLable.textAlignment = NSTextAlignmentRight;
    _priceLable.textColor = [UIColor colorFromHexCode:@"#A31F2C"];
    [self addSubview:_priceLable];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(UI_SCREEN_WIDTH - 120, _headerView.maxY, 120, 55);
    [_button setTitle:@"提交订单" forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont systemFontOfSize:16];
    [_button addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button];
    _button.backgroundColor = App_Main_Color;
    
}

- (void)selectButton:(UIButton *)sender {
    NSString *string;
    if (!sender.selected) {
        string = @"全选";
    }else {
        string = @"取消全选";
    }
    if (self.finishBlock) {
        self.finishBlock(string);
    }
}

- (void)handleButton:(UIButton *)sender {
    if (self.finishBlock) {
        self.finishBlock([sender currentTitle]);
    }
}

@end
