//
//  AppDelegate.h
//  SmallCEO
//
//  Created by huang on 15/8/17.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBarController.h"
#import <CoreLocation/CoreLocation.h>
#import "CImageCache.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import "BaseNavigationViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,UIScrollViewDelegate,WXApiDelegate,WeiboSDKDelegate>{
    UIScrollView *adScrollView;
    UIImageView *lauchImageView;
    NSArray *addImageArr;
    BOOL flag;
    NSTimer *timer;
    NSTimer *aTimer;
    NSString *alertStr;
    NSDictionary *contentDic;
    BOOL  _isshowLocation;
    BOOL  _isFirstLaunch;
    NSString     *_cityLocationStr;
    NSString     *_proviceLocationStr;
    NSString     *_areaLoactionStr;

}

@property(strong,nonatomic) UIWindow *window;
@property(nonatomic,strong) CustomTabBarController *tabBarController;
@property(nonatomic,strong) UIViewController   *curViewController;
@property(nonatomic,strong) UIPageControl  *pageControl;
@property(nonatomic,strong) CLLocationManager  *locationManager;
@property (nonatomic, strong) BaseNavigationViewController *nav;

@end

