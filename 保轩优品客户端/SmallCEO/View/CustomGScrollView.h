//
//  CustomGScrollView.h
//  WanHao
//
//  Created by Cai on 14-6-12.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomGScrollView;
@protocol CustomGScrollViewDelegate <NSObject>

-(void)contentBtnIndex:(int)curBtnIndex currentView:(CustomGScrollView *)curscroll;

@end

@interface CustomGScrollView : UIView{
    UILabel         *_titleLab;
    int             _curBtnIndex;
}

@property(nonatomic,strong)UIScrollView *contentScroll;
@property(nonatomic,assign)id <CustomGScrollViewDelegate> customDelegate;
-(id)initWithFrame:(CGRect)frame Items:(NSDictionary *)itemdic viewType:(int)viewT;

@end
