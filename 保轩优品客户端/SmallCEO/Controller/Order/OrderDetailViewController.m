//
//  OrderDetailViewController.m
//  SmallCEO
//
//  Created by peterwang on 17/3/3.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "CheckOrderCell.h"
#import "SmallTableViewCell.h"
#import "ImageAndNameCell.h"
#import "OrderDetaliHeadCell.h"
#import "CountTableViewCell.h"

@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *serviceAddressLabel;
@property (nonatomic, strong) UIButton *finishOrderButton;
@property (nonatomic, strong) NSDictionary *detailDic;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor clearColor];
    [self createTabView];
    [self getDataFordetail];
}
#pragma mark-创建表示图
- (void)createTabView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64-50) style:UITableViewStylePlain];

    self.tableView.backgroundColor = [UIColor colorFromHexCode:@"#F5F5F5"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[OrderDetaliHeadCell class] forCellReuseIdentifier:@"OrderDetaliHeadCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CheckOrderCell"];
    [self.tableView registerClass:[CountTableViewCell class] forCellReuseIdentifier:@"CountTableViewCell"];
    [self.tableView registerClass:[SmallTableViewCell class] forCellReuseIdentifier:@"SmallTableViewCell"];
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT-50-64, UI_SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    for ( int i  = 0; i<2; i++) {
//        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH-180+90*i, 10, 80, 30) ];
//        btn.layer.borderWidth = 1.0;
//        if (i == 0) {
//            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            btn.layer.borderColor = [UIColor blackColor].CGColor;
//            [btn setTitle:@"删除订单" forState:UIControlStateNormal];
//        }else{
//            btn.layer.borderColor = [UIColor redColor].CGColor;
//            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//            [btn setTitle:@"评价" forState:UIControlStateNormal];
//        }
//        btn.layer.cornerRadius = 3;
//        [view addSubview:btn];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2*i, 0, UI_SCREEN_WIDTH/2, 50) ];
        if (i == 0) {
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitle:@"取消订单" forState:UIControlStateNormal];
        }else{
            btn.backgroundColor = Main_Color;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitle:@"付款" forState:UIControlStateNormal];
        }
        [view addSubview:btn];

    }
}
#pragma mark-UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //改变单元格分割线长度
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if (indexPath.section == 0) {
        OrderDetaliHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetaliHeadCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        if ([[self.detailDic allKeys] containsObject:@"delivery_info"]) {
            NSDictionary *dic = self.detailDic[@"delivery_info"];
            cell.nameLabel.text = [NSString stringWithFormat:@"收货人:%@",dic[@"express"][@"contacts_name"]];
            cell.phoneLabel.text = dic[@"express"][@"contacts_tel"];
            cell.addressLabel.text = [NSString stringWithFormat:@"收货地址:%@",dic[@"express"][@"address"]];
        }
        return cell;
        
    }else if (indexPath.section == 1)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CheckOrderCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        
        if ([[self.detailDic allKeys] containsObject:@"goods_info"]) {
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:self.detailDic[@"goods_info"]];
            NSMutableArray* picUrl = [NSMutableArray arrayWithCapacity:0];
            
            DLog(@"%@",dic);
            int countPic = 0;
        
            for(int i =0;i<[dic[@"goods_img_arr"] count];i++){
                [picUrl addObject:dic[@"goods_img_arr"][i]];
            }
//            if(self.wp == 2){
//                countPic = 1;
//            }else if(self.wp == 1){
//                
//            }
            
            countPic = picUrl.count > 3 ? 3 : (int)picUrl.count;
            
            for (int i = 0; i < countPic; i++) {
                UIImageView * photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + 70 * i, 11.5, 65, 65)];
                photoImageView.backgroundColor = [UIColor whiteColor];
                NSURL* url = [NSURL URLWithString:[picUrl objectAtIndex:i]];
                [photoImageView af_setImageWithURL:url];
                [cell.contentView addSubview:photoImageView];
                
            
                if (picUrl.count > 3) {
                    UILabel *andSoOn = [[UILabel alloc] init];
                    andSoOn.center = CGPointMake(10+60*3+25, 38.5) ;
                    andSoOn.bounds = CGRectMake(0, 0, 50, 20);
                    andSoOn.text = @". . 等";
                    andSoOn.textColor = [UIColor blackColor];
                    andSoOn.textAlignment = NSTextAlignmentCenter;
                    andSoOn.font = [UIFont systemFontOfSize:14];
                    [cell.contentView addSubview:andSoOn];
                }
            
                UIImageView* imgjt = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH-10-5, (88-8)/2, 5, 8)];
                imgjt.image = [UIImage imageNamed:@"gj_jt_right.png"];
                [cell.contentView addSubview:imgjt];
        
                UILabel *goodsCount = [[UILabel alloc] init];
                    //    goodsCount.frame = CGRectMake(UI_SCREEN_WIDTH-15-5-85, 42+timeViewHight, 80, 20);
                goodsCount.frame = CGRectMake(UI_SCREEN_WIDTH-15-5-85, (88-20)/2, 80, 20);
                goodsCount.textColor = BLACK_COLOR;
                goodsCount.textAlignment = NSTextAlignmentRight;
                goodsCount.font = [UIFont systemFontOfSize:14];
                goodsCount.text = [NSString stringWithFormat:@"共%@件",dic[@"goods_total_num"]];
                [cell.contentView addSubview:goodsCount];
            }

        }
        return cell;
    }else if (indexPath.section == 2)
    {
        CountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CountTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        if ([[self.detailDic allKeys] containsObject:@"pay_info"]) {
            NSDictionary *dic = self.detailDic[@"pay_info"];
            cell.total.text = [NSString stringWithFormat:@"¥%@",dic[@"goods_total_money"]];
            cell.freight.text = [NSString stringWithFormat:@"¥%@",dic[@"freight"]];
            cell.total2.text = [NSString stringWithFormat:@"¥%@",dic[@"total_money"]];
        }
        
        return cell;
    }else {
        SmallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SmallTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;

//    if (_type) {
//        }
//        
//    }else {
//        if (indexPath.section == 0) {
//            OrderDetaliHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetaliHeadCell"];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            
//            return cell;
//            
//        }else if (indexPath.section == 1)
//        {
//            CheckOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CheckOrderCell"];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.backgroundColor = [UIColor clearColor];
//            cell.statesLabel.text = @"未完成";
//            
//            return cell;
//        }else
//        {
//            CountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CountTableViewCell"];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.accessoryType = UITableViewCellAccessoryNone;
//            
//            return cell;
//        }
//        
    }
        
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    }else if (indexPath.section == 1){
        return 88;
    }else {
        return 105;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1;
    }else {
        return 10;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 1) {
        
    }
}
//#pragma mark - UIButton action methods
//- (void)finishOrder
//{
//    [SVProgressHUD show];
//    OrderRequest *orderRequest = [OrderRequest new];
//    orderRequest.orderID = [NSString stringWithFormat:@"%@", self.orderInfos[@"id"]];
//    orderRequest.orderRequestType = OrderRequestTypeFinishDeliverCoatings;
//    [orderRequest postWithCompletionBlockWithSuccess:^(BaseRequest *request) {
//        if (request.responseStatusCode == 1)
//        {
//            [SVProgressHUD showSuccessWithStatus:@"完成发货成功"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([SVProgressHUD minimumDismissTimeInterval] * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self.navigationController popToRootViewControllerAnimated:YES];
//            });
//        }
//        else
//        {
//            [SVProgressHUD showErrorWithStatus:request.responseInfo];
//        }
//    } failure:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"网络错误"];
//    }];
//}

//- (void)openMap
//{
//    OnSiteServiceViewController *vc = [OnSiteServiceViewController new];
//    vc.orderInfos = self.orderInfos;
//    [self.navigationController pushViewController:vc animated:YES];
//}

#pragma mark - Http request methods
- (void)getDataFordetail {
    [SVProgressHUD show];
    
    NSString*body = [NSString stringWithFormat:@"act=3&order_id=%@",self.orderInfos[@"order_id"]];
    NSString *str=MOBILE_SERVER_URL(@"orderApi.php");
    
    [RequestManager startRequestWithUrl:str
                                   body:body
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject){
                               DLog(@"%@",responseObject);
                               if ([responseObject[@"is_success"] integerValue] == 1) {
                                   [SVProgressHUD dismiss];
                                   self.detailDic = [NSDictionary dictionaryWithDictionary:responseObject];
                                   [_tableView reloadData];
                                   
                               }else {
                                   if ([responseObject valueForKey:@"info"]!=nil) {
                                       [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
                                   }else{
                                       [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
                                   }
                               }
                               
                           }failureBlock:^(AFHTTPRequestOperation *operation, NSError *error){
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }];
}
#pragma mark - Getter
- (void)creatButton
{
    _finishOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _finishOrderButton.frame = CGRectMake(15, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar - 90, UI_SCREEN_WIDTH - 30, 45);
    _finishOrderButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
    _finishOrderButton.layer.cornerRadius = 5.0;
    _finishOrderButton.backgroundColor = [UIColor colorFromHexCode:@"#269dec"];
    [_finishOrderButton setTitle:@"完成发货" forState:UIControlStateNormal];
    [_finishOrderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_finishOrderButton addTarget:self action:@selector(finishOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:_finishOrderButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
