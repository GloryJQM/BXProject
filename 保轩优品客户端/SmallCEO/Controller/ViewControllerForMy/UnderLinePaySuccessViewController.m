//
//  UnderLinePaySuccessViewController.m
//  WanHao
//
//  Created by quanmai on 15/11/9.
//  Copyright © 2015年 wuxiaohui. All rights reserved.
//

#import "UnderLinePaySuccessViewController.h"

@interface UnderLinePaySuccessViewController ()

@end

@implementation UnderLinePaySuccessViewController


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.moneyString=@"";
        self.timeString=@"";
        self.orderIdString=@"";
    }
    return self;
}

- (void)popViewController {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title=@"支付成功";
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton *leftNavBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [leftNavBtn setImage:[[UIImage imageNamed:@"zaiNav_back.png"] imageWithColor:WHITE_COLOR] forState:UIControlStateNormal];
    [leftNavBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
    self.navigationItem.leftBarButtonItem= leftItem;
    

    
    UIImageView *imageV=[[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2.0-62.5, 20, 125, 125)];
    imageV.backgroundColor=[UIColor clearColor];
    imageV.layer.cornerRadius=0;
    imageV.image=[UIImage imageNamed:@"underline_pay_success.png"];
    [self.view addSubview:imageV];
    
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV.frame)+20, UI_SCREEN_WIDTH, 17)];
    lable.textColor=[UIColor blackColor];
    lable.font=[UIFont systemFontOfSize:16];
    lable.text=@"交易成功";
    lable.textAlignment=NSTextAlignmentCenter;
    lable.backgroundColor=[UIColor clearColor];
    [self.view addSubview:lable];
    
    
    CGFloat curY=CGRectGetMaxY(lable.frame)+30;
    
    NSArray *preTextArr=@[@"金额:  ",@"时间:  ",@"订单编号:  "];
     NSArray *dataTextArr=@[self.moneyString,self.timeString,self.orderIdString];
    
    for (int i=0; i<3; i++) {
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(24, curY+33*i, UI_SCREEN_WIDTH-48, 19)];
        lable.backgroundColor=[UIColor clearColor];
        [self.view addSubview:lable];
        
        
        NSString *preText=[preTextArr objectAtIndex:i];
        NSString *dataText=[dataTextArr objectAtIndex:i];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:18],NSFontAttributeName,[UIColor grayColor],NSForegroundColorAttributeName, nil];
        NSMutableAttributedString *mstring=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",preText,dataText] attributes:dic];
        [mstring addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:18],NSFontAttributeName,[UIColor blackColor],NSForegroundColorAttributeName, nil] range:NSMakeRange(0, preText.length)];
        lable.attributedText=mstring;
    }
}

@end
