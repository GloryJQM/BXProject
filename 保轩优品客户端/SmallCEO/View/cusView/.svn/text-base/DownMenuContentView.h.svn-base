//
//  DownMenuContentView.h
//  chufake
//
//  Created by pan on 13-11-20.
//  Copyright (c) 2013年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DownMenuContentType) {
    DownMenuContentType_Single     = 0,
    DownMenuContentType_Provinces = 1,
};

@class DownMenuContentView;
@protocol DownMenuContentViewDelegate <NSObject>

@optional
- (void)downMenuContentViewDidSelected:(NSString *)str withID:(NSInteger)c_id downMenuContentView:(DownMenuContentView *)view;

@end
    
@interface DownMenuContentView : UIView <UITableViewDataSource, UITableViewDelegate>
{
    id _contentData;
    
    UITableView *singleTableView;
    UITableView *provincesTableView;
    UITableView *cityTableView;
    
    int _currentProvinceIndex;
    int _currentCityIndex;
    int _currentSingleIndex;
}

@property           int index;
@property (weak)    id<DownMenuContentViewDelegate> delegate;
@property           DownMenuContentType contentType;

- (void)setCurrentCity:(NSString *)city;
- (void)setCurrentSingleIndex:(int)index;

- (NSString *)currentTitle;
- (void)loadContent:(id)cotent type:(DownMenuContentType)type;
- (void)resetPosition;
@end
