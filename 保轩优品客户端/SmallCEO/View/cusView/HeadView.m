//
//  HeadView.m
//  SmallCEO
//
//  Created by 俊严 on 15/8/23.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = WHITE_COLOR;
        
        NSArray * array = @[@"    今日收益", @"    今日访问", @"    今日订单", @"    累计收益"];
        NSArray * numArray = @[@"¥ 0", @"0", @"0", @"0"];
        
        for (int i = 0; i < array.count; i++) {
            
            UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH / array.count * i, 0, UI_SCREEN_WIDTH/ array.count, 64)];
            backView.backgroundColor = WHITE_COLOR;
            [self addSubview:backView];
            
            UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, UI_SCREEN_WIDTH / array.count, 20)];
            titleLabel.text = array[i];
            titleLabel.textColor = SUB_TITLE;
            titleLabel.textAlignment = NSTextAlignmentCenter;

            titleLabel.font = [UIFont systemFontOfSize:13];
            [backView addSubview:titleLabel];
            
            UILabel * numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 37, UI_SCREEN_WIDTH  / array.count, 20)];
            numLabel.text = numArray[i];
            numLabel.textAlignment = NSTextAlignmentCenter;
            numLabel.font = [UIFont systemFontOfSize:13];
            [backView addSubview:numLabel];
            
            UIView * line = [[UIView alloc] initWithFrame:CGRectMake(10, 23, 1, 20)];
            line.backgroundColor = [UIColor colorFromHexCode:@"e6e6e6"];
            [backView addSubview:line];
            
            if(i == 1){
                _fangwenView = backView;
                _Label2 = numLabel;
               
            }else if (i == 2){
                _orderView = backView;
                _Label3 = numLabel;
            }else if (i == 0){
                _todayIncomeView = backView;
                _todayIncomeLabel = numLabel;
                
                 line.hidden = YES;
            }else if (i == 3){
                _addView = backView;
                _Label1 = numLabel;
                
            }

        }
    }
    return self;
}

@end