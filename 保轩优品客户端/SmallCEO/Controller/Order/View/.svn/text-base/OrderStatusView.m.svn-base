//
//  OrderStatusView.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/12.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "OrderStatusView.h"

@interface OrderStatusView(){
    UILabel *contentLabel;
    NSString *_timeStr;
    
    NSDictionary *_dataDic;
    
}
@end

@implementation OrderStatusView
- (instancetype)initWithY:(CGFloat)y dataDic:(NSDictionary *)dataDic {
    self = [super initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 100)];
    if (self) {
        self.backgroundColor = [UIColor colorFromHexCode:@"#436D9C"];
        [self creationView:dataDic];
    }
    return self;
}

- (void)creationView:(NSDictionary *)dic {
    
    _dataDic = dic[@"order_head"];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(32, 21, 32, 24)];
    image.image = [UIImage imageNamed:@"订单详情:icon@2x"];
    [self addSubview:image];
    
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(77, 22, UI_SCREEN_HEIGHT - 77 - 15, 20)];
    statusLabel.text = [NSString stringWithFormat:@"%@", _dataDic[@"title"]];
    statusLabel.textColor = [UIColor whiteColor];
    statusLabel.font = [UIFont systemFontOfSize:16];
    statusLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:statusLabel];
    
    contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, image.maxY + 5, UI_SCREEN_WIDTH - 32 - 15, 20)];
    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.numberOfLines = 0;
    
    [self addSubview:contentLabel];
    
    _timeStr = [NSString stringWithFormat:@"%@", _dataDic[@"end_time"]];
    NSString *info = [NSString stringWithFormat:@"%@", _dataDic[@"info"]];
    if ([_timeStr isBlankString] && [info containsString:@"%time"]) {
        NSArray *array = [info componentsSeparatedByString:@"%time"];
        
        contentLabel.text = [NSString stringWithFormat:@"%@%@%@",[array firstObject], [_timeStr countDownStr], [array lastObject]];
        CGSize contentSize = [contentLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH - 64, 20)];
        contentLabel.frame = CGRectMake(32, image.maxY + 5, UI_SCREEN_WIDTH - 64, contentSize.height);
        
        self.aTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleSend) userInfo:nil repeats:YES];
        //开启定时器
        [_aTimer setFireDate:[NSDate distantPast]];
    }else {
        contentLabel.text = [NSString stringWithFormat:@"%@",info];
        CGSize contentSize = [contentLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH - 64, 20)];
        contentLabel.frame = CGRectMake(32, image.maxY + 5, UI_SCREEN_WIDTH - 64, contentSize.height);
        //关闭定时器
        [_aTimer setFireDate:[NSDate distantFuture]];
    }
}

- (void)handleSend {
    NSString *info = [NSString stringWithFormat:@"%@", _dataDic[@"info"]];
    NSArray *array = [info componentsSeparatedByString:@"%time"];
    
    contentLabel.text = [NSString stringWithFormat:@"%@%@%@",[array firstObject], [_timeStr countDownStr], [array lastObject]];
    CGSize contentSize = [contentLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH - 64, 20)];
    contentLabel.frame = CGRectMake(32, 58, UI_SCREEN_WIDTH - 64, contentSize.height);
}
@end
