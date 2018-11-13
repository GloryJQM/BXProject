//
//  BankCardManageViewController.h
//  SmallCEO
//
//  Created by huang on 15/8/26.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BankCardManageType)
{
    BankCardManageTypeDefalut,
    BankCardManageTypeSelect
};

@interface BankCardManageViewController : UIViewController
{
    int curContentPage;
}
@property (nonatomic, assign) BankCardManageType type;   //Default is BankCardManageTypeDefalut

//Only need when type is BankCardManageTypeSelect
@property (nonatomic, strong) void (^selectBankCardBlock)(NSDictionary *, NSDictionary *);
@property (nonatomic, assign)int curPage;


@property (nonatomic,assign)int pageClick;
@property (nonatomic, copy) NSDictionary *accountInfoDic;

@property (nonatomic, assign) int payType;

@end
