//
//  GGView.h
//  Lemuji
//
//  Created by chensanli on 15/7/16.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

typedef NS_ENUM(NSUInteger, GGViewType)
{
    GGViewTypeNormal = 0,
    GGViewTypeWithoutSelectSpecification = 1,
};

#import <UIKit/UIKit.h>

@protocol GGViewDelegate <NSObject>

-(void)outWhichOne:(long)index;

@optional
- (void)goodsCountChanged:(NSInteger)count;

@end

@interface GGView : UIView{
    UIScrollView* midView;
    UIView* numView;
}
@property (weak,nonatomic)   id delegate;
@property (strong,nonatomic) NSString* name;
@property (strong,nonatomic) NSMutableArray* labs;
@property (nonatomic,strong) UITextField* numbersTf;
@property (nonatomic,assign) float  guigeOffsetY;
@property (nonatomic,strong) UILabel *numberLabelInTopView;
@property (nonatomic,strong) UIButton *closeBtn;
@property (nonatomic,assign) int  canBuyNum;

-(instancetype)initWith:(NSArray*)array andUpView:(UIView*)upView andBottomView:(UIView* )bottomView andHeight:(float)height andFrame:(CGRect)frame withGGViewType:(GGViewType)type;

- (void)hideSomeViewForGoodsListWithSumPrice:(CGFloat)sumPrice;

-(void)setUserCanTouch:(BOOL)bol;
@end
