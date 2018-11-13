//
//  BXRegisterViewController.h
//  SmallCEO
//
//  Created by ni on 17/2/25.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BXRegisterViewControllerDelegate <NSObject>
- (void)account:(NSString *)account Password:(NSString *)password;
@end
@interface BXRegisterViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic, weak) id <BXRegisterViewControllerDelegate> delegate;
@property (nonatomic,strong)UITextField* phoneNumTf;
@property (nonatomic,strong)UITextField* passWordTf;
@property (nonatomic,strong)UITextField* getCodeTf;
@property (nonatomic,strong)UITextField* inviteCodeTf;

@end
