//
//  AlipayAccountInfoViewController.m
//  SmallCEO
//
//  Created by huang on 15/9/25.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "AlipayAccountInfoViewController.h"
#import "BindAlipayAccountViewController.h"

@interface AlipayAccountInfoViewController ()

@property (nonatomic, strong) UILabel *accountLabel;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation AlipayAccountInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHexCode:@"f2f2f2"];
    self.title = @"支付宝账号详情";
    
    [self createNagivationBarView];
    [self createMainView];
}

- (void)createMainView
{
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 70.0)];
    mainView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mainView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
    [imageView af_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [self.accountInfoDic objectForKey:@"picurl"]]]];
    [mainView addSubview:imageView];
    
    UILabel *cardNumLabel = [[UILabel alloc] init];
    cardNumLabel.text = [NSString stringWithFormat:@"%@", [self.accountInfoDic objectForKey:@"card"]];
    cardNumLabel.frame = CGRectMake(15 + CGRectGetMaxX(imageView.frame), 25, 200, 20);
    [mainView addSubview:cardNumLabel];
    self.accountLabel = cardNumLabel;
    
    UIView *userNameView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(mainView.frame) + 10, UI_SCREEN_WIDTH, 50)];
    UILabel *cardHolderLabel = [[UILabel alloc] init];
    cardHolderLabel.text = @"姓名";
    CGSize sizeForCardHolderLabel = [cardHolderLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, 30)];
    cardHolderLabel.frame = CGRectMake(15, 10, sizeForCardHolderLabel.width, 30);
    [userNameView addSubview:cardHolderLabel];
    
    UILabel *cardHolderNameLabel = [[UILabel alloc] init];
    cardHolderNameLabel.text = [NSString stringWithFormat:@"%@", [self.accountInfoDic objectForKey:@"name"]];
    cardHolderNameLabel.frame = CGRectMake(20 + CGRectGetMaxX(cardHolderLabel.frame), 10, 200, 30);
    [userNameView addSubview:cardHolderNameLabel];
    self.nameLabel = cardHolderNameLabel;
    
    userNameView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:userNameView];
}

- (void)createNagivationBarView
{
    UIBarButtonItem *billButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain
                                                                      target:self action:@selector(editButtonClick)];
    NSDictionary *textAttributesDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14.0], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [billButtonItem setTitleTextAttributes:textAttributesDic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = billButtonItem;
}

#pragma mark - 按钮点击方法
- (void)editButtonClick
{
    BindAlipayAccountViewController *bindAlipayAccountVC = [[BindAlipayAccountViewController alloc] init];
    bindAlipayAccountVC.type = BindAlipayVCTypeModify;
    bindAlipayAccountVC.oldInfoDic = self.accountInfoDic;
    bindAlipayAccountVC.successBlock = ^(NSDictionary *dic) {
        NSString *string = [dic objectForKey:@"card"];
        self.accountLabel.text = [dic objectForKey:@"card"];
        self.nameLabel.text = [dic objectForKey:@"name"];
    };
    [self.navigationController pushViewController:bindAlipayAccountVC animated:YES];
}

@end
