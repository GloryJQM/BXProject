//
//  HomeCusViewSix.h
//  WanHao
//
//  Created by Cai on 14-6-9.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeCusViewSix;
@protocol HomeCusViewSixDelegate <NSObject>

-(void)cussixitemButton:(UIButton *)curbtn CurView:(HomeCusViewSix *)curVi;

@end

@interface HomeCusViewSix : UIView
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
    
    UIView *titleview;
    UIImageView *arrowimg;
}

@property(nonatomic,assign)id <HomeCusViewSixDelegate> cussixDelegate;
- (id)initWithFrame:(CGRect)frame tbackcolor:(NSString *)tcolor imgbackcolor:(NSString *)imgbackcolor contentDic:(NSDictionary *)cdic;
-(void)sixViewLaodDatas:(NSDictionary *)tempDic;

@end
