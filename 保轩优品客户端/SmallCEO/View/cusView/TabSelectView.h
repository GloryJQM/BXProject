//
//  TabSelectView.h
//  ;
//
//  Created by quanmai on 15/7/15.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TabSelectView;

@protocol TabSelectViewDelegate <NSObject>

-(void)tabView:(TabSelectView *)view clickAtIndex:(NSInteger)index;

@end

@interface TabSelectView : UIView{
    UIButton *preBtn;
    UILabel *moveLine;
    BOOL isBlackMode;
    
    UIColor *selectColor;
    UIColor *noSelectColor;
    
    UIFont *selectFont;
    UIFont *noSelectFont;
}
- (instancetype)initWithFrame:(CGRect)frame isBlack:(BOOL)isBlack kinds:(int)kind;

-(void)updateWithArr:(NSArray *)array;

@property(nonatomic,assign) id<TabSelectViewDelegate>  delegate;

@end
