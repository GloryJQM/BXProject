//
//  HomeCusViewOne.h
//  WanHao
//
//  Created by Cai on 14-6-9.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrikeThroughLabel.h"
#import "SBTickView.h"
#import "SBTickerView.h"

@class HomeCusViewOne;
@protocol HomeCusViewOneDelegate <NSObject>

-(void)cusfirstitemButton:(UIButton *)curbtn CurView:(HomeCusViewOne *)curVi;

@end

@interface HomeCusViewOne : UIView
{
    UILabel *_itemnameLab0;
    UILabel *_itemnameLab1;
    UILabel *_itemnameLab2;
    
    UILabel *_itemNowPLab0;
    UILabel *_itemNowPLab1;
    UILabel *_itemNowPLab2;
    
    UIImageView *_itemImg0;
    UIImageView *_itemImg1;
    UIImageView *_itemImg2;
    
    StrikeThroughLabel     *_itemOldPLab0;
    StrikeThroughLabel     *_itemOldPLab1;
    StrikeThroughLabel     *_itemOldPLab2;
    
    NSTimer         *_CountDownTimer;
    
    NSString *_currentClock;
    NSMutableArray  *_timersArray;
    UIView *contentview0;
    UIView *contentview1;
    UIView *contentview2;
    UIView *countdownview0;
    UIView *countdownview1;
    UIView *countdownview2;
    NSMutableArray *countViewArray;
}
@property(nonatomic,assign)id <HomeCusViewOneDelegate> cusfirstDelegate;
@property(nonatomic,strong)NSMutableArray *_clockTickers;
@property(nonatomic,strong)NSMutableArray *countdownRecord;
@property(nonatomic,strong)NSMutableArray  *countIndexArr;
-(id)initWithFrame:(CGRect)frame Items:(NSDictionary *)itemdic;
-(void)firstViewLaodDatas:(NSDictionary *)tempDic;
-(void)reloadCountDownTime:(NSDictionary *)tempDic;
-(void)stopCountDownTimer;

@end
