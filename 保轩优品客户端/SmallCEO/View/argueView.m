//
//  argueView.m
//  SmallCEO
//
//  Created by 俊严 on 15/10/26.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "argueView.h"
#import "RatingBar.h"
#import "pyItemRatingScoreCustomView.h"
#import "ArgueModel.h"
#import "ArgueViewController.h"
@interface argueView ()
{
    UIImagePickerController *_controller;
}

@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) ArgueModel * model;
@property (nonatomic, strong) UIImageView * photoImageView;

@end

@implementation argueView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.starString=[[NSMutableString alloc] initWithCapacity:0];
        [_starString appendString:@"0,0,0"];
        self.goodsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(16, 12, 83, 78)];
//        _goodsImageView.backgroundColor = [UIColor cyanColor];
        [self addSubview:_goodsImageView];
        
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.goodsImageView.frame)+14, 15, UI_SCREEN_WIDTH - CGRectGetMaxX(self.goodsImageView.frame)-14-26, 40)];
        self.titleLabel.text = @"半亩花田超小颗粒海藻面膜保湿 免洗清洁收缩毛孔";
        self.titleLabel.textColor = [UIColor colorFromHexCode:@"#434343"];
     
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:self.titleLabel];
        
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.goodsImageView.frame)+14, CGRectGetMaxY(self.titleLabel.frame)+10, UI_SCREEN_WIDTH - CGRectGetMaxX(self.goodsImageView.frame)-14-26, 20)];
        self.priceLabel.text = @"￥20";
        self.priceLabel.textColor = [UIColor colorFromHexCode:@"#000000"];
       
        self.priceLabel.numberOfLines = 0;
        self.priceLabel.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:self.priceLabel];
        
        UILabel *argueLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, CGRectGetMaxY(self.goodsImageView.frame)+20, 90, 20)];
        argueLabel.text = @"综合评价";
        argueLabel.textColor = [UIColor colorFromHexCode:@"#000000"];
        
        argueLabel.numberOfLines = 0;
        argueLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:argueLabel];
        
        RatingBar *bar = [[RatingBar alloc] initWithFrame:CGRectMake(CGRectGetMaxX(argueLabel.frame)+16, CGRectGetMaxY(self.goodsImageView.frame)+14, 200, 30)];
//        bar.backgroundColor = [UIColor cyanColor];
        bar.tag = 1000;
        bar.enable=YES;
        bar.delegate = self;
        DLog(@"xingxing   %ld", self.zongHeStartNum);
        [self addSubview:bar];
        
        
        
        self.argueTextView = [[UITextView alloc] initWithFrame:CGRectMake(18, CGRectGetMaxY(argueLabel.frame)+30, UI_SCREEN_WIDTH-65-18-18-20, 130/2)];
//        self.argueTextView.text = @"写下对商品的评价, 改进我们的服务";
        self.argueTextView.backgroundColor = [UIColor colorFromHexCode:@"f9f9f9"];
        self.argueTextView.layer.borderWidth = 1;
        self.argueTextView.layer.cornerRadius = 5;
        [self.argueTextView addPlaceHolder:@"写下对商品的评价, 改进我们的服务"];
        self.argueTextView.layer.borderColor = [UIColor colorFromHexCode:@"dddddd"].CGColor;
        [self addSubview:self.argueTextView];
    
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextViewTextDidChangeNotification object:nil];
//
        
//        [self.argueTextView addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];

        
        self.photoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH-65-18, CGRectGetMaxY(argueLabel.frame)+30, 65, 65)];
        _photoImageView.userInteractionEnabled = YES;
        _photoImageView.image = [UIImage imageNamed:@"getphoto.png"];
        [self addSubview:_photoImageView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photo)];
        [_photoImageView addGestureRecognizer:tap];

        UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_photoImageView.frame)+15, UI_SCREEN_WIDTH, 135)];
        [self addSubview:bottomView];
        
        UIView * intervalView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 1)];
        intervalView.backgroundColor = [UIColor colorFromHexCode:@"f3f4f6"];
        [bottomView addSubview:intervalView];
        
        
        UILabel *datailArgueLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 5, 90, 20)];
        datailArgueLabel.text = @"详细评价";
        datailArgueLabel.textColor = [UIColor colorFromHexCode:@"#000000"];
        
        datailArgueLabel.numberOfLines = 0;
        datailArgueLabel.font = [UIFont boldSystemFontOfSize:15];
        [bottomView addSubview:datailArgueLabel];
        
        NSArray *titleJudgeArr=@[@"描述相符", @"发货速度", @"服务咨询"];
        
        for (int i=0; i<3; i++) {
            pyItemRatingScoreCustomView *vi = [[pyItemRatingScoreCustomView alloc] initWithFrame:CGRectMake(17, CGRectGetMaxY(datailArgueLabel.frame)+5+30*i, self.frame.size.width, 28.0) titleStr:[NSString stringWithFormat:@"%@",[titleJudgeArr objectAtIndex:i]]];
            vi.tag = 2000 + i;
            vi.itemscoreIndex = 90+i;
            vi.itemDelegate = self;
            [bottomView addSubview:vi];
            [_scoreItemArr addObject:vi];
            
//            RatingBar *bar = [[RatingBar alloc] initWithFrame:CGRectMake(17, CGRectGetMaxY(datailArgueLabel.frame)+18+30*i, self.frame.size.width, 28.0)];
//            //        bar.backgroundColor = [UIColor cyanColor];
//            bar.tag = 2000+i;
//            
//            bar.delegate = self;
//            [self addSubview:bar];
        }
  
        CGFloat curHeight=CGRectGetMaxY(datailArgueLabel.frame)+95;
        UIView * photoView = [[UIView alloc] initWithFrame:CGRectMake(0, curHeight+5, UI_SCREEN_WIDTH, 10)];
                photoView.backgroundColor = [UIColor colorFromHexCode:@"e5e5e5"];
        [bottomView addSubview:photoView];
        DLog(@"cellHeight:%f",CGRectGetMaxY(bottomView.frame));
        
    }
    return self;
}






- (void)starNumber:(UITapGestureRecognizer *)gesture
{
    RatingBar * bar = (RatingBar *)[self viewWithTag:1000];
    if(bar.enable){
        CGPoint point = [gesture locationInView:bar];
        NSInteger count = (int)(point.x/bar.starWidth)+1;
        bar.topView.frame = CGRectMake(0, 0, bar.starWidth*count, bar.bounds.size.height);
        if(count>5){
            bar.starNumber = 5;
        }else{
            bar.starNumber = count-1;
        }
    }
    self.zongHeStartNum = bar.starNumber;
    DLog(@"开始的星星数1  %ld  zongHeStartNum=%ld", bar.starNumber, self.zongHeStartNum);
    
    self.model.totalValueNum = self.zongHeStartNum;

}
- (void)photo
{
    DLog(@"拍照");
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    choiceSheet.tag = 100;
    [choiceSheet showInView:[UIApplication sharedApplication].keyWindow];
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
            }
        }else{
            return;
        }
        
        AppDelegate *del=(AppDelegate *) [[UIApplication sharedApplication] delegate];
        [del.curViewController presentViewController:_controller animated:YES completion:^{
            
        }];
        
    }
    
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    //    _headImgV.image=image;
    //    [SVProgressHUD show];
    [picker dismissViewControllerAnimated:YES completion:^() {
        self.photoImageView.image = image;
        self.model.goodsImage = image;
        
    }];
}

//上传图片
-(void)UpLoad:(UIImage *)img picName:(NSString *)name withObj:(NSDictionary *)params
{
    //NSData *imageData = UIImageJPEGRepresentation(img, 0.5);
    [SVProgressHUD show];
    NSString *url = [NSString stringWithFormat:@"%@/mobile/api/edituserinfo_res.php",NEW_KSERVERADD];
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
            self.photoImageView.image = img;
            self.model.goodsImage = img;
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

#pragma mark - 评分点击
-(void)pyItemRatingCustomViewSelectWithIndex:(NSInteger)itemIndex starNum:(NSInteger)starsCount
{
    //    0...
    int index=(int)itemIndex-90;
    if (starsCount>=0&&starsCount<=5) {
        if (index==0) {
            NSRange range={0,1};
            [self.starString replaceCharactersInRange:range withString:[NSString stringWithFormat:@"%ld",(long)starsCount]];
        }else if (index==1){
            NSRange range={2,1};
            [self.starString replaceCharactersInRange:range withString:[NSString stringWithFormat:@"%ld",(long)starsCount]];
        }else if (index==2){
            NSRange range={4,1};
            [self.starString replaceCharactersInRange:range withString:[NSString stringWithFormat:@"%ld",(long)starsCount]];
        }else if (index==3){
            NSRange range={6,1};
            [self.starString replaceCharactersInRange:range withString:[NSString stringWithFormat:@"%ld",(long)starsCount]];
        }else{
            NSRange range={8,1};
            [self.starString replaceCharactersInRange:range withString:[NSString stringWithFormat:@"%ld",(long)starsCount]];
        }
    }
    
    NSString * descriptionStr = [self.starString substringWithRange:NSMakeRange(0, 1)];
    self.model.descriptionNum = [descriptionStr integerValue];
    NSString * speedStr = [self.starString substringWithRange:NSMakeRange(2, 1)];
    self.model.speedNum = [speedStr integerValue];
    NSString * consultStr = [self.starString substringWithRange:NSMakeRange(4, 1)];
    self.model.consultNum = [consultStr integerValue];

    NSLog(@"starString:%@",self.starString);
}

- (void)assignmentWithDataArray:(NSArray *)array
{
    self.dataArray = [NSMutableArray arrayWithArray:array];
    if ([[array objectAtIndex:0] length] > 0) {
        self.goodsImageView.image = [UIImage imageNamed:[array objectAtIndex:0]];
    }
    self.titleLabel.text = [array objectAtIndex:1];
    RatingBar * bar = (RatingBar *)[self viewWithTag:1000];
    if (bar.enable) {
        bar.starNumber = [[array objectAtIndex:2] integerValue];
    }
    if ([[array objectAtIndex:3] length] > 0) {
        self.argueTextView.text = [array objectAtIndex:2];
    }
    pyItemRatingScoreCustomView * descriptionVI = (pyItemRatingScoreCustomView *)[self viewWithTag:2000];
    descriptionVI.startNum = [[array objectAtIndex:4] integerValue];
    pyItemRatingScoreCustomView * speedVI = (pyItemRatingScoreCustomView *)[self viewWithTag:2001];
    speedVI.startNum = [[array objectAtIndex:5] integerValue];
    pyItemRatingScoreCustomView * consultVI = (pyItemRatingScoreCustomView *)[self viewWithTag:2002];
    consultVI.startNum = [[array objectAtIndex:6] integerValue];
}

- (void)assignmentWithModel:(ArgueModel *)model {
    self.model = model;
    if(model.goodsImage!=nil){
        self.photoImageView.image=model.goodsImage;
    }
    [self.goodsImageView    af_setImageWithURL:[NSURL URLWithString:model.picurl]];
    self.titleLabel.text = model.goodsName;
    self.priceLabel.text = model.goodsPrice;
    RatingBar * bar = (RatingBar *)[self viewWithTag:1000];
    if (bar.enable) {
        bar.starNumber = model.totalValueNum;
    }
    if (model.adviceStr) {
        self.argueTextView.text = model.adviceStr;
    }
    pyItemRatingScoreCustomView * descriptionVI = (pyItemRatingScoreCustomView *)[self viewWithTag:2000];
    descriptionVI.startNum = model.descriptionNum;
    pyItemRatingScoreCustomView * speedVI = (pyItemRatingScoreCustomView *)[self viewWithTag:2001];
    speedVI.startNum = model.speedNum;
    pyItemRatingScoreCustomView * consultVI = (pyItemRatingScoreCustomView *)[self viewWithTag:2002];
    consultVI.startNum = model.consultNum;
}

//- (void)textViewDidChange:(UITextView *)textView
//{
//    self.model.adviceStr = textView.text;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
