//
//  ArgueViewController.m
//  SmallCEO
//
//  Created by 俊严 on 15/10/26.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "ArgueViewController.h"
#import "pyItemRatingScoreCustomView.h"
#import "CommentTableViewCell.h"
#import "ArgueCell.h"
#import "ArgueModel.h"

#define kUIScreenWidth [UIScreen mainScreen].bounds.size.width
#define kUIScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ArgueViewController ()<UITextViewDelegate, pyStarRatingCustomViewDelegate,pyItemRatingScoreCustomViewDelegate, UITableViewDataSource, UITableViewDelegate/*, ArgueCellDelegate*/>
{
    
        NSMutableArray              *_scoreItemArr;
        NSMutableString *starString;
   
    UIButton *preButton;
    UILabel *titleLabel;
     UILabel *priceLabel;
    NSInteger zongHeStartNum;
    NSInteger detailStartNum;
    NSInteger faHuoStartNum;
    NSInteger serveStartNum;
    UITextView * argueTextView;
    int isNiMing;
    UIButton * isNiMingBtn;
    
    UIButton *hideKeyBoardBtn;
    
}
@property (nonatomic, strong)UIView * argueDetailView;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * titleArray;/**< 有几件商品,商品的图片名字和商品名字*/


@end

@implementation ArgueViewController

#pragma mark - Getter

- (UITableView *)tableView
{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - 64 - 44);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 420;
        _tableView.separatorStyle=UITableViewCellSelectionStyleNone;
        [_tableView registerClass:[ArgueCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
//
        self.dataArray = [@[] mutableCopy];
    
        NSArray *goodsinfo=[self.dataDic valueForKey:@"goodsinfo"];
        for (int i = 0; i < goodsinfo.count; i++) {
            NSDictionary *dic=[goodsinfo objectAtIndex:i];
            ArgueModel * model = [[ArgueModel alloc] init];
            
            if ([dic isKindOfClass:[NSDictionary class]]) {
                model.goodsName=[NSString stringWithFormat:@"%@",[dic valueForKey:@"subject"]];
                model.goodsPrice=[NSString stringWithFormat:@"%@",[dic valueForKey:@"single_price"]];
                model.picurl=[NSString stringWithFormat:@"%@",[dic valueForKey:@"picurl"]];
                model.goodsPrice=[NSString stringWithFormat:@"%@",[dic valueForKey:@"single_price"]];
                model.aid=[NSString stringWithFormat:@"%@",[dic valueForKey:@"aid"]];
//                model.adviceStr=@"";
            }
            
            [self.dataArray addObject:model];
       }
    }

    return _dataArray;
}

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
   
    self.view.backgroundColor = WHITE_COLOR;
    self.title = @"评价商品";
    self.titleArray = @[@[@"", @"半亩花田超小颗粒海藻面膜保湿 免洗清洁收缩毛孔"]];
    [self.view addSubview:self.tableView];
    
    
    [self creatBottomView];
    


    
    hideKeyBoardBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    hideKeyBoardBtn .backgroundColor=[UIColor clearColor];
    hideKeyBoardBtn.layer.cornerRadius=0;
    [hideKeyBoardBtn addTarget:self action:@selector(missKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hideKeyBoardBtn];
    
    hideKeyBoardBtn.hidden=YES;
   
    
    
}

-(void)missKeyBoard{
    [self.view endEditing:YES];
    hideKeyBoardBtn.hidden=YES;

}

   


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (void)creatBottomView
{
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT-44-64, UI_SCREEN_WIDTH, 44)];
    bottomView.backgroundColor = WHITE_COLOR;
    [self.view addSubview:bottomView];
    
    UIButton*btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 12, 20, 20);
    [btn setImage:[UIImage imageNamed:@"icon_cart_nomal@2x.png"] forState:UIControlStateNormal];
    isNiMing = 1;
    
    btn.tag = 100;
    [btn addTarget:self action:@selector(niMingArgue:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:btn];
  
    UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame)+5, 12, 90, 20)];
    nameLabel.text = @"匿名评价";
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor colorFromHexCode:@"858688"];

    [bottomView addSubview:nameLabel];
    
    
    UIButton*faBiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    faBiaoBtn.frame = CGRectMake(UI_SCREEN_WIDTH-100, 0, 110, 45);
    [faBiaoBtn setTitle:@"发表评价"  forState:UIControlStateNormal];
    [faBiaoBtn setTitleColor:Red_Color forState:UIControlStateNormal];
    faBiaoBtn.layer.borderColor = Red_Color.CGColor;
    faBiaoBtn.layer.borderWidth = 1;
    faBiaoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    faBiaoBtn.backgroundColor = [UIColor colorFromHexCode:@"feeeca"];
    [faBiaoBtn addTarget:self action:@selector(faBiao) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:faBiaoBtn];
    
}
- (void)niMingArgue:(UIButton *)sender
{
    sender = (UIButton *)[self.view viewWithTag:100];
    if (isNiMing == 1) {
       [sender setImage:[UIImage imageNamed:@"icon_cart_pressed@2x.png"] forState:UIControlStateNormal];
        isNiMing = 0;
    }else{
        [sender setImage:[UIImage imageNamed:@"icon_cart_nomal@2x.png"] forState:UIControlStateNormal];
        isNiMing = 1;
    }
}
- (void)faBiao
{
    [self commitComment];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArgueCell * cell = (ArgueCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell assignmentWithModel:self.dataArray[indexPath.row]];
    cell.argueView.argueTextView.delegate=self;
    cell.argueView.argueTextView.tag=indexPath.row;
    return cell;
}


# pragma mark -
# pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    textView.placeHolderTextView.hidden = YES;
    // if (self.textViewDelegate) {
    //
    // }
    hideKeyBoardBtn.hidden=NO;
    
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger index=textView.tag;
    ArgueModel *model=[self.dataArray objectAtIndex:index];
    model.adviceStr=textView.text;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text && [textView.text isEqualToString:@""]) {
        textView.placeHolderTextView.hidden = NO;
    }
    hideKeyBoardBtn.hidden=YES;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 375;
}

#pragma mark - UITableViewDelegate

#pragma mark - ArgueCellDelegate

- (void)getCellNewData:(NSArray *)dataArray objecte:(id)cell
{
    ArgueCell * selectedCell = cell;
    NSIndexPath * indexPahth = [self.tableView indexPathForCell:selectedCell];
    [self.dataArray replaceObjectAtIndex:indexPahth.row withObject:selectedCell];
#pragma 对cell对应的数组进行替换
    
}



-(void)commitComment{
    for (int i=0; i<self.dataArray.count; i++) {
        ArgueModel *model=[self.dataArray objectAtIndex:i];
        
        if ( model.totalValueNum==0 || model.consultNum==0|| model.descriptionNum==0|| model.speedNum==0) {
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"输入不完整,请填写相关信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
       
    }
    
    
    NSMutableArray *commentArr=[[NSMutableArray alloc] initWithCapacity:0];
    
    NSMutableArray *imgArr=[[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<self.dataArray.count; i++) {
        
        ArgueModel *model=[self.dataArray objectAtIndex:i];
        //选填 默认好评
        NSString *content=[model.adviceStr isValid]?[NSString stringWithFormat:@"%@",model.adviceStr]:@"好评";
        NSString *noname=[NSString stringWithFormat:@"%d",isNiMing];
        NSString *all_star=[NSString stringWithFormat:@"%ld",model.totalValueNum];
        NSString *desc_star=[NSString stringWithFormat:@"%ld",model.descriptionNum];
        NSString *deliver_star=[NSString stringWithFormat:@"%ld",model.speedNum];
        NSString *service_star=[NSString stringWithFormat:@"%ld",model.consultNum];
        
        NSDictionary *oneCommentDic=@{@"content":content,
                               @"noname":noname,
                               @"all_star":all_star,
                               @"desc_star":desc_star,
                               @"deliver_star":deliver_star,
                               @"service_star":service_star,
                               @"aid":model.aid
                               };
        [commentArr addObject:oneCommentDic];
        
        
        if (model.goodsImage!=nil) {
            UIImage *img=model.goodsImage;
            NSString *imgName=[NSString stringWithFormat:@"picurl[%@][]",model.aid];
            NSDictionary *onePictureDic=@{@"img":img,
                                          @"imgName":imgName
                                          };
            [imgArr addObject:onePictureDic];
        }
    }
    
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:commentArr
                                                options:kNilOptions error:&error];
   
    
    
    //评论的数组
    NSDictionary *params=@{@"type":@"add",
                           @"order_id":self.orderID,
                           @"comment_content":[[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding]
                           };
//    picurl加【商品id】然后再加【】
    //图片处理
    [self UpLoad:imgArr withObj:params];
}

//上传图片
-(void)UpLoad:(NSArray *)imgArr  withObj:(NSDictionary *)params
{
    [SVProgressHUD show];
    
    NSString *url=MOBILE_SERVER_URL(@"comment.php");
    //NSString *url = @"http://qyw46281.my3w.com/mobile/api/fabuxuqiu.php";
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    //NSString *BOUNDARY = @"******";
    //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"******";
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    
    
    
    NSDictionary *newparams = [[NSDictionary alloc]  initWithDictionary:params];
    
    
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //参数的集合的所有key的集合
    //遍历keys
    for (id key in newparams){
        //得到当前key
        //添加分界线，换行
        [body appendFormat:@"%@\r\n",MPboundary];
        //添加字段名称，换2行
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
        //添加字段的值
        [body appendFormat:@"%@\r\n",[newparams objectForKey:key]];
        
    }
    //将body字符串转化为UTF8格式的二进制
    //开始标示符
    //[body appendFormat:@"%@\r\n",MPboundary];
    NSLog(@"文本内容%@",body);
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    for (int i = 0; i < imgArr.count ; i++) {
        //要上传的图片
        //得到图片的data
        NSDictionary *dic=[imgArr objectAtIndex:i];
        UIImage *img = [dic valueForKey:@"img"];
        //        NSData* data = UIImagePNGRepresentation(img);
        NSData* data = UIImageJPEGRepresentation(img, 0.5);
        
        NSMutableString *tempbodystr = [[NSMutableString alloc] initWithCapacity:0];
        [tempbodystr appendFormat:@"%@\r\n",MPboundary];
        //声明pic字段，文件名为boris.png
        [tempbodystr appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"test.png\"\r\n",[dic valueForKey:@"imgName"]];
        //声明上传文件的格式
        [tempbodystr appendFormat:@"Content-Type: image/png\r\n\r\n"];
        NSLog(@"拼接的字符串是%@",tempbodystr);
        //将body字符串转化为UTF8格式的二进制
        [myRequestData appendData:[tempbodystr dataUsingEncoding:NSUTF8StringEncoding]];
        //将image的data加入
        [myRequestData appendData:data];
        NSString *imgend = [NSString stringWithFormat:@"\r\n"];
        [myRequestData appendData:[imgend dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%d", [myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    DLog(@"body %@",body);
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        DLog(@"result:%@",responseObject);
        
        NSString *status=(NSString *)[responseObject objectForKey:@"status"];
        if ([status intValue] == 1) {
            [SVProgressHUD dismissWithSuccess:@"提交成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        else{
            if ([responseObject objectForKey:@"info"]) {
                [SVProgressHUD dismissWithError:[responseObject objectForKey:@"info"]];
            }else{
                [SVProgressHUD dismissWithError:@"网络错误"];
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"错误-----%@-----",operation.responseString);
        [SVProgressHUD dismissWithError:@"网络异常"];
    }];
    [op start];
    
    
}


@end
