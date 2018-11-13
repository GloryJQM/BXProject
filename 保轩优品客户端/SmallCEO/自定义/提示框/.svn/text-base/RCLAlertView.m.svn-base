//
//  RCLAlertView.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/1.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "RCLAlertView.h"
#import <QuartzCore/QuartzCore.h>
//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
// rgb颜色转换（16进制->10进制）
#define HHUIColorFrom0x16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface RCLAlertView() {
    NSString *titleString;
    NSString *contentString;
    NSString *leftBtnTitle;
    NSString *rightBtnTitle;
}
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@end
@implementation RCLAlertView
- (id)initWithTitle:(NSString *)title contentText:(NSString *)content leftButtonTitle:(NSString *)leftTitle rightButtonTitle:(NSString *)rigthTitle {
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6f];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        titleString = title;
        contentString = content;
        leftBtnTitle = leftTitle;
        rightBtnTitle = rigthTitle;
    }
    return self;
}

- (void)createContentView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, 120)];
    bgView.center = self.center;
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    [self addSubview:bgView];
    
    CGFloat height = 60;
    CGSize contentSize = [contentString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-110, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    if (contentSize.height > 60) {
        height = contentSize.height;
    }
    
    UILabel *titleLabel;
    if ([titleString isEqualToString:@"版本更新"]) {
        titleLabel  = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, bgView.width-20, 15)];
        titleLabel.text = titleString;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:14 weight:20];
        [bgView addSubview:titleLabel];
    }else{
        
    }
    UILabel *alertContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, titleLabel.maxY+5, SCREEN_WIDTH-120, height)];
    
    alertContentLabel.text = contentString;
    alertContentLabel.textAlignment  =NSTextAlignmentCenter;
    alertContentLabel.numberOfLines = 0;
    alertContentLabel.textColor = [UIColor blackColor];
    alertContentLabel.font = [UIFont systemFontOfSize:17.0];
    [bgView addSubview:alertContentLabel];
    
    
    UIView *lineView1 = [[UILabel alloc]initWithFrame:CGRectMake(0, alertContentLabel.maxY+10, bgView.width, 0.5)];
    lineView1.backgroundColor = HHUIColorFrom0x16(0xcacaca);
    [bgView addSubview:lineView1];
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.layer.cornerRadius = 4.0;
    self.leftBtn.layer.masksToBounds = YES;
    self.leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.leftBtn setTitle:leftBtnTitle forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:Color74828B forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.leftBtn];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(bgView.width/2.0, alertContentLabel.maxY+10, bgView.width/2.0, 40);
    self.rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.rightBtn setTitle:rightBtnTitle forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:App_Main_Color forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.rightBtn];
    self.leftBtn.frame = CGRectMake(0, alertContentLabel.maxY+10, bgView.width/2.0, 40);
    UIView *lineView2 = [[UILabel alloc]initWithFrame:CGRectMake(bgView.width/2.0-0.5, alertContentLabel.maxY+10, 1, 40)];
    lineView2.backgroundColor = HHUIColorFrom0x16(0xcacaca);
    [bgView addSubview:lineView2];
    if (leftBtnTitle == nil || leftBtnTitle.length == 0) {
        self.leftBtn.frame = CGRectZero;
        self.rightBtn.frame = CGRectMake(0, alertContentLabel.maxY+10, bgView.width, 40);
        lineView2.hidden  = YES;
    }
    bgView.height = self.rightBtn.maxY;
    bgView.center = self.center;
}

- (void)leftBtnClicked:(id)sender {
    if (self.leftBlock) {
        self.leftBlock();
    }
    [self dismissAlert];
}

- (void)rightBtnClicked:(id)sender {
    if (self.rightBlock) {
        self.rightBlock();
    }
    [self dismissAlert];
}

- (void)show {
    [self createContentView];

    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];

}

- (void)show1 {
    [self createContentView];
        AppDelegate *del=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        [del.curViewController.view addSubview:self];
}

- (void)dismissAlert {
    [self removeFromSuperview];
}

- (CGFloat)baseTheStrToFitHeight:(NSString *)str fontSize:(int)size width:(CGFloat)width {
    CGSize titleSize = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil].size;
    return titleSize.height;
}

- (CGSize)baseTheStrToFitwidth:(NSString *)str fontSize:(int)size  {
    CGSize titleSize = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil].size;
    return titleSize;
}
@end

@implementation UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
