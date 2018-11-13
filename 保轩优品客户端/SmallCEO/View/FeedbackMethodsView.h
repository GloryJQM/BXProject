//
//  FeedbackMethodsView.h
//  SmallCEO
//
//  Created by huang on 2017/3/2.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FeedbackMethod)
{
    FeedbackMethodHotLine = 0,
    FeedbackMethodConsult
};

@interface FeedbackMethodsView : UIView

@property (nonatomic, copy) void (^selectBlock)(FeedbackMethod);

+ (FeedbackMethodsView *)sharedView;

+ (void)showWithArray:(NSArray *)array;

+ (void)dismiss;

@end
