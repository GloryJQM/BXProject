//
//  HomeCusViewEleven.h
//  WanHao
//
//  Created by Cai on 14-8-19.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeCusViewEleven;
@protocol HomeCusViewElevenDelegate <NSObject>

-(void)cuselevenitemButton:(UIButton *)curbtn CurView:(HomeCusViewEleven *)curVi;

@end

@interface HomeCusViewEleven : UIView
{
    UIImageView     *_image0;
    UIImageView     *_image1;
    UIImageView     *_image2;
    UILabel         *_itemLab0;
    UILabel         *_itemLab1;

}
@property(nonatomic,assign)id<HomeCusViewElevenDelegate> cuselevenDelegate;

-(void)elevenViewLaodDatas:(NSDictionary *)tempDic;
@end
