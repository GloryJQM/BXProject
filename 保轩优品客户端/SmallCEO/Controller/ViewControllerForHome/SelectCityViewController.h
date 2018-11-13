//
//  SelectCityViewController.h
//  WanHao
//
//  Created by Cai on 14-8-21.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface SelectCityViewController : UIViewController<CLLocationManagerDelegate>
{
    //定位
    CLLocationCoordinate2D mylocation;
    CLGeocoder *Geocoder;
    NSMutableString     *_locationCityStr;
}

@property (strong,nonatomic) CLLocationManager *locationManager;

@end
