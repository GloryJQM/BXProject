//
//  BaseNavigationViewController.m
//  chufake
//
//  Created by pan on 13-12-13.
//  Copyright (c) 2013年 quanmai. All rights reserved.
//

#import "BaseNavigationViewController.h"
#import "AppDelegate.h"
#import "UIColor+FlatUI.h"
#import "CustomTabBarController.h"
#import "HomeViewController.h"
#import "PurchaseReminderViewController.h"
#import "MyInfoViewController.h"
#import "InviteDealerViewController.h"
#import "SearchViewController.h"

#import "ClassifyViewController.h"

#define UIColorFromHex_BaseNavigationViewController(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0x00FF00) >> 8))/255.0  blue:((float)((hexValue & 0x0000FF) >> 0))/255.0 alpha:1]
#define C_IOS7_BaseNavigationViewController                     ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f ? YES : NO)

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController
@synthesize name;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.delegate = self;
        self.navigationBar.translucent = NO;
        [self.navigationBar setTitleTextAttributes:
                        @{NSFontAttributeName:[UIFont systemFontOfSize:17],
                          NSForegroundColorAttributeName:[UIColor blackColor]}];
        
        [self.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
        name = @"BaseNavigation";
    }
    return self;
}


- (void)customBackButton:(BOOL)back {
    if (self.viewControllers.count >1) {
      
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 44)];
        if(C_IOS7){
            backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0);
        }
        backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        if (back) {
            [backBtn addTarget:self action:@selector(backPop:) forControlEvents:UIControlEventTouchUpInside];
        }else {
            [backBtn addTarget:self action:@selector(popTwice) forControlEvents:UIControlEventTouchUpInside];
        }
        [backBtn setImage:[UIImage imageNamed:@"Button-fanhui@2x.png"] forState:UIControlStateNormal];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        ((UIViewController *)[self.viewControllers objectAtIndex:self.viewControllers.count -1]).navigationItem.leftBarButtonItem = backItem;
        if ([self.viewControllers[self.viewControllers.count - 1] isKindOfClass:NSClassFromString(@"OtherDetailController")]) {
            [backBtn setImage:[UIImage imageNamed:@"NewNav_back_white@2x"] forState:UIControlStateNormal];
            
        }
    } else {
        
        if ([self.viewControllers[0] isKindOfClass:[ClassifyViewController class]] ) {
            return;
        }
        
        if (![self.viewControllers[0] isKindOfClass:[SearchViewController class]] ) {
            
            ((UIViewController *)[self.viewControllers objectAtIndex:self.viewControllers.count -1]).navigationItem.leftBarButtonItem = nil;
        }else{
            UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 44)];
            if(C_IOS7){
                backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0);
            }
            backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
            if (back) {
                [backBtn addTarget:self action:@selector(backPop:) forControlEvents:UIControlEventTouchUpInside];
            }else {
                [backBtn addTarget:self action:@selector(popTwice) forControlEvents:UIControlEventTouchUpInside];
            }
            [backBtn setImage:[UIImage imageNamed:@"Button-fanhui@2x.png"] forState:UIControlStateNormal];
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
            ((UIViewController *)[self.viewControllers objectAtIndex:self.viewControllers.count -1]).navigationItem.leftBarButtonItem = backItem;
            
            if ([self.viewControllers[self.viewControllers.count - 1] isKindOfClass:NSClassFromString(@"OtherDetailController")]) {
                [backBtn setImage:[UIImage imageNamed:@"NewNav_back_white@2x"] forState:UIControlStateNormal];
            }
            
        }
    }
    
}


-(void)backPop:(id)sender {
    if ([(UIViewController *)[self.viewControllers objectAtIndex:self.viewControllers.count -1] isKindOfClass:[SearchViewController class]]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [self popViewControllerAnimated:YES];
    }
}

- (void)popTwice {
    if (![self.viewControllers[0] isKindOfClass:[SearchViewController class]]) {
        UIViewController * viewVC = [self.viewControllers objectAtIndex:self.viewControllers.count - 3];
        [self popToViewController:viewVC animated:YES];
    }
}

+(void)getNumOfShopCart{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CustomTabBarController *tab = delegate.tabBarController;
    
    
    if(![[PreferenceManager sharedManager] preferenceForKey:@"didLogin"])
    {
        NSNumber *shopcarType = [[PreferenceManager sharedManager] preferenceForKey:@"shopcarType"];
        [tab setTipText:@"0" withTag:shopcarType.intValue];
        return;
    }

    NSString *body = [NSString stringWithFormat:@"type=6"];
    NSString *str = MOBILE_SERVER_URL(@"addcart.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    DLog(@"body is%@",body);
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        NSNumber *shopcarType = [[PreferenceManager sharedManager] preferenceForKey:@"shopcarType"];

        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            NSString *countStr = [NSString stringWithFormat:@"%@", [[responseObject objectForKey:@"content"] objectForKey:@"count"]];
            [tab setTipText:countStr withTag:shopcarType.intValue];
        }else{
            [tab setTipText:@"0" withTag:shopcarType.intValue];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
    }];
    [op start];

}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    int num=0x100;
    NSString *string16=[NSString stringWithFormat:@"string10%d",num];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CustomTabBarController *tab = delegate.tabBarController;
    delegate.curViewController=viewController;
    [tab showTabView:self.viewControllers.count<=1 animated:YES];
    self.currentViewController = viewController;
    if (self.viewControllers.count<=1 ) {
        [[self class] getNumOfShopCart];
        
        [self.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:17],
           NSForegroundColorAttributeName:[UIColor blackColor]}];
    }else{
        [self.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:17],
           NSForegroundColorAttributeName:[UIColor blackColor]}];
        
    }
    
    if (C_IOS7) {
        viewController.automaticallyAdjustsScrollViewInsets=NO;
        viewController.edgesForExtendedLayout=UIRectEdgeNone;
    }
    
    UIColor *color = [UIColor whiteColor];
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:color rect:CGRectMake(0, 0, UI_SCREEN_WIDTH, STATE_HEIGHT+44)] forBarMetrics:UIBarMetricsDefault];
    if ([viewController isKindOfClass:NSClassFromString(@"CommodityDetailViewController")]) {
        if(C_IOS7){
            viewController.edgesForExtendedLayout=UIRectEdgeAll;
            viewController.automaticallyAdjustsScrollViewInsets=NO;
            self.navigationBar.translucent=YES;
             [self.navigationBar lt_setNavigationBarLineHiden:NO];
        }
    } else {
        viewController.edgesForExtendedLayout=UIRectEdgeNone;
        viewController.automaticallyAdjustsScrollViewInsets=NO;
        self.navigationBar.translucent=NO;
        [self.navigationBar setBackgroundImage:[UIImage imageWithColor:color rect:CGRectMake(0, 0, UI_SCREEN_WIDTH, STATE_HEIGHT+44)] forBarMetrics:UIBarMetricsDefault];
        [self.navigationBar lt_setNavigationBarLineHiden:NO];
        
        if ([viewController isKindOfClass:NSClassFromString(@"PayFinishViewController")] ||
            [viewController isKindOfClass:NSClassFromString(@"ApplicationReturnsViewController")] ||
            [viewController isKindOfClass:NSClassFromString(@"ChargeSuccessViewController")] ||
            [viewController isKindOfClass:NSClassFromString(@"UnderLinePaySuccessViewController")])
        {
        }else{
            if ([viewController isKindOfClass:NSClassFromString(@"PaymentResultViewController")] || [viewController isKindOfClass:NSClassFromString(@"PayOrderViewController")] || [viewController isKindOfClass:NSClassFromString(@"OrderPayViewController")] || [viewController isKindOfClass:NSClassFromString(@"BxPayResultViewController")] || [viewController isKindOfClass:NSClassFromString(@"PointPayOrderViewController")] || [viewController isKindOfClass:NSClassFromString(@"PointMallViewController")] || [viewController isKindOfClass:NSClassFromString(@"AdrListViewController")]) {
                return;
            }
            if ([viewController isKindOfClass:NSClassFromString(@"BQCoinSuccessViewController")] ||[viewController isKindOfClass:NSClassFromString(@"BQCoinFailViewController")] ||
                [viewController isKindOfClass:NSClassFromString(@"PayViewController")]) {
                [self customBackButton:NO];
            }else {
                [self customBackButton:YES];
            }
        }
    }
    if ([viewController isKindOfClass:NSClassFromString(@"ClassifyViewController")] || [viewController isKindOfClass:NSClassFromString(@"HomeViewController")] || [viewController isKindOfClass:NSClassFromString(@"OtherShopListController")] || [viewController isKindOfClass:NSClassFromString(@"SearchListViewController")] || [viewController isKindOfClass:NSClassFromString(@"SearchViewController")] || [viewController isKindOfClass:NSClassFromString(@"GeneralPageViewController")] || [viewController isKindOfClass:NSClassFromString(@"PaymentResultViewController")]) {
        [self.navigationBar setBackgroundImage:[UIImage imageWithColor:WHITE_COLOR_3 rect:CGRectMake(0, 0, UI_SCREEN_WIDTH, STATE_HEIGHT+44)] forBarMetrics:UIBarMetricsDefault];
    }
    if ([viewController isKindOfClass:NSClassFromString(@"OtherDetailController")]) {
        viewController.edgesForExtendedLayout=UIRectEdgeAll;
        viewController.automaticallyAdjustsScrollViewInsets=NO;
        self.navigationBar.translucent=YES;
        [self.navigationBar lt_setNavigationBarLineHiden:YES];

        [self.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    }
    //设置关于navigation的颜色
    if ([viewController isKindOfClass:NSClassFromString(@"MyInfoViewController")]) {
        
        //个人中心，黑色
        [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:17 / 255.0 green:17 / 255.0 blue:17 / 255.0 alpha:1] rect:CGRectMake(0, 0, UI_SCREEN_WIDTH, STATE_HEIGHT+44)] forBarMetrics:UIBarMetricsDefault];
        [self.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:17],
           NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [self.navigationBar lt_setNavigationBarLineHiden:NO];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }else {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
    if ([viewController isKindOfClass:NSClassFromString(@"ClassifyViewController")]) {
        [self.navigationBar lt_setNavigationBarLineHiden:NO];
    }
    

    
    if ([viewController isKindOfClass:NSClassFromString(@"OtherDetailController")]) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
    
    if (@available(iOS 11.0, *)) {
        NSArray *array = viewController.view.subviews;
        for (int i = 0; i < array.count; i++) {
            if ([array[i] isKindOfClass:[UIScrollView class]]) {
                UIScrollView *scrollView = array[i];
                scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
                break;
            }else if ([array[i] isKindOfClass:[UITableView class]]) {
                UITableView *tableView = array[i];
                tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
                break;
            }
        }
    } else {
        viewController.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    //viewcontroller即将消失的时候消失键盘
    if (self.viewControllers.count!=0) {
        UIViewController *vc= (UIViewController *)[self.viewControllers objectAtIndex:self.viewControllers.count-1];
        [vc.view endEditing:YES];
    }
    return [super popViewControllerAnimated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    
    
    return [super popToRootViewControllerAnimated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.viewControllers.count!=0) {
        [viewController setHidesBottomBarWhenPushed:YES];
    }
    [super pushViewController:viewController animated:animated];
}

@end
