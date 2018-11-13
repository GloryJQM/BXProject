//
//  CouponViewController.m
//  SmallCEO
//
//  Created by 俊严 on 15/10/20.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "CouponViewController.h"
#import "CouponTableViewCell.h"
@interface CouponViewController ()<UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate>
{
    UITextField * addTF;
}
@property (nonatomic, strong)UIButton * useBtn;
@property (nonatomic,assign)long curChose;
@property (nonatomic, strong)UITableView * couponView;
@property (nonatomic, assign)int curPage;

@property (nonatomic, assign)int status;
@end

@implementation CouponViewController

-(void)dealloc
{
    [self.headerView free];
    [self.footerView free];
}
- (void)misskeyboard {
    [addTF endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.curPage = 1;
    
    self.view.backgroundColor = [UIColor colorFromHexCode:@"f5f5f5"];

    [self.view addSubview:self.couponView];
    
    
    self.headerView = [[MJRefreshHeaderView alloc] init];
    self.headerView.scrollView = _couponView;
    self.headerView.delegate = self;
    
    self.footerView = [[MJRefreshFooterView alloc] init];
    self.footerView.scrollView = _couponView;
    self.footerView.delegate = self;
    
    
    UIView * textFieldView = [[UIView alloc] initWithFrame:CGRectMake(21, 13, UI_SCREEN_WIDTH-42, 43)];
    textFieldView.layer.borderColor = App_Main_Color.CGColor;
    textFieldView.layer.borderWidth = 1;
    textFieldView.backgroundColor = [UIColor whiteColor];
    textFieldView.layer.cornerRadius = 5;
    textFieldView.clipsToBounds = YES;
    [self.view addSubview:textFieldView];
    
    addTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, (UI_SCREEN_WIDTH-42)/5 * 4, 43)];
    UIColor *color = App_Main_Color;
    addTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"           点击输入优惠码" attributes:@{NSForegroundColorAttributeName: color}];
    addTF.hideStatus = @"1";
    [textFieldView addSubview:addTF];
    UIButton *btnT=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 33)];
    btnT.backgroundColor=[UIColor colorFromHexCode:@"d9d9d9" alpha:1];
    [btnT setTitle:@"轻触此处可隐藏键盘" forState:UIControlStateNormal];
    btnT.titleLabel.font=[UIFont systemFontOfSize:14];
    [btnT addTarget:self action:@selector(misskeyboard) forControlEvents:UIControlEventTouchUpInside];
    [btnT setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    if(addTF.inputAccessoryView==nil){
        addTF.inputAccessoryView=btnT;
    }
    
    UIButton * addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake((UI_SCREEN_WIDTH-42)/5 * 4, 0, (UI_SCREEN_WIDTH-42)/5, 43);
    [addButton setTitle:@"添加" forState: UIControlStateNormal];
    [addButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    addButton.backgroundColor = App_Main_Color;
    [addButton addTarget:self action:@selector(addCoupon) forControlEvents:UIControlEventTouchUpInside];
    [textFieldView addSubview:addButton];
    
    if (self.flag == 2) {
        self.title = @"可用优惠券";
        UIButton* sureButton = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.couponView.frame), UI_SCREEN_WIDTH, 47)];
        sureButton.backgroundColor = App_Main_Color;
        [sureButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [sureButton addTarget:self action:@selector(selectCoupon) forControlEvents:UIControlEventTouchUpInside];
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.view addSubview:sureButton];
    }else
    {
        self.couponDataArray = [NSMutableArray arrayWithCapacity:0];
        [self postPurchaseData];
        self.title = @"使用优惠券";
    }
    

}
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView == self.headerView) {
        self.curPage = 1;
        
        [self postPurchaseData];
    }else{
        self.curPage++;
        
        [self postPurchaseData];
    }
}
- (UITableView *)couponView
{
    if (_couponView == nil) {
        CGFloat height = self.flag == 2 ? UI_SCREEN_HEIGHT-56-64-47 : UI_SCREEN_HEIGHT-56-64;
        self.couponView = [[UITableView alloc] initWithFrame:CGRectMake(0, 56, UI_SCREEN_WIDTH, height)];
        _couponView.delegate = self;
        _couponView.dataSource = self;
        _couponView.backgroundColor =  [UIColor colorFromHexCode:@"f5f5f5"];
        _couponView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _couponView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.couponDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.flag == 2)
    {
        static NSString * cellIndentifier1 = @"coupon1";
        CouponTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier1];
        if (cell == nil) {
            cell = [[CouponTableViewCell alloc] initWithSelecteButtonAndReuseIdentifier:cellIndentifier1];
        }
        
        cell.selectButton.selected = indexPath.row == self.selectedCouponIndex;
        cell.tag = indexPath.row;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell updateCellData:self.couponDataArray[indexPath.row]];
        return cell;
    }
    else
    {
        static NSString * cellIndentifier = @"coupon";
        CouponTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[CouponTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell updateCellData:self.couponDataArray[indexPath.row]];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 11+127/2;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.flag != 2;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.couponDataArray removeObjectAtIndex:indexPath.row];
//        // Delete the row from the data source.
//        [_couponView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self deleteCoupon:indexPath.row];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isFromWallet) {
        return;
    }
    if (self.flag == 2)
    {
        CouponTableViewCell *cell = (CouponTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        self.selectedCouponIndex = indexPath.row;
        cell.selectButton.selected = !cell.selectButton.selected;
        for (CouponTableViewCell *subCell in tableView.visibleCells)
        {
            if (subCell != cell)
            {
                subCell.selectButton.selected = NO;
            }
        }
        return;
    }
    
    
    self.cell =  (CouponTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    self.cell.tag=indexPath.row;
    
    if(self.curChose == indexPath.row)
    {
        self.curChose = -1;
        self.cell=nil;
        self.quanID=@"0";
        
    }else
    {
        self.curChose = indexPath.row;
        self.quanID=[NSString stringWithFormat:@"%@",[[self.couponArray objectAtIndex:indexPath.row] valueForKey:@"id"]];
        self.useBtn.userInteractionEnabled = YES;
        _inde = _cell.CouponID;
        _money = _cell.totalMoney;
    }
    [self.tab reloadData];
    
    if ([self.delegate respondsToSelector:@selector(changeView:quanID:)]) {
        [self.delegate changeView:self.cell quanID:self.quanID];
    }
    
    
    if ([self.delegate respondsToSelector:@selector(shuzi:withMoney:)]) {
        
        [self.delegate shuzi:self.inde withMoney:self.money];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)deleteCoupon:(NSInteger)index
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"&type=3&quan_id=%@", [[[self.couponDataArray objectAtIndex:index] objectForKey:@"id"] URLEncodedString]];
    NSString *str=MOBILE_SERVER_URL(@"youhuiquan_lemuji.php");
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
            NSMutableArray *array = [NSMutableArray arrayWithArray:self.couponDataArray];
            [array removeObjectAtIndex:index];
            self.couponDataArray = array;
            [SVProgressHUD dismissWithSuccess:[responseObject objectForKey:@"info"]];
            [self.couponView reloadData];
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

- (void)addCoupon
{
    [self postAddCoupon];
}

-(void)postPurchaseData
{
    [SVProgressHUD show];
    NSString*body;
    if (self.flag == 2) {
        body=[NSString stringWithFormat:@"type=5&goods_price=%0.2f&goods_id=%@&p=%d",self.price,self.aids, self.curPage];
    }else {
        body=[NSString stringWithFormat:@"type=1&p=%d", self.curPage];

    }
    NSString *str=MOBILE_SERVER_URL(@"youhuiquan_list.php");
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
            
            
            NSArray *tempArray = [responseObject objectForKey:@"quan"];
            
            
            if([tempArray isKindOfClass:[NSArray class]])
            {
                if(self.curPage == 1)
                {
                    [self.couponDataArray removeAllObjects];
                }
                [self.couponDataArray addObjectsFromArray:tempArray];
                
            }
            [_couponView reloadData];
            
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络成功"] ;
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
-(void)postAddCoupon
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"type=4&youhuicode=%@", [addTF.text URLEncodedString]];
    NSString *str=MOBILE_SERVER_URL(@"youhuiquan_list.php");
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
            self.status = 1;
            [SVProgressHUD dismissWithSuccess:@"你成功获得一张优惠券"];
            [addTF resignFirstResponder];
            addTF.text = @"";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self postPurchaseData];
            });
        }else{
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络成功"] ;
            }
        }
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
    
}

#pragma mark - 确定点击方法
- (void)selectCoupon
{
    if ([self.delegate respondsToSelector:@selector(chooseCouponAtIndex:)])
    {
        NSInteger selectedIndex = -1;
        for (CouponTableViewCell *subCell in self.couponView.visibleCells)
        {
            if (subCell.selectButton.selected)
            {
                selectedIndex = subCell.tag;
                break;
            }
        }
        
        [self.delegate chooseCouponAtIndex:selectedIndex];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

@end
