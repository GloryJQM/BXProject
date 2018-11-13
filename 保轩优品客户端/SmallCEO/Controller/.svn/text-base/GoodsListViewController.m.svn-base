//
//  GoodsListViewController.m
//  Lemuji
//
//  Created by chensanli on 15/7/16.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "GoodsListViewController.h"
#import "GoodsListTableViewCell.h"
#import "CommodityDetailViewController.h"
@interface GoodsListViewController ()
@property (nonatomic,strong)UITableView* tab;
@end

@implementation GoodsListViewController
@synthesize dataSourceArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"商品清单";
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64)];
    self.tab.backgroundColor = WHITE_COLOR;
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tab.delegate = self;
    self.tab.dataSource = self;
    [self.view addSubview:self.tab];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 86;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     DLog(@"_______________%@", self.goodsListArray);
    return self.goodsListArray.count;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self popGGview:indexPath.row];
//    if ((self.guigeArr!=nil) && (self.guigeArr.count==self.goodsListArray.count)) {
//        self.selectedGoodsSpecificationArray=[[self.guigeArr objectAtIndex:indexPath.row] valueForKey:@"guige"];
//        [self popGGview:indexPath.row];
//    }
    
//    if (indexPath.row<self.cartIdArr.count) {
//        NSString *cartid=[self.cartIdArr objectAtIndex:indexPath.row];
//        NSString *aid=[NSString stringWithFormat:@"%@",[[self.goodsListArray objectAtIndex:indexPath.row] valueForKey:@"aid"]];
//        NSInteger index=indexPath.row;
//        //[self getGoodsSpecification:cartid aid:aid withIndex:index];
//    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* goodslist = @"goodsCell";
    GoodsListTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:goodslist];
    if(cell == nil)
    {
        cell = [[GoodsListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodslist];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    DLog(@"%d",self.flag);
    if (self.flag == 0) {
        [cell updateDic:self.goodsListArray[indexPath.row] is_point_type:self.is_point_type];
    }else{
        [cell updateDic1:self.goodsListArray[indexPath.row] is_point_type:self.is_point_type];
    }
    DLog(@"合计价:%.2f",[[[self.goodsListArray objectAtIndex:indexPath.row] objectForKey:@"price_sum"] doubleValue]);
    
    return cell;
}

#pragma mark - Shop cart relative method
- (void)getGoodsSpecification:(NSString *)cartid  aid:(NSString *)aid withIndex:(NSInteger)index
{
    NSString *body = [NSString stringWithFormat:@"type=4&cart_id=%@&aid=%@", cartid,aid];
    NSString *str = MOBILE_SERVER_URL(@"addcart.php");
    [self httpPostWithBody:body andUrlString:str andCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.selectedGoodsSpecificationArray = [NSMutableArray arrayWithArray:[responseObject objectForKey:@"guige"]];
        for (int i = 0; i < self.selectedGoodsSpecificationArray.count; i++)
        {
            NSArray *array = [[self.selectedGoodsSpecificationArray objectAtIndex:i] objectForKey:@"data"];
            for (int j = 0; j < array.count; j++)
            {
                NSNumber *selectedStatus = [[array objectAtIndex:j] objectForKey:@"select"];
                if ([selectedStatus longValue] == 1)
                    [self.goodsSelectedSpecificationIndexArray addObject:[NSString stringWithFormat:@"%d", j]];
            }
        }
        [self popGGview:index];
        [SVProgressHUD dismiss];
    }];
}


#pragma mark - HTTP request method
- (void)httpPostWithBody:(NSString *)body andUrlString:(NSString *)urlStr andCompletionBlockWithSuccess:(successBlock)block
{
    [SVProgressHUD show];
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op.securityPolicy setAllowInvalidCertificates:YES];
    [op.securityPolicy setSSLPinningMode:AFSSLPinningModeNone];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    DLog(@"body is%@",body);
    [op setCompletionBlockWithSuccess:block failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求发生的错误是:%@",error);
        DLog(@"返回的数据:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络错误"];
    }];
    [op start];
}



/*商品详情接口*/
-(void)productshopdetailWithAid:(NSString *)aid
{
    [SVProgressHUD show];
    NSString*body=[NSString stringWithFormat:@"aid=%@",aid];
    NSString *str=MOBILE_SERVER_URL(@"productshopdetail_lemuji.php");
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


#pragma mark -
-(void)popGGview:(NSInteger)index
{
    [self goToCommodityDetail:index];
//    if(self.myGGView == nil)
//    {
//        self.myGGView = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
//        self.myGGView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
//        self.myGGView.tag = 1888;
//        self.myGGView.windowLevel = 1999;
//        //[self.view addSubview:self.myGGView];
//        [self.myGGView makeKeyAndVisible];
//        
//    }else
//    {
//        self.myGGView.hidden = NO;
//    }
//    
//    for (UIView *view in self.myGGView.subviews) {
//        [view removeFromSuperview];
//    }
//    
//    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 40)];
//    
//    [maskView addTarget:self action:@selector(closeGGView) forControlEvents:UIControlEventTouchUpInside];
//
//    [self.myGGView addSubview:maskView];
//    
//    self.bodyView = [[UIView alloc]initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-maskView.frame.size.height - 14)];
//    self.bodyView.backgroundColor = [UIColor clearColor];
//    [self.myGGView addSubview:self.bodyView];
//    
//    ShopCartCell* cell = [[ShopCartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//    cell.backgroundColor = WHITE_COLOR;
//    cell.numSelect.hidden = YES;
//    cell.imageArrowView.hidden=YES;
//    cell.finishBtn.hidden = YES;
//    cell.numChangeV.hidden = YES;
//    cell.thLab.hidden = YES;
//    [cell.exitBtn addTarget:self action:@selector(closeGGView) forControlEvents:UIControlEventTouchUpInside];
//    [cell setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH,106)];
//    cell.picImg.frame = CGRectMake(15, cell.picImg.frame.origin.y, cell.picImg.frame.size.width, cell.picImg.frame.size.height);
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"点击查看商品详情" attributes:nil];
//    [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, 8)];
//    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, 8)];
//    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"787878"] range:NSMakeRange(0, 8)];
//    UILabel *goToCommodityDetail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cell.picImg.frame) + 15, CGRectGetMaxY(cell.picImg.frame) - 20, 150, 20)];
//    goToCommodityDetail.tag = index;
//    goToCommodityDetail.textAlignment = NSTextAlignmentCenter;
//    goToCommodityDetail.attributedText = attributedString;
//    [goToCommodityDetail addTarget:self action:@selector(goToCommodityDetail:) forControlEvents:UIControlEventTouchUpInside];
//    [cell addSubview:goToCommodityDetail];
//    
//    cell.choseComBtn.hidden = YES;
//    
//    if(self.guigeArr.count>0){
//        [cell updateWithDicFromGoodList:[self.goodsListArray objectAtIndex:index] isEdit:YES];
//    }else{
//        [cell updateWithDicFromGoodList:[self.goodsListArray objectAtIndex:index] isEdit:NO];
//    }
//    
//    self.shopCell=cell;
//    
//    
//    UIView* ggbottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bodyView.frame.size.height-80, UI_SCREEN_WIDTH, 0)];
//    ggbottomView.backgroundColor = [UIColor whiteColor];
//    ggbottomView.hidden = YES;
    
//    self.sumMoneyLabelInGGView = [[UILabel alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH-200-15, ggbottomView.frame.size.height-20, 200, 20)];
//    self.sumMoneyLabelInGGView.textAlignment = NSTextAlignmentRight;
//    self.sumMoneyLabelInGGView.backgroundColor = [UIColor whiteColor];
//    self.sumMoneyLabelInGGView.textColor = App_Main_Color;
//    
//    
//    self.sumMoneyLabelInGGView.text = [NSString stringWithFormat:@"合计:%.2f", [[[self.goodsListArray objectAtIndex:index] objectForKey:@"price_sum"] doubleValue]];
//    [ggbottomView addSubview:self.sumMoneyLabelInGGView];
    
//    UIButton* sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, ggbottomView.frame.size.height-10-47, UI_SCREEN_WIDTH-30, 47)];
//    sureBtn.backgroundColor = App_Main_Color;
//    [sureBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
//    [sureBtn addTarget:self action:@selector(clickSureBtn) forControlEvents:UIControlEventTouchUpInside];
//    [sureBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [ggbottomView addSubview:sureBtn];
    
    
//    GGView* ggView = [[GGView alloc]initWith:self.selectedGoodsSpecificationArray andUpView:cell andBottomView:ggbottomView andHeight:400 andFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, self.bodyView.frame.size.height) withGGViewType:GGViewTypeWithoutSelectSpecification];
//    ggView.delegate = self;
//    
//    NSString *priceKey = nil;
//    NSString *countKey = nil;
//    if (self.flag == 0) {
//        //订单进入
//        priceKey = @"single_price";
//        countKey = @"goods_number";
//    }else {
//        //购物车
//        priceKey = @"price";
//        countKey = @"count";
//    }
//    CGFloat price = [[[self.goodsListArray objectAtIndex:index] objectForKey:priceKey] doubleValue];
//    NSInteger count = [[[self.goodsListArray objectAtIndex:index] objectForKey:countKey] intValue];
//    DLog(@"进入商品清单%.2f--%ld--%d\n%@",price,count,_flag,_goodsListArray);
//    [ggView hideSomeViewForGoodsListWithSumPrice:[[NSString stringWithFormat:@"%.2f", price*count] floatValue]];
//    [ggView.closeBtn addTarget:self action:@selector(closeGGView) forControlEvents:UIControlEventTouchUpInside];
//    
//    maskView.frame=CGRectMake(maskView.frame.origin.x, maskView.frame.origin.y+ggView.guigeOffsetY, maskView.frame.size.width, maskView.frame.size.height);
//    
//    if(self.guigeArr.count>0){
//        ggView.numbersTf.text = [NSString stringWithFormat:@"%@",[[self.goodsListArray objectAtIndex:index] objectForKey:@"goods_number"]];
//    }else{
//        ggView.numbersTf.text = [NSString stringWithFormat:@"%@",[[self.goodsListArray objectAtIndex:index] objectForKey:@"count"]];
//    }
//    [self.bodyView addSubview:ggView];
//    
//    [ggView setUserCanTouch:NO];
//    ggView.userInteractionEnabled=NO;
    
    
//    Animation_Appear .3];
//    self.myGGView.hidden = NO;
//    [self.bodyView setTransform:CGAffineTransformMake(1, 0, 0, 1, 0, -self.bodyView.frame.size.height)];
//    [UIView commitAnimations];
}

-(void)closeGGView
{
    Animation_Appear .3];
    [self.bodyView setTransform:CGAffineTransformMake(1, 0, 0, 1, 0, 0)];
    [UIView commitAnimations];
    [self performSelector:@selector(closeGGSuper) withObject:nil afterDelay:0.32];
}

-(void)closeGGSuper
{
    self.myGGView.hidden = YES;
    [self.bodyView removeFromSuperview];
    UIWindow* win = [UIApplication sharedApplication].keyWindow;
    [win makeKeyAndVisible];
    
}

#pragma mark - 按钮方法
- (void)clickSureBtn
{
    [self closeGGView];
}

- (void)goToCommodityDetail:(NSInteger *)index
{
//    [self closeGGView];
    NSDictionary *dic = [self.goodsListArray objectAtIndex:index];
    NSString *aid;
    if ([[dic allKeys] containsObject:@"aid"]) {
        aid = [NSString stringWithFormat:@"%@", [dic objectForKey:@"aid"]];
    }else if ([[dic allKeys] containsObject:@"goods_id"]){
        aid = [NSString stringWithFormat:@"%@", [dic objectForKey:@"goods_id"]];
    }
    
    [self productshopdetailWithAid:aid];
}

@end
