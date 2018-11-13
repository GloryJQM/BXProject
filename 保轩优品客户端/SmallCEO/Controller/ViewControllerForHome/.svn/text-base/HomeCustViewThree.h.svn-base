//
//  HomeCustViewThree.h
//  WanHao
//
//  Created by Cai on 14-6-9.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrikeThroughLabel.h"
@class HomeCustViewThree;
@protocol HomeCustViewThreeDelegate <NSObject>

-(void)custhreeitemButton:(UIButton *)curbtn CurView:(HomeCustViewThree *)curVi;

@end

@interface HomeCustViewThree : UIView
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
    
}

@property(nonatomic,assign)id <HomeCustViewThreeDelegate> custhreeDelegate;
-(void)threeViewLaodDatas:(NSDictionary *)tempDic;

@end
