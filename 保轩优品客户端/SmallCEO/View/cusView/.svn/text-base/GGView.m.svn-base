//
//  GGView.m
//  Lemuji
//
//  Created by chensanli on 15/7/16.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "GGView.h"
#import "ShopCartCell.h"

@interface GGView ()

@property (nonatomic, strong) ShopCartCell *topCellView;
@property (nonatomic,assign)GGViewType viewType;

@end

@implementation GGView
@synthesize closeBtn;

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
        [self.topCellView addSubview:self.numberLabelInTopView];
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
                lab.layer.borderColor = LINE_SHALLOW_COLOR.CGColor;
                lab.layer.borderWidth = 1.0;
                lab.layer.cornerRadius = 6.0;
                lab.tag = 10000*k + i;
                lab.layer.masksToBounds = YES;
                if ([[subGuige[i] objectForKey:@"select"] longValue] == 1)
                {
                    lab.backgroundColor = App_Main_Color;
                    lab.textColor = WHITE_COLOR;
                    lab.layer.borderColor = App_Main_Color.CGColor;
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
        choseNameLab.text = @"数量选择";
        choseNameLab.font = [UIFont systemFontOfSize:14];
        [numView addSubview:choseNameLab];
        
        for(int i = 0;i<2;i++)
        {
            UIView* line = [[UIView alloc]initWithFrame:CGRectMake(15, 0+i*59, UI_SCREEN_WIDTH-30, 1)];
            line.backgroundColor = LINE_SHALLOW_COLOR;
            [numView addSubview:line];
            
            UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH-20-140 + 100*i, 15, 40, 30)];
            btn.tag = i;
            [btn setBackgroundColor:LINE_SHALLOW_COLOR];
            [btn addTarget:self action:@selector(choseNum:) forControlEvents:UIControlEventTouchUpInside];
            if(i==0)
            {
                [btn setImage:[UIImage imageNamed:@"gj_cou.png"] forState:UIControlStateNormal];
            }else if(i==1)
            {
                [btn setImage:[UIImage imageNamed:@"gj_add.png"] forState:UIControlStateNormal];
            }
            [numView addSubview:btn];
        }
        
        UITextField* numTf = [[UITextField alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH-20-100, 15, 60, 30)];
        self.numbersTf = numTf;
        numTf.userInteractionEnabled=NO;
        numTf.backgroundColor = LINE_SHALLOW_COLOR;
        numTf.textAlignment = NSTextAlignmentCenter;
        numTf.text = @"1";
        numTf.font = [UIFont systemFontOfSize:13];
        [numView addSubview:numTf];
        
        [self addSubview:numView];
        
        bottomView.userInteractionEnabled=YES;
        [self addSubview:bottomView];
    }
    return self;
}

- (void)setSelectedSpecification
{
}

-(void)choseNum:(UIButton* )btn
{
    if(btn.tag == 0)
    {
        if([self.numbersTf.text integerValue] > 1)
        {
            self.numbersTf.text = [NSString stringWithFormat:@"%ld",[self.numbersTf.text integerValue]-1];
        }
    }
    else
    {
        self.numbersTf.text = [NSString stringWithFormat:@"%ld",[self.numbersTf.text integerValue]+1];
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
                myLab.layer.borderColor = App_Main_Color.CGColor;
            }else if(x == m && y != n)
            {
                myLab.backgroundColor = WHITE_COLOR;
                myLab.textColor = BLACK_COLOR;
                myLab.layer.borderColor = LINE_SHALLOW_COLOR.CGColor;
            }
        }
        [self.delegate outWhichOne:sel];
    }
    
}

-(void)setUserCanTouch:(BOOL)bol{
//    midView.userInteractionEnabled=bol;
    for (UIView *view in midView.subviews) {
        view.userInteractionEnabled=bol;
    }
    numView.userInteractionEnabled=bol;
}

- (void)hideSomeViewForGoodsListWithSumPrice:(CGFloat)sumPrice
{
    numView.hidden = YES;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.frame) - 30, UI_SCREEN_WIDTH - 30, 30)];
    label.text = [NSString stringWithFormat:@"合计:%.2f", sumPrice];
    label.textColor = App_Main_Color;
    label.textAlignment = NSTextAlignmentRight;
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
