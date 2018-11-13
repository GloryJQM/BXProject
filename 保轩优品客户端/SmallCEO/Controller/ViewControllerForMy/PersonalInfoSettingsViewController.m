//
//  PersonalInfoSettingsViewController.m
//  SmallCEO
//
//  Created by huang on 15/8/24.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "AdrListViewController.h"
#import "AlipayAccountInfoViewController.h"
#import "BankCardManageViewController.h"
#import "BindAlipayAccountViewController.h"
#import "EditPwdWithOldPwdViewController.h"
#import "InputInfoViewController.h"
#import "GeneralInfoTableViewCell.h"
#import "PersonalInfoSettingsViewController.h"
#import "RealNameViewController.h"
#import "SetSecretViewController.h"

#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>
@interface PersonalInfoSettingsViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>{
    UITableView *mainTableView;
    NSString *adressCountStr;
    NSString *statusStr;
    BOOL isPersonVerify;
}

@property (nonatomic, copy) NSArray *footerTitleArray;
@property (nonatomic,strong)UIImageView* headImgVi;
@property (nonatomic,strong)UIImage* headImg;
@property (nonatomic, assign) BOOL isShowTixian;
@end

@implementation PersonalInfoSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHexCode:@"f2f2f2"];
    self.title = @"个人资料设定";
    statusStr = @"";
    //防止点进去的时候 未填写完整 跳出
    adressCountStr = @"-1";
    
    [self createMainView];
    if ([[PreferenceManager sharedManager] preferenceForKey:@"isShowTixian"]) {
        self.isShowTixian = YES;
        _footerTitleArray = [NSArray arrayWithObjects:@"此地址为您的收货地址",
                             @"输入真实姓名将方便工作人员联系您，您的资料将被保密",
                             @"您的注册手机号无法拨通时，将拨通该电话",
                             @"输入真实信息将方便商品入境申报，您的资料将被保密",
                             @"用于余额转出(提现)", nil];
    }else {
        _footerTitleArray = [NSArray arrayWithObjects:@"此地址为您的收货地址",
                             @"输入真实姓名将方便工作人员联系您，您的资料将被保密",
                             @"您的注册手机号无法拨通时，将拨通该电话",
                             @"输入真实信息将方便商品入境申报，您的资料将被保密",
                             @"登录密码修改", nil];
    }
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getMyCenterData];
}

- (void)createMainView
{
    CGFloat topViewHeight = 7.5;
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topViewHeight, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar - topViewHeight) style:UITableViewStyleGrouped];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:mainTableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 2;
//    if (section == 0)
//    {
//        return 2;
//    }else if (section == 4)
//    {
//        if (self.isShowTixian) {
//            return 3;
//        }else {
//            return 1;
//        }
//    }else
//    {
//        return 1;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cellForPersonalInfoSettings";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    GeneralInfoTableViewCell *cellView;
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cellView = [[GeneralInfoTableViewCell alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 51.0)];
        cellView.tag=2000;
        [cell addSubview:cellView];
    }
    cellView = (GeneralInfoTableViewCell*)[cell viewWithTag:2000];
    if (indexPath.section == 0 &&
        indexPath.row == 0)
    {
        self.headImgVi = [[UIImageView alloc]initWithFrame:CGRectMake(15, 11/2.0, 40, 40)];
        self.headImgVi.layer.cornerRadius = 20;
        self.headImgVi.layer.masksToBounds = YES;
        self.headImgVi.userInteractionEnabled=YES;
        [cellView addSubview:self.headImgVi];
        cellView.detailTextLabel.text = @"请选择头像";
        cellView.detailTextLabel.textColor = [UIColor colorFromHexCode:@"a4a4a8"];
        cellView.rightImageView.image = [UIImage imageNamed:@"gj_jt_right.png"];
    }

    if (indexPath.section == 0 &&
        indexPath.row == 1)
    {
        cellView.leftTextLabel.text = @"收货地址";
        cellView.rightImageView.image = [UIImage imageNamed:@"gj_jt_right.png"];

        if (![adressCountStr isValid] || [adressCountStr isEqualToString:@"0"])
        {
            UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 85, 51)];
            
            UILabel *addressStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (51 - 25) / 2, 80, 25)];
            addressStatusLabel.text = @"未填写完整";
            addressStatusLabel.textColor = WHITE_COLOR;
            addressStatusLabel.textAlignment = NSTextAlignmentCenter;
            addressStatusLabel.font = [UIFont systemFontOfSize:14.0];
            [rightView addSubview:addressStatusLabel];
            addressStatusLabel.backgroundColor = App_Main_Color;
            addressStatusLabel.layer.cornerRadius = 3;
            addressStatusLabel.clipsToBounds = YES;
            cell.accessoryView = rightView;
        }
        else
        {
            cell.accessoryView = nil;
        }

    }
    else if (indexPath.section == 1)
    {
        cellView.leftTextLabel.text = @"姓名";
        if([realNameString isValid]){
            cellView.detailTextLabel.text = realNameString;
        }
        else{
             cellView.detailTextLabel.text = @"编辑姓名";
        }
        cellView.detailTextLabel.textColor = [UIColor colorFromHexCode:@"a4a4a8"];
        cellView.rightImageView.image = [UIImage imageNamed:@"gj_jt_right.png"];
    }
    else if (indexPath.section == 2)
    {
        cellView.leftTextLabel.text = @"其他联系方式";
        if([otherContactWayString isValid]){
            cellView.detailTextLabel.text = otherContactWayString;
        }
        else{
            cellView.detailTextLabel.text = @"编辑联系方式";
        }
        cellView.detailTextLabel.textColor = [UIColor colorFromHexCode:@"a4a4a8"];
        cellView.rightImageView.image = [UIImage imageNamed:@"gj_jt_right.png"];
    }
    else if (indexPath.section == 3)
    {
        cellView.leftTextLabel.text = @"实名认证";
        cellView.rightImageView.image = [UIImage imageNamed:@"gj_jt_right.png"];
        if (isPersonVerify) {
            cellView.detailTextLabel.text = @"已认证";
            cellView.detailTextLabel.textColor = App_Main_Color;
        }else {
            cellView.detailTextLabel.text = @"未认证";
            cellView.detailTextLabel.textColor = [UIColor colorFromHexCode:@"a4a4a8"];
        }
    }
    else if (indexPath.section == 4 &&
             indexPath.row == 0)
    {
        cellView.leftTextLabel.text = @"修改密码";
        cellView.rightImageView.image = [UIImage imageNamed:@"gj_jt_right.png"];
    }
    else if (self.isShowTixian && indexPath.section == 4 &&
             indexPath.row == 1)
    {
        cellView.leftTextLabel.text = @"管理银行卡";
        cellView.rightImageView.image = [UIImage imageNamed:@"gj_jt_right.png"];
    }
    else if (self.isShowTixian && indexPath.section == 4 &&
             indexPath.row == 2)
    {
        cellView.leftTextLabel.text = @"管理支付宝账号";
        cellView.rightImageView.image = [UIImage imageNamed:@"gj_jt_right.png"];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    //return 5;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 &&
        indexPath.row == 0)
    {
        
        UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"拍照", @"从相册中选取", nil];
        choiceSheet.tag = 100;
        [choiceSheet showInView:[UIApplication sharedApplication].keyWindow];
        
    }

    if (indexPath.section == 0 &&
        indexPath.row == 1)
    {
        AdrListViewController* vc = [[AdrListViewController alloc]init];
        vc.wp = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 1)
    {
        InputInfoViewController *inputInfoVC = [[InputInfoViewController alloc] init];
        inputInfoVC.type = InputInfoTypeName;
        [self.navigationController pushViewController:inputInfoVC animated:YES];
    }
    else if (indexPath.section == 2)
    {
        InputInfoViewController *inputInfoVC = [[InputInfoViewController alloc] init];
        inputInfoVC.type = InputInfoTypePhone;
        [self.navigationController pushViewController:inputInfoVC animated:YES];
    }
    else if (indexPath.section == 3)
    {
        [self cheakRealNameRequest];
    }
    else if (indexPath.section == 4 &&
        indexPath.row == 0)
    {
    
//        EditPwdWithOldPwdViewController *editPwdVC = [[EditPwdWithOldPwdViewController alloc] init];
//        editPwdVC.phoneNum =[[PreferenceManager sharedManager] preferenceForKey:@"phone_num"];
//        [self.navigationController pushViewController:editPwdVC animated:YES];
        SetSecretViewController *set = [[SetSecretViewController alloc]init];
        set.SecretType = SetLogInSecretType;
        [self.navigationController pushViewController:set animated:YES];
    }
    else if (self.isShowTixian && indexPath.section == 4 &&
             indexPath.row == 1)
    {
        BankCardManageViewController *bankCardManageVC = [[BankCardManageViewController alloc] init];
        [self.navigationController pushViewController:bankCardManageVC animated:YES];
    }
    else if (self.isShowTixian && indexPath.section == 4 &&
             indexPath.row == 2)
    {
        BankCardManageViewController *bankCardManageVC = [[BankCardManageViewController alloc] init];
        bankCardManageVC.payType = 2;
        [self.navigationController pushViewController:bankCardManageVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 51.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 29;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 29)];
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, UI_SCREEN_WIDTH - 20, 29)];
    textLabel.text = [_footerTitleArray objectAtIndex:section];
    textLabel.font = [UIFont systemFontOfSize:11.0];
    textLabel.textColor = [UIColor colorFromHexCode:@"a4a4a8"];
    [footerView addSubview:textLabel];
    
    return footerView;
}

#pragma mark - 获取我的页面的数据
- (void)getMyCenterData
{
    [SVProgressHUD show];
    NSString *str = MOBILE_SERVER_URL(@"mycenter.php");
    [RequestManager startRequestWithUrl:str
                                   body:@""
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               NSString *returnState = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"is_success"]];
                               if (![returnState isEqualToString:@"1"])
                               {
                                   [SVProgressHUD dismissWithSuccess:@"网络成功"];
                                   return;
                               }
                               NSString *str = [NSString stringWithFormat:@"%@", [[responseObject valueForKey:@"user_info"] valueForKey:@"user_avatar"]];
                               if ([str isValid])
                               {
                                   [self.headImgVi sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"s_morenLogo.png"]];
                               }
                               isPersonVerify = [[[responseObject valueForKey:@"user_info"] valueForKey:@"is_personverify"] intValue] == 1 ? YES : NO;
                               realNameString=[NSString stringWithFormat:@"%@",[[responseObject valueForKey:@"user_info"] valueForKey:@"user_name"]];
                               otherContactWayString=[NSString stringWithFormat:@"%@",[[responseObject valueForKey:@"user_info"] valueForKey:@"tel"]];
                               adressCountStr=[NSString stringWithFormat:@"%@",[[responseObject valueForKey:@"user_info"] valueForKey:@"contact_num"]];
                               
                               [mainTableView reloadData];
                               [SVProgressHUD dismiss];
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }];
}
- (void)cheakRealNameRequest {
    [SVProgressHUD show];
    NSString*body=@"&type=check";
    NSString *str=MOBILE_SERVER_URL(@"personverify.php");
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
            DLog(@"已经实名认证~~");
            [SVProgressHUD dismiss];
            NSDictionary *info = responseObject[@"info"];
            
            RealNameViewController *vc = [[RealNameViewController alloc] init];
            vc.isAlreadyVerify = isPersonVerify;
            vc.nameStr = [NSString stringWithFormat:@"%@",info[@"name"]];
            vc.cardIdStr = [NSString stringWithFormat:@"%@",info[@"IDCard"]];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if ([[responseObject objectForKey:@"status"] intValue] == 0) {
            DLog(@"未实名认证~~");
            [SVProgressHUD dismiss];
            RealNameViewController *vc = [[RealNameViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else{
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
- (void)getAliPayAccountData
{
    [SVProgressHUD show];
    NSString *str = MOBILE_SERVER_URL(@"zhifubao.php");
    [RequestManager startRequestWithUrl:str
                                   body:@"type=1"
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               NSString *returnState = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"status"]];
                               [SVProgressHUD dismiss];
                               if ([returnState isEqualToString:@"0"])
                               {
                                   BindAlipayAccountViewController *bindAlipayAccountVC = [[BindAlipayAccountViewController alloc] init];
                                   bindAlipayAccountVC.type = BindAlipayVCTypeAdd;
                                   [self.navigationController pushViewController:bindAlipayAccountVC animated:YES];
                               }
                               else
                               {
                                   AlipayAccountInfoViewController *alipayAccountInfoVC = [[AlipayAccountInfoViewController alloc] init];
                                   alipayAccountInfoVC.accountInfoDic = [responseObject objectForKey:@"content"];
                                   [self.navigationController pushViewController:alipayAccountInfoVC animated:YES];
                               }
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet.tag == 100) {
        if (buttonIndex == 0) {
            // 拍照
            if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
                _controller = [[UIImagePickerController alloc] init];
                _controller.sourceType = UIImagePickerControllerSourceTypeCamera;
                if ([self isFrontCameraAvailable]) {
                    _controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
                }
                NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
                _controller.mediaTypes = mediaTypes;
                _controller.delegate = self;
                _controller.allowsEditing = YES;
                [self isCameraJurisdiction];
            }
        } else if (buttonIndex == 1) {
            // 从相册中选取
            if ([self isPhotoLibraryAvailable]) {
                _controller = [[UIImagePickerController alloc] init];
                _controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
                _controller.mediaTypes = mediaTypes;
                _controller.delegate = self;
                _controller.allowsEditing = YES;
                [self isPhotoJurisdiction];
            }
        }
    }
    
}

//判断相机是否有权限
- (void)isCameraJurisdiction {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus ==AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:nil message:@"应用未开启相机权限，请到iPhone设置-隐私-相机中开启" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alerView.tag = 112;
        [alerView show];
    }else {
        statusStr = @"相机";
       [self.navigationController presentViewController:_controller animated:YES completion:nil];
    }
}

//判断相册时候有权限
- (void)isPhotoJurisdiction {
    //相册权限
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author ==kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied){
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:nil message:@"此应用没有权限访问您的照片或视频。您可以到“隐私设置中”启用访问。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alerView.tag = 111;
        [alerView show];
    }else {
        statusStr = @"相册";
        [self presentViewController:_controller animated:YES completion:nil];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 111) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }else if (alertView.tag == 112) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            [[UIApplication sharedApplication]openURL:url];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    //    _headImgV.image=image;
    //    [SVProgressHUD show];
    [picker dismissViewControllerAnimated:YES completion:^() {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus != kCLAuthorizationStatusAuthorized && [statusStr isEqualToString:@"相机"]) {
            return;
        }
        NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"avatar",@"type",nil];
        self.headImg = image;
        //头像格式改成.png，防止手机上注册修改头像到网页上显示不了头像
        [self UpLoad:image picName:@"png" withObj:params];
        
    }];
}

//上传图片
-(void)UpLoad:(UIImage *)img picName:(NSString *)name withObj:(NSDictionary *)params
{
    //NSData *imageData = UIImageJPEGRepresentation(img, 0.5);
    [SVProgressHUD show];
    NSString *url = MOBILE_SERVER_URL(@"edituserinfo_res.php");
    //NSString *url = [NSString stringWithFormat:@"%@/mobile/api/edituserinfo_res.php",NEW_KSERVERADD];
    //    NSString *url=MOBILE_SERVER_URL(string);
    
    //    NSString *url = MOBILE_SERVER_URL(@"api/edituserinfo_res.php");
    
    //    NSLog(@"URL:%@",url);
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:
                                [NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    //NSString *BOUNDARY = @"******";
    //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"******";
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //要上传的图片
    //得到图片的data
    NSData* data = UIImageJPEGRepresentation(img,0.5);
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //参数的集合的所有key的集合
    //遍历keys
    for (id key in params){
        //得到当前key
        //添加分界线，换行
        [body appendFormat:@"%@\r\n",MPboundary];
        //添加字段名称，换2行
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
        //添加字段的值
        [body appendFormat:@"%@\r\n",[params objectForKey:key]];
    }
    ////添加分界线，换行
    [body appendFormat:@"%@\r\n",MPboundary];
    //声明pic字段，文件名为boris.png
    [body appendFormat:@"Content-Disposition: form-data; name=\"avatar\"; filename=\"%@\"\r\n",name];
    //声明上传文件的格式
    [body appendFormat:@"Content-Type: image/png\r\n\r\n"];
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //将image的data加入
    [myRequestData appendData:data];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%ld", [myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    
    NSLog(@"头像request:%@",request);
    //修改发送请求方式，解决请求发送两次的问题7.4
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"头像responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"status"]integerValue]==1) {
            
            //重要：为该标识修改完上传服务器后初始化为NO，目的是因为修改头像后该标识为YES，如果退出登录
            //会导致该标识未清为NO，而使drawPager方法中的判断进不去，最后会导致之后的账号头像与前一个
            //账号头像相同的情况  2014-08-12
            
            //读取后台返回的头像链接,因为更换后的头像是UIImage,直接保存到数据
            //库后界面切换程序会中断  2014-08-14
            [[PreferenceManager sharedManager] setPreference:[responseObject objectForKey:@"customer_avatar"] forKey:@"avatar"];
            
            
            
            //头像上传服务器成功后再更换头像  2014-08-15
            //            [_headImgV af_setImageWithURL:[NSURL URLWithString:[[PreferenceManager sharedManager]preferenceForKey:@"avatar"]]];
            NSLog(@"保存在数据库的 头像：%@",[[PreferenceManager sharedManager] preferenceForKey:@"avatar"]);
            //之前逻辑不对，如果后台头像上传成功，后台返回不对会出现显示不出头像的情况 2014-08-28
            self.headImgVi.image = img;
            [SVProgressHUD dismissWithSuccess:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"info"]]];
        }else{
            [SVProgressHUD dismissWithSuccess:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"info"]]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
        NSLog(@"errorR:%@",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络异常"];
    }];
    [op start];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
        
    }];
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

@end
