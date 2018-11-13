//
//  PreLoginViewController.h
//  SmallCEO
//
//  Created by ni on 17/4/14.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginNavigationController;

typedef void(^loginAlreadyBlock)(void);
typedef void(^loginSuccessBlock)(BOOL);

@interface PreLoginViewController : UIViewController

@property (strong)  loginAlreadyBlock alreadyBlock;
@property (strong)  loginSuccessBlock successBlock;

+ (void)performIfLogin:(UIViewController *)viewController withShowTab:(BOOL)showTab loginAlreadyBlock:(loginAlreadyBlock)alreadyBlock loginSuccessBlock:(loginSuccessBlock)successBlock;

@end
