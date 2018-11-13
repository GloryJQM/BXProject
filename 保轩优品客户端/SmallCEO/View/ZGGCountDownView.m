//
//  ZGGCountDownView.m
//  SmallCEO
//
//  Created by huang on 15/10/30.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "ZGGCountDownView.h"

@interface ZGGCountDownView ()

@property (nonatomic, strong) NSMutableArray *timeArray;
@property (nonatomic, strong) NSMutableArray *timeLabelArray;

@property (nonatomic, assign) NSInteger timestamp;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ZGGCountDownView

- (instancetype)initWithOrignalPoint:(CGPoint)point Width:(CGFloat)height;
{
    self = [super initWithFrame:CGRectMake(point.x, point.y, 0, height)];
    if (self != nil)
    {
        self.timeArray = [NSMutableArray new];
        self.timeLabelArray = [NSMutableArray new];
    }
    
    return self;
}

- (void)updateViewWithTimestamp:(NSString *)timestamp
{
    self.timestamp = abs([timestamp integerValue]);
    [self convertTimestampToDate:self.timestamp];
    NSMutableString *timeStr = [NSMutableString new];
    for (NSInteger i = 0; i < self.timeArray.count; i++) {
        [timeStr appendString:[self.timeArray objectAtIndex:i]];
    }
    
    self.text = timeStr;
    CGSize size = [self sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, self.frame.size.height)];
    CGRect frame = self.frame;
    frame.size.width = size.width;
    self.frame = frame;
}

- (void)startCountDown
{
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

- (void)stopCountDown
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


#pragma mark - private method
- (void)countDown
{
    if (self.timestamp <=0)
    {
        [self stopCountDown];
        return;
    }
    
    self.timestamp --;
    [self updateViewWithTimestamp:[NSString stringWithFormat:@"%d", self.timestamp]];

}

- (void)convertTimestampToDate:(NSInteger)timestamp
{
    [self.timeArray removeAllObjects];
    NSInteger leftSecond = timestamp % 60;
    [self.timeArray insertObject:[NSString stringWithFormat:@"%d秒", leftSecond] atIndex:0];
    if (timestamp / 60 != 0)
    {
        timestamp /= 60;
        NSInteger leftMinute = timestamp % 60;
        [self.timeArray insertObject:[NSString stringWithFormat:@"%d分", leftMinute] atIndex:0];
        if (timestamp / 60 != 0)
        {
            timestamp /= 60;
            NSInteger leftHour = timestamp % 24;
            [self.timeArray insertObject:[NSString stringWithFormat:@"%d小时", leftHour] atIndex:0];
            if (timestamp / 24 != 0)
            {
                timestamp /= 24;
                NSInteger leftDay = timestamp % 24;
                [self.timeArray insertObject:[NSString stringWithFormat:@"%d天", leftDay] atIndex:0];
            }
        }
    }
}

@end
