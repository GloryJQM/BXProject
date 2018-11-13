//
//  CloudStoreCalloutView.h
//  SmallCEO
//
//  Created by huang on 16/4/26.
//  Copyright © 2016年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CalloutViewButtonType)
{
    CalloutViewButtonTypeNavigation,
    CalloutViewButtonTypeSure
};

@class CloudStoreCalloutView;
@protocol CloudStoreCalloutViewDelegate <NSObject>

@optional
- (void)didClickView:(CloudStoreCalloutView *)view withButtonWithType:(CalloutViewButtonType)buttonType;

@end

@interface CloudStoreCalloutView : UIView

@property (nonatomic, assign) NSInteger shopInfoIndex;
@property (nonatomic, strong) UIButton *sureButton;

@property (nonatomic, weak) id<CloudStoreCalloutViewDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle;

- (void)updateWithTitle:(NSString *)title subTitle:(NSString *)subTitle;

@end
