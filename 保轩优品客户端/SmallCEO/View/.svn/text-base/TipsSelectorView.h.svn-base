//
//  TipsSelectorView.h
//  HuaQi
//
//  Created by 黄建芳 on 8/4/16.
//  Copyright © 2016 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TipsSelectorView;
@protocol TipsSelectorViewDelegate <NSObject>

@optional
- (void)selectTipsAtIndex:(NSInteger)index AndTag:(NSInteger)tag;

- (void)didClickClearButton:(UIButton*)button;

@end

@interface TipsSelectorView : UIView

@property (nonatomic, weak) id<TipsSelectorViewDelegate> delegate;

@property (nonatomic, strong) UILabel *topTitleLabel;

@property (nonatomic, copy)   NSArray <NSString *> *tips;

@property (nonatomic, strong) NSMutableArray *totalTipButtons;

@property (nonatomic, strong) UIScrollView *mainScrollView;
// Default is Yes
@property (nonatomic, assign) BOOL enableMultipleChoice;
@property (nonatomic, strong) UIButton *clearButton;

//- (instancetype)initWithTips:(NSArray <NSString *> *)tips;
- (void)unselectTipButtonWithTitle:(NSString *)title;
- (void)selectTipButtonWithTips:(NSArray *)tips;
- (void)unselectAll;
@end
