//
//  BankCardDetailsViewController.h
//  SmallCEO
//
//  Created by huang on 15/8/26.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankCardDetailsViewController : UIViewController

@property (nonatomic, copy)   NSDictionary *bankCardInfoDic;
@property (nonatomic, strong) void(^deleteBankCardBlock)(void);

@end
