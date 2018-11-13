//
//  SectionHeadView.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/28.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "SectionHeadView.h"

@implementation SectionHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self creationView];
    }
    return self;
}

- (void)creationView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, UI_SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    self.checkButton = [[UIButton alloc] initWithFrame:CGRectMake(16, 14, 20, 20)];
    [_checkButton setImage:[UIImage imageNamed:@"button-weixuanzhong@2x"] forState:UIControlStateNormal];
    [_checkButton setImage:[UIImage imageNamed:@"chartCheckbox@2x"] forState:UIControlStateSelected];
    [view addSubview:_checkButton];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(_checkButton.maxX + 20, 15, 20, 20)];
    imageView1.image = [UIImage imageNamed:@"填写订单:Icon@2x"];
    [view addSubview:imageView1];
    
    self.supplierLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView1.maxX + 10, 15, UI_SCREEN_WIDTH - imageView1.maxX - 20, 20)];
    _supplierLabel.textAlignment = NSTextAlignmentLeft;
    _supplierLabel.font = [UIFont systemFontOfSize:14];
    _supplierLabel.textColor = Color3D4E56;
    [view addSubview:_supplierLabel];
    
    [view addLineWithY:49.5];
}

- (void)setHeaderModel:(HeaderModel *)headerModel {
    _supplierLabel.text = headerModel.supplier_name;
    _checkButton.selected = headerModel.selectState;
}

@end
