//
//  HomeCusViewSec.h
//  WanHao
//
//  Created by Cai on 14-6-9.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrikeThroughLabel.h"
@class HomeCusViewSec;
@protocol HomeCusViewSecDelegate <NSObject>

-(void)cusseconditemButton:(UIButton *)curbtn CurView:(HomeCusViewSec *)curVi;

@end

@interface HomeCusViewSec : UIView
{
    UILabel *_titleLab;
    
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
    
//    UILabel *_itemOldPLab0;
//    UILabel *_itemOldPLab1;
//    UILabel *_itemOldPLab2;
}

@property(nonatomic,assign)id <HomeCusViewSecDelegate> cussecondDelegate;
-(void)secondViewLaodDatas:(NSDictionary *)tempDic;

@end
