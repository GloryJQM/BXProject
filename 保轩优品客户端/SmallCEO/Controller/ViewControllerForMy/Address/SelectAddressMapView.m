//
//  SelectAddressMapView.m
//  Jiang
//
//  Created by huang on 17/1/5.
//  Copyright © 2017年 quanmai. All rights reserved.
//

#import "SelectAddressMapView.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

@interface SelectAddressMapView () <BMKLocationServiceDelegate>
{
    NSString *myGPS;
}

@property(nonatomic, strong) BMKLocationService *locationService;

/**没有调用viewDisAppear方法的时候调用了appear会导致页面回到初始位置北京*/
@property(nonatomic, assign)  BOOL isDisAppear;

@end

@implementation SelectAddressMapView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addScaleButton];
        
        self.locationService = [[BMKLocationService alloc] init];
        
        self.userTrackingMode = BMKUserTrackingModeNone;
        self.mapType = BMKMapTypeStandard;
        self.showsUserLocation = NO;//先关闭显示的定位图层
        self.rotateEnabled = NO;
        
        [self setStyle];
    }
    return self;
}

#pragma mark - 父类方法

-(void)viewWillAppear{
    if (_isDisAppear) {
        [super viewWillAppear];
    }
    _isDisAppear = NO;
    //*暂时去掉  视图重新appear的时候会回到定位点
    //    if (_locationService) {
    //        [self openLocation];
    //    }
}

-(void)viewWillDisappear{
    [super viewWillDisappear];
    _isDisAppear = YES;
    //*暂时去掉  视图重新appear的时候会回到定位点
    //    if (_locationService) {
    //        [self stopLocation];
    //    }
}

#pragma mark - Public methods
-(void)openLocation{
    self.locationService.delegate = self;
    [self.locationService startUserLocationService];
    self.showsUserLocation = NO;//先关闭显示的定位图层
    self.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    self.showsUserLocation = YES;//显示定位图层
}

#pragma mark - Private methods
-(void)stopLocation{
    [self.locationService stopUserLocationService];
    self.locationService.delegate = nil;
    self.showsUserLocation = NO;//先关闭显示的定位图层
    self.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    self.showsUserLocation = YES;//显示定位图层
}

-(void)setStyle{
    BMKLocationViewDisplayParam *param = [[BMKLocationViewDisplayParam alloc] init];
    param.isAccuracyCircleShow = NO;
    [self updateLocationViewWithParam:param];
}

-(void)addScaleButton{
    UIView *scaleButtonView = [[UIView alloc] initWithFrame:CGRectMake(self.width - 45.0, self.height - 100 - 45, 45, 135)];
    [self addSubview:scaleButtonView];
    scaleButtonView.layer.cornerRadius = 5.0;
    scaleButtonView.clipsToBounds = YES;
    scaleButtonView.backgroundColor = [UIColor whiteColor];
    
    self.locationButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
    [_locationButton setImage:[UIImage imageNamed:@"icon-dinwei@2x"] forState:UIControlStateNormal];
    
    [scaleButtonView addSubview:_locationButton];
    
    UIButton *biggerButton = [[UIButton alloc] init];
    biggerButton.backgroundColor = [UIColor whiteColor];
    [biggerButton setImage:[UIImage getPlusOrMinus:YES] forState:UIControlStateNormal];
    [biggerButton addTarget:self action:@selector(plus) forControlEvents:UIControlEventTouchUpInside];
    [scaleButtonView addSubview:biggerButton];
    biggerButton.frame = CGRectMake(0, 45, 45, 45);
    
    UIButton *smallerButton = [[UIButton alloc] init];
    smallerButton.backgroundColor = [UIColor whiteColor];
    [smallerButton setImage:[UIImage getPlusOrMinus:NO] forState:UIControlStateNormal];
    [smallerButton addTarget:self action:@selector(minus) forControlEvents:UIControlEventTouchUpInside];
    [scaleButtonView addSubview:smallerButton];
    smallerButton.frame = CGRectMake(0, 90, 45, 45);
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(12, scaleButtonView.height / 3.0, scaleButtonView.width - 24, 0.5)];
    lineView1.backgroundColor = [UIColor grayColor];
    [scaleButtonView addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(12, scaleButtonView.height / 3.0 * 2, scaleButtonView.width - 24, 0.5)];
    lineView2.backgroundColor = [UIColor grayColor];
    [scaleButtonView addSubview:lineView2];
}

-(void)plus{
    //    [self zoomIn];
    [self setZoomLevel:++self.zoomLevel];
}

-(void)minus{
    //    [self zoomOut];
    [self setZoomLevel:--self.zoomLevel];
    
}

-(void)setZoomLevel:(float)zoomLevel{
    CGFloat base = zoomLevel > 16 ? 16 : zoomLevel;
    CGFloat percent = base / 16.0;
    DLog(@"set 3- 21 zoomLevel :%f  percent:%f",zoomLevel,percent);
    
    [super setZoomLevel:zoomLevel];
    
}

#pragma mark - Map methods
/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    if ([self isLocationEnable]) {
        [self updateLocationData:userLocation];
    }
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    myGPS = [NSString stringWithFormat:@"%f,%f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude];
    if ([self isLocationEnable]) {
        [self updateLocationData:userLocation];
        if (self.locationSucceedBlock)
        {
            self.locationSucceedBlock(userLocation.location.coordinate);
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self stopLocation];
        });
    }
    
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    
    DLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    [self backToMyPlace];
    DLog(@"location error");
}

-(BOOL)isLocationEnable{
    BOOL systemEnable = [CLLocationManager locationServicesEnabled];
    BOOL appEnable = [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways;
    return systemEnable && appEnable;
}

-(void)backToMyPlace{
    NSArray *tempGps = [myGPS componentsSeparatedByString:@","];
    if (tempGps.count == 2)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CLLocationCoordinate2D currentPosition;
            currentPosition.longitude = [[tempGps objectAtIndex:0] doubleValue];
            currentPosition.latitude = [[tempGps objectAtIndex:1] doubleValue];
            
            BMKCoordinateSpan theSpan;
            theSpan.latitudeDelta = 0.01;
            theSpan.longitudeDelta = 0.01;
            
            BMKCoordinateRegion theRegion;
            theRegion.center = currentPosition;
            theRegion.span = theSpan;
            [self setRegion:theRegion animated:YES];
        });
    }
    
    self.showsUserLocation = NO;//先关闭显示的定位图层
    self.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    self.showsUserLocation = YES;//显示定位图层
}


@end
