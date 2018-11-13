//
//  MyCollectionViewController.m
//  SmallCEO
//
//  Created by 俊严 on 15/10/19.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyCollectionTableViewCell.h"
#import "CommodityDetailViewController.h"

@interface MyCollectionViewController ()<UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate, MyCollectionTableViewCellDelegate>
{
    UILabel * wuLabel;
    UILabel *noDataWarningLabel;
    int seletedIndex;
    
}
@property (nonatomic, strong)UIView * topView;
@property (nonatomic, strong)NSMutableArray * buttonArray;
@property (nonatomic, strong)UIScrollView * mainView;

@property (nonatomic, strong)UITableView * goodsTableView;
@property (nonatomic, strong)UITableView * groupBuyTableView;
@property (nonatomic, strong)UITableView * tryOutTableView;

@property (nonatomic, strong)NSMutableArray * goodsListArray;
@property (nonatomic, strong)UIImageView *imageV;

@property (nonatomic,assign)int pageClick;

@end

@implementation MyCollectionViewController

- (void)dealloc
{
    [_headView free];
    [_footView free];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.curPage=1;
    [self reloadData];
    
    seletedIndex = self.pageClick+500;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITE_COLOR;
    self.title = @"我的收藏";
    
    self.curPage=1;
    self.pageClick = 0;
    
    self.goodsListArray = [NSMutableArray arrayWithCapacity:0];
    
    
    [self.view addSubview:self.mainView];
    [self.mainView addSubview:self.goodsTableView];
    
    _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2-75, UI_SCREEN_HEIGHT/4-50, 150, 150)];
    _imageV.hidden = NO;
    _imageV.image = [UIImage imageNamed:@"icon-tishi2@2x"];
    [self.goodsTableView addSubview:_imageV];
    
    self.headView=[[MJRefreshHeaderView alloc] init];
    self.headView.scrollView=self.goodsTableView;
    self.headView.delegate=self;
    self.footView=[[MJRefreshFooterView alloc] init];
    self.footView.scrollView=self.goodsTableView;
    self.footView.delegate=self;
    
    
    noDataWarningLabel = [[UILabel alloc] init];
    noDataWarningLabel.frame = CGRectMake(0, 200-IPHONE4HEIGHT(50), UI_SCREEN_WIDTH, 80);
//    noDataWarningLabel.text = @"暂无记录";
    noDataWarningLabel.textColor=[UIColor grayColor];
    noDataWarningLabel.textAlignment = NSTextAlignmentCenter;
    noDataWarningLabel.font = [UIFont systemFontOfSize:17.0];
    noDataWarningLabel.hidden = NO;
    [self.view addSubview:noDataWarningLabel];
    
}

#pragma mark - 懒加载
- (UIScrollView *)mainView
{
    if (!_mainView) {
        self.mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
        _mainView.contentSize = CGSizeMake(self.view.frame.size.width * 5, self.view.frame.size.height-64);
        _mainView.showsHorizontalScrollIndicator = NO;
        _mainView.userInteractionEnabled =YES;
        _mainView.delegate = self;
        _mainView.pagingEnabled = YES;
        _mainView.contentSize =CGSizeMake(UI_SCREEN_WIDTH, self.view.frame.size.height-64);
        _mainView.alwaysBounceHorizontal = NO;
        _mainView.scrollEnabled = NO;
        _mainView.alwaysBounceVertical = NO;
    }
    return _mainView;
}

- (UITableView *)goodsTableView
{
    if (_goodsTableView == nil) {
        self.goodsTableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
        _goodsTableView.dataSource = self;
        _goodsTableView.delegate = self;
        _goodsTableView.tag = 100;
        _goodsTableView.rowHeight = 12+207/2;
        _goodsTableView.backgroundColor = [UIColor colorFromHexCode:@"f2f2f2"];
        _goodsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _goodsTableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
    }
    return _goodsTableView;
}
#pragma mark - MJRefresh
- (void)refresh:(UITableView *)tempView
{
    self.headView.scrollView=tempView;
    self.footView.scrollView=tempView;
}
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView==self.headView)
    {
        self.curPage=1;
        [self reloadData];
        
    }else
    {
        self.curPage++;
        [self reloadData];
        
    }
}
-(void)reloadData
{
    CGPoint point =  self.mainView.contentOffset;
    self.pageClick = point.x/UI_SCREEN_WIDTH;
    [self postCollectionDataWth:self.pageClick];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goodsListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIndentifier = @"myCollection";
    MyCollectionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[MyCollectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.cancelButton.tag = indexPath.row;
    [cell updateCellData:self.goodsListArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.goodsTableView) {
        //普通
        [self goodsdetailWithAid:[NSString stringWithFormat:@"%@",[self.goodsListArray[indexPath.row] objectForKey:@"goods_id"]]];
        
    }
}

- (void)cancelCollectionGoods:(UIButton *)sender {
    DLog(@"取消收藏");
    
    cancleSelectEditIndex = sender.tag;
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"确定取消收藏" delegate: self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self postCancle];
    }
}

/*正常商品详情接口*/
-(void)goodsdetailWithAid:(NSString *)aid {
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"aid=%@",aid];
    NSString *str=MOBILE_SERVER_URL(@"getSupplierProductNew2.php");
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
            
            NSDictionary *contDic=[responseObject valueForKey:@"cont"];
            
            if ([contDic isKindOfClass:[NSDictionary class]]) {
                CommodityDetailViewController *vc=[[CommodityDetailViewController alloc] init];
                vc.comDetailDic=contDic;
                [self.navigationController pushViewController:vc animated:YES];
            }
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
#pragma mark - 取消收藏
- (void)postCancle {
    if(cancleSelectEditIndex >= self.goodsListArray.count){
        return;
    }
    
    NSString * strID = [[self.goodsListArray objectAtIndex:cancleSelectEditIndex] objectForKey:@"goods_id"];
    [SVProgressHUD show];
    
    NSString*body=[NSString stringWithFormat:@"&type=cancel&goods_id=%@&come_way=%d",strID,self.pageClick+1];
    NSString *str=MOBILE_SERVER_URL(@"goods_collection.php");
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
        if ([[responseObject objectForKey:@"is_success"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismissWithSuccess:@"取消收藏成功"];
            self.curPage=1;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self postCollectionDataWth:self.pageClick];
            });
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

- (void)postCollectionDataWth:(int)index {
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"&type=list&page=%d&number_of_age=20&come_way=%d", self.curPage,index+1];
    NSString *str=MOBILE_SERVER_URL(@"goods_collection.php");
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
        if ([[responseObject objectForKey:@"is_success"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismiss];
            
            NSArray *tempArray = [responseObject objectForKey:@"list"];
            
            if(self.curPage == 1) {
                [self.goodsListArray removeAllObjects];
            }
            
            if([tempArray isKindOfClass:[NSArray class]]) {
                [self.goodsListArray addObjectsFromArray:tempArray];
            }
            
            _imageV.hidden = self.goodsListArray.count == 0 ? NO:YES;
            if (index == 0) {
                [self.goodsTableView reloadData];
            }else if (index == 1){
                [self.groupBuyTableView reloadData];
            }else {
                [self.tryOutTableView reloadData];
            }
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络成功"] ;
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

@end
