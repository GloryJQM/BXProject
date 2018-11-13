//
//  CustomView.m
//  TypedefAndDefineDemo
//
//  Created by XuMengFan on 15/10/12.
//  Copyright © 2015年 XuMengFan. All rights reserved.
//

#import "CustomView.h"

@interface CustomView ()

@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UIView * footerView;
@property (nonatomic, strong) UILabel * dataLabel;
@property (nonatomic, strong) UILabel * percentageLabel;





@end

@implementation CustomView

- (id)initWithDataStr:(NSString *)dataStr percentageStr:(double)percentageStr isHighlighted:(BOOL)isHighlighted
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 20, 50);
        
        self.headerView = [UIView new];
        self.headerView.frame = CGRectMake(90, 0, (self.frame.size.width-90)*percentageStr, self.frame.size.height);
        NSLog(@"%@", NSStringFromCGRect(self.headerView.frame));
        if (isHighlighted) {
            self.headerView.backgroundColor = [UIColor colorFromHexCode:@"ea6153"];
        }else {
            self.headerView.backgroundColor = [UIColor grayColor];
        }
        [self addSubview:self.headerView];
        
        self.dataLabel = [UILabel new];
        self.dataLabel.frame = CGRectMake(0, 0, 90, self.headerView.frame.size.height);
        self.dataLabel.text = dataStr;
        _dataLabel.textAlignment = NSTextAlignmentLeft;
        _dataLabel.font = [UIFont systemFontOfSize:14];
        _dataLabel.textColor= WHITE_COLOR;
        _dataLabel.backgroundColor = [UIColor colorFromHexCode:@"ea6153"];
        [self addSubview:_dataLabel];
        
        self.percentageLabel = [UILabel new];
        self.percentageLabel.frame = CGRectMake(0, 0, 150, self.headerView.frame.size.height);
        self.percentageLabel.text = [NSString stringWithFormat:@"%.2f", percentageStr];
        _percentageLabel.font = [UIFont systemFontOfSize:14];
        _percentageLabel.textColor= WHITE_COLOR;
        _percentageLabel.backgroundColor = [UIColor colorFromHexCode:@"ea6153"];
        _percentageLabel.textAlignment = NSTextAlignmentCenter;
        [self.headerView addSubview:_percentageLabel];

        
    }
    return self;
}

//percentage 当前日收入
- (void)updateCellData:(NSString *)date percentage:(double)percentage max:(double)max min:(double)min
{
    
    if (max<min) {
        return;
    }else if(max==min){
        self.headerView.frame=CGRectMake(90, 0, 100, self.headerView.frame.size.height);
    }else{
        CGFloat leftWidth=self.frame.size.width-90;
        if(percentage>max){
            self.headerView.frame=CGRectMake(90, 0, self.frame.size.width-90, self.headerView.frame.size.height);
        }else{
            CGFloat percent=percentage/(max-min);
            self.headerView.frame=CGRectMake(90, 0, 70+(leftWidth-70)*percent, self.headerView.frame.size.height);
        }
        
        
        
    }
    self.dataLabel.text = [NSString stringWithFormat:@" %@",date];
    if (self.isInt) {
        self.percentageLabel.text = [NSString stringWithFormat:@"%d", (int)percentage];
    }else {
        self.percentageLabel.text = [NSString stringWithFormat:@"%.2lf", percentage];
    }
}


@end
