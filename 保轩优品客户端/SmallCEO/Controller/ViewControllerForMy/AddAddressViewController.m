//
//  AddAddressViewController.m
//  Lemuji
//
//  Created by gaojun on 15-7-16.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "AddAddressViewController.h"
#import "PersonInforView.h"
#import "AddressSingleton.h"

@interface AddAddressViewController ()<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate,UITextViewDelegate>
{
    NSArray *provinces, *cities, *areas, *curAreas;
    UILabel *provinceLab, *cityLab, *areaLab;
    UIView *adrDetailView;
    UITextView *addressTextView;
    UIView *adrDetailLine;
    NSInteger curIndex;
    NSInteger curRow;
}

@property (nonatomic,assign)int shengId;
@property (nonatomic,assign)int shiId;
@property (nonatomic,assign)int quId;

@property (nonatomic,strong)NSString* shengName;
@property (nonatomic,strong)NSString* shiName;
@property (nonatomic,strong)NSString* quName;

@property (nonatomic,strong)UITextField* nameTf;
@property (nonatomic,strong)UITextField* phoneTf;


@property (nonatomic,assign)int isDefult;

@property (nonatomic, strong) UIWindow  *overlayWindow;
@property (nonatomic, strong) UIView    *maskView;

@end

@implementation AddAddressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"新增收货地址";
    if(self.wp == 2)
    {
        self.title = @"修改收货地址";
    }

    UIView * barLine = [[UIView  alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 1)];
    barLine.backgroundColor = LINE_DEEP_COLOR;
    
    [self.view addSubview:barLine];
    if(self.wp == 2)
    {
        UIButton * morenButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [morenButton setTitle:@"设为默认" forState:UIControlStateNormal];
        morenButton.frame = CGRectMake(UI_SCREEN_WIDTH - 80, 0, 70, 25);
        [morenButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        morenButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [morenButton addTarget:self action:@selector(goEdit) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:morenButton];
        morenButton.titleLabel.font = [UIFont systemFontOfSize:17];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    provinces = [NSArray arrayWithArray:[AddressSingleton sharedManager].sonAddressArray];
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(missKeyBoard)];
 
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [self creatView];
}

//取消键盘
-(void)missKeyBoard{
    [self.view endEditing:YES];
}
- (void)creatView
{
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 45*3)];
    [self.view addSubview:topView];
    
    NSArray *leftTitles = @[@"省份",@"城市",@"地区"];
    for (int i = 0; i < 3; i ++) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 45*i, UI_SCREEN_WIDTH, 45)];
        backView.backgroundColor = WHITE_COLOR;
        backView.tag = i;
        [topView addSubview:backView];
        
        UILabel * leftLab = [[UILabel alloc] initWithFrame:CGRectMake(13, 13, 80, 20)];
        leftLab.text = leftTitles[i];
        leftLab.font = LMJ_CT 14];
        leftLab.textColor = [UIColor colorFromHexCode:@"#8B8B94"];
        [backView addSubview:leftLab];
        
        UILabel * areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(13+80, 13, UI_SCREEN_WIDTH-80-13*2-20, 20)];
        areaLabel.font = LMJ_CT 14.5];
        areaLabel.textColor = [UIColor colorFromHexCode:@"#505059"];
        [backView addSubview:areaLabel];
        
        UIImageView * nextImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gj_jt_right.png"]];
        nextImageView.frame = CGRectMake(UI_SCREEN_WIDTH-5-15, 19, 5, 8);
        [backView addSubview:nextImageView];
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(14, 44, UI_SCREEN_WIDTH-28-15, 1)];
        line.backgroundColor = [UIColor colorFromHexCode:@"e8e8e8"];
        [backView addSubview:line];

        if (i == 0) {
            provinceLab = areaLabel;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choseProvince)];
            [backView addGestureRecognizer:tap];
        }else if (i == 1) {
            cityLab = areaLabel;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choseCity)];
            [backView addGestureRecognizer:tap];
        }else {
            areaLab = areaLabel;
            line.frame = CGRectMake(14, 44, UI_SCREEN_WIDTH-28, 1);
            line.backgroundColor = LINE_DEEP_COLOR;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choseArea)];
            [backView addGestureRecognizer:tap];
        }
    }

    NSArray * inforArray = @[@"联系电话", @"联系人"];
    for (int i = 0; i < inforArray.count; i++) {
        
        self.personInformationView = [[PersonInforView alloc] initWithFrame:CGRectMake(0, 45*3 + 44 * i,UI_SCREEN_WIDTH, 44)];

        self.personInformationView.informationLabel.text = [inforArray objectAtIndex:i];
        self.personInformationView.informationLabel.font = LMJ_CT 14];
        self.personInformationView.informationLabel.textColor = [UIColor colorFromHexCode:@"#8B8B94"];
        self.personInformationView.informationField.delegate = self;
        
        if(i==0) {
            self.phoneTf = self.personInformationView.informationField;
            self.phoneTf.keyboardType=UIKeyboardTypeNumberPad;
        }else if(i==1) {
            self.nameTf = self.personInformationView.informationField;
        }
        self.personInformationView.line.frame = CGRectMake(14, 44, UI_SCREEN_WIDTH - 28, 1);
        [self.view addSubview:_personInformationView];
    }
    
    adrDetailView = [[UIView alloc] initWithFrame:CGRectMake( 0, 45*5, UI_SCREEN_WIDTH, 45)];
    adrDetailView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:adrDetailView];
    
    UILabel *adrDetailLab = [[UILabel alloc] initWithFrame:CGRectMake(13, 12, 70, 20)];
    adrDetailLab.textColor = [UIColor colorFromHexCode:@"#8B8B94"];
    adrDetailLab.text = @"详细地址";
    adrDetailLab.font = LMJ_CT 14];
    [adrDetailView addSubview:adrDetailLab];
    
    addressTextView = [[UITextView alloc] initWithFrame:CGRectMake(13+70, 4, UI_SCREEN_WIDTH-70-26, 36)];
    addressTextView.delegate = self;
    addressTextView.font = LMJ_XT 16];
    addressTextView.textColor = SUB_TITLE;
    addressTextView.scrollEnabled = NO;
    [adrDetailView addSubview:addressTextView];
    
    UIButton *btnT=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 33)];
    btnT.backgroundColor=[UIColor colorFromHexCode:@"d9d9d9" alpha:1];
    [btnT setTitle:@"轻触此处可隐藏键盘" forState:UIControlStateNormal];
    btnT.titleLabel.font=[UIFont systemFontOfSize:14];
    [btnT setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnT addTarget:self action:@selector(hideTextView) forControlEvents:UIControlEventTouchUpInside];
    if(addressTextView.inputAccessoryView==nil){
        addressTextView.inputAccessoryView=btnT;
    }
    
    adrDetailLine = [[UIView alloc] initWithFrame:CGRectMake(14, 44, UI_SCREEN_WIDTH - 28, 1)];
    adrDetailLine.backgroundColor = [UIColor colorFromHexCode:@"e8e8e8"];
    [adrDetailView addSubview:adrDetailLine];
    
    if(self.wp == 2)
    {
        addressTextView.text = [NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"address"]];
        int width = (int)[self getLengthWithStr:addressTextView.text];
        int tvWidth = UI_SCREEN_WIDTH-70-26-15;
        int num = width/tvWidth;
        if (num >= 1) {
            adrDetailView.frame = CGRectMake( 0, 45*5, UI_SCREEN_WIDTH, 45+20*num);
            addressTextView.frame = CGRectMake(13+70, 4, UI_SCREEN_WIDTH-70-26, 36+20*num);
            adrDetailLine.frame = CGRectMake(14, 44+20*num, UI_SCREEN_WIDTH - 28, 1);
        }
        self.nameTf.text = [NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"contact_name"]];
        self.phoneTf.text = [NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"phone_num"]];
        
        
        self.shengName = [NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"province_name"]];
        self.shiName = [NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"city_name"]];
        self.quName = [NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"a_name"]];
        
        NSString *areaName = [NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"area_name"]];
        
        if (![self.shiName isValid]) {
            provinceLab.text = areaName;
            self.shengName = areaName;
            self.shiName = @"";
            self.quName = @"";
            cityLab.text = @"";
            areaLab.text = @"";
        }else {
            provinceLab.text = self.shengName;
            cityLab.text = self.shiName;
            areaLab.text = self.quName;
        }
        self.areaAllStr = [NSString stringWithFormat:@"%@%@%@",self.shengName,self.shiName,self.quName];
        
        self.quId = [[self.dataDic objectForKey:@"area_id"] intValue];
        self.shiId =  [[self.dataDic objectForKey:@"city_id"] intValue];
        
        NSString * provinceID = [NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"province_id"]];
        if ([provinceID isValid]) {
            self.shengId = [provinceID intValue];
            for (int i = 0;i < provinces.count; i++)
            {
                AddressModel *model = provinces[i];
                if (self.shengId == [model.majorID integerValue]) {
                    cities = ((AddressModel *)[provinces objectAtIndex:i]).sonAddressArray;
                    if (cities.count != 0) {
                        for (int j = 0;j < cities.count; j++)
                        {
                            AddressModel *model = cities[j];
                            if (self.shiId == [model.majorID integerValue]) {
                                areas = ((AddressModel *)[cities objectAtIndex:j]).sonAddressArray;
                                break;
                            }
                        }
                    }
                    break;
                }
            }
        }
    }
    
    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    saveBtn.frame = CGRectMake(0, UI_SCREEN_HEIGHT - 44 - 64, UI_SCREEN_WIDTH, 44);
    saveBtn.backgroundColor = App_Main_Color;
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = LMJ_CT 15.5];
    saveBtn.titleLabel.textColor = [UIColor colorFromHexCode:@"#FFFFFF"];
    [saveBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
  
}
-(void)textViewDidChange:(UITextView *)textView
{
    int width = (int)[self getLengthWithStr:addressTextView.text];
    int tvWidth = UI_SCREEN_WIDTH-70-26-15;
    int num = width/tvWidth;
    if (num >= 1) {
        adrDetailView.frame = CGRectMake( 0, 45*5, UI_SCREEN_WIDTH, 45+20*num);
        addressTextView.frame = CGRectMake(13+70, 4, UI_SCREEN_WIDTH-70-26, 36+20*num);
        adrDetailLine.frame = CGRectMake(14, 44+20*num, UI_SCREEN_WIDTH - 28, 1);
    }else {
        adrDetailView.frame = CGRectMake( 0, 45*5, UI_SCREEN_WIDTH, 45);
        addressTextView.frame = CGRectMake(13+70, 4, UI_SCREEN_WIDTH-70-26, 36);
        adrDetailLine.frame = CGRectMake(14, 44, UI_SCREEN_WIDTH - 28, 1);
    }
}
- (float)getLengthWithStr:(NSString *)str {
    CGRect rect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    return ceilf(rect.size.width);
}
- (void)hideTextView {
    [addressTextView endEditing:YES];
}

- (void)choseProvince {
    curAreas = provinces;
    curIndex = 0;
    [self areaFilter];
}
- (void)choseCity {
    if (cities.count == 0) {
        [self showAlertView:@"该地区没有城市选择"];
        return;
    }
    if ([provinceLab.text isValid]) {
        curAreas = cities;
        curIndex = 1;
        DLog(@"---%@",[NSString stringWithFormat:@"%@", ((AddressModel *)[curAreas objectAtIndex:0]).name]);
        [self areaFilter];
    }else {
        [self showAlertView:@"请选择省份"];
    }
}
- (void)choseArea {
    if (areas.count == 0) {
        [self showAlertView:@"该地区没有地区选择"];
        return;
    }
    if ([cityLab.text isValid]) {
        curAreas = areas;
        curIndex = 2;
        [self areaFilter];
    }else {
        [self showAlertView:@"请选择城市"];
    }
}
- (void)showAlertView:(NSString *)message {
    UIAlertView *art = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [art show];
}
#pragma mark - 选择地址要最终确认
- (void)billFilter
{
    [self createBillFilterView];
    [self showSelectView];
}
- (void)cancelFilter
{
    [self hideSelectView];
}

- (void)finishFilter
{
    [self hideSelectView];
    if(self.wp == 0)
    {
        [self postUpAddAdr];
    }else if(self.wp == 2)
    {
        [self postEditAdr:0];
    }
}

#pragma mark -
- (UIWindow *)overlayWindow {
    if(!_overlayWindow) {
        _overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _overlayWindow.backgroundColor = [UIColor clearColor];
        _overlayWindow.windowLevel = UIWindowLevelNormal + 1;
        _overlayWindow.userInteractionEnabled = YES;
    }
    return _overlayWindow;
}

- (void)showSelectView
{
    self.maskView.alpha = 0.7;
    self.maskView.backgroundColor = [UIColor grayColor];
    if(!self.maskView.superview)
        [self.overlayWindow insertSubview:self.maskView atIndex:0];
    
    [self.overlayWindow makeKeyAndVisible];
}

- (void)hideSelectView
{
    [self.maskView removeFromSuperview];
    self.maskView = nil;
    
    // Make sure to remove the overlay window from the list of windows
    // before trying to find the key window in that same list
    NSMutableArray *windows = [[NSMutableArray alloc] initWithArray:[UIApplication sharedApplication].windows];
    [windows removeObject:self.overlayWindow];
    [self.overlayWindow.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.overlayWindow = nil;
    
    [windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIWindow *window, NSUInteger idx, BOOL *stop) {
        if([window isKindOfClass:[UIWindow class]] && window.windowLevel == UIWindowLevelNormal) {
            [window makeKeyWindow];
            *stop = YES;
        }
    }];
}



- (void)createBillFilterView
{
    CGFloat btnHight = 0;
    CGFloat labHight = 0;
    CGFloat offHight = 0;
    int font = 0;
    BOOL isTwoLine = NO;
    
    if (IS_IPHONE4 || IS_IPHONE5) {
        font = 15;
        btnHight = 32;
        labHight = 20;
        offHight = 200;
    }else {
        font = 17;
        btnHight = 38;
        labHight = 22;
        offHight = 250;
    }

    self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(30, 100, UI_SCREEN_WIDTH-60, UI_SCREEN_HEIGHT-64-offHight+IPHONE4HEIGHT(50))];
    whiteView.backgroundColor = WHITE_COLOR;
    whiteView.layer.cornerRadius = 5;
    whiteView.layer.masksToBounds = YES;
    [self.overlayWindow addSubview:whiteView];
    
    CGFloat width = whiteView.frame.size.width;

    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 50)];
    titleView.backgroundColor = [UIColor colorFromHexCode:@"f6f6f6"];
    [whiteView addSubview:titleView];
    
    UILabel *alertTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, width, 20)];
    alertTitle.font = LMJ_XT 17];
    alertTitle.text = @"确认收货地址";
    alertTitle.textAlignment = NSTextAlignmentCenter;
    alertTitle.textColor = [UIColor colorFromHexCode:@"525252"];
    [titleView addSubview:alertTitle];
    
    NSArray *leftTextArr = @[@"联系人:",@"联系电话:",@"地区:"];
    NSArray *rightTextArr = @[[NSString stringWithFormat:@"%@",self.nameTf.text],[NSString stringWithFormat:@"%@",self.phoneTf.text],[NSString stringWithFormat:@"%@",self.areaAllStr]];
    
    for (int i = 0; i < 4; i ++) {
        
        if (i == 0 || i == 1) {
            UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 50+15+i*(labHight+5), 120, labHight)];
            leftLab.text =leftTextArr[i];
            leftLab.font = LMJ_XT font];
            leftLab.textAlignment = NSTextAlignmentLeft;
            leftLab.textColor = [UIColor colorFromHexCode:@"aaaaaa"];
            CGSize size = [leftLab sizeThatFits:CGSizeMake(FLT_MAX, labHight)];
            leftLab.frame = CGRectMake(20, 50+15+i*(labHight+5), size.width, labHight);
            [whiteView addSubview:leftLab];
            
            UILabel *rightLab = [[UILabel alloc] initWithFrame:CGRectMake(20+size.width+5, 50+15+i*(labHight+5), width-(size.width+5+20+15), labHight)];
            rightLab.text =rightTextArr[i];
            rightLab.font = LMJ_XT font];
            rightLab.textColor = App_Main_Color;
            rightLab.textAlignment = NSTextAlignmentRight;
            [whiteView addSubview:rightLab];
            
        }else  if (i == 2){
            UILabel *detailLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 50+15+i*(labHight+5), width-(20+10), labHight)];
            detailLab.font = LMJ_XT font];
            detailLab.text = [NSString stringWithFormat:@"地区: %@",self.areaAllStr];
            detailLab.textAlignment = NSTextAlignmentLeft;
            detailLab.numberOfLines = 2;
            [whiteView addSubview:detailLab];
            
            CGRect rect = [detailLab.text boundingRectWithSize:CGSizeMake(MAXFLOAT, labHight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
            if (rect.size.width >  (width-20-15)) {
                detailLab.frame = CGRectMake(20, 50+15+i*(labHight+5), width-(20+10), labHight*2);
                isTwoLine = YES;
            }
            
            NSString* oldStr = detailLab.text;
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:oldStr attributes:nil];
            [str addAttribute:NSForegroundColorAttributeName value:App_Main_Color range:NSMakeRange(4,detailLab.text.length-4)];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"aaaaaa"] range:NSMakeRange(0,3)];
            detailLab.attributedText = str;
        }else  if (i == 3){
            CGFloat off_Y = 0;
            if (isTwoLine == YES) {
                off_Y = 50+15+i*(labHight+5)+labHight;
            }else {
                off_Y = 50+15+i*(labHight+5);
            }
            UILabel *detailLab = [[UILabel alloc] initWithFrame:CGRectMake(20, off_Y, width-(20+10), labHight)];
            detailLab.font = LMJ_XT font];
            detailLab.text = [NSString stringWithFormat:@"详细地址: %@",addressTextView.text];
            detailLab.textAlignment = NSTextAlignmentLeft;
            detailLab.numberOfLines = 3;
            [whiteView addSubview:detailLab];
            
            CGRect rect = [detailLab.text boundingRectWithSize:CGSizeMake(MAXFLOAT, labHight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
            int numOfLine = rect.size.width / (width-20-15);
            if (numOfLine > 2) {
                numOfLine = 2;
            }
            if (numOfLine >= 1) {
                detailLab.frame = CGRectMake(20, off_Y, width-(20+10), labHight*(numOfLine+1));
            }
            
            NSString* oldStr = detailLab.text;
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:oldStr attributes:nil];
            [str addAttribute:NSForegroundColorAttributeName value:App_Main_Color range:NSMakeRange(6,detailLab.text.length-6)];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"aaaaaa"] range:NSMakeRange(0,5)];
            detailLab.attributedText = str;
        }
        
    }
    
    NSArray * titles = @[@"取消",@"确认"];
    for (int i = 0; i < 2; i++) {
        UIButton *leftBarButton = [[UIButton alloc] init];
        leftBarButton.frame = CGRectMake(20+i*((width-20*3)/2+20), whiteView.frame.size.height-btnHight-26+IPHONE4HEIGHT(10), (width-20*3)/2, btnHight);
        leftBarButton.titleLabel.font = LMJ_XT font];
        [leftBarButton setTitle:titles[i] forState:UIControlStateNormal];
        leftBarButton.layer.cornerRadius = 4;
        leftBarButton.layer.masksToBounds = YES;
        if (i == 0) {
            [leftBarButton addTarget:self action:@selector(cancelFilter) forControlEvents:UIControlEventTouchUpInside];
            leftBarButton.backgroundColor = WHITE_COLOR;
            [leftBarButton setTitleColor:[UIColor colorFromHexCode:@"888888"] forState:UIControlStateNormal];
            leftBarButton.layer.borderColor = [UIColor colorFromHexCode:@"dcdcdc"].CGColor;
            leftBarButton.layer.borderWidth = 1;
        }else{
            [leftBarButton addTarget:self action:@selector(finishFilter) forControlEvents:UIControlEventTouchUpInside];
            leftBarButton.backgroundColor = App_Main_Color;
            [leftBarButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        }
        [whiteView addSubview:leftBarButton];
    }
}


#pragma mark -
- (void)alertView:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
}
-(void)saveBtnClick
{
    self.nameTf.text=[self.nameTf.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    addressTextView.text=[addressTextView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.areaAllStr=[self.areaAllStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.phoneTf.text=[self.phoneTf.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([self.shengName isEqualToString:@"台湾省"] ||
        [self.shengName isEqualToString:@"香港特别行政区"] ||
        [self.shengName isEqualToString:@"澳门特别行政区"])
    {
        
    }else {
        if (![self.shiName isValid] || ![self.quName isValid]) {
            [self alertView:@"请选择完整信息"];
            return;
        }
    }
    
    if ([self.areaAllStr isEqualToString:@""] ||
        [addressTextView.text isEqualToString:@""] ||
        [self.nameTf.text isEqualToString:@""] ||
        [self.phoneTf.text isEqualToString:@""])
    {
        [self alertView:@"请选择完整信息"];
        return;
    }
    
    if([self.phoneTf.text isBeginsWith:@"1"]){
        if (self.phoneTf.text.length !=11 ) {
            [self alertView:@"手机号格式错误"];
            return;
        }
    }
    if (self.phoneTf.text.length < 4)
    {
        [self alertView:@"联系电话不规范"];
        return;
    }
    
    [self billFilter];
}

//取消键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UIPickerView的创建
- (void)areaFilter
{
    curRow = 0;
    [self creatPickView];
    [self showSelectView];
}
- (void)areaCancelFilter
{
    [self hideSelectView];
}

- (void)areaFinishFilter
{
    [self hideSelectView];

    if (curIndex == 0)
    {
        AddressModel *provinceModel = [provinces objectAtIndex:curRow];
        cities = provinceModel.sonAddressArray;
        self.shengName = [NSString stringWithFormat:@"%@", provinceModel.name];
        self.shengId = [[NSString stringWithFormat:@"%@", provinceModel.majorID] intValue];
        if (cities.count == 0)
        {
            areas = nil;
        }
        provinceLab.text = self.shengName;
        self.shiName = @"";
        self.quName = @"";
        self.shiId = 0;
        self.quId = 0;
        cityLab.text = @"";
        areaLab.text = @"";
    }
    else if (curIndex == 1 && curRow < cities.count)
    {
        AddressModel *cityModel = [cities objectAtIndex:curRow];
        areas = cityModel.sonAddressArray;
        self.shiName = [NSString stringWithFormat:@"%@", cityModel.name];
        self.shiId = [cityModel.majorID intValue];
        cityLab.text = self.shiName;
        
        self.quName = [NSString stringWithFormat:@""];
        self.quId = 0;
        areaLab.text = @"";
    }
    else if (curIndex == 2 && curRow < areas.count)
    {
        AddressModel *cityModel = [areas objectAtIndex:curRow];
        self.quName = [NSString stringWithFormat:@"%@", cityModel.name];
        self.quId = [cityModel.majorID intValue];
        areaLab.text = self.quName;
    }
    self.areaAllStr = [NSString stringWithFormat:@"%@%@%@",self.shengName,self.shiName,self.quName];
}

#pragma mark -

- (void)creatPickView
{
    self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    
    self.areaPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT-218, UI_SCREEN_WIDTH, 218)];
    _areaPickerView.dataSource = self;
    _areaPickerView.delegate = self;
    _areaPickerView.backgroundColor = WHITE_COLOR;
    [_areaView addSubview:_areaPickerView];
    [self.overlayWindow addSubview:_areaPickerView];
    
    UIToolbar *pickerToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(_areaPickerView.frame) - 40, UI_SCREEN_WIDTH, 40)];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(areaCancelFilter)];
    
    UIBarButtonItem *blankSpaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *fixedBlankSpaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedBlankSpaceButton.width = 15.0;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(areaFinishFilter)];
    
    NSArray *itemsArray = [NSArray arrayWithObjects:fixedBlankSpaceButton,leftBarButton, blankSpaceButton, rightBarButton, fixedBlankSpaceButton, nil];
    pickerToolBar.items = itemsArray;
    [self.overlayWindow addSubview:pickerToolBar];
    
    UIView *topViewInWindow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - CGRectGetHeight(_areaPickerView.frame) - CGRectGetHeight(pickerToolBar.frame))];
    [topViewInWindow addTarget:self action:@selector(hideSelectView) forControlEvents:UIControlEventTouchUpInside];
    [self.overlayWindow addSubview:topViewInWindow];
}


#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return curAreas.count;
}

//将数据显示到pickerView上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%@", ((AddressModel *)[curAreas objectAtIndex:row]).name];
}

//改变pickView上的字体大小
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    curRow = row;
}


#pragma mark - HTTP Request

-(void)postUpAddAdr
{
    [SVProgressHUD show];
    NSString*body;
    if ([self.shengName isEqualToString:@"台湾省"] ||
        [self.shengName isEqualToString:@"香港特别行政区"] ||
        [self.shengName isEqualToString:@"澳门特别行政区"])
    {
        body = [NSString stringWithFormat:@"&act=add&area_name=%@&contact_name=%@&phone_num=%@&address=%@&city_id=%d&area_id=%d&is_default=%d",self.shengName,self.nameTf.text,self.phoneTf.text,addressTextView.text,self.shengId,self.shengId,self.isDefult];
    }
    else
    {
        body=[NSString stringWithFormat:@"&act=add&area_name=%@%@%@&contact_name=%@&phone_num=%@&address=%@&city_id=%d&area_id=%d&is_default=%d&h5_uid=1409", self.shengName, self.shiName, self.quName,self.nameTf.text,self.phoneTf.text,addressTextView.text,self.shiId,self.quId,self.isDefult];
    }
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
            [self.navigationController popViewControllerAnimated:YES];
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

-(void)postEditAdr:(int)isDefult
{
    [SVProgressHUD show];
    NSString*body;
    
    if ([self.shengName isEqualToString:@"台湾省"] ||
        [self.shengName isEqualToString:@"香港特别行政区"] ||
        [self.shengName isEqualToString:@"澳门特别行政区"])
    {
        body=[NSString stringWithFormat:@"&act=edit&contact_id=%d&area_name=%@&contact_name=%@&phone_num=%@&address=%@&city_id=%d&area_id=%d&is_default=%d",self.adrId,self.shengName,self.nameTf.text,self.phoneTf.text,addressTextView.text,self.shengId,self.shengId,isDefult];
    }
    else
    {
        body=[NSString stringWithFormat:@"&act=edit&contact_id=%d&area_name=%@%@%@&contact_name=%@&phone_num=%@&address=%@&city_id=%d&area_id=%d&is_default=%d",self.adrId,self.shengName, self.shiName, self.quName,self.nameTf.text,self.phoneTf.text,addressTextView.text,self.shiId,self.quId,isDefult];
    }
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
            DLog(@"修改成功~~");
            [SVProgressHUD dismiss];
            if(self.myBlock)
            {
                if (self.isCurrent == YES) {
                    self.myBlock(0);
                }
                if (self.currentIndex != 0) {
                    self.myBlock(self.currentIndex);
                }
            }
            [self.navigationController popViewControllerAnimated:YES];
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

-(void)goEdit
{
    self.nameTf.text=[self.nameTf.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    addressTextView.text=[addressTextView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.areaAllStr=[self.areaAllStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.phoneTf.text=[self.phoneTf.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([self.shengName isEqualToString:@"台湾省"] ||
        [self.shengName isEqualToString:@"香港特别行政区"] ||
        [self.shengName isEqualToString:@"澳门特别行政区"])
    {
        
    }else {
        if (![self.shiName isValid] || ![self.quName isValid]) {
            [self alertView:@"请选择完整信息"];
            return;
        }
    }
    
    if ([self.areaAllStr isEqualToString:@""] ||
        [addressTextView.text isEqualToString:@""] ||
        [self.nameTf.text isEqualToString:@""] ||
        [self.phoneTf.text isEqualToString:@""])
    {
        [self alertView:@"请选择完整信息"];
        return;
    }
    
    if([self.phoneTf.text isBeginsWith:@"1"]){
        if (self.phoneTf.text.length !=11 ) {
            [self alertView:@"手机号格式错误"];
            return;
        }
    }
    if (self.phoneTf.text.length < 4)
    {
        [self alertView:@"联系电话不规范"];
        return;
    }

    [self postEditAdr:1];
}
@end
