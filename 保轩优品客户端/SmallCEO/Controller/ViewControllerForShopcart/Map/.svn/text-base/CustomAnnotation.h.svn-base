//
//  CustomAnnotation.h
//  Lemuji
//
//  Created by huang on 15/8/12.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKAnnotation.h>

#import "CustomAnnotationView.h"

@interface CustomAnnotation : NSObject <BMKAnnotation>

@property (nonatomic, strong) NSString *positionStr;
@property (nonatomic, strong) NSString *contactInformation;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) NSInteger index;

+ (MKAnnotationView *)createViewAnnotationForMapView:(MKMapView *)mapView annotation:(id <MKAnnotation>)annotation type:(ButtonCountType)type;

- (BOOL)isEqualToCustomAnnotation:(CustomAnnotation *)annotation;

@end
