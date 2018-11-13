//
//  AddViewController.h
//  SmallCEO
//
//  Created by 俊严 on 15/8/23.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController

@property (nonatomic, strong)UILabel * totalMoney;

@property (nonatomic, strong)UILabel * modayLabel;

@property (nonatomic, strong)UILabel * dayLabel;

@property (nonatomic, strong)UILabel * peopleNumLabel;

@property (nonatomic, strong)UILabel * firstLabel;

@property (nonatomic, strong)UILabel * secondLabel;

@property (nonatomic, strong)UILabel * threeLabel;

@property (nonatomic, strong)UILabel * fiveLabel;

@property (nonatomic, strong)UILabel * sixLabel;

@property (nonatomic, strong)MJRefreshHeaderView * headerView;
@property (nonatomic, strong)MJRefreshFooterView * footerView;

@property (nonatomic, assign)BOOL isClick;

@property (nonatomic,strong) void(^popBlock)(int vcTag);
@end
