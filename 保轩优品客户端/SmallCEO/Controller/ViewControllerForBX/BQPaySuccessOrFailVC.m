//
//  BQPaySuccessOrFailVC.m
//  Price
//
//  Created by 俊严 on 17/2/28.
//  Copyright © 2017年 俊严. All rights reserved.
//

#import "BQPaySuccessOrFailVC.h"
#import "UIColor+FlatUI.h"
@interface BQPaySuccessOrFailVC ()
@property (nonatomic, strong)UIImageView * payStacticImageView;
@property (nonatomic, strong)UILabel * payStacticLabel;
@property (nonatomic, strong)UILabel * coinLabel;
@property (nonatomic, strong)UILabel * nameLabel;
@property (nonatomic, strong)UILabel * timeLabel;
@end

@implementation BQPaySuccessOrFailVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorFromHexCode:@"f5f5f5"];
    [self creatMainView];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc] initWithTitle:@"账单详情" style:UIBarButtonItemStylePlain target:self action:@selector(doclick)];
    rightItem.tintColor = [UIColor colorFromHexCode:@"646464"];
    self.navigationItem.rightBarButtonItem=rightItem;
}
-(void)doclick
{

}
- (void)creatMainView
{
    UIView*topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 170)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    _payStacticImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-70/2,20, 70, 70)];
    _payStacticImageView.backgroundColor = [UIColor grayColor];
    _payStacticImageView.layer.cornerRadius = 70/2;
    [topView addSubview:_payStacticImageView];
    
    _payStacticLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_payStacticImageView.frame)+12, self.view.frame.size.width, 20)];
    _payStacticLabel.textColor = [UIColor colorFromHexCode:@"01126a"];
    _payStacticLabel.textAlignment = NSTextAlignmentCenter;
    _payStacticLabel.font = [UIFont systemFontOfSize:17];
    [topView addSubview:_payStacticLabel];
    
    
    if (!_type) {
        _payStacticImageView.image = [UIImage imageNamed:@"pho-fukuanshibai@2x"];
        _payStacticLabel.text = @"付款失败";
        DLog(@"%@",_dic);
        _coinLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_payStacticLabel.frame)+12, self.view.frame.size.width, 20)];
        _coinLabel.text = _dic[@"info"];
        _coinLabel.textColor = [UIColor colorFromHexCode:@"646464"];
        _coinLabel.textAlignment = NSTextAlignmentCenter;
        _coinLabel.font = [UIFont systemFontOfSize:14];
        [topView addSubview:_coinLabel];
        
        UIButton*actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        actionBtn.frame = CGRectMake(10, CGRectGetMaxY(topView.frame)+20, self.view.frame.size.width-20, 50);
        [actionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        actionBtn.layer.cornerRadius = 25;
        actionBtn.clipsToBounds = YES;
        actionBtn.backgroundColor = [UIColor colorFromHexCode:@"01126a"];
        [actionBtn setTitle:@"完成" forState:UIControlStateNormal];
        [actionBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:actionBtn];
        
    }else {
        
        _coinLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_payStacticLabel.frame)+12, self.view.frame.size.width, 20)];
        _coinLabel.text = [NSString stringWithFormat:@"%@元",self.dic[@"money"]];
        _coinLabel.textAlignment = NSTextAlignmentCenter;
        _coinLabel.font = [UIFont systemFontOfSize:30];
        [topView addSubview:_coinLabel];
        
        _payStacticImageView.image = [UIImage imageNamed:@"pho-fukuanchenggong@2x"];
        _payStacticLabel.text = @"付款成功";
        
        UIView*line = [[UIView alloc] initWithFrame:CGRectMake(0, 169.5, self.view.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor colorFromHexCode:@"c8c8c8"];
        [topView addSubview:line];
        
        UIView*detailView = [[UIView alloc] initWithFrame:CGRectMake(0, 170, self.view.frame.size.width, 40)];
        detailView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:detailView];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.view.frame.size.width/2-5, 40)];
        _nameLabel.text = self.dic[@"shop_name"];
        _nameLabel.textColor = [UIColor colorFromHexCode:@"646464"];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont systemFontOfSize:14];
        [detailView addSubview:_nameLabel];
        
        //获取当前时间
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSString *DateTime = [formatter stringFromDate:date];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame), 0, self.view.frame.size.width/2-5, 40)];
        _timeLabel.text = [NSString stringWithFormat:@"交易时间 %@",DateTime];
        _timeLabel.textColor = [UIColor colorFromHexCode:@"646464"];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = [UIFont systemFontOfSize:14];
        [detailView addSubview:_timeLabel];
        
        UIButton*actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        actionBtn.frame = CGRectMake(10, CGRectGetMaxY(detailView.frame)+20, self.view.frame.size.width-20, 50);
        [actionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        actionBtn.layer.cornerRadius = 25;
        actionBtn.clipsToBounds = YES;
        actionBtn.backgroundColor = [UIColor colorFromHexCode:@"01126a"];
        [actionBtn setTitle:@"完成" forState:UIControlStateNormal];
        [actionBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:actionBtn];

    }
    
}
- (void)backAction {
    UIViewController * viewVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-3];
    [self.navigationController popToViewController:viewVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
