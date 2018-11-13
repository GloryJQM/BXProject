//
//  NoDataWarningView.h
//  SmallCEO
//
//  Created by ni on 16/7/7.
//  Copyright © 2016年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,WarningType) {
    WarningTypeDefult = 0,
    WarningTypeNoNetWork,
    WarningTypeNotFound,
    WarningTypeNotLogin
};

typedef void (^LoginBlock)();

@interface NoDataWarningView : UIView

@property (nonatomic, assign) void(^ loginBlock)();
@property (nonatomic, strong) UIButton *loginButton;

/** type */
@property (nonatomic, assign) WarningType warningType;

/** warning title */
@property (nonatomic, strong) NSString *warningTitle;

/** warning title */
@property (nonatomic, strong) NSString *buttonTitle;

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title;

@end
