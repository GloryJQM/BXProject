//
//  HomeCusViewBanner.h
//  WanHao
//
//  Created by csl on 14-12-11.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "XLCycleScrollView.h"

@protocol HomeCusViewBannerDelegate <NSObject>

-(void)clickBannerViewGetUrl:(NSString * )url linkType:(NSString *)type ltitle:(NSString *)linkTitle;

@end

@interface HomeCusViewBanner : UIView<XLCycleScrollViewDatasource,XLCycleScrollViewDelegate>{
    XLCycleScrollView *_HomeADPager;
    NSArray *_HomeADArrary;
    NSTimer *_HomeADTimer;
}
@property(nonatomic,assign) id<HomeCusViewBannerDelegate> delegate;
@property (nonatomic,assign) CGPoint offsetFromO;
@property (nonatomic ,assign) float gapDis;

-(void)SetDataSourceArr:(NSArray *)arr;

@end
