//
//  HomeCusViewFour.h
//  WanHao
//
//  Created by Cai on 14-6-9.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeCusViewFour;
@protocol HomeCusViewFourDelegate <NSObject>

-(void)itemButton:(UIButton *)curbtn CurView:(HomeCusViewFour *)curVi;

@end

@interface HomeCusViewFour : UIView
{
    UILabel *_titleLab;
    
    UILabel *_orderLab0;
    UILabel *_orderLab1;
    UILabel *_orderLab2;
    UILabel *_orderLab3;
    UILabel *_orderLab4;
    UILabel *_orderLab5;
    
    UIImageView *_orderImg0;
    UIImageView *_orderImg1;
    UIImageView *_orderImg2;
    UIImageView *_orderImg3;
    UIImageView *_orderImg4;
    UIImageView *_orderImg5;
    
}
@property(nonatomic,assign)id <HomeCusViewFourDelegate> cusfourDelegate;
-(void)fourViewLaodDatas:(NSDictionary *)tempDic;

@end
