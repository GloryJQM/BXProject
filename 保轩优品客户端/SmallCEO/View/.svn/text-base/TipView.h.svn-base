//
//  TipView.h
//  CslProject
//
//  Created by chensanli on 15/3/20.
//  Copyright (c) 2015年 chenweidong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TipViewDelegate <NSObject>

-(void)TipViewBtnTag:(int)tag;
-(void)gotoGoodsList:(int)type linkvale:(NSString *)lValue title:(NSString *)keyword;

@end

@interface TipView : UIView<UIScrollViewDelegate>{
    NSArray *originArr;
    NSArray *dicArr;
    float originFrameHeight;
    UIScrollView *scrollV;
    int num;
    BOOL openKeybool;
    NSTimer *scrollTimer;
    UIView *bgView;
    
}
@property(nonatomic,assign) id<TipViewDelegate> delegate;
@property(nonatomic,strong) UIImageView *imageV;

-(id)initWithFrame:(CGRect)frame  scrollArr:(NSArray *)arr;

-(void)updateUIWithDic:(NSDictionary *)dict;

//界面不显示的时候可以临时停止自动滚动的动画
-(void)setAnimationEnable:(BOOL)value;

@end
