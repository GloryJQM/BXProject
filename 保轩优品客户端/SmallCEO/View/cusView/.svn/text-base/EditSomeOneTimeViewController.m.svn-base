//
//  EditSomeOneTimeViewController.m
//  gongfubao
//
//  Created by chensanli on 15/6/17.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "EditSomeOneTimeViewController.h"

@interface EditSomeOneTimeViewController ()
@property (nonatomic,strong)UIImageView* headImg;
@property (nonatomic,strong)UILabel* nameLab;
@property (nonatomic,strong)UILabel* timeLab;
@property (nonatomic,strong)UIButton* caddBtn;
@property (nonatomic,strong)UIButton* ccouBtn;
@end

@implementation EditSomeOneTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改工时";
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,44,28)];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    rightButton.layer.cornerRadius = 3.0;
    rightButton.titleLabel.font = GFB_FONT_CT 14];
    [rightButton setBackgroundColor:BLUE_COLOR];
    [rightButton addTarget:self action:@selector(overPostUp) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    self.view.backgroundColor = WHITE_COLOR;
    [self createView];
}

-(void)createView
{
    UIView* body = [[UIView alloc]initWithFrame:CGRectMake(15, 15, (UI_SCREEN_WIDTH-60)/2, 130)];
    // body.backgroundColor = [UIColor redColor];
    
    self.headImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 12, 41, 41)];
    self.headImg.image = [UIImage imageNamed:@"gj_de_head.png"];
    self.headImg.layer.cornerRadius = 20.5;
    self.headImg.layer.masksToBounds = YES;
    NSURL* url = [NSURL URLWithString:[self.dic objectForKey:@"customer_avatar"]];
    [self.headImg af_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"gj_de_head.png"]];
    
    self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(50, 14, 40, 20)];
    self.nameLab.text = [NSString stringWithFormat:@"%@",[self.dic objectForKey:@"customer_name"]];
    self.nameLab.textColor = LAB_COLOR;
    self.nameLab.font = GFB_FONT_XT 12];
    
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(50, 34, 40, 20)];
    self.timeLab.text = [NSString stringWithFormat:@"%.1f",self.time];
    self.timeLab.textColor = LAB_COLOR;
    self.timeLab.font = GFB_FONT_XT 15];
    
    UIButton* addBtn = [[UIButton alloc]initWithFrame:CGRectMake(95, 9, 32, 21.5)];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"gj_addtime.png"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addtime) forControlEvents:UIControlEventTouchUpInside];
    self.caddBtn = addBtn;
    
    UIButton* couBtn = [[UIButton alloc]initWithFrame:CGRectMake(95, 30.5, 32, 20.5)];
    [couBtn setBackgroundImage:[UIImage imageNamed:@"gj_coutime.png"] forState:UIControlStateNormal];
    [couBtn addTarget:self action:@selector(coutime) forControlEvents:UIControlEventTouchUpInside];
    self.ccouBtn = couBtn;
    
    [body addSubview:self.headImg];
    [body addSubview:self.nameLab];
    [body addSubview:self.timeLab];
    [body addSubview:addBtn];
    [body addSubview:couBtn];
    
    [self.view addSubview:body];
}

-(void)addtime
{
    self.time = self.time+0.1;
    self.timeLab.text = [NSString stringWithFormat:@"%.1f",self.time];
}

-(void)coutime
{
    if(self.time>0)
    {
        self.time = self.time-0.1;
        self.timeLab.text = [NSString stringWithFormat:@"%.1f",self.time];
    }
}

-(void)overPostUp
{
    [self postUp];
}

-(void)postUp
{
    [SVProgressHUD show];
    NSString* stryear = [self.date substringToIndex:4];
    NSString* strmonth = [self.date substringWithRange:NSMakeRange(4, 2)];
    NSString* strday = [self.date substringWithRange:NSMakeRange(6, 2)];
    
    NSString* date2 = [NSString stringWithFormat:@"%@-%@-%@",stryear,strmonth,strday];
    NSString*body=[NSString stringWithFormat:@"&project_id=%@&member_id=%@&customer_id=%@&type=2&time=%@&gongshi_num=%f&price=%@",self.obId,[self.dic objectForKey:@"member_id"],[self.dic objectForKey:@"customer_id"],date2,[self.timeLab.text floatValue],[self.dic objectForKey:@"price"]];
    NSString *str=MOBILE_SERVER_URL(@"gongshiedit.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    DLog(@"%@",body);
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone   ];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            DLog(@"成功~~");
            [SVProgressHUD dismissWithSuccess:@"保存成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
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
