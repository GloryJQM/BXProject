//
//  CustomAnnotationView.h
//  Lemuji
//
//  Created by huang on 15/8/12.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

typedef NS_ENUM(NSUInteger, ButtonCountType)
{
    ButtonCountTypeWithTwoButton = 0,
    ButtonCountTypeOnlySure
};

typedef NS_ENUM(NSUInteger, ButtonClickType) {
    ButtonClickTypeSelect = 0,
    ButtonClickTypeNagivation = 1,
};

#import <MapKit/MapKit.h>

@interface CustomAnnotationView : MKAnnotationView

@property (nonatomic, assign) NSInteger index;
@property (nonatomic,strong) void(^returnBlock)(NSInteger, ButtonClickType);

- (instancetype)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier type:(ButtonCountType)type;

- (void)showTitleAndImage:(BOOL)show;

@end
