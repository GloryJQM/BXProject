//
//  AdrListViewController.m
//  Lemuji
//
//  Created by chensanli on 15/7/15.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "AdrListViewController.h"
#import "AdrListTableViewCell.h"
#import "AddAddressViewController.h"
#import "AddressSingleton.h"

const NSString *plistName = @"address.plist";

@interface AdrListViewController ()
@property (nonatomic,strong)UITableView* tab;
@property (nonatomic,strong)NSMutableArray* myAdrList;
@property (nonatomic,assign)int IsEdit;
@property (nonatomic, strong)UIButton * morenButton;
@end

@implementation AdrListViewController
@synthesize hdBlock;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myAdrList = [NSMutableArray arrayWithCapacity:0];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = NAVI_COLOR;
    self.title = @"收货地址";
    
    if(self.wp == 1)
    {
        self.curChose = -1;
    }
    
    self.morenButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_morenButton setTitle:@"编辑" forState:UIControlStateNormal];
    _morenButton.frame = CGRectMake(UI_SCREEN_WIDTH - 50, 0, 40, 25);
    [_morenButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [_morenButton addTarget:self action:@selector(popEditView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:_morenButton];
    _morenButton.titleLabel.font = [UIFont systemFontOfSize:17];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.tab = [[UITableView alloc] init];
    self.tab.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-65-64);
    self.tab.backgroundColor = WHITE_COLOR;
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tab.delegate = self;
    self.tab.dataSource = self;
    [self.view addSubview:self.tab];
    
    self.nilView = [[UIView alloc]initWithFrame:self.tab.frame];
    UIImageView* imgVi = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2-90/2, 90, 90, 90)];
    imgVi.image = [UIImage imageNamed:@"gj_tanhao.png"];
    [self.nilView addSubview:imgVi];
    
    UILabel* lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 190, UI_SCREEN_WIDTH, 20)];
    lab.text = @"未添加收货地址";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = DETAILS_COLOR;
    lab.font = LMJ_XT 12];
    [self.nilView addSubview:lab];
    [self.tab addSubview:self.nilView];
    self.nilView.hidden = YES;
    
    
    
    
    UIButton* addAdrBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, UI_SCREEN_HEIGHT-15-47 - 64, UI_SCREEN_WIDTH-30, 47)];
    addAdrBtn.backgroundColor = App_Main_Color;
    [addAdrBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [addAdrBtn setTitle:@"新增收货地址" forState:UIControlStateNormal];
    [addAdrBtn addTarget:self action:@selector(goAddressVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addAdrBtn];
    
    UIView * barLine = [[UIView  alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 0.5)];
    barLine.backgroundColor = LINE_DEEP_COLOR;
    [self.view addSubview:barLine];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myAdrList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* adrList = @"storeListCell";
    AdrListTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:adrList];
    if(cell == nil)
    {
        cell = [[AdrListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:adrList];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    
    cell.editBtn.tag = indexPath.row;
    cell.delBtn.tag = indexPath.row;
    
    if(self.curChose == indexPath.row)
    {
        cell.choseView.hidden = NO;
    }else
    {
        cell.choseView.hidden = YES;
    }
    [cell upDataWith:self.myAdrList[indexPath.row]];
    
    [cell.editBtn addTarget:self action:@selector(goEditAdr:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.delBtn addTarget:self action:@selector(goDelAdr:) forControlEvents:UIControlEventTouchUpInside];
    
    if(self.IsEdit == 1)
    {
        [cell delSelf];
    }else
    {
        [cell backSelf];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"%ld",(long)indexPath.row);
    
    if(self.wp == 1)
    {
        
    }else
    {
        if(self.curChose == indexPath.row)
        {
            
        }else
        {
            self.curChose = indexPath.row;
            [self.tab reloadData];
        }
        
        if(hdBlock)
        {
            NSDictionary* dic = [self.myAdrList objectAtIndex:indexPath.row];
            hdBlock(dic,self.curChose);
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        AdrListTableViewCell* cell = (AdrListTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        //cell.choseView.hidden = NO;
        
        if ([_delegate respondsToSelector:@selector(changeInformationName:withPhone:withAddress:)]) {
            [_delegate changeInformationName:cell.nameLab.text withPhone:cell.phoneLab.text withAddress:cell.adrLab.text];
        }
    }
}

- (void)goAddressVC
{
    AddAddressViewController * orderVC = [[AddAddressViewController alloc] init];
    [self.navigationController pushViewController:orderVC animated:YES];
}

-(void)popEditView
{
    if(self.IsEdit == 1)
    {
        self.IsEdit = 0;
        [self.morenButton setTitle:@"编辑" forState:UIControlStateNormal];
    }else
    {
        self.IsEdit = 1;
        [self.morenButton setTitle:@"完成" forState:UIControlStateNormal];
    }
    
    
    [self.tab reloadData];
}

-(void)postAdrList
{
    [SVProgressHUD show];
    NSMutableString *body = [NSMutableString new];
    body.string = [NSString stringWithFormat:@"act=get"];
    
    NSString *str=MOBILE_SERVER_URL(@"api/mycontact.php");
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
            [self.myAdrList removeAllObjects];
            DLog(@"成功~~");
            [SVProgressHUD dismiss];
            NSArray* temp = [responseObject objectForKey:@"my_contact"];
            [self.myAdrList addObjectsFromArray:temp];
            [self.tab reloadData];
            if(self.myAdrList.count == 0)
            {
                self.nilView.hidden = NO;
            }else
            {
                self.nilView.hidden = YES;
            }
            
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

-(void)viewWillAppear:(BOOL)animated
{
    if (![self plistFileExist])
    {
        [self getAllAddressData];
    }
    else
    {
        [[AddressSingleton sharedManager] createAddressModel:[self getDataFromLocalSandbox]];
        [self postAdrList];
    }
}

-(void)goDelAdr:(UIButton*)btn
{
    DLog(@"%ld删除",btn.tag);
    NSIndexPath* indexp = [NSIndexPath indexPathForRow:btn.tag inSection:0];
    AdrListTableViewCell* cell = (AdrListTableViewCell*)[self.tab cellForRowAtIndexPath:indexp];
    
    if (_curChose == btn.tag) {
        _curChose = -1;
    }
    if (_curChose > btn.tag) {
        _curChose --;
    }
    
    [cell backSelf];
    
    [self postDelAdr:btn.tag];
}

-(void)goEditAdr:(UIButton*)btn
{
    DLog(@"111");
    AddAddressViewController* vc = [[AddAddressViewController alloc]init];
    NSIndexPath* indexp = [NSIndexPath indexPathForRow:btn.tag inSection:0];
    AdrListTableViewCell* cell = (AdrListTableViewCell*)[self.tab cellForRowAtIndexPath:indexp];
    [cell backSelf];
    vc.wp = 2;
    vc.adrId = [[NSString stringWithFormat:@"%@",[self.myAdrList[btn.tag] objectForKey:@"contact_id"]] intValue];
    vc.dataDic = self.myAdrList[btn.tag];
    if (_curChose == btn.tag) {
        vc.isCurrent = YES;
    }
    if (_curChose == 0) {
        vc.currentIndex = (int)btn.tag;
    }
    vc.myBlock = ^(int current)
    {
        DLog(@"block 回调");
        _curChose = current;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Plist relative method
- (BOOL)plistFileExist
{
    NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", plistName]];
    return [[NSFileManager defaultManager] fileExistsAtPath:filename];
}

- (void)writeDataToLocalSandbox:(NSArray *)dataArray
{
    NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", plistName]];
    [dataArray writeToFile:filename atomically:YES];
}

- (NSArray *)getDataFromLocalSandbox
{
    NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", plistName]];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:filename];
    return data;
}

#pragma mark - HTTP Request
- (void)getAllAddressData
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"&type=4"];
    NSString *str=MOBILE_SERVER_URL(@"api/getcitylist.php");
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
            [self writeDataToLocalSandbox:[responseObject objectForKey:@"content"]];
            [[AddressSingleton sharedManager] createAddressModel:[responseObject objectForKey:@"content"]];
            [self postAdrList];
            [SVProgressHUD dismiss];
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

- (void)getSupportAddressData
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"&type=5"];
    NSString *str=MOBILE_SERVER_URL(@"api/getcitylist.php");
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
            [[AddressSingleton sharedManager] createAddressModel:[responseObject objectForKey:@"content"]];
            [self postAdrList];
            [SVProgressHUD dismiss];
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


-(void)postDelAdr:(NSInteger)index
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"&act=del&contact_id=%@", [NSString stringWithFormat:@"%@",[self.myAdrList[index] objectForKey:@"contact_id"]]];
    NSString *str=MOBILE_SERVER_URL(@"api/mycontact.php");
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
            [self postAdrList];
            
            if ([self.delegate respondsToSelector:@selector(adrListViewController:didDeleteAtIndex:)])
            {
                [self.delegate adrListViewController:self didDeleteAtIndex:index];
            }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
