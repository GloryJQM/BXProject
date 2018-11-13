//
//  LoginViewController.h
//  Lemuji
//
//  Created by chensanli on 15/7/14.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginNavigationController;
typedef void(^loginAlreadyBlock)(void);
typedef void(^loginSuccessBlock)(BOOL);

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic,strong)UITextField* phoneNumTf;
@property (nonatomic,strong)UITextField* passWordTf;

@property (strong)  loginAlreadyBlock alreadyBlock;
@property (strong)  loginSuccessBlock successBlock;

+ (void)performIfLogin:(UIViewController *)viewController withShowTab:(BOOL)showTab loginAlreadyBlock:(loginAlreadyBlock)alreadyBlock loginSuccessBlock:(loginSuccessBlock)successBlock;

+ (void)performIfLogin:(UIViewController *)viewController withShowTab:(BOOL)showTab loginAlreadyBlock:(loginAlreadyBlock)alreadyBlock loginSuccessBlock:(loginSuccessBlock)successBlock isOK:(BOOL)isoK;
@end
