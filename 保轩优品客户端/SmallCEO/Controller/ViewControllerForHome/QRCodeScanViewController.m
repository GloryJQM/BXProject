//
//  QRCodeScanViewController.m
//  JDQX
//
//  Created by pan on 13-11-12.
//  Copyright (c) 2013年 quanmai. All rights reserved.
//

#import "QRCodeScanViewController.h"
#import "ScanBGView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "BxPayViewController.h"
#import "LoginViewController.h"
@interface QRCodeScanViewController ()<AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) ZXCapture* capture;

//View
@property (strong, nonatomic) ScanBGView *myScanBGView;
@property (strong, nonatomic) UIImageView *scanRectView, *lineView;
@property (strong, nonatomic) UILabel *tipLabel;
@property (strong, nonatomic) UIButton * lightButton;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (strong, nonatomic) CIDetector *detector;
@property (assign, nonatomic) BOOL openLight;
//Data
@property (strong, nonatomic) NSString * orderToken;

@end

@implementation QRCodeScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二维码扫描";
    self.view.backgroundColor = [UIColor blackColor];
    [self initWithNotification];
}

- (void)initWithNotification {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(applicationDidBecomeActive:)
               name:UIApplicationDidBecomeActiveNotification
             object:nil];
    [nc addObserver:self
           selector:@selector(applicationWillResignActive:)
               name:UIApplicationWillResignActiveNotification
             object:nil];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!_videoPreviewLayer) {
        [self configUI];
    }else{
        [self startScan];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self stopScan];
}

- (void)configUI {
    CGFloat width = UI_SCREEN_WIDTH *2/3;
    CGFloat padding = (UI_SCREEN_WIDTH - width)/2;
    CGRect scanRect = CGRectMake(padding, UI_SCREEN_HEIGHT/10, width, width);
    
    if (!_videoPreviewLayer) {
        NSError *error;
        AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
        if (!input) {
            [SVProgressHUD showErrorWithStatus:@"请开启相机权限"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            //设置会话的输入设备
            AVCaptureSession *captureSession = [AVCaptureSession new];
            [captureSession addInput:input];
            //对应输出
            AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
            [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_queue_create("ease_capture_queue",NULL)];
            [captureSession addOutput:captureMetadataOutput];
            
            //设置条码类型:包含 AVMetadataObjectTypeQRCode 就好
            if (![captureMetadataOutput.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
                [SVProgressHUD showErrorWithStatus:@"摄像头不支持扫描二维码！"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [captureMetadataOutput setMetadataObjectTypes:captureMetadataOutput.availableMetadataObjectTypes];
            }
            captureMetadataOutput.rectOfInterest = CGRectMake(CGRectGetMinY(scanRect)/CGRectGetHeight(self.view.frame), 1 - CGRectGetMaxX(scanRect)/CGRectGetWidth(self.view.frame), CGRectGetHeight(scanRect)/CGRectGetHeight(self.view.frame), CGRectGetWidth(scanRect)/CGRectGetWidth(self.view.frame));//设置扫描区域。。默认是手机头向左的横屏坐标系（逆时针旋转90度）
            //将捕获的数据流展现出来
            _videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
            [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
            [_videoPreviewLayer setFrame:self.view.bounds];
        }
    }
    
    if (!_myScanBGView) {
        _myScanBGView = [[ScanBGView alloc] initWithFrame:self.view.bounds];
        _myScanBGView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        _myScanBGView.scanRect = scanRect;
    }
    
    if (!_scanRectView) {
        _scanRectView = [[UIImageView alloc] initWithFrame:scanRect];
        _scanRectView.image = [[UIImage imageNamed:@"scan_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(25, 25, 25, 25)];
        _scanRectView.clipsToBounds = YES;
    }
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.font = [UIFont boldSystemFontOfSize:13];
        _tipLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        _tipLabel.text = @"将二维码放入框内，即可自动扫描";
        _tipLabel.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 20);
        _tipLabel.centerY = _scanRectView.maxY+20;
    }
    if (!_lineView) {
        UIImage *lineImage = [UIImage imageNamed:@"scan_line"];
        CGFloat lineHeight = 2;
        CGFloat lineWidth = CGRectGetWidth(_scanRectView.frame);
        _lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, lineWidth, lineHeight)];
        _lineView.contentMode = UIViewContentModeScaleToFill;
        _lineView.image = lineImage;
    }
    
    [self.view.layer addSublayer:_videoPreviewLayer];
    [self.view addSubview:_myScanBGView];
    [self.view addSubview:_scanRectView];
    [self.view addSubview:_tipLabel];
    [self.view addSubview:_myScanBGView];
    [self.view addSubview:_tipLabel];
    

    [_scanRectView addSubview:_lineView];
    [_videoPreviewLayer.session startRunning];
    [self scanLineStartAction];
}

- (CIDetector *)detector {
    if (!_detector) {
        _detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    }
    return _detector;
}

- (void)scanLineStartAction {
    [self scanLineStopAction];
    
    CABasicAnimation *scanAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    scanAnimation.fromValue = @(-CGRectGetHeight(_lineView.frame));
    scanAnimation.toValue = @(CGRectGetHeight(_lineView.frame) + CGRectGetHeight(_scanRectView.frame));
    
    scanAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scanAnimation.repeatCount = CGFLOAT_MAX;
    scanAnimation.duration = 2.0;
    [self.lineView.layer addAnimation:scanAnimation forKey:@"basic"];
}

- (void)scanLineStopAction {
    [self.lineView.layer removeAllAnimations];
}

- (void)dealloc {
    [self.videoPreviewLayer removeFromSuperlayer];
    self.videoPreviewLayer = nil;
    [self scanLineStopAction];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    //判断是否有数据，是否是二维码数据
    if (metadataObjects != nil && metadataObjects.count > 0) {
        __block AVMetadataMachineReadableCodeObject *result = nil;
        [metadataObjects enumerateObjectsUsingBlock:^(AVMetadataMachineReadableCodeObject *obj, NSUInteger idx, BOOL *stop) {
            if ([obj.type isEqualToString:AVMetadataObjectTypeQRCode]) {
                result = obj;
                *stop = YES;
            }
        }];
        if (!result && metadataObjects != nil) {
            result = [metadataObjects firstObject];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self analyseResult:result];
        });
    }
}

- (void)analyseResult:(AVMetadataMachineReadableCodeObject *)result {
    DLog(@"%@",result);
    if (result.stringValue == nil) {
        return;
    }

    NSString *resultStr = result.stringValue;
    if (resultStr.length <= 0) {
        return;
    }
    //停止扫描
    [self stopScan];
    //震动反馈
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    [self dealWithUrl:resultStr];
}

#pragma mark Notification
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self startScan];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self stopScan];
}
#pragma mark Photo
- (void)clickRightBarButton:(UIBarButtonItem*)item {
    if (![self checkPhotoLibraryAuthorizationStatus]) {
        return;
    }
    //停止扫描
    [self stopScan];
    
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        [self handleImageInfo:info];
    }];
}
- (void)handleImageInfo:(NSDictionary *)info {
    //停止扫描
    [self stopScan];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    __block NSString *resultStr = nil;
    NSArray *features = [self.detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    [features enumerateObjectsUsingBlock:^(CIQRCodeFeature *obj, NSUInteger idx, BOOL *stop) {
        if (obj.messageString.length > 0) {
            resultStr = obj.messageString;
            *stop = YES;
            [self dealWithUrl:resultStr];
        }
    }];
    //震动反馈
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

#pragma mark public
- (BOOL)isScaning {
    return _videoPreviewLayer.session.isRunning;
}

- (void)startScan {
    [self.videoPreviewLayer.session startRunning];
    [self scanLineStartAction];
}

- (void)stopScan {
    [self.videoPreviewLayer.session stopRunning];
    [self scanLineStopAction];
}
#pragma mark --检查手机相机权限
- (BOOL)checkPhotoLibraryAuthorizationStatus {
    if ([ALAssetsLibrary respondsToSelector:@selector(authorizationStatus)]) {
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        if (ALAuthorizationStatusDenied == authStatus ||
            ALAuthorizationStatusRestricted == authStatus) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"请在iPhone的“设置->隐私->照片”中打开本应用的访问权限" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alert show];
            return NO;
        }
    }
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self startScan];
}

#pragma  mark 将扫描的url进行处理
- (void)dealWithUrl:(NSString *)url {
    if (![url containsString:@"mobile/api/userOffLinePayApi"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"该二维码不是商家所有" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if ([[PreferenceManager sharedManager] preferenceForKey:@"didLogin"] == nil || [[PreferenceManager sharedManager] preferenceForKey:@"token"] == nil ) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            AppDelegate *del=(AppDelegate *)[[UIApplication sharedApplication] delegate];
            [LoginViewController performIfLogin:del.curViewController withShowTab:NO loginAlreadyBlock:^{
                [self startScan];
            } loginSuccessBlock:^(BOOL login){
                if (login) {
                    [self startScan];
                }
            }];
        });
        return;
    }
    
    [SVProgressHUD show];
    [RequestManager startRequestWithUrl:url
                                   body:@""
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject :%@", responseObject);
                               if ([[responseObject objectForKey:@"is_success"] integerValue] == 1) {
                                   BXPayViewController *pay = [[BXPayViewController alloc]init];
                                   pay.dataDic = responseObject;
                                   [self.navigationController pushViewController:pay animated:YES];
                               }else {
                                   NSString *message;
                                   if ([responseObject valueForKey:@"info"]!=nil) {
                                       message = [responseObject valueForKey:@"info"];
                                   }else{
                                       message = @"网络错误";
                                   }
                                   RCLAlertView *rclAlerView = [[RCLAlertView alloc]initWithTitle:App_Alert_Notice_Title contentText:message leftButtonTitle:@"" rightButtonTitle:@"确定"];
                                   rclAlerView.rightBlock = ^(){
                                       //错误时继续扫描
                                       [self startScan];
                                   };
                                   [rclAlerView show];
                               }
                               [SVProgressHUD dismiss];
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                               [self startScan];
                           }];
}
@end
