//
//  CloudStoreSearchBar.m
//  SmallCEO
//
//  Created by huang on 16/4/27.
//  Copyright © 2016年 lemuji. All rights reserved.
//

#import "CloudStoreSearchBar.h"

@implementation CloudStoreSearchBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.tintColor = [UIColor darkGrayColor];
        [self.layer setBorderColor:[UIColor clearColor].CGColor];
        [self setSearchTextPositionAdjustment:UIOffsetMake(0, 0)];
        [self setSearchFieldBackgroundPositionAdjustment:UIOffsetMake(0, 0)];
        self.layer.cornerRadius = 4;
        
        [self setDefaultPlaceholder:@"搜索"];
        
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

- (void)setCloudStorePlaceholderStr:(NSString *)cloudStorePlaceholderStr
{
    _cloudStorePlaceholderStr = cloudStorePlaceholderStr;
    if (cloudStorePlaceholderStr)
    {
        [self setDefaultPlaceholder:cloudStorePlaceholderStr];
    }
}

- (void)setDefaultPlaceholder:(NSString *)placeholder
{
    UITextField *searchField = [self valueForKey:@"_searchField"];
    if (searchField)
    {
        searchField.attributedPlaceholder=[[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
        //searchField.backgroundColor=myRgba(253, 162, 158, 1);
        searchField.backgroundColor=[UIColor whiteColor];
        searchField.textColor=[UIColor lightGrayColor];
        searchField.clearButtonMode=UITextFieldViewModeWhileEditing;
    }
    else
    {
        self.placeholder = placeholder;
    }
}

@end
