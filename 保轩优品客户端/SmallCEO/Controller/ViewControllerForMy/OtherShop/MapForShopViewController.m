//
//  MapForShopViewController.m
//  SmallCEO
//
//  Created by ni on 17/3/22.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "MapForShopViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Map/BMKAnnotation.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
#import "CustomAnnotation.h"


@interface MapForShopViewController ()<BMKLocationServiceDelegate,BMKMapViewDelegate>

@property (nonatomic,strong) BMKMapView *mapView;//地图视图
@property (nonatomic,strong) BMKLocationService *service;//定位服务
@property (nonatomic,assign) NSInteger isFirst;
@property (nonatomic,assign) BOOL ischina;
@end

@implementation MapForShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
}

- (void)createView {
    
    self.title = @"店铺位置";
    self.isFirst = YES;
    //初始化地图
    self.mapView = [[BMKMapView alloc] initWithFrame:self.view.frame];
    self.mapView.delegate =self;
    
    //添加到view上
    [self.view addSubview:self.mapView];
    
    //初始化定位
    self.service = [[BMKLocationService alloc] init];
    
    //设置代理
    self.service.delegate = self;
    
    //开启定位
    [self.service startUserLocationService];
    
    [self addAnnotationWithShopInfo];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _mapView.showsUserLocation = NO;
}
- (void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
}

//添加点到地图
- (void)addAnnotationWithShopInfo
{
    BMKPointAnnotation *item = [[BMKPointAnnotation alloc] init];
    CGFloat latitude = [[_dataDic objectForKey:@"latitude"] doubleValue];
    CGFloat longitude = [[_dataDic objectForKey:@"longitude"] doubleValue];
    item.title = [NSString stringWithFormat:@"%@", [_dataDic objectForKey:@"shop_name"]];
    item.subtitle = [NSString stringWithFormat:@"%@", [_dataDic objectForKey:@"address"]];

    item.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    [_mapView addAnnotation:item];
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
}

#pragma mark -------BMKLocationServiceDelegate
/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    
    //如果是注释点
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        //根据注释点,创建并初始化注释点视图
        BMKPinAnnotationView  *newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"an"];
        //设置大头针的颜色
        newAnnotation.pinColor = BMKPinAnnotationColorRed;
        newAnnotation.image = [UIImage imageNamed:@"button-ditudinwei@2x_03"];
        //设置动画
        newAnnotation.animatesDrop = YES;
        return newAnnotation;
    }
    return nil;
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    
    //展示定位
    self.mapView.showsUserLocation = YES;
    
    //更新位置数据
    [self.mapView updateLocationData:userLocation];
    
    if (self.isFirst) {
        //获取用户的坐标
        
        self.mapView.zoomLevel =18;
        self.isFirst = NO;
    }
}


- (void)dealloc
{
    _mapView.delegate = nil;
    _mapView.showsUserLocation = NO;
    [_mapView removeFromSuperview];
    _mapView = nil;
}
#pragma mark - 隐藏键盘
-(void)missKeyBoard
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
