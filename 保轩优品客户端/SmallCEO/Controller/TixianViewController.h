//
//  TixianViewController.h
//  SmallCEO
//
//  Created by quanmai on 15/8/25.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TixianType)
{
    TixianTypeBankCard,
    TixianTypeAliPay
};

@interface TixianViewController : UIViewController{
    UITextField *moneytextF;
}

@property (nonatomic,strong)  NSDictionary *bankDic;
@property (nonatomic, strong) NSDictionary *bankCardDic;
@property (nonatomic, strong) NSDictionary *alipayAccountDic;      //only used when type is TixianTypeAliPay
@property (nonatomic, assign) TixianType type;

@end
