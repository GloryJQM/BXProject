//
//  AlertLab.m
//  Mylng
//
//  Created by 马强 on 16/7/14.
//  Copyright © 2016年 马强. All rights reserved.
//

#import "AlertLab.h"
#import "AppDelegate.h"

@implementation AlertLab

- (instancetype)initWithFrame:(CGRect)frame AndTitle:(NSString *)title {
    self=[super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius=5;
        self.layer.masksToBounds=YES;
        self.backgroundColor=[UIColor colorWithWhite:0.3 alpha:0.5];
        self.text=title;
        self.textAlignment=NSTextAlignmentCenter;
        self.textColor=[UIColor whiteColor];
        self.font=[UIFont systemFontOfSize:15];
        [self startPainting];
    }
    return self;
}

- (CGFloat)time {
    if (_time>0) {
        return _time;
    }
    return 0.5;
}

-(void)startPainting {
    self.timer=[NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(removeView) userInfo:nil repeats:NO];
}

-(void)removeView{
    [self.timer invalidate];
    [self removeFromSuperview];
    [self.delegate alertViewRemoveAction];
}

- (void)show {
    AppDelegate *ad = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [ad.window addSubview:self];
}

- (instancetype)initWithTitle:(NSString *)title Success:(void (^)(void))success {
    //根据传入的title  自动适配显示的label的大小
    CGFloat width = title.length*15+5;
    CGFloat height = 30;
    if (width > UI_SCREEN_WIDTH/4*3) {
        height = 60;
        width = UI_SCREEN_WIDTH/4*3;
    }

    if (self = [super init]) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        self.text = title;
        self.textAlignment=NSTextAlignmentCenter;
        self.numberOfLines = 2;
        self.textColor=[UIColor whiteColor];
        self.font=[UIFont systemFontOfSize:15];
        
        CGSize maximumLabelSize = CGSizeMake(UI_SCREEN_WIDTH-100, 9999);//labelsize的最大值
        CGSize expectSize = [self sizeThatFits:maximumLabelSize];
            self.frame = CGRectMake(UI_SCREEN_WIDTH/2-expectSize.width/2, UI_SCREEN_HEIGHT/2, expectSize.width + 10, expectSize.height + 10);

        [self performSelector:@selector(hiddenWithBlock:) withObject:success afterDelay:2];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title {
    //根据传入的title  自动适配显示的label的大小
    CGFloat width = title.length*15+5;
    CGFloat height = 30;
    if (width > UI_SCREEN_WIDTH/4*3) {
        height = 60;
        width = UI_SCREEN_WIDTH/4*3;
    }
    
    if (self = [super init]) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        self.text = title;
        self.textAlignment=NSTextAlignmentCenter;
        self.numberOfLines = 2;
        self.textColor=[UIColor whiteColor];
        self.font=[UIFont systemFontOfSize:15];
        
        CGSize maximumLabelSize = CGSizeMake(UI_SCREEN_WIDTH-100, 9999);//labelsize的最大值
        CGSize expectSize = [self sizeThatFits:maximumLabelSize];

            self.frame = CGRectMake(UI_SCREEN_WIDTH/2-expectSize.width/2, UI_SCREEN_HEIGHT - expectSize.height - 40, expectSize.width + 10, expectSize.height + 10);
        [self performSelector:@selector(hiddenWithBlock:) withObject:nil afterDelay:2];
    }
    return self;
}

- (void)hiddenWithBlock:(void (^)(void))success {
    [self removeView];
    if (success) {
        success();
    }
}

+ (void)showTitle:(NSString *)title {
    AlertLab *lab = [[AlertLab alloc] initWithTitle:title Success:^{
    }];
    lab.time = 1.5;
    [lab show];
}

- (void)setType:(NSString *)type {
    CGRect frame = self.frame;
    frame.origin.y = UI_SCREEN_HEIGHT - frame.size.height - 40;
    self.frame = frame;
}

@end
