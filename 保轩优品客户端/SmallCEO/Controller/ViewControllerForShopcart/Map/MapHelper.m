//
//  MapHelper.m
//  Lemuji
//
//  Created by quanmai on 15/8/6.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "MapHelper.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapHelper ()<UIActionSheetDelegate>

@property(nonatomic,assign) CLLocationCoordinate2D startCoor ;
@property(nonatomic,assign)  CLLocationCoordinate2D endCoor;

@end

@implementation MapHelper




-(void)navFrom:(CLLocationCoordinate2D )froml  toLocation:(CLLocationCoordinate2D)toLocation{
    self.startCoor=froml;
    self.endCoor=toLocation;
    [self showActionSheet];
}
-(void)showActionSheet{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://map/direction"]]) {
        NSString *urlString=[NSString stringWithFormat:@"iosamap://navi"];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString ]]) {
            UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"百度地图",@"系统地图",@"高德地图", nil];
            actionSheet.tag=300;
            UIWindow *window=[[UIApplication sharedApplication] keyWindow];
            [actionSheet showInView:window];
        }else{
            UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"百度地图",@"系统地图", nil];
            actionSheet.tag=100;
            UIWindow *window=[[UIApplication sharedApplication] keyWindow];
            [actionSheet showInView:window];
        }
    }else{
        //1  百度  2 系统
        NSString *urlString=[NSString stringWithFormat:@"iosamap://navi"];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString ]]) {
            UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"高德地图",@"系统地图", nil];
            actionSheet.tag=200;
            UIWindow *window=[[UIApplication sharedApplication] keyWindow];
            [actionSheet showInView:window];
        }else{
            [self guide:2];
        }
        
    }
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag==100) {
        if (buttonIndex==0) {
            //百度
            [self guide:1];
        }
        if(buttonIndex==1){
            //系统
            [self guide:2];
        }
    }
    if (actionSheet.tag==200) {
        if(buttonIndex==0){
            //高德
            [self guide:3];
        }
        if(buttonIndex==1){
            //系统
            [self guide:2];
        }
    }
    if (actionSheet.tag==300) {
        if(buttonIndex==0){
            //百度
            [self guide:1];
        }
        if(buttonIndex==1){
            //系统
            [self guide:2];
        }
        if(buttonIndex==2){
            //高德
            [self guide:3];
        }
    }
}



-(void)guide:(NSInteger)mapType{
    CLLocationCoordinate2D startCoor =self.startCoor ;
    CLLocationCoordinate2D endCoor = self.endCoor;
    //    mapType=3;
    if (mapType==1) {
        double startLong=startCoor.longitude;
        double startLa=startCoor.latitude ;
        
        double endLong=endCoor.longitude;
        double endLa=endCoor.latitude ;
        
        NSString *originValue=[NSString stringWithFormat:@"%f,%f",startLa,startLong];
        NSString *endValue=[NSString stringWithFormat:@"%f,%f",endLa,endLong];
        
        NSString *urlString=[NSString stringWithFormat:@"baidumap://map/direction?origin=%@&destination=%@&mode=driving&src=%@",originValue,endValue,AppScheme];
        NSLog(@"usrlString:%@",urlString);
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString ]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
        
    }
    if (mapType==2) {
        if(C_IOS7){
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil]];
            toLocation.name = @"to name";
            [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                           launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
        }
    }
    
    if (mapType==3) {
        NSString *urlString=[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%@&lon=%@&dev=0&style=0",AppScheme,AppScheme,[NSString stringWithFormat:@"%f",endCoor.latitude],[NSString stringWithFormat:@"%f",endCoor.longitude]];
        NSLog(@"usrlString:%@",urlString);
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString ]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
        
    }
    
    
}



@end
