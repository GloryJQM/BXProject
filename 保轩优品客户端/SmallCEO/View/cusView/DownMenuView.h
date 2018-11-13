//
//  DownMenuView.h
//  chufake
//
//  Created by pan on 13-11-15.
//  Copyright (c) 2013年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DownMenuView;
@protocol DownMenuViewDelegate <NSObject>

@optional
- (void)downMenuDetailViewwillPullOut:(int)index downMenuView:(DownMenuView *)view;
- (void)downMenuDetailViewwillPullIn:(int)index downMenuView:(DownMenuView *)view;

@required
- (UIView *)downMenuDetailViewatIndex:(int)index;

@end

@interface DownMenuView : UIView
{
    @protected
    NSMutableArray *_buttons;
    NSMutableArray *_images;
    NSMutableArray *_indexs;
    
    @private
    UIView *_downContentView;
    UIControl *_downTapControl;
    
    int _selectIndex;
}

@property (readonly)    NSMutableArray *downMenus;
@property (nonatomic)   UIView *currentContentView;
@property (weak)        id<DownMenuViewDelegate> delegate;

- (void)disableMenuButtonAtIndex:(int)index;
- (void)pullBack;

- (void)changeTitle:(NSString *)title atIndex:(int)index;
- (void)setupWithTitles:(NSArray *)titles;
@end
