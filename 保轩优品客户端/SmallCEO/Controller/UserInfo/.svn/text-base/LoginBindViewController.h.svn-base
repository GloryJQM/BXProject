//
//  LoginBindViewController.h
//  WanHao
//
//  Created by Cai on 14-9-19.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AlipaySDK/AlipaySDK.h>

@interface LoginBindViewController : UIViewController<UIWebViewDelegate>
{
    UIButton *_rightBtn;
    NSString *_function;
    NSString *_alerturl;

    NSMutableArray *_products;
    SEL _result;
  
}

@property (strong ,nonatomic)   NSMutableArray      *arrBrowseHistory;
@property (strong)  UIWebView *webView;

@property (nonatomic,strong) void(^ loginbingBlock)(BOOL finish, NSDictionary *dic);

-(void) loadWebView:(NSString *)url;


@end
