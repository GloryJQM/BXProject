//
//  AuthenticationPwdInputView.h
//  HuaQi
//
//  Created by 黄建芳 on 8/2/16.
//  Copyright © 2016 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat AuthenticationPwdInputViewHeight;

@protocol AuthenticationPwdInputViewDelegate <NSObject>

- (void)inputCompletePassword:(NSMutableString *)password;

@end

@interface AuthenticationPwdInputView : UIView

@property (nonatomic, weak) id <AuthenticationPwdInputViewDelegate>delegate;

@end
