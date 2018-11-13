//
//  CityListViewController.h
//  Jiang
//
//  Created by huang on 16/12/29.
//  Copyright © 2016年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityListViewController : UIViewController

@property (nonatomic, copy) void(^selectCityBlock)(NSString *);

@end
