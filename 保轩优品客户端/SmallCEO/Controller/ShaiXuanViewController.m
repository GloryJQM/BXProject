//
//  ShaiXuanViewController.m
//  SmallCEO
//
//  Created by 俊严 on 15/9/7.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "ShaiXuanViewController.h"
#import "MyOrderCell.h"
#import "OrderCell.h"
#import "WaitViewController.h"
#import "ConfirmDetailVC.h"
#import "RecordCell.h"
#import "TimeDetailTableViewCell.h"
#import "TodayIncomeViewController.h"
#import "ArgueViewController.h"
#import "ApplicationReturnsViewController.h"
#import "PayFinishViewController.h"
@interface ShaiXuanViewController ()<UITableViewDataSource, UITableViewDelegate,RiliViewDelegate>
{
    NSInteger allOrderClickIndexPath;
    NSInteger goodsClickIndexPath;
    NSInteger cancleClickIndepath;
    NSInteger cancleOrderIndepath;
    NSInteger argueClickIndepath;
    NSInteger saleClickIndepath;
    NSString *dateStr;
    UILabel *noDataWarningLabel;
}
@property (nonatomic, strong) NSArray *month;
@property (nonatomic, strong) UILabel *tiplable;
@property (nonatomic, strong)UITableView * mainTableView;
@end

@implementation ShaiXuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITE_COLOR;
    if (self.isGoodsVisterClick == YES) {
         self.title = @"当日浏览";
    }else {
         self.title = @"筛选结果";
    }
   
    UITableView * tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64)];
    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    tab.dataSource = self;
    tab.delegate = self;
    self.mainTableView  = tab;
    [self.view addSubview:tab];
    DLog(@"筛选界面:%ld",[self.dataArray count]);
    if (self.flag == 6) {
        self.tiplable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, tab.frame.size.width,tab.frame.size.height)];
        self.tiplable.textColor=[UIColor lightGrayColor];
        self.tiplable.font=GFB_FONT_CT 17];
        self.tiplable.textAlignment=NSTextAlignmentCenter;
        self.tiplable.backgroundColor=[UIColor clearColor];
        [tab addSubview:_tiplable];
        self.month = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    }
    
    
    noDataWarningLabel = [[UILabel alloc] init];
    noDataWarningLabel.frame = CGRectMake(0, 200-IPHONE4HEIGHT(50), UI_SCREEN_WIDTH, 80);
    noDataWarningLabel.text = @"暂无数据";
    noDataWarningLabel.textColor = DETAILS_COLOR;
    noDataWarningLabel.textAlignment = NSTextAlignmentCenter;
    noDataWarningLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:noDataWarningLabel];
    
    noDataWarningLabel.hidden = self.dataArray.count == 0 ? NO:YES;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.flag == 6) {
        return 1;
    }else {
        return self.dataArray.count;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.flag == 6) {
        if(self.dataArray.count == 0){
            _tiplable.hidden = NO;
        }else{
            _tiplable.hidden = YES;
        }
        return self.dataArray.count;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.flag == 6) {
        return 90;
    }
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.flag == 6) {
        NSDictionary *tempDic=[self.dataArray objectAtIndex:section];
        
        UIView* head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 90)];
        
        UIView* upVi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 32)];
        upVi.backgroundColor = [UIColor colorFromHexCode:@"f4f4f4"];
        
        UILabel* lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 32)];
        lab.text = [NSString stringWithFormat:@"%@年%@月",[tempDic valueForKey:@"year" ],[tempDic valueForKey:@"month"]];
        lab.textColor = TIILE_COLOR;
        lab.font = GFB_FONT_XT 18];
        [upVi addSubview:lab];
        
        
        UIView* midVi = [[UIView alloc]initWithFrame:CGRectMake(0, 32, UI_SCREEN_WIDTH, 20)];
        midVi.backgroundColor = BLUE_COLOR;
        
        UILabel* lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 90, 20)];
        lab1.textColor = WHITE_COLOR;
        lab1.font = GFB_FONT_XT 12];
        
        UILabel* lab2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 65, 20)];
        lab2.textColor = WHITE_COLOR;
        lab2.font = GFB_FONT_CT 15];
        
        [midVi addSubview:lab1];
        [midVi addSubview:lab2];
        
        UIView* downVi = [[UIView alloc]initWithFrame:CGRectMake(0, 52, UI_SCREEN_WIDTH, 38)];
        downVi.backgroundColor = WHITE_COLOR;
        
        NSArray* arr = [NSArray array];
        arr = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
        for(int i = 0;i<arr.count;i++)
        {
            UILabel* lab3 = [[UILabel alloc]initWithFrame:CGRectMake(15+i*(UI_SCREEN_WIDTH-30)/7, 0, (UI_SCREEN_WIDTH-30)/7, 38)];
            lab3.text = arr[i];
            lab3.textColor = LINE_COLOR;
            lab3.textAlignment = NSTextAlignmentCenter;
            lab3.font = GFB_FONT_CT 15];
            
            [downVi addSubview:lab3];
        }
        UIView* line = [[UIView alloc]initWithFrame:CGRectMake(0, 37, UI_SCREEN_WIDTH, 1)];
        line.backgroundColor = LINE_COLOR;
        [downVi addSubview:line];
        
        [head addSubview:upVi];
        [head addSubview:midVi];
        [head addSubview:downVi];
        
        return head;

    }else {
        return nil;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.flag == 3) {
        static NSString * indentifier = @"MyCell";
        MyOrderCell * myCell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (!myCell) {
            myCell = [[MyOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        }
            [myCell updataWith:self.dataArray[indexPath.row]];
        NSDictionary * goodsinfoDic = [self.dataArray objectAtIndex:indexPath.row];
        if ([[goodsinfoDic objectForKey:@"is_pay_status"] intValue]==3) {
            myCell.checkWuLiuBtn.tag = indexPath.row;
            [myCell.checkWuLiuBtn addTarget:self action:@selector(allCheckWuLiu:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        myCell.quxiaoButton.tag = indexPath.row;
        [myCell.quxiaoButton addTarget:self action:@selector(doClickNextPage:) forControlEvents:UIControlEventTouchUpInside];

        return myCell;
        
    }else if(self.flag == 4){
    
        static NSString * indentifier = @"cell";
        OrderCell * cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (!cell) {
            cell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        }
        
        [cell updataWith:self.dataArray[indexPath.row]];
        cell.checkButton.tag = indexPath.row;
        [cell.checkButton addTarget:self action:@selector(customeAllCheckWuLiu:) forControlEvents:UIControlEventTouchUpInside];

        
        return cell;
    }else if (self.flag == 5) {
        static NSString * cellIndentifier = @"hisCell";
        RecordCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (!cell) {
            cell = [[RecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];

        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.isGoodsVisterClick) {
            [cell updateDicInGoods:[self.dataArray objectAtIndex:indexPath.row]];

        }else {
            [cell updateDic:[self.dataArray objectAtIndex:indexPath.row]];

        }
        return cell;
    }else if (self.flag == 6) {
        static NSString* str2 = @"TimeDetailCell";
        TimeDetailTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:str2];
        if(cell == nil)
        {
            cell = [[TimeDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        NSString *month=[NSString stringWithFormat:@"%@",[[self.dataArray objectAtIndex:indexPath.section] valueForKey:@"month"]];
        NSString *year=[NSString stringWithFormat:@"%@",[[self.dataArray objectAtIndex:indexPath.section] valueForKey:@"year"]];
        [cell upDataWith:[year intValue] andMonth:[month intValue] delegate:self :self.dataArray[indexPath.section] withStep:NO];
        
        return cell;
    }
    return nil;
}
- (void)allCheckWuLiu:(UIButton *)sender
{
    DLog(@"物流信息");
    DLog(@"全部订单的查看物流 %ld", sender.tag);
    NSDictionary * goodsinfoDic = [self.dataArray objectAtIndex:sender.tag];
    WaitViewController * waitVC = [[WaitViewController alloc] init];
    [self.navigationController pushViewController:waitVC animated:YES];
    
    if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 2) {
        
        waitVC.flag = 2;
        waitVC.orderTitle = [goodsinfoDic objectForKey:@"order_title"];
        [waitVC.view removeFromSuperview];
        [waitVC.buttomView removeFromSuperview];
        [waitVC.logisticsView removeFromSuperview];
        [waitVC.bView removeFromSuperview];
        
    }
    if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 3) {
        
        
        waitVC.flagVC = 3;
        waitVC.flag = 3;
        
        waitVC.orderTitle = [goodsinfoDic objectForKey:@"order_title"];
        waitVC.titleArrays = @[@"确认收货"];
        
        waitVC.erweiImage = [UIImage imageNamed:@"gj_saomiao_twocode@2x.png"];
    }
    
}
- (void)doClickNextPage:(UIButton *)sender
{
    allOrderClickIndexPath= sender.tag;
    NSDictionary * goodsinfoDic = [self.dataArray objectAtIndex:sender.tag];
    int stats = [[goodsinfoDic objectForKey:@"is_pay_status"] intValue];
    if (stats == 13) {
        ArgueViewController * vc = [[ArgueViewController alloc] init];
        vc.orderID =   [goodsinfoDic objectForKey:@"order_id"];
        vc.dataDic  = goodsinfoDic;
        
        [self.navigationController pushViewController:vc animated:YES];
    }else if (stats == 11){
        DLog(@"售后申请");
        
        NSString*returnMoneyString=[NSString stringWithFormat:@"%@", [goodsinfoDic objectForKey:@"actual_pay_money"]];
        NSString * order = [goodsinfoDic objectForKey:@"order_title"];
        ApplicationReturnsViewController *vc=[[ApplicationReturnsViewController alloc] init];
        vc.returnMoney=returnMoneyString;
        vc.orderId=order;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (stats == 13){
        DLog(@"评价");
        NSDictionary * goodsinfoDic = [self.dataArray objectAtIndex:sender.tag];
        
        ArgueViewController * vc = [[ArgueViewController alloc] init];
        vc.orderID =   [goodsinfoDic objectForKey:@"order_id"];
        vc.dataDic  = goodsinfoDic;
        
        [self.navigationController pushViewController:vc animated:YES];
    }else if (stats == 3){
        //代发货和待收货
        DLog(@"确认收货");
        UIActionSheet* act = [[UIActionSheet alloc]initWithTitle:@"确认已签收商品？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
        act.tag = 2000;
        [act showInView:self.view];
        
        
        
    }else if (stats == 2){
        
        [self allCheckWuLiu:sender];
        
    } else if (stats == 0){
        
        cancleClickIndepath = sender.tag;
        DLog(@"全部:%d", cancleClickIndepath);
        UIActionSheet* act = [[UIActionSheet alloc]initWithTitle:@"确认取消订单？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
        act.tag = 1000;
        [act showInView:self.view];
        
    }
}

- (void)customeAllCheckWuLiu:(UIButton *)sender
{
    NSDictionary * goodsinfoDic = [self.dataArray objectAtIndex:sender.tag];
    
    
    
    if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 2) {
        WaitViewController * waitVC = [[WaitViewController alloc] init];
        
        waitVC.flag = 2;
        waitVC.orderTitle = [goodsinfoDic objectForKey:@"order_title"];
        [waitVC.view removeFromSuperview];
        [waitVC.buttomView removeFromSuperview];
        [waitVC.logisticsView removeFromSuperview];
        [waitVC.bView removeFromSuperview];
        [self.navigationController pushViewController:waitVC animated:YES];
    }
    if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 3) {
        WaitViewController * waitVC = [[WaitViewController alloc] init];
        [self.navigationController pushViewController:waitVC animated:YES];
        waitVC.flagVC = 4;
        waitVC.flag = 3;
        waitVC.orderTitle = [goodsinfoDic objectForKey:@"order_title"];
        waitVC.titleArrays = @[@"确认收货"];
    }
    
    if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 4) {
        
        ConfirmDetailVC * confirmVC = [[ConfirmDetailVC alloc] init];
        //            confirmVC.flagVC = self.flag;
        [self.navigationController pushViewController:confirmVC animated:YES];
        confirmVC.userInterfaceType = HaveConfirmUI;
        confirmVC.ID = [goodsinfoDic objectForKey:@"order_title"];      }
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.flag == 3) {
        
        return 214;
        
    }else if(self.flag == 4){
        
        return 214;
    }else if(self.flag == 5){
        
        return 41;
    }else if(self.flag == 6) {
        DateOut* date = [[DateOut alloc]init];
        int year = [[[self.dataArray objectAtIndex:indexPath.section] valueForKey:@"year"] intValue];
        int mo = [[[self.dataArray objectAtIndex:indexPath.section] valueForKey:@"month"]intValue];
        int allDay = [date allDayInYear:year andMonth:mo];
        int firstDay = [date theFirstDayIsInYear:year andMonth:mo];
        int row = 0;
        if(allDay==28 && firstDay ==1)
        {
            row = 4;
        }else if(firstDay == 7 &&  allDay>29)
        {
            row = 6;
        }else if(firstDay == 6 &&  allDay>30)
        {
            row = 6;
        }else
        {
            row = 5;
        }
        
        return 44*row;
    }
    return  66;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.flag == 5 || self.flag == 6) {
        
    }else {
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
        NSDictionary * goodsinfoDic = [self.dataArray objectAtIndex:indexPath.row];
        if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 0) {
            WaitViewController * waitVC = [[WaitViewController alloc] init];
            [self.navigationController pushViewController:waitVC animated:YES];
            if (self.flag == 3) {
                waitVC.flagVC = 3;
            }
            waitVC.flag = 1;
            waitVC.flagVC = self.flagVC;
            waitVC.titleArrays = @[@"取消订单", @"付款"];
            
            waitVC.orderTitle = [goodsinfoDic objectForKey:@"order_title"];
            [waitVC.payType removeFromSuperview];
            [waitVC.logisticsView removeFromSuperview];
            
            [waitVC.erWeiImageView removeFromSuperview];
        }
        if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 2) {
            WaitViewController * waitVC = [[WaitViewController alloc] init];
            [self.navigationController pushViewController:waitVC animated:YES];
            
            waitVC.flag = 2;
            waitVC.flagVC = self.flagVC;
            waitVC.orderTitle = [goodsinfoDic objectForKey:@"order_title"];
            [waitVC.view removeFromSuperview];
            [waitVC.buttomView removeFromSuperview];
            [waitVC.logisticsView removeFromSuperview];
            [waitVC.bView removeFromSuperview];
            
        }
        if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 3) {
            WaitViewController * waitVC = [[WaitViewController alloc] init];
            [self.navigationController pushViewController:waitVC animated:YES];
            
            waitVC.flag = 3;
            waitVC.flagVC = self.flagVC;
            waitVC.orderTitle = [goodsinfoDic objectForKey:@"order_title"];
            waitVC.titleArrays = @[@"确认收货"];
          
            waitVC.erweiImage = [UIImage imageNamed:@"gj_saomiao_twocode@2x.png"];
        }
        
        if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 4) {
            
            ConfirmDetailVC * confirmVC = [[ConfirmDetailVC alloc] init];
            [self.navigationController pushViewController:confirmVC animated:YES];
            confirmVC.userInterfaceType = HaveConfirmUI;
            confirmVC.ID =   [goodsinfoDic objectForKey:@"order_title"];
        }
        
        if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 7 ||
            [[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 8 ||
            [[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 9)
        {
            ConfirmDetailVC * confirmVC = [[ConfirmDetailVC alloc] init];
            [self.navigationController pushViewController:confirmVC animated:YES];
            confirmVC.userInterfaceType = ApplicationReturnsUI;
            confirmVC.ID =   [goodsinfoDic objectForKey:@"order_title"];
        }
        if ([[goodsinfoDic objectForKey:@"is_pay_status"] integerValue] == 10) {
            
            ConfirmDetailVC * confirmVC = [[ConfirmDetailVC alloc] init];
            [self.navigationController pushViewController:confirmVC animated:YES];
            confirmVC.userInterfaceType = HaveConfirmUI;
            confirmVC.status = BottomViewStatusDelete;
            confirmVC.ID =   [goodsinfoDic objectForKey:@"order_title"];
        }

        if ([[goodsinfoDic objectForKey:@"is_pay_status"]intValue]==13) {
            ConfirmDetailVC * confirmVC = [[ConfirmDetailVC alloc] init];
            confirmVC.status = BottomViewStatusDelete;
            [self.navigationController pushViewController:confirmVC animated:YES];
            confirmVC.userInterfaceType = HaveConfirmUI;
            confirmVC.ID =   [goodsinfoDic objectForKey:@"order_title"];
        }
    }
}
-(void)giveUp:(long)date work:(float)workTime {
    dateStr = [NSString stringWithFormat:@"%ld",date];
    [self getSpecificDateBillInfo];
}
- (void)getSpecificDateBillInfo
{
    [SVProgressHUD show];
    
    NSString *time = [NSString stringWithFormat:@"%@-%@-%@",[dateStr substringToIndex:4],[dateStr substringWithRange:NSMakeRange(4, 2)],[dateStr substringWithRange:NSMakeRange(6, 2)]];
    
    NSString * body = [NSString stringWithFormat:@"record_type=0&see_type=3&time_type=5&time=%@&aid=%@",time,self.goodsID];

    NSString *str=MOBILE_SERVER_URL(@"my_product_record.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];

    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    DLog(@"body is %@",body);
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"is_success"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismiss];
            ShaiXuanViewController*vc = [[ShaiXuanViewController alloc] init];
            vc.dataArray =[responseObject objectForKey:@"list"] ;
            vc.flag = 5;
            vc.isGoodsVisterClick = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0 && actionSheet.tag ==1000)
    {
        [self postRemoveData];
    }else if (buttonIndex == 0 && actionSheet.tag ==1001){
        
        [self postCancelData];
    }else if (buttonIndex == 0 && actionSheet.tag == 5000){
        //5000代表售后的
        [self postShouHouData];
    }else if (buttonIndex == 0 && actionSheet.tag == 2000){
        //2000代表全部订单的代发货和待收货
        [SVProgressHUD show];
        
        NSString * order = [[self.dataArray objectAtIndex:allOrderClickIndexPath] objectForKey:@"order_title"];
        [SVProgressHUD show];
        NSString*body=[NSString stringWithFormat:@"&type=5&order_title=%@",  order];
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
                [SVProgressHUD showSuccessWithStatus:@"已确认"] ;
                PayFinishViewController* vc = [[PayFinishViewController alloc]init];
                vc.orderTitle=order;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                if ([responseObject valueForKey:@"info"]!=nil) {
                    [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
                }else{
                    [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            DLog(@"请求发生的错误是:%@",error);
            DLog(@"返回的数据:%@",operation.responseString);
            [SVProgressHUD dismissWithError:@"网络错误"];
        }];
        [op start];
        
    }else if (buttonIndex == 0&&actionSheet.tag == 7000){
        
        [SVProgressHUD show];
        
        NSString * order = [[self.dataArray objectAtIndex:goodsClickIndexPath] objectForKey:@"order_title"];
        [SVProgressHUD show];
        NSString*body=[NSString stringWithFormat:@"&type=5&order_title=%@",  order];
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
                [SVProgressHUD showSuccessWithStatus:@"已确认"] ;
                PayFinishViewController* vc = [[PayFinishViewController alloc]init];
                vc.orderTitle=order;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                if ([responseObject valueForKey:@"info"]!=nil) {
                    [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
                }else{
                    [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            DLog(@"请求发生的错误是:%@",error);
            DLog(@"返回的数据:%@",operation.responseString);
            [SVProgressHUD dismissWithError:@"网络错误"];
        }];
        [op start];
        
    }
}

-(void)postShouHouData
{
    [SVProgressHUD show];
    
    NSString * order = [[self.dataArray objectAtIndex:saleClickIndepath] objectForKey:@"order_title"];
    NSString*body=[NSString stringWithFormat:@"&type=7&order_title=%@",  order];
    
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
            
            [SVProgressHUD showSuccessWithStatus:@"申请售后成功"];
            [self.navigationController popViewControllerAnimated:YES];            
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}
//取消订单
-(void)postRemoveData
{
    [SVProgressHUD show];
    
    NSString * order = [[self.dataArray objectAtIndex:cancleClickIndepath] objectForKey:@"order_title"];
    NSString*body=[NSString stringWithFormat:@"&type=4&order_title=%@",  order];
    
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
            
            [SVProgressHUD showSuccessWithStatus:@"取消订单成功"];
//            [_mainTableView reloadData];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}

//代付款的取消订单
-(void)postCancelData
{
    [SVProgressHUD show];
    
    NSString * order = [[self.dataArray objectAtIndex:cancleOrderIndepath] objectForKey:@"order_title"];
    NSString*body=[NSString stringWithFormat:@"&type=4&order_title=%@",  order];
    
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
            
            [SVProgressHUD showSuccessWithStatus:@"取消订单成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}


@end
