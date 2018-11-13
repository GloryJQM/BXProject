//
//  SlideScrollView.h
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/7.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadImagesScrollView.h"
@interface SlideScrollView : UIScrollView
@property (nonatomic, strong) UIScrollView *firstScrollView;
@property (nonatomic, strong) LoadImagesScrollView *loadImagesScrollView;
@end
