//
//  ProductDetailsViewController.h
//  WanHao
//
//  Created by wuxiaohui on 14-1-23.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlixLibService.h"
//@interface Product : NSObject{
//@private
//	float _price;
//	NSString *_subject;
//	NSString *_body;
//	NSString *_orderId;
//}
//@property (nonatomic, assign) float price;
//@property (nonatomic, retain) NSString *subject;
//@property (nonatomic, retain) NSString *body;
//@property (nonatomic, retain) NSString *orderId;
//
//@end


@interface ProductDetailsViewController : UIViewController<UIWebViewDelegate,UIGestureRecognizerDelegate>
{
    UIButton *_rightBtn;
    NSString *_function;
    NSString *_alerturl;
    BOOL     _isaddurl;
    BOOL isTap;
    
    NSMutableArray *_products;
    SEL _result;
    int  numOfSubUrl;
    int curUrlNum;
    BOOL isChange;          //适应坐标记录

}
@property (assign ,nonatomic)  int numOfSubUrl;
@property (strong ,nonatomic)  NSMutableArray      *arrBrowseHistory;
@property (strong ,nonatomic)  UIWebView *webView;
@property (nonatomic,assign)   BOOL isShare;

-(void) loadWebView:(NSString *)url;

-(void) loadWebView1:(NSString *)url;


@property (nonatomic,assign) SEL result;//这里声明为属性方便在于外部传入。
-(void)paymentResult:(NSString *)result;

-(instancetype)initWithType:(BOOL)isFromRegister;

@property (nonatomic, copy) NSString *is64;

@end
