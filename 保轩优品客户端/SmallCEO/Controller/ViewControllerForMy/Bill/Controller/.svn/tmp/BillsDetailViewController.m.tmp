//
//  BillDetailViewController.m
//  Jiang
//
//  Created by peterwang on 17/2/28.
//  Copyright © 2017年 quanmai. All rights reserved.
//

#import "BillsDetailViewController.h"
@interface BillsDetailViewController ()
@property (nonatomic, strong) NSDictionary *dic;
@end

@implementation BillsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //取反
    _type = !_type;
    
    if (_type) {
        self.title = @"收入详情";
    }else {
        self.title = @"支出详情";
    }
    
//    [self setupMainView];
    [self requestData];
}
- (void)requestData {
    [SVProgressHUD show];
    NSString *str;
    NSString *bodyStr;
    str = MOBILE_SERVER_URL(@"billDetailApi.php");
    if (_act) {
        if ([_act isEqualToString:@"金币"]) {
            bodyStr = [NSString stringWithFormat:@"id=%@&act=1",self.orderId];
        }else if ([_act isEqualToString:@"积分"]){
            bodyStr = [NSString stringWithFormat:@"id=%@&act=2",self.orderId];
        }else if ([_act isEqualToString:@"现金"]){
            str =  MOBILE_SERVER_URL(@"moneyApiNew.php");
            bodyStr = [NSString stringWithFormat:@"id=%@&act=2&type=%@",self.orderId, self.moneyType];
        }else if ([_act isEqualToString:@"代金券"]) {
            bodyStr = [NSString stringWithFormat:@"id=%@&act=4",self.orderId];
        }
    }else {
        
        bodyStr = [NSString stringWithFormat:@"id=%@&act=3",self.orderId];
    }
    
    [RequestManager startRequestWithUrl:str
                                   body:bodyStr
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               if ([[responseObject objectForKey:@"is_success"] integerValue] == 1) {
                                   _dic = responseObject[@"detail"];
                                   [self setupMainView];
                               }else {
                                   [SVProgressHUD showErrorWithStatus:responseObject[@"info"]];
                               }
                               
                               [SVProgressHUD dismiss];
                               
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               [SVProgressHUD dismissWithError:@"网络错误"];
                               
                           }];
}
- (void)setupMainView
{
    NSArray *arr;
    
    self.view.backgroundColor = [UIColor colorFromHexCode:@"#F5F5F5"];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 250)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 210, UI_SCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor colorFromHexCode:@"#F5F5F5"];
    [backView addSubview:line];
    
    if ([_dic isKindOfClass:[NSDictionary class]]) {
        arr = _dic[@"list"];
    }else {
        return;
    }
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", [_dic objectForKey:@"target_name"]]];
    
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    if (_type) {
        attch.image = [UIImage imageNamed:@"pho-shouru@2x"];
    }else {
        attch.image = [UIImage imageNamed:@"pho-zhichu@2x"];
    }
    
    // 设置图片大小
    attch.bounds = CGRectMake(0, -10, 32, 32);
    
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri insertAttributedString:string atIndex:0];
    //[attri appendAttributedString:string];
    
    // 用label的attributedText属性来使用富文本
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 50)];
    title.text = [NSString stringWithFormat:@"%@", [_dic objectForKey:@"target_name"]];
    title.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:title];
    
    
    UILabel *money = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, UI_SCREEN_WIDTH, 35)];
    if (_type) {
        money.text = self.money;
    }else {
    money.text = self.money;
    }
    
    money.font = [UIFont systemFontOfSize:35];
    money.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:money];
    
    UILabel *state = [[UILabel alloc]initWithFrame:CGRectMake(0, 120, UI_SCREEN_WIDTH, 20)];
    state.text = @"交易成功";
    state.textColor = [UIColor lightGrayColor];
    state.font = [UIFont systemFontOfSize:15];
    state.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:state];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(12, 160, UI_SCREEN_WIDTH/2, 20)];
    name.text = arr[0][@"key"];
    name.textColor = [UIColor lightGrayColor];
    name.font = [UIFont systemFontOfSize:15];
    [backView addSubview:name];
    
    UILabel *type = [[UILabel alloc]initWithFrame:CGRectMake(12, 180, UI_SCREEN_WIDTH/2, 20)];
    type.text = arr[2][@"key"];
    type.textColor = [UIColor lightGrayColor];
    type.font = [UIFont systemFontOfSize:15];
    [backView addSubview:type];
    
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(12, 220, UI_SCREEN_WIDTH/2, 20)];
    time.text = @"创建时间";
    time.textColor = [UIColor lightGrayColor];
    time.font = [UIFont systemFontOfSize:15];
    [backView addSubview:time];
    
    UILabel *named = [[UILabel alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2, 160, UI_SCREEN_WIDTH/2-12, 20)];
    named.text = arr[0][@"name"];
    named.textAlignment = NSTextAlignmentRight;
    named.textColor = [UIColor lightGrayColor];
    named.font = [UIFont systemFontOfSize:15];
    [backView addSubview:named];
    
    UILabel *typed = [[UILabel alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/2, 180, UI_SCREEN_WIDTH/2-12, 20)];
    typed.text = arr[2][@"name"];
    typed.textAlignment = NSTextAlignmentRight;
    typed.textColor = [UIColor lightGrayColor];
    typed.font = [UIFont systemFontOfSize:15];
    [backView addSubview:typed];
    
    UILabel *timed = [[UILabel alloc]initWithFrame:CGRectMake(time.maxX, 220, UI_SCREEN_WIDTH - time.maxX - 12, 20)];
    timed.text = _dic[@"log_time"];
    timed.textAlignment = NSTextAlignmentRight;
    timed.textColor = [UIColor lightGrayColor];
    timed.font = [UIFont systemFontOfSize:15];
    [backView addSubview:timed];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
