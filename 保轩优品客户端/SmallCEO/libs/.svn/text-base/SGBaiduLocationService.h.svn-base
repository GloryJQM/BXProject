//
//  SGBaiduLocationSearch.h
//  Jiang
//
//  Created by quanmai on 2016/10/2.
//  Copyright © 2016年 quanmai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>


@interface SGBaiduLocationService : NSObject

+(instancetype)shareInstance;

-(void)baiduLoadLocation;

- (void)searchWithText:(NSString *)text;

- (void)searchWithPoiUID:(NSString *)uid;

@property(nonatomic, strong) void (^finishBlock)(NSArray *result);
@property(nonatomic, strong) void (^getPoiDetailsBlock)(BMKPoiDetailResult *result);

@end
