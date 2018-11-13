//
//  pyStarRatingCustomView.h
//  WanHao
//
//  Created by Cai on 15-3-17.
//  Copyright (c) 2015年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol pyStarRatingCustomViewDelegate <NSObject>

@optional

-(void)ratingScoreSelectWithFlag:(BOOL)isSelect withCount:(NSInteger)countNum;

@end

@interface pyStarRatingCustomView : UIView

@property(nonatomic,assign)BOOL    isSelectedFlag;
@property(nonatomic,assign)id<pyStarRatingCustomViewDelegate> starratingDelegate;

@property (nonatomic,assign) NSInteger starNumber;


@property (nonatomic,strong) UIColor *viewColor;


@property (nonatomic,assign) BOOL touchEnable;

- (id)initWithFrame:(CGRect)frame scoreImgFrame:(CGRect)scoreFrame selImgName:(NSString *)selimgName normalImgName:(NSString *)norimgName;

@end
