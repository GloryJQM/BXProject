//
//  PayFinishViewController.m
//  Lemuji
//
//  Created by Cai on 15-8-4.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "PayFinishViewController.h"
#import "OrderViewController.h"

@interface PayFinishViewController ()

@end

@implementation PayFinishViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.view.backgroundColor = WHITE_COLOR;
    self.title = @"交易成功";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    
    
    UIButton *leftNavBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [leftNavBtn setImage:[[UIImage imageNamed:@"Button-fanhui.png"] imageWithColor:WHITE_COLOR] forState:UIControlStateNormal];
    [leftNavBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
    self.navigationItem.leftBarButtonItem= leftItem;
    
    [self creatView];
    [self creatBottomView];
    
    // Do any additional setup after loading the view.
}

-(void)popViewController{
    UIViewController *temp=[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-3];
    [self.navigationController popToViewController:temp animated:YES];
}

- (void)creatView
{
    UIImageView * finishImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"s_payFinish.png"]];
    finishImageView.frame = CGRectMake((UI_SCREEN_WIDTH-150)/2.0, 44 , 150, 150);
    finishImageView.layer.cornerRadius = 75;
    [self.view addSubview:finishImageView];
    
    UILabel * finishLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, UI_SCREEN_WIDTH, 30)];
    //    finishLabel.backgroundColor = [UIColor redColor];
    finishLabel.text = @"交易成功";
    finishLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:finishLabel];
}

- (void)creatBottomView
{
    self.buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT - 46 - 64, UI_SCREEN_WIDTH, 46)];
    [self.view addSubview:_buttomView];
    
    NSArray * titleArray = @[@"返回首页", @"查看订单"];
    for (int i = 0; i < titleArray.count; i++) {
        
        self.twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH / 2 * i, 0, UI_SCREEN_WIDTH / 2, 46)];
        self.twoLabel.text = [titleArray objectAtIndex:i];
        _twoLabel.tag = 101 + i;
        [_buttomView addSubview:self.twoLabel];
        
        _twoLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(doClick:)];
        [_twoLabel addGestureRecognizer:tap];
        _twoLabel.textAlignment = NSTextAlignmentCenter;
        
        if (i == 0) {
            self.twoLabel.textColor = App_Main_Color;
        }
        
        if (i == 1) {
            self.twoLabel.textColor = [UIColor whiteColor];
            self.twoLabel.backgroundColor = App_Main_Color;
        }
        
    }
}


- (void)doClick:(id)sender
{
    UILabel * label = (UILabel *)[sender view];
    if ([label.text isEqualToString:@"查看订单"]) {
        ConfirmDetailVC * confirmVC = [[ConfirmDetailVC alloc] init];
        [self.navigationController pushViewController:confirmVC animated:YES];
        confirmVC.ID =self.orderTitle;
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
