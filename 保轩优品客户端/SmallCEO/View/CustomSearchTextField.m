//
//  CustomSearchTextField.m
//  SmallCEO
//
//  Created by huang on 2017/3/1.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "CustomSearchTextField.h"

@implementation CustomSearchTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        searchImageView.image = [[UIImage imageNamed:@"icon-sousuo@2x"] imageWithMinimumSize:CGSizeMake(15, 15)];
        searchImageView.contentMode = UIViewContentModeCenter;
        self.layer.cornerRadius = 15.0;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.backgroundColor=[UIColor whiteColor];
        self.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        self.font=[UIFont systemFontOfSize:15];
        self.placeholder = @"   搜索商户、商品、地点、用户、图文";
        self.font = [UIFont systemFontOfSize:12];
        self.textAlignment = NSTextAlignmentLeft;
        self.returnKeyType=UIReturnKeySearch;
        self.userInteractionEnabled = YES;
        self.leftView = searchImageView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    
    return self;
}

@end
