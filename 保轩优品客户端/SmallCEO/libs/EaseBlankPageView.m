//
//  EaseBlankPageView.m
//  LDWalkerMan
//
//  Created by 糖纸疯了 on 16/8/12.
//  Copyright © 2016年 糖纸疯了. All rights reserved.
//  1.有错误就直接显示错误，然后跳出循环
//  2.没有错误就显示

#import "EaseBlankPageView.h"

@implementation EaseBlankPageView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)configWithType:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block{
    
    if (hasData) {
        [self removeFromSuperview];
        return;
    }
    self.alpha = 1.0;
    //    图片
    if (!_monkeyView) {
        _monkeyView = [[UIImageView alloc] init];
        [self addSubview:_monkeyView];
        
    }
    //    文字
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = [UIFont systemFontOfSize:17];
        _tipLabel.textColor = [UIColor lightGrayColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipLabel];
    }
    
    //    布局ce
    _monkeyView.centerX = self.centerX;
    _monkeyView.centerY = self.y + UI_SCREEN_WIDTH / 2 + 50;

    _tipLabel.x = self.x;
    _tipLabel.width = self.width;
    
    _tipLabel.y = _monkeyView.maxY;

    _tipLabel.height = 50;
    

    
    _reloadButtonBlock = nil;
    
    if (!_reloadButton) {
        _reloadButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_reloadButton setImage:[UIImage imageNamed:@"blankpage_button_reload"] forState:UIControlStateNormal];
        _reloadButton.adjustsImageWhenHighlighted = YES;
        [_reloadButton addTarget:self action:@selector(reloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_reloadButton];

        _reloadButton.x = UI_SCREEN_WIDTH / 2 - 65;
        _reloadButton.y = _tipLabel.maxY;
        _reloadButton.size = CGSizeMake (130, 40);
    }
    _reloadButton.hidden = NO;
    _reloadButtonBlock = block;
    
    if (hasError) {
        //1.加载失败(改变图片)
        [_monkeyView setImage:[UIImage imageNamed:@"blankpage_image_loadFail"]];
        _tipLabel.text = @"服务器貌似出了点差错";
        //2.
        switch (blankPageType) {
            case EaseBlankPageTypeNoButton:{
                _reloadButton.hidden=YES;
            }
                break;
            default://其它页面（这里没有提到的页面，都属于其它）
            {
               _reloadButton.hidden=NO;
            }
                break;
        }
    }else{
        //        空白数据
        if (_reloadButton) {
            _reloadButton.hidden = NO;
        }
        NSString *imageName, *tipStr;
        switch (blankPageType) {
            case EaseBlankPageTypeOrderRefresh:
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"当前还没有该车辆信息,尝试其他车辆租赁";
            }
                break;
            case EaseBlankPageTypeReleaseRefresh:
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"当前无车辆信息发布";
            }
                break;
            case EaseBlankPageTypeGoodsRefresh:
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"当前无车辆交易订单";
            }
                break;
            case EaseBlankPageTypeCouponRefresh:
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"当前没有优惠券";
            }
                break;
            case EaseBlankPageTypePayDetailRefresh:
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"赔偿节目表完善中...";
            }
                break;
            case EaseBlankPageTypeMapRefresh:
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"没有定位权限，请开启后再试";
            }
                break;
            default://其它页面（这里没有提到的页面，都属于其它）
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"当前无数据";
            }
                break;
        }
        [_monkeyView setImage:[UIImage imageNamed:imageName]];
        _tipLabel.text = tipStr;
    }
}

- (void)reloadButtonClicked:(id)sender{
    self.hidden = YES;
    [self removeFromSuperview];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_reloadButtonBlock) {
            _reloadButtonBlock(sender);
        }
    });
}

@end
