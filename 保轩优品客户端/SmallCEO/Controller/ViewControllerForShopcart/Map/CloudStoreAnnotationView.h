//
//  CloudStoreAnnotationView.h
//  SmallCEO
//
//  Created by huang on 16/4/26.
//  Copyright © 2016年 lemuji. All rights reserved.
//

#import <MapKit/MapKit.h>

#import "CloudStoreCalloutView.h"

@interface CloudStoreAnnotationView : MKAnnotationView

@property (nonatomic, strong) CloudStoreCalloutView *calloutView;

@end
