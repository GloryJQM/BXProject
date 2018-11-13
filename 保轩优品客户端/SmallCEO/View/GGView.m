//
//  GGView.m
//  Lemuji
//
//  Created by chensanli on 15/7/16.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "GGView.h"
#import "ShopCartCell.h"

@interface GGView ()<UITextFieldDelegate>
{
    UIView *TfBackView;
    UILabel *warningLabel;
}
@property (nonatomic, strong) ShopCartCell *topCellView;
@property (nonatomic,assign)GGViewType viewType;

@end

@implementation GGView
@synthesize closeBtn;
- (void)missKeyBoard {
    [self endEditing:YES];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (!TfBackView) {
        TfBackView = [[UIView alloc]init];
    }
    TfBackView.frame = CGRectMake(0, - UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    TfBackView.backgroundColor = [UIColor grayColor];
    TfBackView.alpha = 0.4f;;
    TfBackView.userInteractionEnabled = YES;
    [TfBackView addTarget:self action:@selector(missKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:TfBackView];
    
    if (!warningLabel) {
        warningLabel = [[UILabel alloc] init];
    }
    warningLabel.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 30);
    warningLabel.font = [UIFont systemFontOfSize:14.0];
    warningLabel.textAlignment = NSTextAlignmentCenter;
    warningLabel.text = @"轻触灰色区域隐藏键盘";
    warningLabel.textColor = [UIColor whiteColor];
    textField.inputAccessoryView = warningLabel;
    
    TfBackView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    self.frame = CGRectMake(0, -216 + 44, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    TfBackView.frame = CGRectMake(0, -UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    
    if (textField.text.length < 1 || textField.text.length > 3|| [textField.text isEqualToString:@"0"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:App_Alert_Notice_Title message:@"您输入的数量有误,请重输(大于0,小于1000)" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        self.numbersTf.text = @"1";
    }
    int num = [textField.text intValue];
    if (self.canBuyNum <= num && self.canBuyNum != 0) {
        NSString *msg = [NSString stringWithFormat:@"该产品限购%d件",self.canBuyNum];
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
        self.numbersTf.text = [NSString stringWithFormat:@"%d",self.canBuyNum];
    }
    
    if([self.delegate respondsToSelector:@selector(goodsCountChanged:)])
    {
        [self.delegate goodsCountChanged:[self.numbersTf.text integerValue]];
    }
    
}

-(instancetype)initWith:(NSArray *)array andUpView:(UIView *)upView andBottomView:(UIView *)bottomView andHeight:(float)height andFrame:(CGRect)frame withGGViewType:(GGViewType)type
{
    self = [super init];
    if(self)
    {
        self.viewType = type;
        self.topCellView = (ShopCartCell *)upView;
        self.numberLabelInTopView = [[UILabel alloc] initWithFrame:CGRectMake(self.topCellView.frame.size.width - 60, CGRectGetMaxY(self.topCellView.priceLab.frame) + 20, 50, 22)];
        self.numberLabelInTopView.font = [UIFont systemFontOfSize:13];
        self.numberLabelInTopView.textAlignment = NSTextAlignmentCenter;
        self.numberLabelInTopView.backgroundColor = LINE_SHALLOW_COLOR;
        [self addObserver:self forKeyPath:@"numbersTf.text" options:NSKeyValueObservingOptionNew context:nil];
        //        [self.topCellView addSubview:self.numberLabelInTopView];
        [self setFrame:frame];
        self.userInteractionEnabled=YES;
        
        closeBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
        closeBtn .backgroundColor=[UIColor clearColor];
        closeBtn.layer.cornerRadius=0;
        [self addSubview:closeBtn];
        
        UIView *backView=[[UIView alloc] initWithFrame:self.bounds];
        backView.backgroundColor=[UIColor whiteColor];
        [self addSubview:backView];
        
        
        self.backgroundColor=[UIColor clearColor];
        //默认偏移为0
        self.guigeOffsetY=0;
        
        self.labs = [NSMutableArray array];
        [self addSubview:upView];
        
        //创建规格选择View
        CGFloat midViewHeight = frame.size.height - upView.frame.size.height - bottomView.frame.size.height-60;
        midView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, upView.frame.size.height, UI_SCREEN_WIDTH, midViewHeight)];
        [self addSubview:midView];
        
        float nowHight = 0.0;
        
        for(int k = 0;k<array.count;k++)
        {
            
            UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(0, nowHight, UI_SCREEN_WIDTH, 0)];
            
            UIView* line = [[UIView alloc]initWithFrame:CGRectMake(15, 0, UI_SCREEN_WIDTH-30, 1)];
            line.backgroundColor = LINE_SHALLOW_COLOR;
            [backView addSubview:line];
            
            UILabel* nameLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 150, 20)];
            nameLab.text = [array[k] objectForKey:@"name"];
            nameLab.font = [UIFont systemFontOfSize:14];
            [backView addSubview:nameLab];
            
            float x = 0;
            int row = 0;
            int num = 1;
            float allLength = 0;
            float nowLength = 15;
            
            NSMutableArray* subGuige = [[NSMutableArray alloc] initWithCapacity:0];
            [subGuige addObjectsFromArray: [array[k] objectForKey:@"data"]];
            
            
            for(int i = 0;i<subGuige.count;i++)
            {
                NSString* str = (NSString*)[subGuige[i] objectForKey:@"name"];
                UILabel* lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 35)];
                lab.font = [UIFont systemFontOfSize:12];
                lab.textAlignment = NSTextAlignmentCenter;
                //                lab.layer.borderColor = LINE_SHALLOW_COLOR.CGColor;
                //                lab.layer.borderWidth = 1.0;
                lab.layer.cornerRadius = 6.0;
                lab.backgroundColor = [UIColor colorFromHexCode:@"f2f2f2"];
                lab.textColor = [UIColor colorFromHexCode:@"aaa9a9"];
                
                lab.tag = 10000*k + i;
                lab.layer.masksToBounds = YES;
                if ([[subGuige[i] objectForKey:@"select"] longValue] == 1)
                {
                    lab.backgroundColor = App_Main_Color;
                    lab.textColor = [UIColor whiteColor];
                    //                    lab.layer.borderColor = App_Main_Color.CGColor;
                }
                else if ([[subGuige[i] objectForKey:@"select"] longValue] == 0 &&
                         type == GGViewTypeWithoutSelectSpecification)
                {
                    lab.backgroundColor = [UIColor colorFromHexCode:@"d9d9d9"];
                    lab.textColor = [UIColor colorFromHexCode:@"4e5f6f"];
                }
                
                [backView addSubview:lab];
                [self.labs addObject:lab];
                
                lab.userInteractionEnabled = YES;
                UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLab:)];
                [lab addGestureRecognizer:tap];
                
                
                lab.text = str;
                CGSize size = [lab sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH-60, 35)];
                
                x = size.width + 30;
                allLength = nowLength + x + 15;
                
                if(allLength < UI_SCREEN_WIDTH)
                {
                    [lab setFrame:CGRectMake(nowLength, row*50+30, (size.width+30), 35)];
                    nowLength = allLength;
                    
                }else
                {
                    row++;
                    nowLength = 30 + x;
                    [lab setFrame:CGRectMake(15, row*50+30, (size.width+30), 35)];
                    num = 0;
                    allLength = 0;
                }
            }
            float a = (row+1) * 50+30;
            
            backView.frame =CGRectMake(0, nowHight, UI_SCREEN_WIDTH, a);
            
            [midView addSubview:backView];
            
            nowHight = nowHight + a;
            DLog(@"nowHeigth:%f",nowHight);
        }
        
        midView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, nowHight);
        
        //规格改变的高度
        self.guigeOffsetY=0;
        //规格内容不够多要修改
        if (nowHight<midViewHeight) {
            
            self.guigeOffsetY=midViewHeight-nowHight;
            midView.frame=CGRectMake(midView.frame.origin.x, midView.frame.origin.y+self.guigeOffsetY, midView.frame.size.width, midView.frame.size.height);
            upView.frame=CGRectMake(upView.frame.origin.x, upView.frame.origin.y+self.guigeOffsetY, upView.frame.size.width, upView.frame.size.height);
            backView.frame=CGRectMake(backView.frame.origin.x, backView.frame.origin.y+self.guigeOffsetY, backView.frame.size.width, backView.frame.size.height);
        }
        
        //创建数量选择
        numView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - bottomView.frame.size.height - 60, UI_SCREEN_WIDTH, 60)];
        numView.backgroundColor = WHITE_COLOR;
        
        UILabel *choseNameLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 150, 30)];
        choseNameLab.text = @"购买数量";
        choseNameLab.font = [UIFont systemFontOfSize:14];
        [numView addSubview:choseNameLab];
        
        UIView * tempNumView = [[UIView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-20-200, 15, 140, 30)];
        //        tempNumView.backgroundColor = [UIColor cyanColor];
        tempNumView.layer.borderWidth = 1;
        tempNumView.layer.borderColor = LINE_SHALLOW_COLOR.CGColor;
        tempNumView.layer.cornerRadius = 5;
        [numView addSubview:tempNumView];
        
        for(int i = 0;i<2;i++)
        {
            UIView* line = [[UIView alloc]initWithFrame:CGRectMake(15, 0+i*59, UI_SCREEN_WIDTH-30, 1)];
            line.backgroundColor = LINE_SHALLOW_COLOR;
            [numView addSubview:line];
            UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(100*i, 0, 40, 30)];
            btn.tag = i;
            [btn setBackgroundColor:WHITE_COLOR];
            [btn addTarget:self action:@selector(choseNum:) forControlEvents:UIControlEventTouchUpInside];
            if(i==0)
            {
                [btn setImage:[UIImage imageNamed:@"csl_minus.png"] forState:UIControlStateNormal];
            }else if(i==1)
            {
                [btn setImage:[UIImage imageNamed:@"csl_plus.png"] forState:UIControlStateNormal];
            }
            [tempNumView addSubview:btn];
        }
        
        UITextField* numTf = [[UITextField alloc]initWithFrame:CGRectMake(40, 0, 60, 30)];
        self.numbersTf = numTf;
        numTf.keyboardType = UIKeyboardTypeNumberPad;
        numTf.userInteractionEnabled = YES;
        numTf.delegate = self;
        numTf.backgroundColor = WHITE_COLOR;
        numTf.textAlignment = NSTextAlignmentCenter;
        numTf.text = @"1";
        numTf.font = [UIFont systemFontOfSize:13];
        [tempNumView addSubview:numTf];
        
        for (int i = 0; i < 2; i++) {
            UIView * line = [[UIView alloc] initWithFrame:CGRectMake(40 + 60 * i, 0, 1, 30)];
            line.backgroundColor = LINE_SHALLOW_COLOR;
            [tempNumView addSubview:line];
        }
        
        
        [self addSubview:numView];
        
        bottomView.userInteractionEnabled=YES;
        [self addSubview:bottomView];
    }
    return self;
}

-(void)choseNum:(UIButton* )btn
{
    if(btn.tag == 0)
    {
        if([self.numbersTf.text integerValue] > 1)
        {
            self.numbersTf.text = [NSString stringWithFormat:@"%d",[self.numbersTf.text intValue]-1];
        }
    }
    else
    {
        int num = [self.numbersTf.text intValue];
        if (self.canBuyNum <= num  && self.canBuyNum != 0) {
            NSString *msg = [NSString stringWithFormat:@"该产品限购%d件",self.canBuyNum];
            UIAlertView *alt = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alt show];
        }else {
            self.numbersTf.text = [NSString stringWithFormat:@"%d",[self.numbersTf.text intValue]+1];
        }
    }
    if([self.delegate respondsToSelector:@selector(goodsCountChanged:)])
    {
        [self.delegate goodsCountChanged:[self.numbersTf.text integerValue]];
    }
}



-(void)clickLab:(id)sender
{
    if([self.delegate respondsToSelector:@selector(outWhichOne:)])
    {
        UILabel* lab = (UILabel*)[sender view];
        long sel = lab.tag;
        //x 为多类规格里父类规格所在的位置
        //y 为一类规格里子类规格所在的位置
        long x = sel/10000;
        long y = sel%10000;
        
        
        for(UILabel* myLab in self.labs)
        {
            long m = myLab.tag/10000;
            long n = myLab.tag%10000;
            
            if(x == m && y == n)
            {
                myLab.backgroundColor = App_Main_Color;
                myLab.textColor = WHITE_COLOR;
                //                myLab.layer.borderColor = App_Main_Color.CGColor;
            }else if(x == m && y != n)
            {
                myLab.backgroundColor = [UIColor colorFromHexCode:@"f2f2f2"];
                myLab.textColor = [UIColor colorFromHexCode:@"aaa9a9"];
                //                myLab.layer.borderColor = LINE_SHALLOW_COLOR.CGColor;
            }
        }
        [self.delegate outWhichOne:sel];
    }
    
}

-(void)setUserCanTouch:(BOOL)bol{
    for (UIView *view in midView.subviews) {
        view.userInteractionEnabled=bol;
    }
    numView.userInteractionEnabled=bol;
}

- (void)hideSomeViewForGoodsListWithSumPrice:(CGFloat)sumPrice
{
    numView.hidden = YES;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.frame) - 30, UI_SCREEN_WIDTH - 30, 30)];
    label.textAlignment = NSTextAlignmentRight;
    
    NSString* thStr =[NSString stringWithFormat:@"合计: %.2f", sumPrice];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:thStr attributes:nil];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"6a6a6a"] range:NSMakeRange(0,3)];
    [str addAttribute:NSForegroundColorAttributeName value:Red_Color range:NSMakeRange(3,thStr.length-3)];
    label.attributedText = str;
    
    [self addSubview:label];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"numbersTf.text"])
    {
        if (self.viewType == GGViewTypeWithoutSelectSpecification)
        {
            self.numberLabelInTopView.text = [NSString stringWithFormat:@"数量%@", self.numbersTf.text];
            self.numberLabelInTopView.backgroundColor = [UIColor clearColor];
        }
        else
        {
            self.numberLabelInTopView.text = self.numbersTf.text;
        }
    }
}

#pragma mark -
- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"numbersTf.text"];
}

@end
