//
//  EditPwdWithOldPwdViewController.h
//  Lemuji
//
//  Created by chensanli on 15/7/30.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EditPasswordType)
{
    EditPasswordTypeDefault = 0,
    EditPasswordTypePayPassword,
    EditPasswordTypePayPasswordWithoutVerifyCode
};

@interface EditPwdWithOldPwdViewController : UIViewController

@property (nonatomic, strong) NSString* phoneNum;
@property (nonatomic, assign) EditPasswordType type;    //Default is EditPasswordTypeDefault

@property (nonatomic, strong) void(^SetPayPasswordSuccessBlock)();

@end
