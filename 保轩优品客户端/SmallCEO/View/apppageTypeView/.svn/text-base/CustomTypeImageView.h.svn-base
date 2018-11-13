//
//  CustomTypeImageView.h
//  cancelRequsetTest
//
//  Created by Cai on 14-8-26.
//  Copyright (c) 2014年 jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTypeImageView;
@protocol CustomTypeImageViewDelegate <NSObject>

-(void)CustomTypeImageViewButton:(int)curbtn CurView:(CustomTypeImageView *)curVi;

@end

@interface CustomTypeImageView : UIView
{
    NSMutableArray          *_itemArr;
    NSMutableArray          *_itemDataArr;
    
    UIView                  *_backView;
}


@property(nonatomic,assign)id<CustomTypeImageViewDelegate> custypeDelegate;

- (id)initWithFrame:(CGRect)frame ContentDic:(NSDictionary *)dic;

-(void)CustomTypeViewLaodDatas:(NSDictionary *)tempDic;

@end
