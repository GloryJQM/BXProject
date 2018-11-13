//
//  CustomAnnotation.m
//  Lemuji
//
//  Created by huang on 15/8/12.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation

+ (MKAnnotationView *)createViewAnnotationForMapView:(MKMapView *)mapView annotation:(id <MKAnnotation>)annotation type:(ButtonCountType)type
{
    NSString *str = [NSString stringWithFormat:@"%@", [NSDate date]];
    MKAnnotationView *returnedAnnotationView =
    (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:str];
    if (returnedAnnotationView == nil)
    {
        returnedAnnotationView =
        [[CustomAnnotationView alloc] initWithAnnotation:annotation
                                         reuseIdentifier:NSStringFromClass([CustomAnnotation class]) type:type];
    }
    
    return returnedAnnotationView;
}

- (BOOL)isEqualToCustomAnnotation:(CustomAnnotation *)annotation
{
    if (![annotation isKindOfClass:[CustomAnnotation class]])
        return NO;
    
    if ([self.positionStr isEqualToString:annotation.positionStr] &&
        [self.contactInformation isEqualToString:annotation.contactInformation] &&
        [self.shopName isEqualToString:annotation.shopName] &&
        [self.cityName isEqualToString:annotation.cityName])
    {
        return YES;
    }
    
    return NO;
}

@end
