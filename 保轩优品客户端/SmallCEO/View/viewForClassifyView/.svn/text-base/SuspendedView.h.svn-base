//
//  SuspendedView.h
//  HuaQi
//
//  Created by 黄建芳 on 7/22/16.
//  Copyright © 2016 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN const CGFloat SuspendedViewHeight;

typedef NS_ENUM(NSUInteger, SuspendedViewStyle)
{
    SuspendedViewStyleDefault = 0,  // A vertical line between texts
    SuspendedViewStyleVaule1,  // A line at the bottom, line width is average
    SuspendedViewStyleVaule2,  // A line at the bottom, but width is same as text
    SuspendedViewStyleVaule3   // A vertical line and a line at the bottom
};

@class SuspendedView;
@protocol SuspendedViewDelegate <NSObject>

@optional
- (void)didClickView:(SuspendedView *)view atItemIndex:(NSInteger)index;

@end

@interface SuspendedView : UIView

- (instancetype)initWithSuspendedViewStyle:(SuspendedViewStyle)style;
@property (nonatomic, strong) UIView *bottomSelectedLineView;
@property (nonatomic, assign) NSInteger currentItemIndex;
@property (nonatomic, copy)   NSArray<NSString *> *items;
@property (nonatomic, weak)   id<SuspendedViewDelegate> delegate;

@end
