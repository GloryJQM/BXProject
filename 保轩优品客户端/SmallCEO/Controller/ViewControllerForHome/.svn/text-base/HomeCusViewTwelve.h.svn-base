//
//  HomeCusViewTwelve.h
//  WanHao
//
//  Created by Cai on 14-9-19.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeCusViewTwelve;
@protocol HomeCusViewTwelveDelegate <NSObject>

-(void)cusTwelveitemButton:(UIButton *)curbtn CurView:(HomeCusViewTwelve *)curVi;

@end

@interface HomeCusViewTwelve : UIView
{
    UILabel *_titleLab;
    
    UILabel *_kindNameLab;
    
    UILabel *_itemnameLab0;
    UILabel *_itemnameLab1;
    UILabel *_itemnameLab2;
    
    UIButton *_itemBtn0;
    UIButton *_itemBtn1;
    UIButton *_itemBtn2;
    UIButton *_itemBtn3;
    UIButton *_itemBtn4;
    UIButton *_itemBtn5;
    
    UIImageView *_itemImg0;
}
@property(nonatomic,assign)id <HomeCusViewTwelveDelegate> custwelveDelegate;
- (id)initWithFrame:(CGRect)frame tbackcolor:(NSString *)tcolor imgbackcolor:(NSString *)imgbackcolor contentDic:(NSDictionary *)cdic;
-(void)twelveViewLaodDatas:(NSDictionary *)tempDic;

@end
