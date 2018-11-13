//
//  HomeCusViewBanner.m
//  WanHao
//
//  Created by csl on 14-12-11.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "HomeCusViewBanner.h"
#import <Foundation/Foundation.h>

@implementation HomeCusViewBanner
@synthesize delegate;
@synthesize offsetFromO;
@synthesize gapDis;

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorFromHexCode:@"#eeeeee"];
        _HomeADPager = [[XLCycleScrollView alloc] initWithFrame:CGRectMake(0, 0,frame.size.width, frame.size.height)];
        _HomeADPager.delegate = self;
        _HomeADPager.datasource = self;
        _HomeADPager.backgroundColor=[UIColor clearColor];
        [self addSubview:_HomeADPager];
        
       
    }
    return self;
}

-(void)timerAction{
    [_HomeADPager showNext];
}

-(void)SetDataSourceArr:(NSArray *)arr{
    _HomeADArrary=[NSArray arrayWithArray:arr];
    [_HomeADPager reloadData];
    
    if (_HomeADTimer) {
        [_HomeADTimer invalidate];
        _HomeADTimer = nil;
    }
    _HomeADTimer=[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

#pragma - XLCycleScrollView delegate
- (NSInteger)numberOfPages
{
    return [_HomeADArrary count];
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    float x=offsetFromO.x;
    float y=offsetFromO.y;
    
    UIView  *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    backView.backgroundColor = [UIColor clearColor];
//    backView.backgroundColor=(index==0 ? [UIColor redColor] :(index==1 ? [UIColor blueColor] :(index==2 ? [UIColor greenColor]: [UIColor yellowColor])));
    
    UIImageView *imgV=[[UIImageView alloc]initWithFrame:CGRectMake(x, y, self.frame.size.width-2*x, self.frame.size.height-y)];
    NSString *url=[[_HomeADArrary objectAtIndex:index]valueForKey:@"picurl"];
    [imgV sd_setImageWithURL:[NSURL URLWithString:url]];
    
    [backView addSubview:imgV];
    return backView;
}

- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
//    if ([delegate respondsToSelector:@selector(clickBannerViewGetUrl:)]) {
//        NSString *url=[[_HomeADArrary objectAtIndex:index]valueForKey:@"link"];
//        [delegate clickBannerViewGetUrl:url];
//    }
    
    if ([delegate respondsToSelector:@selector(clickBannerViewGetUrl:linkType:ltitle:)]) {
        NSString *url=[NSString stringWithFormat:@"%@",[[_HomeADArrary objectAtIndex:index]valueForKey:@"link_value"]];
        NSString *type=[NSString stringWithFormat:@"%@",[[_HomeADArrary objectAtIndex:index]valueForKey:@"link_type"]];
        NSString *title=[NSString stringWithFormat:@"%@",[[_HomeADArrary objectAtIndex:index]valueForKey:@"title"]];
        [delegate clickBannerViewGetUrl:url linkType:type ltitle:title];
    }
    
//
//    [self cheackUrl:url];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
