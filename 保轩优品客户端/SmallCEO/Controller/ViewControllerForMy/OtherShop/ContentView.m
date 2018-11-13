//
//  ContentView.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/5/31.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "ContentView.h"

@implementation ContentView
- (instancetype)initWithy:(CGFloat)y dataDic:(NSDictionary *)dataDic dicDic:(NSDictionary *)dicDic block:(void(^) (void))block{
    self = [super initWithFrame:CGRectMake(0, y, UI_SCREEN_WIDTH, 160)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.finishBlock = block;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, UI_SCREEN_WIDTH, 30)];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = [dataDic objectForKey:@"shop_name"] ;
        [self addSubview:titleLabel];
        
        
        NSString *distance = [NSString stringWithFormat:@"%@", [dicDic objectForKey:@"distance"]];
        if (![distance isBlankString]) {
            distance = @"0";
        }
        
        NSString *contentStr = [NSString stringWithFormat:@"%@ | %@ | %@", [dicDic objectForKey:@"shop_cat_name"], [dicDic objectForKey:@"address"],distance];
        
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
        NSRange range = [contentStr rangeOfString:@"|"];
        
        NSRange range1 = NSMakeRange(range.location + 3 + [NSString stringWithFormat:@"%@",[dicDic objectForKey:@"address"]].length, 1);
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:range];
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:range1];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, titleLabel.maxY + 10, UI_SCREEN_WIDTH - 10, 20)];
        contentLabel.textColor = [UIColor blackColor];
        contentLabel.font = [UIFont systemFontOfSize:13];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.attributedText = attStr ;
        [self addSubview:contentLabel];
        
        UILabel *consumeLabel = [[UILabel alloc] initWithFrame:CGRectMake(1., contentLabel.maxY + 10, UI_SCREEN_WIDTH - 20, 20)];
        consumeLabel.textColor = [UIColor lightGrayColor];
        consumeLabel.font = [UIFont systemFontOfSize:14];
        consumeLabel.textAlignment = NSTextAlignmentCenter;
        NSString *percent = [dicDic objectForKey:@"user_able_use_coupon_percent_text"];
        consumeLabel.text = percent;
        [self addSubview:consumeLabel];
        
        
        UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, consumeLabel.maxY + 20, UI_SCREEN_WIDTH - 90, 20)];
        addressLabel.textColor = [UIColor blackColor];
        addressLabel.font = [UIFont systemFontOfSize:15];
        addressLabel.numberOfLines = 0;
        addressLabel.textAlignment = NSTextAlignmentLeft;
        addressLabel.text = [dataDic objectForKey:@"address"];
        CGSize sizeForCardHolderLabel = [addressLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH - 90, 20)];
        addressLabel.frame = CGRectMake(20, consumeLabel.maxY + 20, UI_SCREEN_WIDTH - 90, sizeForCardHolderLabel.height);
        [self addSubview:addressLabel];
        
        
        self.phoneStr = [dataDic objectForKey:@"contact_tel"];
        UIButton *phoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 30, addressLabel.y, 20, 20)];
        [phoneBtn setBackgroundImage:[UIImage imageNamed:@"icon-dianhua@2x"] forState:UIControlStateNormal];
        [phoneBtn addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:phoneBtn];
        
        UIButton *mapBtn = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 60, phoneBtn.y, 20, 20)];
        [mapBtn addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
        [mapBtn setImage:[UIImage imageNamed:@"icon-fangxiang@2x"] forState:UIControlStateNormal];
        [self addSubview:mapBtn];
        
        DLog(@"%f", addressLabel.maxY);
        CGRect frame = self.frame;
        frame.size.height = addressLabel.maxY + 10;
        self.frame = frame;
    }
    return self;
}

- (void)callAction {
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",self.phoneStr];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    });
}

- (void)tapAction {
    if (self.finishBlock) {
        self.finishBlock();
    }
}

@end
