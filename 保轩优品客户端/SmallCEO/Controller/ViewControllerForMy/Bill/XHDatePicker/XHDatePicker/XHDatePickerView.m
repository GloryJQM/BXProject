//
//  XHDatePickerView.m
//  XHDatePicker
//
//  Created by 江欣华 on 16/8/16.
//  Copyright © 2016年 江欣华. All rights reserved.
//

#import "XHDatePickerView.h"
#import "DVYearMonthDatePicker.h"
#define RGBA(r, g, b, a) ([UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a])
#define RGB(r, g, b) RGBA(r,g,b,1)


typedef void(^doneBlock)(NSDate *);

@interface XHDatePickerView ()<DVYearMonthDatePickerDelegate> {
    //日期存储数组
    NSMutableArray *_yearArray;
    NSMutableArray *_monthArray;
    NSMutableArray *_dayArray;
    NSMutableArray *_hourArray;
    NSMutableArray *_minuteArray;
    NSString *_dateFormatter;
    //记录位置
    NSInteger yearIndex;
    NSInteger monthIndex;
    NSInteger dayIndex;
    NSInteger hourIndex;
    NSInteger minuteIndex;
    
    NSInteger preRow;
    
    NSDate *_startDate;
    NSDate *_endDate;
}

@property (nonatomic,strong)doneBlock doneBlock;
@property (nonatomic,strong)UIDatePicker *datepicker;
@property (nonatomic, strong) DVYearMonthDatePicker *dateP;

@end

@implementation XHDatePickerView

-(instancetype)initWithCompleteBlock:(void(^)(NSDate *))completeBlock andType:(NSInteger) type{
    self = [super init];
    if (self) {
        self.type = type;
        [self setupUI];
        if (completeBlock) {
            self.doneBlock = ^(NSDate *startDate) {
                completeBlock(startDate);
            };
        }
    }
    return self;
}

-(void)setupUI {
    
    //背景
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 300, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-300)];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    
    self.themeColor = RGB(230, 68, 62);
    self.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    
    //点击背景是否影藏
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [self addGestureRecognizer:tap];
    
    self.backgroundColor = RGBA(0, 0, 0, 0);
    [self layoutIfNeeded];
    
   
    //提到最前
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    //时间选择器
    //年月选择
    if (self.type == 1) {
        _dateP = [[DVYearMonthDatePicker alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 400)];
        _dateP.backgroundColor = [UIColor whiteColor];
        _dateP.dvDelegate = self;
        [_dateP selectToday];
        [backView addSubview:_dateP];
        
        //确定按钮
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, _dateP.maxY+20, UI_SCREEN_WIDTH-40, 50)];
        btn.backgroundColor = self.themeColor;
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:btn];
    }else {
        _datepicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-400)];
        _datepicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
        _datepicker.datePickerMode = UIDatePickerModeDate;
        _datepicker.minimumDate = [NSDate date];
        [backView addSubview:_datepicker];
        
        //确定按钮
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, _datepicker.maxY+20, UI_SCREEN_WIDTH-40, 50)];
        btn.backgroundColor = self.themeColor;
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:btn];
    }
    
    
    
    
}
- (void)btnAction {
    if (self.type == 1) {
        self.doneBlock(_dateP.date);
    }else {
        self.doneBlock(_datepicker.date);
    }
    [self dismiss];
}


#pragma mark - Action
-(void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.3 animations:^{
        self.centerY = UI_SCREEN_HEIGHT/2;
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        [self layoutIfNeeded];
    }];
}
-(void)dismiss {

    [UIView animateWithDuration:.3 animations:^{
        self.backgroundColor = RGBA(0, 0, 0, 0);
        self.centerY = self.height*2;
        [self layoutIfNeeded];
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    } completion:^(BOOL finished) {
//        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//        [self removeFromSuperview];
    }];
}


@end
