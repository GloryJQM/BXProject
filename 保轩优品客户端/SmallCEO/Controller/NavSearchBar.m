//
//  NavSearchBar.m
//  Lemuji
//
//  Created by quanmai on 15/7/17.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "NavSearchBar.h"

@implementation NavSearchBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.tintColor = [UIColor darkGrayColor];
//        [self.layer setBorderColor:[UIColor clearColor].CGColor];
        [self.layer setBorderColor:[UIColor darkGrayColor].CGColor];
        self.layer.borderWidth = 0.5;

        UIImage* img = [UIImage imageNamed:@"nav_gray.png"];
//        UIImage* img = [UIImage imageNamed:@"home_search_black.png"];
        
        UIImage *img1=[[img imageWithColor:[UIColor lightGrayColor]] imageWithMinimumSize:CGSizeMake(self.frame.size.width, self.frame.size.height)];
        [self setSearchFieldBackgroundImage:img1 forState:UIControlStateNormal];
        [self setSearchTextPositionAdjustment:UIOffsetMake(0, 0)];
        [self setSearchFieldBackgroundPositionAdjustment:UIOffsetMake(0, 0)];
        self.layer.cornerRadius=15;
        
        UITextField *searchField = [self valueForKey:@"_searchField"];
        if (searchField) {
            searchField.leftView=({
                UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
                view;
            });
            searchField .rightViewMode=UITextFieldViewModeNever;
            searchField.layer.cornerRadius=4;
            [searchField setClearButtonMode:UITextFieldViewModeWhileEditing];
        }
        
        //移除背景

        UIView *view1=[self.subviews objectAtIndex:0];
        if (view1!=nil) {
            UIView *view2=[view1.subviews objectAtIndex:0];
            if (view2!=nil) {
                [view2 removeFromSuperview];
            }
        }

    }
    return self;
}

@end
