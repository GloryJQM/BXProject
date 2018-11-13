//
//  pyItemRatingScoreCustomView.h
//  WanHao
//
//  Created by Cai on 15-3-17.
//  Copyright (c) 2015年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pyStarRatingCustomView.h"

@protocol pyItemRatingScoreCustomViewDelegate <NSObject>

@optional
-(void)pyItemRatingCustomViewSelectWithIndex:(NSInteger)itemIndex starNum:(NSInteger)starsCount;

@end

@interface pyItemRatingScoreCustomView : UIView<pyStarRatingCustomViewDelegate>
{
    UILabel     *_degreeLab;
    NSArray     *_degreeArr;
    
}

@property(nonatomic,assign)id<pyItemRatingScoreCustomViewDelegate> itemDelegate;
@property(nonatomic,assign)NSInteger    itemscoreIndex;
@property (nonatomic, assign) NSInteger startNum;


-(id)initWithFrame:(CGRect)frame titleStr:(NSString *)title ;

@end
