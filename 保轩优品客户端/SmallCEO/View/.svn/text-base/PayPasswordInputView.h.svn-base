//
//  PayPasswordInputView.h
//  SmallCEO
//
//  Created by huang on 15/8/31.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ButtonType)
{
    ButtonTypeReturn,
    ButtonTypeForgetPassword,
    ButtonTypePay
};

@protocol PayPasswordInputViewDelegate;

@interface PayPasswordInputView : UIView

@property (nonatomic, weak) id<PayPasswordInputViewDelegate> delegate;

- (void)showInView:(UIView *)view;

@end

@protocol PayPasswordInputViewDelegate <NSObject>

- (void)inputView:(PayPasswordInputView *)inputView doClickButtonWithType:(ButtonType)type withPassword:(NSString *)password;

@end