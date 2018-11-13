//
//  SelectAddressMapView.h
//  Jiang
//
//  Created by huang on 17/1/5.
//  Copyright © 2017年 quanmai. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface SelectAddressMapView : BMKMapView

- (void)openLocation;
@property (nonatomic, strong) UIButton *locationButton;
@property (nonatomic, copy) void (^locationSucceedBlock)(CLLocationCoordinate2D);

@end
