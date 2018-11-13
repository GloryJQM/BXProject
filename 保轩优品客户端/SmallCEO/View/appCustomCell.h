//
//  appCustomCell.h
//  WanHao
//
//  Created by wuxiaohui on 14-1-10.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircyView.h"
@interface appCustomCell : UITableViewCell{

CircyView *_circyView;
UIImageView *_nextImgV;
}


@property (nonatomic, strong) UIImageView       *imageV;
@property (nonatomic, strong) UILabel        *titlelabel;
@property (nonatomic, strong) UILabel        *subtitleLabel;
@end
