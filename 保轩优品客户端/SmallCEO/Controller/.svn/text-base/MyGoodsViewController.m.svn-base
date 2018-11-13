//
//  MyGoodsViewController.m
//  SmallCEO
//
//  Created by 俊严 on 15/8/23.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "MyGoodsViewController.h"
#import "MyGoodsCell.h"
#import "HeadView.h"
#import "FielMangerViewController.h"
#import "OrderViewController.h"
#import "TodayIncomeViewController.h"
#import "TodayOrderViewController.h"
#import "AddViewController.h"
#import "RecordViewController.h"
#import "CumulativeGainViewController.h"
#import "EditPwdWithOldPwdViewController.h"
#import "HistoryViewController.h"
#import "TabSelectView.h"
#import "TodayIncomeViewController.h"
#import "CustomViewController.h"
#import "MyGoodStatisticsViewController.h"
#import "MyGoodsSearchViewController.h"


@interface MyGoodsViewController ()<UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate, TabSelectViewDelegate>
{
    UIImageView* imgVi;
    UILabel *noDataWarningLabel;
    TabSelectView *tabView;
    NSArray *categoryArray;
    NSString *currentCatID;
}
@property (nonatomic, strong)UITableView * tab;
@property (nonatomic, strong)NSMutableArray * dataArray;

@property (nonatomic, strong) NSString * ID;

@property (nonatomic, strong) NSString * aId;

@property (nonatomic, strong) UITextField *sellPriceTextFiled;

@end

@implementation MyGoodsViewController

- (void)dealloc {
    [self.headView free];
    [self.footView free];
    [self removeObserver:self forKeyPath:@"nowLabel.text"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"产品中心";
    currentCatID = @"0";
    self.curPage=1;
    
    [self.view addSubview:self.tab];
    [self addObserver:self forKeyPath:@"nowLabel.text" options:NSKeyValueObservingOptionNew context:nil];
    [self key];

    
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.headView=[[MJRefreshHeaderView alloc] init];
    self.headView.scrollView=_tab;
    self.headView.delegate=self;
    
    self.footView=[[MJRefreshFooterView alloc] init];
    self.footView.scrollView=_tab;
    self.footView.delegate=self;
    
    /*右导航按钮*/
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"search_item.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                               style:UIBarButtonItemStylePlain
                                                              target:self action:@selector(gotoSearch)];
    self.navigationItem.rightBarButtonItem = item;
    
    [self postGoodsWithCatID:currentCatID];

}

- (void)gotoSearch {
    MyGoodsSearchViewController *vc = [MyGoodsSearchViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView {
    if (refreshView==self.headView) {
        self.curPage=1;
        [self postGoodsWithCatID:currentCatID];
        
    }else {
        self.curPage++;
        [self postGoodsWithCatID:currentCatID];
    }
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.shouldPushToSetPayPasswordPage) {
        self.shouldPushToSetPayPasswordPage = NO;
        EditPwdWithOldPwdViewController *editPwdVC = [[EditPwdWithOldPwdViewController alloc] init];
        editPwdVC.type = EditPasswordTypePayPasswordWithoutVerifyCode;
        editPwdVC.phoneNum = [[PreferenceManager sharedManager] preferenceForKey:@"userPhone"];
        [self.navigationController pushViewController:editPwdVC animated:YES];
    }
}

#pragma mark - 懒加载
-(UITableView *)tab {
    if (!_tab) {
        self.tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64)];
        _tab.backgroundColor = MONEY_COLOR;
        _tab.delegate = self;
        _tab.dataSource = self;
        _tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.headerView = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 64)];
        
        [_headerView.fangwenView addTarget:self action:@selector(todayFangwenAnimated) forControlEvents:UIControlEventTouchUpInside];
        
        [_headerView.orderView addTarget:self action:@selector(todayOrderAnimated) forControlEvents:UIControlEventTouchUpInside];
        
        [_headerView.addView addTarget:self action:@selector(addAnimated) forControlEvents:UIControlEventTouchUpInside];
        
        [_headerView.todayIncomeView addTarget:self action:@selector(todayIncomeAnimated) forControlEvents:UIControlEventTouchUpInside];
        _tab.tableHeaderView = _headerView;
    }
    return _tab;
}

#pragma mark - UITableViewDataSource/delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIndentifier = @"cell";
    MyGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[MyGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    //取消选中状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.fiel.tag = indexPath.row;
    
    [cell.fiel addTarget:self action:@selector(fielManger:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.jiage.tag = indexPath.row;
    [cell.jiage addTarget:self action:@selector(popPickerView:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell updateWith:[self.dataArray objectAtIndex:indexPath.row]];
    cell.xiaJiaBtn.tag = indexPath.row;
    [cell.xiaJiaBtn addTarget:self action:@selector(xiaJia:) forControlEvents:UIControlEventTouchUpInside];
   
    cell.cancelBtn.tag =  indexPath.row;
    [cell.cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.StatisticsBtn.tag = indexPath.row;
     [cell.StatisticsBtn addTarget:self action:@selector(Statistics:) forControlEvents:UIControlEventTouchUpInside];

    return cell;

}
- (void)xiaJia:(UIButton *)sender
{
    xiaJiaPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    xiaJiaSelectEditIndex = sender.tag;
    MyGoodsCell * cell = (MyGoodsCell *)[_tab cellForRowAtIndexPath:xiaJiaPath];
    if ([cell.xiaJiaBtn.titleLabel.text isEqualToString:@"点击下架"]) {
        
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"确定下架" delegate: self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 5000;
        [alert show];
    }else
    {
    
        UIAlertView * alert1 = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title  message:@"确定上架" delegate: self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert1.tag = 5001;
        [alert1 show];
    }
}
-(void)postXiaJia
{
    
    
    if(xiaJiaSelectEditIndex>=self.dataArray.count){
        return;
    }
    
    NSString * strID = [[self.dataArray objectAtIndex:xiaJiaSelectEditIndex] objectForKey:@"id"];
    
//    NSString * strAID = [[self.dataArray objectAtIndex:xiaJiaSelectEditIndex] objectForKey:@"aid"];
    DLog(@"_________&&&&&  %@", strID);
    [SVProgressHUD show];
    
    NSString*body=[NSString stringWithFormat:@"id=%@&type=1",  strID];
    
    NSString *str=MOBILE_SERVER_URL(@"myproduct_xiajia.php");
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
            self.curPage=1;
            [self postGoodsWithCatID:currentCatID];
            
//            MyGoodsCell * cell = (MyGoodsCell *)[_tab cellForRowAtIndexPath:xiaJiaPath];
//            [cell.xiaJiaBtn setTitle:@"上架" forState:UIControlStateNormal];
//           
//            [_tab reloadData];
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
        
        [self.footView endRefreshing];
        [self.headView endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        [self.footView endRefreshing];
        [self.headView endRefreshing];
    }];
    [op start];
}
-(void)postShangJia
{
    
    
    if(xiaJiaSelectEditIndex>=self.dataArray.count){
        return;
    }
    
    NSString * strID = [[self.dataArray objectAtIndex:xiaJiaSelectEditIndex] objectForKey:@"id"];

    DLog(@"_________&&&&&  %@", strID);
    [SVProgressHUD show];
    
    NSString*body=[NSString stringWithFormat:@"id=%@&type=3",  strID];
    
    NSString *str=MOBILE_SERVER_URL(@"myproduct_xiajia.php");
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
            self.curPage=1;
            [self postGoodsWithCatID:currentCatID];
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
        [self.footView endRefreshing];
        [self.headView endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        [self.footView endRefreshing];
        [self.headView endRefreshing];
    }];
    [op start];
}

- (void)cancel:(UIButton *)btn
{
    cancleSelectEditIndex = btn.tag;
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"确定删除" delegate: self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 5002;
    [alert show];
}
- (void)Statistics:(UIButton *)sender
{
    MyGoodStatisticsViewController *vc = [MyGoodStatisticsViewController new];
    vc.goodsID = [NSString stringWithFormat:@"%@",[[self.dataArray objectAtIndex:sender.tag] objectForKey:@"id"]];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)postCancle
{
    
    
    if(cancleSelectEditIndex>=self.dataArray.count){
        return;
    }
    
    NSString * strID = [[self.dataArray objectAtIndex:cancleSelectEditIndex] objectForKey:@"id"];
    DLog(@"_________&&&&&  %@", strID);
    [SVProgressHUD show];
    
    NSString*body=[NSString stringWithFormat:@"&id=%@&type=2",  strID];
    
    NSString *str=MOBILE_SERVER_URL(@"myproduct_xiajia.php");
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
            [SVProgressHUD dismissWithSuccess:@"删除成功"];
            sleep(2);
            self.curPage=1;
            [self postGoodsWithCatID:currentCatID];
            
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
        
        [self.footView endRefreshing];
        [self.headView endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        [self.footView endRefreshing];
        [self.headView endRefreshing];
    }];
    [op start];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [NSString stringWithFormat:@"%@",[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"subject"]];
    CGFloat hightForTitle = [self getLengthWithStr:title];
    return 128 + hightForTitle;
}
- (float)getLengthWithStr:(NSString *)str {
    CGRect rect = [str boundingRectWithSize:CGSizeMake(UI_SCREEN_WIDTH - 96, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    return ceilf(rect.size.height);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 36)];
    sectionView.backgroundColor = WHITE_COLOR;
    
    UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 1)];
    line1.backgroundColor = [UIColor colorFromHexCode:@"cdcdcd"];
    [sectionView addSubview:line1];
    NSArray * array = @[@"商品", @"订单", @"数据", @"文案"];
    for (int i = 0; i < array.count; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH/ array.count * i, 1, UI_SCREEN_WIDTH / array.count, 35)];
        label.text = array[i];
        label.userInteractionEnabled = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        [sectionView addSubview:label];
        if (i == 0) {
            label.textColor = App_Main_Color;
            label.backgroundColor = [UIColor colorFromHexCode:@"ffeeca"];
        }
        if (i == 1) {
            [label addTarget:self action:@selector(order) forControlEvents:UIControlEventTouchUpInside];
        }
        if (i == 3) {
            [label addTarget:self action:@selector(fileCenter) forControlEvents:UIControlEventTouchUpInside];
        }
        
        if (i == 2) {
            [label addTarget:self action:@selector(data) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 36, UI_SCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor colorFromHexCode:@"cdcdcd"];
    [sectionView addSubview:line];
    return sectionView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 36;
}

#pragma mark - http
-(void)postGoodsWithCatID:(NSString *)catID
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"p=%d&catid=%@", self.curPage, catID];
    NSString *str=MOBILE_SERVER_URL(@"myproductlist.php");
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
            
            if(self.curPage == 1)
            {
                [self.dataArray removeAllObjects];
            }
            
            NSArray * tempArray = [NSArray array];
            tempArray = [responseObject objectForKey:@"content"];
            
            
            if([tempArray isKindOfClass:[NSArray class]])
            {
                [self.dataArray addObjectsFromArray:tempArray];
                if (self.dataArray.count == 0) {
                    
                    if (!imgVi) {
                        imgVi = [[UIImageView alloc] init];
                        imgVi.frame = CGRectMake(UI_SCREEN_WIDTH/2-90/2+IPHONE4HEIGHT(5), 235-IPHONE4HEIGHT(40), 90-IPHONE4HEIGHT(10), 90-IPHONE4HEIGHT(10));
                        imgVi.image = [UIImage imageNamed:@"gj_tanhao.png"];
                        imgVi.tag = 10001;
                        [self.tab addSubview:imgVi];
                    }
                    
                    if (!noDataWarningLabel) {
                        noDataWarningLabel = [[UILabel alloc] init];
                        noDataWarningLabel.tag = 10086;
                        noDataWarningLabel.frame = CGRectMake(0, 300-IPHONE4HEIGHT(50), UI_SCREEN_WIDTH, 80);
                        noDataWarningLabel.text = @"产品库是空的";
                        noDataWarningLabel.textColor = DETAILS_COLOR;
                        noDataWarningLabel.textAlignment = NSTextAlignmentCenter;
                        noDataWarningLabel.font = [UIFont systemFontOfSize:14.0f];
                        [_tab addSubview:noDataWarningLabel];
                    }
                    
                }else {
                    [imgVi removeFromSuperview];
                    [noDataWarningLabel removeFromSuperview];
                }

            }
            [self.tab reloadData];

            self.headerView.todayIncomeLabel.text = [NSString stringWithFormat:@"  ¥ %.2f", [[responseObject objectForKey:@"tshouru"] floatValue]];
            
             self.headerView.Label1.text = [NSString stringWithFormat:@"  ¥ %.2f", [[responseObject objectForKey:@"shouyitotal"] floatValue]];
            
             self.headerView.Label2.text = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"tfangwen"]];
            
            self.headerView.Label3.text = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"tordernum"]];
            

        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
            }
        }
        
        [self.footView endRefreshing];
        [self.headView endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        [self.footView endRefreshing];
        [self.headView endRefreshing];
    }];
    [op start];
    
}

-(void)postPrice:(UIButton *)sender
{
    if(sender.tag>=self.dataArray.count){
        return;
    }
    
    NSString * strID = [[self.dataArray objectAtIndex:curSelectEditIndex] objectForKey:@"id"];
    
 NSString * strAID = [[self.dataArray objectAtIndex:curSelectEditIndex] objectForKey:@"aid"];
     DLog(@"_________&&&&&  %@", strID);
    [SVProgressHUD show];
    
    NSString*body=[NSString stringWithFormat:@"price=%@&id=%@&aid=%@", _nowLabel.text, strID, strAID];
   
    NSString *str=MOBILE_SERVER_URL(@"editprice.php");
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
        
        [self.footView endRefreshing];
        [self.headView endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
        [self.footView endRefreshing];
        [self.headView endRefreshing];
    }];
    [op start];
}

#pragma mark - key
- (void)key
{
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    _backView.backgroundColor = MONEY_COLOR;
    _backView.userInteractionEnabled = YES;
    [_backView addTarget:self action:@selector(hidePickerView) forControlEvents:UIControlEventTouchUpInside];
    [_backView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.3]];
    [self.view addSubview:_backView];
    
    //底部视图
    self.areaView = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 313)];
    _areaView.backgroundColor = WHITE_COLOR;
    [_backView addSubview:_areaView];
    
   
    UIView * fiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 96)];
    
    fiView.backgroundColor = MONEY_COLOR;
    [_areaView addSubview:fiView];
    
    
    UILabel * teLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 14, UI_SCREEN_WIDTH / 5, 20)];
    teLabel.text = @"售价 ￥";
    teLabel.font = [UIFont systemFontOfSize:14];
    
    NSString* thStr = teLabel.text;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:thStr attributes:nil];

    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"CECECE"] range:NSMakeRange(3,thStr.length-3)];
    
    teLabel.attributedText = str;
    
    [fiView addSubview:teLabel];
    
    self.nowLabel = [[UILabel alloc] initWithFrame:CGRectMake(18 + UI_SCREEN_WIDTH / 5, 14, UI_SCREEN_WIDTH / 4, 20)];
    
    _nowLabel.text = @"0.00";
    _nowLabel.font = [UIFont systemFontOfSize:14];

    self.sellPriceTextFiled = [[UITextField alloc] initWithFrame:self.nowLabel.frame];
    self.sellPriceTextFiled.inputView = [[UIView alloc]initWithFrame:CGRectZero];
    [fiView addSubview:self.sellPriceTextFiled];
    self.sellPriceTextFiled.hideStatus = @"1";
    
    self.orginLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH / 2, 14, UI_SCREEN_WIDTH / 2 - 18, 20)];
    _orginLabel.text = @"参考价 ￥4600";
    _orginLabel.font = [UIFont systemFontOfSize:13];
    _orginLabel.textColor = [UIColor colorFromHexCode:@"9595A2"];
    _orginLabel.textAlignment = NSTextAlignmentRight;
    [fiView addSubview:_orginLabel];
    
    
    UIView * keyLine1 = [[UIView alloc] initWithFrame:CGRectMake(18, 96 / 2, UI_SCREEN_WIDTH - 18, 1)];
    keyLine1.backgroundColor = LINE_SHALLOW_COLOR;
    [fiView addSubview:keyLine1];
    
    self.vi = [[UILabel alloc] initWithFrame:CGRectMake(18, 64, UI_SCREEN_WIDTH, 44 - 25)];
    _vi.text = @"价格可调节范围: 4400 - 4700";
    _vi.font = [UIFont systemFontOfSize:13];
    _vi.textColor = [UIColor colorFromHexCode:@"9595A2"];
    [fiView addSubview:_vi];
    
    UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 96, UI_SCREEN_WIDTH, 1)];
    line1.backgroundColor = LINE_SHALLOW_COLOR;
    [fiView addSubview:line1];
    
    for (int i = 0; i < 9; i++) {
        
        NSInteger index = i % 3;
        NSInteger page = i / 3;
        
        UIButton * btn = [[UIButton alloc] initWithFrame: CGRectMake(index * (UI_SCREEN_WIDTH / 3 - 82 / 3), page * (217 / 4) + 97, UI_SCREEN_WIDTH / 3 - 82 / 3, 217 / 4) ];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:21];
        [btn setTitle:[NSString stringWithFormat:@"%d", i + 1] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(huoqu:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 2000 + i;
        btn.backgroundColor = [UIColor whiteColor];
        [_areaView addSubview:btn];
        
        
    }
    
    for (int i = 1; i < 4; i++) {
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake((UI_SCREEN_WIDTH / 3 - 82 / 3) *(i),  97, 1, 313 - 97)];
        line.backgroundColor = LINE_SHALLOW_COLOR;
        [_areaView addSubview:line];
        
        UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(0,  217 / 4 * i + 97, UI_SCREEN_WIDTH - 82, 1)];
        line1.backgroundColor = LINE_SHALLOW_COLOR;
        [_areaView addSubview:line1];
    }
    
    UIView * keyLine3 = [[UIView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 83, 97, 1, 313  - 97)];
    keyLine3.backgroundColor = LINE_SHALLOW_COLOR;
    //    [_areaView addSubview:keyLine3];
    
    UIButton * dianbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    dianbtn.frame = CGRectMake(0, 217 / 4 * 3 + 96, UI_SCREEN_WIDTH / 3 - 81 / 3, 217 / 4);
    [dianbtn setTitle:@"." forState:UIControlStateNormal];
    [dianbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    dianbtn.titleLabel.font = [UIFont systemFontOfSize:21];

    [dianbtn addTarget:self action:@selector(huoqu:) forControlEvents:UIControlEventTouchUpInside];
    [_areaView addSubview:dianbtn];

    
    UIButton * zerobtn = [UIButton buttonWithType:UIButtonTypeSystem];
    zerobtn.frame = CGRectMake(UI_SCREEN_WIDTH / 3 - 82 / 3, 217 / 4 * 3 + 96, UI_SCREEN_WIDTH / 3 - 82 / 3, 217 / 4);
    [zerobtn setTitle:[NSString stringWithFormat:@"%d", 0] forState:UIControlStateNormal];
    [zerobtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    zerobtn.titleLabel.font = [UIFont systemFontOfSize:21];
    [zerobtn addTarget:self action:@selector(huoqu:) forControlEvents:UIControlEventTouchUpInside];
    [_areaView addSubview:zerobtn];

    UIButton * hiderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hiderBtn.frame = CGRectMake((UI_SCREEN_WIDTH / 3 - 82 / 3) * 2, 217 / 4 * 3 + 96, UI_SCREEN_WIDTH / 3 - 82 / 3, 217 / 4);
    [hiderBtn setImage:[UIImage imageNamed:@"s_key.png"] forState:UIControlStateNormal];
    [hiderBtn addTarget:self action:@selector(hidePickerView) forControlEvents:UIControlEventTouchUpInside];
    [_areaView addSubview:hiderBtn];
    
    
    UIButton * quxiaobtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quxiaobtn.frame = CGRectMake(UI_SCREEN_WIDTH - 82, 97, 82, 313 / 2 - 97 / 2);
    [quxiaobtn setTitle:@"a" forState:UIControlStateNormal];
    [quxiaobtn addTarget:self action:@selector(huoqu:) forControlEvents:UIControlEventTouchUpInside];
    [quxiaobtn setImage:[UIImage imageNamed:@"backspace.png"] forState:UIControlStateNormal];
    [_areaView addSubview:quxiaobtn];
    
    UIButton * quedingBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    quedingBtn.frame = CGRectMake(UI_SCREEN_WIDTH - 82, 313 / 2 - 97 / 2 + 97, 82, 313 / 2 - 97 / 2);
    [quedingBtn addTarget:self action:@selector( queding:) forControlEvents:UIControlEventTouchUpInside];
    [quedingBtn setTitle:@"确定" forState:UIControlStateNormal];
    quedingBtn.backgroundColor = [UIColor colorFromHexCode:@"0d85ff"];
    [quedingBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [_areaView addSubview:quedingBtn];
    
    
    
}

- (void)huoqu:(UIButton *)sender
{
    
    
    if (self.isClickKey == NO) {
        _isClickKey = YES;
        _nowLabel.text = sender.currentTitle;
        
        if ([sender.currentTitle isEqualToString:@"a"]) {
            
            _nowLabel.text = @"";
        }else{
            _nowLabel.text = sender.currentTitle;
            
        }
        
    }else{
        
        [self changeTextFieldContent:sender.currentTitle];
    }
}

- (void)changeTextFieldContent:(NSString *)titleStr
{
    if ([titleStr isEqualToString:@""]) {
        
//        [self.textField resignFirstResponder];
    }else if ([self.nowLabel.text isEqualToString:@"0.00"]) {
        
        self.nowLabel.text = 0;
    
    }else if([titleStr isEqualToString:@"a"]) {
        //如果文本框中有内容则 删除最后一个文本框中的最后一个字符
        if (self.nowLabel.text.length > 0) {
            //先获取文本框中的内容
            NSMutableString * mutableStr = [NSMutableString stringWithString: self.nowLabel.text];
            //将文本框中 的内容移除最后一个字符
            [mutableStr deleteCharactersInRange:NSMakeRange(mutableStr.length - 1, 1)];
            NSLog(@"%@", titleStr);
            self.nowLabel.text = mutableStr;
        }
    } else {
        NSString * newStr = [NSString stringWithFormat:@"%@%@", self.nowLabel.text, titleStr];
        NSLog(@"%@", titleStr);
        self.nowLabel.text = newStr;
    }
}

- (void)queding:(UIButton *)btn
{
    if ([_nowLabel.text floatValue] >= [low floatValue] && [_nowLabel.text floatValue] <= [high floatValue]) {
        
        UIAlertView * lert = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"确定修改售价" delegate: self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        lert.tag = 2000;
        [lert show];
        [self postPrice:btn];
    }else{
        
        UIAlertView * alt = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title  message:@"您输入不在范围内, 请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
    }
    
    self.isClickKey = NO;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1 && alertView.tag == 2000) {
        [self hidePickerView];
        
        [self postGoodsWithCatID:currentCatID];
    }
    
    if (buttonIndex == 1 && alertView.tag == 5000) {
//        [self hidePickerView];
        
        [self postXiaJia];
    }

    
    if (buttonIndex == 1 && alertView.tag == 5001) {
        //        [self hidePickerView];
        
        [self postShangJia];
    }

    if (buttonIndex == 1 && alertView.tag == 5002) {
        //        [self hidePickerView];
        
        [self postCancle];
    }

}
#pragma mark - 弹出和消失
- (void)popPickerView:(UIButton *)sender
{
    [self.sellPriceTextFiled becomeFirstResponder];
    curSelectEditIndex=sender.tag;
    
    price = [[self.dataArray objectAtIndex:curSelectEditIndex] objectForKey:@"price"];
    
    low = [[self.dataArray objectAtIndex:curSelectEditIndex] objectForKey:@"lowprice"];
    
    high = [[self.dataArray objectAtIndex:curSelectEditIndex] objectForKey:@"powprice"];
    
    _nowLabel.text = [NSString stringWithFormat:@"%@", [[self.dataArray objectAtIndex:curSelectEditIndex] objectForKey:@"price"]];
    self.sellPriceTextFiled.text = _nowLabel.text;
    _vi.text =[NSString stringWithFormat:@"价格可调节范围:%@ - %@" ,[[self.dataArray objectAtIndex:curSelectEditIndex] objectForKey:@"lowprice"], [[self.dataArray objectAtIndex:curSelectEditIndex] objectForKey:@"powprice"]];
    _orginLabel.text = [NSString stringWithFormat:@"参考价 ￥%@", [[self.dataArray objectAtIndex:sender.tag] objectForKey:@"F_Price"]];

    self.backView.frame = self.view.bounds;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.backView.backgroundColor=[UIColor colorFromHexCode:@"000000" alpha:0.7];
    UIWindow *window=[[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self.backView];
    [window addSubview:self.areaView];
    
    
    self.areaView.frame = CGRectMake(0, UI_SCREEN_HEIGHT - 313, UI_SCREEN_WIDTH, 313);

    [UIView commitAnimations];
}

- (void)hidePickerView
{
    [self.sellPriceTextFiled resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.areaView.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 313);
    [UIView commitAnimations];
    
    [self performSelector:@selector(back) withObject:nil afterDelay:0.3];
    
}
- (void)back
{
    self.backView.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    
}

#pragma mark - 触发事件
- (void)addAnimated
{
    CumulativeGainViewController * vc = [[CumulativeGainViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)todayFangwenAnimated
{
    RecordViewController * vc = [[RecordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.popBlock = ^(int vcTag)
    {
        [self pushToNextViewControllerWithTag:vcTag];
    };
    
    
}
- (void)todayOrderAnimated
{
    TodayOrderViewController * vc = [[TodayOrderViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    vc.popBlock = ^(int vcTag)
    {
        [self pushToNextViewControllerWithTag:vcTag];
    };
}

- (void)todayIncomeAnimated
{

    TodayIncomeViewController * vc = [[TodayIncomeViewController alloc] init];
    vc.whereVC = 3;
    [self.navigationController pushViewController:vc animated:YES];
    vc.popBlock = ^(int vcTag)
    {
        [self pushToNextViewControllerWithTag:vcTag];
    };

}
- (void)data {
    AddViewController * vc = [[AddViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.popBlock = ^(int vcTag)
    {
        [self pushToNextViewControllerWithTag:vcTag];
    };
}


#pragma mark - Block回调跳转
- (void)add {
    AddViewController * vc = [[AddViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
    vc.popBlock = ^(int vcTag)
    {
        [self pushToNextViewControllerWithTag:vcTag];
    };
    
}
- (void)todayIncome
{
    TodayIncomeViewController * vc = [[TodayIncomeViewController alloc] init];
    vc.whereVC = 3;
    [self.navigationController pushViewController:vc animated:NO];
    vc.popBlock = ^(int vcTag)
    {
        [self pushToNextViewControllerWithTag:vcTag];
    };
    
}


- (void)todayFangwen
{
    RecordViewController * vc = [[RecordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
    vc.popBlock = ^(int vcTag)
    {
        [self pushToNextViewControllerWithTag:vcTag];
    };
    
}

- (void)todayOrder
{
    TodayOrderViewController * vc = [[TodayOrderViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
    vc.popBlock = ^(int vcTag)
    {
        [self pushToNextViewControllerWithTag:vcTag];
    };
    
}
- (void)historyFangwen
{
    HistoryViewController  * vc = [[HistoryViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
    vc.popBlock = ^(int vcTag)
    {
        [self pushToNextViewControllerWithTag:vcTag];
    };
    
}

- (void)pushToNextViewControllerWithTag:(int)vcTag {
    switch (vcTag) {
        case 501:
            [self todayIncome];
            break;
        case 502:
            [self todayFangwen];
            break;
        case 503:
            [self todayOrder];
            break;
        case 504:
            [self add];
            break;
        case 505:
            [self historyFangwen];
            break;
        default:
            break;
    }
}

- (void)fielManger:(UIButton *)sender
{
    FielMangerViewController * vc = [[FielMangerViewController alloc] init];
    vc.flag = 1;
    vc.aID = [[self.dataArray objectAtIndex:sender.tag] objectForKey:@"id"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)fileCenter
{
    FielMangerViewController * vc = [[FielMangerViewController alloc] init];
    vc.flag=2;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)order
{

    CustomViewController * vc = [[CustomViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.popBlock = ^(int vcTag)
    {
        [self pushToOrderViewControllerWithTag:vcTag];
    };
}

- (void)pushToOrderViewControllerWithTag:(int)vcTag {
    switch (vcTag) {
        case 600:
            [self myOrder];
            break;
        case 601:
            [self customOrder];
            break;
            
        default:
            break;
    }
}
#pragma mark - Block回调跳转
- (void)myOrder {
    OrderViewController * vc = [[OrderViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
    vc.popBlock = ^(int vcTag)
    {
        [self pushToOrderViewControllerWithTag:vcTag];
    };
    
}
- (void)customOrder
{
    CustomViewController * vc = [[CustomViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
    vc.popBlock = ^(int vcTag)
    {
        [self pushToOrderViewControllerWithTag:vcTag];
    };
    
}
#pragma mark - KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"nowLabel.text"])
    {
        self.sellPriceTextFiled.text = self.nowLabel.text;
    }
}



@end
