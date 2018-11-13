//
//  AddViewController.m
//  SmallCEO
//
//  Created by 俊严 on 15/8/23.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "AddViewController.h"
#import "CumulativeGainViewController.h"

@interface AddViewController ()<MJRefreshBaseViewDelegate>
{
    UIView * titleView;
}
@property (nonatomic, strong)UIScrollView * mainView;


@property (nonatomic, strong)UIView * backView;

@property (nonatomic, strong)UIView * areaView;

@property (nonatomic, strong)NSMutableArray * buttonArray;

@property (nonatomic, strong)NSMutableArray * labelArray;


@end

@implementation AddViewController

-(void)dealloc
{
    [_headerView free];
    [_footerView free];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITE_COLOR;
    

    self.buttonArray = [NSMutableArray arrayWithCapacity:0];
    
    self.labelArray = [NSMutableArray arrayWithCapacity:0];

    titleView = [[UIView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH / 2 - 80 / 2, 30, 100, 20)];

    self.navigationItem.titleView = titleView;
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    titleLable.text = @"收入概览";
    titleLable.textColor = [UIColor whiteColor];
    [titleView addSubview:titleLable];
    UIImageView * topView = [[UIImageView alloc] initWithFrame:CGRectMake( 80, 6, 11, 6)];
    topView.image = [[UIImage imageNamed:@"zai_xiaLa@2x"] imageWithColor:WHITE_COLOR];
    [titleView addSubview:topView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xiala)];
    [titleView addGestureRecognizer:tap];
        
    
    [self.view addSubview:self.mainView];
    [self creatView];
    
    self.headerView = [[MJRefreshHeaderView alloc] init];
    self.headerView.scrollView = _mainView;
    self.headerView.delegate = self;
    
    self.footerView = [[MJRefreshFooterView alloc] init];
    self.footerView.scrollView = _mainView;
    self.footerView.delegate = self;
    
    [self postToday];
    [self key];
    // Do any additional setup after loading the view.
}



#pragma mark - 弹出和消失
- (void)xiala
{
    self.isClick = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePickerView)];
    [titleView addGestureRecognizer:tap];
    self.backView.frame = self.view.bounds;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];

    [self.view addSubview:_backView];
    
    self.areaView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 219);
    
    [UIView commitAnimations];
}

- (void)hidePickerView
{
    DLog(@"_______");
    self.isClick = NO;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xiala)];
    [titleView addGestureRecognizer:tap];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.areaView.frame = CGRectMake(0, -219, UI_SCREEN_WIDTH, 219);
    } completion:^(BOOL finished) {
        self.backView.frame = CGRectMake(0, -UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    }];
    
}


- (void)key
{
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, -UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT )];
    _backView.backgroundColor = MONEY_COLOR;
    _backView.userInteractionEnabled = YES;
    [_backView addTarget:self action:@selector(hidePickerView) forControlEvents:UIControlEventTouchUpInside];
    [_backView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.3]];
    [self.view addSubview:_backView];
    
    //底部视图
    self.areaView = [[UIView alloc] initWithFrame:CGRectMake(0, -438 / 2, UI_SCREEN_WIDTH, 438 / 2)];
    _areaView.backgroundColor = WHITE_COLOR;
    [_backView addSubview:_areaView];
    
    
    
    NSArray * array = @[ @"累计收益", @"今日收益", @"今日访问", @"今日订单", @"收入概览", @"历史访问"];
    
    
    for (int i = 0; i <  array.count; i++) {
        
        UIView * tempView = [[UIView alloc] initWithFrame:CGRectMake(0,  219 / 6 * i, UI_SCREEN_WIDTH, 219 / 6)];
        //                line.backgroundColor = LINE_SHALLOW_COLOR;
        [_areaView addSubview:tempView];
        
        UIImageView * clickImageView = [[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 10 - 40.5, (219 / 6 - 10) / 2, 14, 10)];
        clickImageView.image = [UIImage imageNamed:@"icon_buleright.png"];
        clickImageView.tag = 400 + i;
        clickImageView.userInteractionEnabled = YES;
        
        [clickImageView addTarget:self action:@selector(btnDoClick:) forControlEvents:UIControlEventTouchUpInside];
        [tempView addSubview:clickImageView];
        [self.buttonArray addObject:clickImageView];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
        label.text = array[i];
        
        [tempView addSubview:label];
        
        tempView.tag = 500 + i;
        
        UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(10,  36 *(i + 1), UI_SCREEN_WIDTH - 20, 1)];
        line1.backgroundColor = LINE_SHALLOW_COLOR;
        [_areaView addSubview:line1];
        
        [_labelArray addObject:label];
        [tempView addTarget:self action:@selector(doClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 4) {
            label.textColor = App_Main_Color;
            
        }
        
        if (i == 5) {
            line1.hidden  = YES;
        }
        
        if (i == 4) {
            
        }else{
            clickImageView.hidden = YES;
        }
        
    }
    

}
- (void)btnDoClick:(UIImageView *)sender
{
    [self hidePickerView];
    
    [self performSelector:@selector(popToMyGoodsVCWithTag:) withObject:@(sender.tag+100) afterDelay:0.5];
}
- (void)doClick:(UIView *)sender
{
    
    UIImageView  * tempImageView  = (UIImageView *)[[[_areaView viewWithTag:sender.tag] subviews] objectAtIndex:0];
    tempImageView.hidden = NO;
    for (UIImageView * buttn1 in self.buttonArray) {
        if (![tempImageView isEqual:buttn1]) {
            buttn1.hidden = YES;
        }
    }
    
    
    UILabel * label1 = (UILabel *)[[[_areaView viewWithTag:sender.tag] subviews] objectAtIndex:1];
    NSLog(@"1 = %@", label1);
    NSLog(@"count = coutn = %ld", self.labelArray.count);
    label1.textColor = App_Main_Color;//被点击的按钮要改变的颜色
    for (UILabel * tilabel in self.labelArray) {
        NSLog(@"2 = %@", tilabel);
        if (![label1 isEqual:tilabel]) {
            tilabel.textColor = [UIColor blackColor];//其余按钮要改变到的颜色
        }
    }
    
    [self hidePickerView];
    
    [self performSelector:@selector(popToMyGoodsVCWithTag:) withObject:@(sender.tag) afterDelay:0.5];
}
- (void)popToMyGoodsVCWithTag:(NSNumber *)obj {
    int vcTag = [obj intValue];
    if (vcTag == 504) {
        
    }else if (vcTag == 500) {
        CumulativeGainViewController * vc = [[CumulativeGainViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        [self.navigationController popViewControllerAnimated:NO];
        
        if (self.popBlock) {
            self.popBlock(vcTag);
        }
    }
}

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    [self postToday];
}

- (UIScrollView *)mainView
{
    if (!_mainView) {
        self.mainView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _mainView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT + 10);
        _mainView.backgroundColor = WHITE_COLOR;
    }
    return _mainView;
}

- (void)creatView
{
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 104)];
    backView.backgroundColor = App_Main_Color;
    [self.mainView addSubview:backView];
    
    self.totalMoney = [[UILabel alloc] initWithFrame:CGRectMake(23 , 21, 150, 20)];
    _totalMoney.text = @"总收入(元)";
    _totalMoney.font = [UIFont systemFontOfSize:20];
    _totalMoney.textColor = [UIColor colorFromHexCode:@"f0d200"];
    [backView addSubview:_totalMoney];
    
    self.modayLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 50, 200, 40)];
    _modayLabel.font = [UIFont systemFontOfSize:30];
    _modayLabel.textColor = WHITE_COLOR;
    [backView addSubview:_modayLabel];
    
    self.peopleNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 104 + 12, 200, 20)];
    _peopleNumLabel.text = @"访客数(人)";
    _peopleNumLabel.font = [UIFont systemFontOfSize:20];
    _peopleNumLabel.textColor = SUB_TITLE;
    [self.mainView addSubview:_peopleNumLabel];

    self.firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 104 + 40, 200, 40)];
    _firstLabel.font = [UIFont systemFontOfSize:30];
    _firstLabel.textColor = App_Main_Color;

    [self.mainView addSubview:_firstLabel];

    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 186, UI_SCREEN_WIDTH, 152)];
    bottomView.backgroundColor = MONEY_COLOR;
    [self.mainView addSubview:bottomView];
    
    UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 1)];
    line1.backgroundColor = LINE_SHALLOW_COLOR;
    [bottomView addSubview:line1];
    
    UIView * line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 152 / 2, UI_SCREEN_WIDTH, 1)];
    line2.backgroundColor = LINE_SHALLOW_COLOR;
    [bottomView addSubview:line2];
    
    UIView * line3 = [[UIView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH / 2, 0, 1, 152)];
    line3.backgroundColor = LINE_SHALLOW_COLOR;
    [bottomView addSubview:line3];
    
    
    UIView * line4 = [[UIView alloc] initWithFrame:CGRectMake(0, 152, UI_SCREEN_WIDTH, 1)];
    line4.backgroundColor = LINE_SHALLOW_COLOR;
    [bottomView addSubview:line4];
    
    UILabel * payLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 12, (UI_SCREEN_WIDTH / 2) - 23, 20)];
    payLabel.text = @"支付转化率";
    payLabel.textColor = SUB_TITLE;
    payLabel.font = [UIFont systemFontOfSize:20];
    [bottomView addSubview:payLabel];
    
    self.secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 39, (UI_SCREEN_WIDTH / 2) - 23, 20)];
    _secondLabel.font = [UIFont systemFontOfSize:18];
    [bottomView addSubview:_secondLabel];

    
    
    UILabel * payNumLabel = [[UILabel alloc] initWithFrame:CGRectMake((UI_SCREEN_WIDTH / 2) + 23, 12, (UI_SCREEN_WIDTH / 2) - 23, 20)];
    payNumLabel.text = @"支付订单数";
    payNumLabel.textColor = SUB_TITLE;
    payNumLabel.font = [UIFont systemFontOfSize:20];
    [bottomView addSubview:payNumLabel];

    self.threeLabel = [[UILabel alloc] initWithFrame:CGRectMake((UI_SCREEN_WIDTH / 2) + 23, 39, (UI_SCREEN_WIDTH / 2) - 23, 20)];
    _threeLabel.font = [UIFont systemFontOfSize:18];
    [bottomView addSubview:_threeLabel];

    
    UILabel * zongLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 152 / 2 + 12, (UI_SCREEN_WIDTH / 2) - 23, 20)];
    zongLabel.text = @"总下单(单)";
    zongLabel.textColor = SUB_TITLE;
    zongLabel.font = [UIFont systemFontOfSize:20];
    [bottomView addSubview:zongLabel];
    
    
    self.fiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 39 + 152 / 2, (UI_SCREEN_WIDTH / 2) - 23, 20)];
    _fiveLabel.font = [UIFont systemFontOfSize:18];
    [bottomView addSubview:_fiveLabel];

    
    UILabel *  saleNumLabel = [[UILabel alloc] initWithFrame:CGRectMake( 23 + (UI_SCREEN_WIDTH / 2), 152 / 2 + 12, (UI_SCREEN_WIDTH / 2) - 23, 20)];
    saleNumLabel.text = @"售出商品件数";
    saleNumLabel.textColor = SUB_TITLE;
    saleNumLabel.font = [UIFont systemFontOfSize:20];
    [bottomView addSubview:saleNumLabel];
    
    self.sixLabel = [[UILabel alloc] initWithFrame:CGRectMake((UI_SCREEN_WIDTH / 2) + 23, 39 + 152 / 2, (UI_SCREEN_WIDTH / 2) - 23, 20)];
    _sixLabel.font = [UIFont systemFontOfSize:18];
    [bottomView addSubview:_sixLabel];

    
}

#pragma mark - http
-(void)postToday
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@""];
    NSString *str=MOBILE_SERVER_URL(@"all_shouyi.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    DLog(@"body is%@",body);
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismiss];
            
            NSDictionary * dic = [responseObject objectForKey:@"content"];
            
            self.modayLabel.text = [NSString stringWithFormat:@"%.2f", [[dic objectForKey:@"alllirun"] floatValue]];
            self.firstLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"fangwennum"]];
            self.secondLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"zhifuzhuanhualv"]];
            self.threeLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"zhifuordernum"]];
            self.fiveLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"ordernum"]];
            self.sixLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"allgoodsnum"]];
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
            }
        }
        [self.footerView endRefreshing];
        [self.headerView endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        [self.footerView endRefreshing];
        [self.headerView endRefreshing];
    }];
    [op start];
}

@end
