//
//  SearchResultNotFoundViewController.m
//  SmallCEO
//
//  Created by huang on 16/4/28.
//  Copyright © 2016年 lemuji. All rights reserved.
//

#import "SearchResultNotFoundViewController.h"

#import "CloudStoreSearchBar.h"

@implementation SearchResultNotFoundViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CloudStoreSearchBar *searchBar=[[CloudStoreSearchBar alloc] initWithFrame:CGRectMake(-10, 7, UI_SCREEN_WIDTH-2*50, 30)];
    searchBar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    searchBar.layer.borderWidth = 1;
    searchBar.userInteractionEnabled = NO;
    searchBar.text = self.searchedStr;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 44)];
    titleView.backgroundColor=[UIColor clearColor];
    [titleView addSubview:searchBar];
    [titleView addTarget:self action:@selector(returnToSearchView) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleView;
    [self creatView];
}

- (void)creatView
{
    UIImageView * finishImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gj_tanhao.png"]];
    finishImageView.frame = CGRectMake((UI_SCREEN_WIDTH-150)/2.0, 44 , 150, 150);
    finishImageView.layer.cornerRadius = 75;
    [self.view addSubview:finishImageView];
    
    UILabel * finishLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, UI_SCREEN_WIDTH, 30)];
    finishLabel.text = @"暂无匹配的店";
    finishLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:finishLabel];
}

- (void)returnToSearchView
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
