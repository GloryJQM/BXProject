//
//  OtherDetailController.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/5/31.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "OtherDetailController.h"
#import "BannerScrollView.h" //自动轮播图
#import "JJPhotoManeger.h" //点击放大
#import "ContentView.h"
#import "MerchantView.h"
#import "LabelImageView.h"
#import "LoginViewController.h"
#import "MapForShopViewController.h" 
#import "BxPayViewController.h"
@interface OtherDetailController ()<BannerScrollNetDelegate, JJPhotoDelegate>{
    NSMutableArray *_bannerImageArray;
}
@property (nonatomic, strong) UIScrollView *mainScrollView;
@end

@implementation OtherDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _bannerImageArray = [NSMutableArray array];
    [self setUpView];
}

- (void)setUpView {
    self.mainScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-40)];
    _mainScrollView.backgroundColor= WHITE_COLOR2;
    _mainScrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_mainScrollView];
    
    BannerScrollView *localScrollView = [[BannerScrollView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 234 / 375.0 * UI_SCREEN_WIDTH) WithNetImages:[[self dataDic]objectForKey:@"img_arr"]];
    localScrollView.AutoScrollDelay = 2;
    localScrollView.netDelagate = self;
    [_mainScrollView addSubview:localScrollView];
    
    ContentView *contentView = [[ContentView alloc] initWithy:localScrollView.maxY dataDic:self.dataDic dicDic:self.dicDic block:^{
        MapForShopViewController *map = [[MapForShopViewController alloc]init];
        map.dataDic = self.dataDic;
        [self.navigationController pushViewController:map animated:YES];
    }];
    [_mainScrollView addSubview:contentView];
    
    MerchantView *merchantView = [[MerchantView alloc] initWithy:contentView.maxY + 20 dataDic:self.dataDic];
    [_mainScrollView addSubview:merchantView];
    
    LabelImageView *labelImageView = [[LabelImageView alloc] initWithY:merchantView.maxY + 20 dataDic:self.dataDic block:^(NSInteger index, NSArray *array) {
        [self checkImageView:index array:array];
    }];
    [_mainScrollView addSubview:labelImageView];
    
    _mainScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, labelImageView.maxY);
    
    UIButton *payBillButton = [[UIButton alloc]initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT - 40, UI_SCREEN_WIDTH, 40)];
    [payBillButton setTitle:@"买  单" forState:UIControlStateNormal];
    payBillButton.backgroundColor = App_Main_Color;
    [payBillButton addTarget:self action:@selector(payBillButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payBillButton];
}

#pragma mark BannerScrollNetDelegate 点击轮播图
-(void)didSelectedNetImageAtIndex:(NSInteger)index {
    [self checkImageView:index array:nil];
}

- (void)checkImageView:(NSInteger)index array:(NSArray *)ary{
    [_bannerImageArray removeAllObjects];
    NSArray *array;
    if (ary.count > 0) {
        array = ary;
    }else {
        array = [[self dataDic]objectForKey:@"img_arr"];
    }
    
    for (int i = 0; i < array.count; i++) {
        UIImageView *imageview = [[UIImageView alloc] init];
        [imageview sd_setImageWithURL:[NSURL URLWithString:array[i]] placeholderImage:nil];
        [_bannerImageArray addObject:imageview];
    }
    JJPhotoManeger *mg = [JJPhotoManeger maneger];
    mg.delegate = self;
    mg.viewController = self.navigationController;
    [mg showLocalPhotoViewer:_bannerImageArray selecView:_bannerImageArray[index]];
}

- (void)payBillButton:(UIButton *)sender {
    if ([[PreferenceManager sharedManager] preferenceForKey:@"didLogin"] == nil || [[PreferenceManager sharedManager] preferenceForKey:@"token"] == nil ) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            AppDelegate *del=(AppDelegate *)[[UIApplication sharedApplication] delegate];
            [LoginViewController performIfLogin:del.curViewController withShowTab:NO loginAlreadyBlock:^{
                
            } loginSuccessBlock:^(BOOL login){
                if (login) {
                    
                }
            }];
        });
        return;
    }
    
    [SVProgressHUD show];
    [RequestManager startRequestWithUrl:[self.dataDic objectForKey:@"buy_href"]
                                   body:@""
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               if ([[responseObject objectForKey:@"is_success"] integerValue] == 1) {
                                   BXPayViewController *pay = [[BXPayViewController alloc]init];
                                   pay.dataDic = responseObject;
                                   [self.navigationController pushViewController:pay animated:YES];
                               }else {
                                   if ([responseObject valueForKey:@"info"]!=nil) {
                                       [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"info"]] ;
                                   }else{
                                       [SVProgressHUD showErrorWithStatus:@"网络错误"] ;
                                   }
                               }
                               [SVProgressHUD dismiss];
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
