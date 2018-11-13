//
//  EditAddressListViewController.m
//  Price
//
//  Created by 俊严 on 17/3/2.
//  Copyright © 2017年 俊严. All rights reserved.
//

#import "EditAddressListViewController.h"
#import "EditAddressTableViewCell.h"
#import "UIColor+FlatUI.h"
#import "AddAddressViewController.h"

#define UI_SCREEN_WIDTH                 ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)
@interface EditAddressListViewController ()<UITableViewDataSource,UITableViewDelegate, EditAddressTableViewCellDelegte,UIAlertViewDelegate>

@property (nonatomic, strong)UITableView * addressTabelView;
@property (nonatomic,strong)NSMutableArray* myAdrList;
@property (nonatomic,assign)NSInteger selectIndex;

@end

@implementation EditAddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.title = @"编辑收货地址";
    [self.view addSubview:self.addressTabelView];
    self.myAdrList = [[NSMutableArray alloc]initWithCapacity:0];
}
#pragma mark - 获取数据
- (void)viewWillAppear:(BOOL)animated {
    [self postAdrList];
}
-(void)postAdrList
{
    [SVProgressHUD show];
    NSMutableString *body = [NSMutableString new];
    body.string = [NSString stringWithFormat:@"act=get"];
    
    NSString *str=MOBILE_SERVER_URL(@"mycontact.php");
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
            [_addressTabelView reloadData];
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
#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.myAdrList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == self.myAdrList.count-1) {
        return 0.1;
    }
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*cellIndentier = @"cell";
    EditAddressTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellIndentier];
    if (!cell) {
        cell = [[EditAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentier];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.delegate = self;
    cell.tag = indexPath.section;
    NSDictionary *dic = self.myAdrList[indexPath.section];
    [cell updateWithData:dic];
    
    return cell;
}
#pragma mark - cell delegate
- (void)editeAddressBtn:(NSInteger)index
{
    AddAddressViewController *address = [[AddAddressViewController alloc]init];;
    [self.navigationController pushViewController:address animated:YES];
    address.wp = 2;
    address.adrId = [[NSString stringWithFormat:@"%@",[self.myAdrList[index] objectForKey:@"contact_id"]] intValue];
    address.dataDic = self.myAdrList[index];
    if ([self.myAdrList[index][@"is_default"] integerValue] == 1) {
        address.isCurrent = 1;
    }else {
        address.isCurrent = 0;
    }
}
- (void)deleteAddressBtn:(NSInteger)index
{
    self.selectIndex = index;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"是否删除地址?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
- (void)defaultAddressBtn:(NSInteger)index
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"act=set_default&id=%@", [NSString stringWithFormat:@"%@",[self.myAdrList[index] objectForKey:@"contact_id"]]];
    NSString *str=MOBILE_SERVER_URL(@"mycontact.php");
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
            
            NSMutableArray *array = [NSMutableArray arrayWithArray:self.myAdrList];
            for (int i=0; i<array.count; i++) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:array[i]];
                [dic setObject:@"0" forKey:@"is_default"];
                array[i] = dic;
            }
            NSMutableDictionary *dics = [NSMutableDictionary dictionaryWithDictionary:array[index]];
            [dics setObject:@"1" forKey:@"is_default"];
            array[index] = dics;
            self.myAdrList = array;
            [_addressTabelView reloadData];
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
#pragma mark - alert delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        //NSLog(@"calel%ld", index);
        [SVProgressHUD show];
        NSString*body=[NSString stringWithFormat:@"act=del&contact_id=%@", [NSString stringWithFormat:@"%@",[self.myAdrList[self.selectIndex] objectForKey:@"contact_id"]]];
        NSString *str=MOBILE_SERVER_URL(@"mycontact.php");
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
                //移除特定元素之后刷新
                NSMutableArray *array = [NSMutableArray arrayWithArray:self.myAdrList];
                [array removeObjectAtIndex:self.selectIndex];
                self.myAdrList = array;
                [_addressTabelView reloadData];
                if (self.myAdrList.count == 0) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
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
}
#pragma mark - getter
- (UITableView *)addressTabelView
{
    if (_addressTabelView==nil) {
        self.addressTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64)];
        _addressTabelView.delegate = self;
        _addressTabelView.dataSource = self;
        _addressTabelView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _addressTabelView.rowHeight = 115.5;
        _addressTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _addressTabelView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
