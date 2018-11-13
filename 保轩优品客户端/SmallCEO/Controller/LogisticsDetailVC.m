//
//  LogisticsDetailVC.m
//  Lemuji
//
//  Created by gaojun on 15-7-15.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "LogisticsDetailVC.h"
#import "LogisticsDetailCell.h"
#import "ShopCartViewController.h"

@interface LogisticsDetailVC () <UITableViewDataSource, UITableViewDelegate>
{
    UIImageView * logisticsLogo;
}
@property (nonatomic, strong)UIView * topView;
@property (nonatomic, strong)NSArray * titleArr;
@property (nonatomic, strong)UIView * bottomView;
@property (nonatomic, strong)UIView * typeView;
@property (nonatomic, strong)UITableView *logisticsTableView;
@property (nonatomic, copy)  NSMutableArray *logisticsInfoArray;
@property (nonatomic, copy)  NSMutableArray *textHeightArray;
@property (nonatomic, strong)UILabel *statusLabel;
@property (nonatomic, strong) NSDictionary *dic;

@end

@implementation LogisticsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"物流信息";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
//    
//    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(UI_SCREEN_WIDTH - 90, 0, 25, 25);
//    [btn setImage:[UIImage imageNamed:@"gj_shopcar_uns.png"] forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(goshopCart) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    self.navigationItem.rightBarButtonItem = rightItem;

    _logisticsInfoArray = [[NSMutableArray alloc] initWithCapacity:0];
    _textHeightArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self creatTopView];
    [self postWait];
}

-(void)goshopCart{
    ShopCartViewController *vc=[[ShopCartViewController alloc] init];
    vc.isNotHome=YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)creatTopView
{
    self.logisticsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 138, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 138 - 64)];
    self.logisticsTableView.delegate = self;
    self.logisticsTableView.dataSource = self;
    self.logisticsTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    
//    [self.view addSubview:self.topView];
    [self.view addSubview:self.logisticsTableView];
//    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.typeView];
    
    
    UIView * topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 90, UI_SCREEN_WIDTH, 1)];
    topLine.backgroundColor = LINE_DEEP_COLOR;
    
    UIView * bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 98, UI_SCREEN_WIDTH, 1)];
    bottomLine.backgroundColor = LINE_DEEP_COLOR;
    
    UIView * littleView = [[UIView alloc] initWithFrame:CGRectMake(0, 90, UI_SCREEN_WIDTH, 8)];
    littleView.backgroundColor = MONEY_COLOR;
    
    
    [self.view addSubview:littleView];
    [self.view addSubview:topLine];
    [self.view addSubview:bottomLine];

    

}
-(UIView *)typeView
{
    if (_typeView == nil) {
        self.typeView = [[UIView alloc] initWithFrame:CGRectMake(0, 98, UI_SCREEN_WIDTH, 40)];
        UILabel * typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 13, 100, 16)];
        typeLabel.text = @"物流状态";
        typeLabel.font = [UIFont systemFontOfSize:14];
        [_typeView addSubview:typeLabel];
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(typeLabel.frame) + 10, UI_SCREEN_WIDTH - 24, 1)];
        line.backgroundColor = LINE_SHALLOW_COLOR;
        [_typeView addSubview:line];
    }
    return _typeView;
}

- (UIView *)topView
{
    if (_topView == nil) {
        self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 90)];
        logisticsLogo = [[UIImageView alloc] initWithFrame:CGRectMake(9, 17, 40, 40)];
        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[_dic objectForKey:@"picurl"]]];
        [logisticsLogo af_setImageWithURL:url];
        [_topView addSubview:logisticsLogo];
        NSString *str1 = [NSString stringWithFormat:@"%@",_dic[@"com"] ];
        NSString *str2 = [NSString stringWithFormat:@"%@", _dic[@"nu"]];
        self.titleArr = @[str1,str2];
        for (int i = 0; i < _titleArr.count; i++) {
        
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(52, 17 + 20 * i, UI_SCREEN_WIDTH, 15)];
            label.text =  [_titleArr objectAtIndex:i];
            label.font = [UIFont systemFontOfSize:15];
            [_topView addSubview:label];
        }
    }
    return _topView;
}

-(void)postWait
{
    [SVProgressHUD show];
    NSString*body= @"";
    
     body=[NSString stringWithFormat:@"order=%@",self.orderStr];
    NSString *str=MOBILE_SERVER_URL(@"express.php");
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
            self.dic = responseObject;
            _logisticsInfoArray = [responseObject objectForKey:@"data"];
            UIFont *font = [UIFont systemFontOfSize:15.0];
            NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:font
                                                                        forKey:NSFontAttributeName];
            for (int i = 0; i < _logisticsInfoArray.count; i++) {
                
                NSAttributedString *platFormstr = [[NSAttributedString alloc] initWithString:[[[responseObject objectForKey:@"data"] objectAtIndex:i] objectForKey:@"context"] attributes:attrsDictionary];
                CGRect paragraphRect =
                [platFormstr boundingRectWithSize:CGSizeMake(UI_SCREEN_WIDTH - 46 * adapterFactor - 10, CGFLOAT_MAX)
                                          options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                          context:nil];
                
                NSAttributedString *platFormstr1 = [[NSAttributedString alloc] initWithString:[[[responseObject objectForKey:@"data"] objectAtIndex:i] objectForKey:@"ftime"] attributes:attrsDictionary];
                CGRect paragraphRect1 =
                [platFormstr1 boundingRectWithSize:CGSizeMake(UI_SCREEN_WIDTH - 46 * adapterFactor - 10, CGFLOAT_MAX)
                                           options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                           context:nil];
                
                [_textHeightArray addObject:[[NSNumber alloc] initWithDouble:paragraphRect1.size.height + paragraphRect.size.height]];
            }
            [self.logisticsTableView reloadData];
            [self.view addSubview:self.topView];
            [SVProgressHUD dismiss];
            
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}


- (void)doClick:(id)sender
{
    UIActionSheet* act = [[UIActionSheet alloc]initWithTitle:@"确认收货" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
    act.tag = 999;
    [act showInView:self.view];
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
         [self postConfirmGoodsData];
    }
}
-(void)postConfirmGoodsData
    {
        [SVProgressHUD show];
        NSString*body=[NSString stringWithFormat:@"&type=5&order_title=%@",  self.OID];
        NSString *str=MOBILE_SERVER_URL(@"myorderlistinfo.php");
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
                
            }else{
                if ([responseObject valueForKey:@"info"]!=nil) {
                    [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
                }else{
                    [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            DLog(@"请求发生的错误是:%@",error);
            DLog(@"返回的数据:%@",operation.responseString);
            [SVProgressHUD dismissWithError:@"网络错误"];
        }];
        [op start];
    }
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _logisticsInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* logisticsInfoCellName = @"logisticsInfoCell";
    LogisticsDetailCell* cell = [tableView dequeueReusableCellWithIdentifier:logisticsInfoCellName];
    if(cell == nil)
    {
        cell = [[LogisticsDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:logisticsInfoCellName];

    }
    
    cell.mainInfoLabel.text = [[_logisticsInfoArray objectAtIndex:indexPath.row] objectForKey:@"context"];
    cell.timeInfoLabel.text = [[_logisticsInfoArray objectAtIndex:indexPath.row] objectForKey:@"ftime"];
    cell.isLastStatus = (indexPath.row == 0);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[_textHeightArray objectAtIndex:indexPath.row] doubleValue] + 20;
}

#pragma mark - UITableViewDelegate


#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
