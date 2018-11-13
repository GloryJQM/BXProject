//
//  BindAlipayAccountViewController.h
//  SmallCEO
//
//  Created by huang on 15/9/25.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BindAlipayVCType)
{
    BindAlipayVCTypeAdd,
    BindAlipayVCTypeModify
};

@interface BindAlipayAccountViewController : UIViewController

@property (nonatomic, assign) BindAlipayVCType type;
@property (nonatomic, copy)   NSDictionary *oldInfoDic;      // only used when type is BindAlipayVCTypeModify
@property (nonatomic, strong) void(^successBlock)(NSDictionary*);

@end
