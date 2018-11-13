//
//  RecordTableViewCell.h
//  SmallCEO
//
//  Created by gaojun on 15-8-25.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *recordImageView;
@property (nonatomic, strong) UILabel *appplyLable;
@property (nonatomic, strong) UILabel *timeLable;
@property (nonatomic, strong) UIView *view;


-(void)updateUIwithDic:(NSDictionary *)dic;


@end
