//
//  BillSuspendView.h
//  Jiang
//
//  Created by peterwang on 17/3/2.
//  Copyright © 2017年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN const CGFloat BillSuspendedViewHeight;

typedef NS_ENUM(NSUInteger, BillSuspendedViewStyle)
{
    SuspendedViewStyleDefault = 0,  // A vertical line between texts
    SuspendedViewStyleVaule1,  // A line at the bottom, line width is average
    SuspendedViewStyleVaule2,  // A line at the bottom, but width is same as text
    SuspendedViewStyleVaule3   // A vertical line and a line at the bottom
};

@class BillSuspendView;
@protocol BillSuspendedViewDelegate <NSObject>

@optional
- (void)didClickView:(BillSuspendView *)view atItemIndex:(NSInteger)index;

@end

@interface BillSuspendView : UIView

- (instancetype)initWithSuspendedViewStyle:(BillSuspendedViewStyle)style;

@property (nonatomic, assign) NSInteger currentItemIndex;
@property (nonatomic, copy)   NSArray<NSString *> *items;
@property (nonatomic, weak)   id<BillSuspendedViewDelegate> delegate;
@end
