//
//  ShopCartCell.m
//  Lemuji
//
//  Created by quanmai on 15/7/16.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//
#import "ShopCartCell.h"
#import "NumSelectView.h"

@interface ShopCartCell() <UIScrollViewDelegate>{
    
}

@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)NSMutableArray *deleteButtonStatusArray;
@property (nonatomic, strong)UIButton *deleteButton;


@end

@implementation ShopCartCell
@synthesize imageArrowView;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 60, 0, 60, 106)];
        [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [self.deleteButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [self.deleteButton setBackgroundColor:Red_Color];
        [self addSubview:self.deleteButton];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 106)];
        self.scrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH + 60, 106);
        self.scrollView.delegate = self;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [self addSubview:self.scrollView];
        
        UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 106)];
        maskView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:maskView];
        UIButton *realDeleteButton = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH, 0, 60, 106)];
        [realDeleteButton addTarget:self action:@selector(clickDeleteButton:) forControlEvents:UIControlEventTouchDown];
        [self.scrollView addSubview:realDeleteButton];
        
        self.choseComBtn=[[UIButton alloc] initWithFrame:CGRectMake( 15, 31, 20, 20)];
        self.choseComBtn .backgroundColor=[UIColor clearColor];
        self.choseComBtn.layer.cornerRadius=0;
        [self.choseComBtn setImage:[UIImage imageNamed:@"s_pay_is.png"] forState:UIControlStateNormal];
        [self.choseComBtn setImage:[UIImage imageNamed:@"fen_pay.png"] forState:UIControlStateSelected];
        self.choseComBtn.hidden = YES;
        [self.choseComBtn addTarget:self action:@selector(choseCommodity:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:self.choseComBtn];
        
        
        UIImageView *imageV=[[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 80, 80)];
        imageV.backgroundColor=[UIColor whiteColor];
        imageV.layer.cornerRadius=0;
        imageV.image=[UIImage imageNamed:@""];
        [self.scrollView addSubview:imageV];
        self.picImg = imageV;
        
        nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(110, 15, UI_SCREEN_WIDTH-110-78, 15)];
        nameLabel.hidden = YES;
        nameLabel.textColor = [UIColor colorFromHexCode:@"4e5f6f"];
        nameLabel.font=[UIFont boldSystemFontOfSize:15];
        nameLabel.text=@"";
        nameLabel.backgroundColor=[UIColor clearColor];
        [self.scrollView addSubview:nameLabel];
        self.nameLab = nameLabel;
        
        UIButton *btnForName = [[UIButton alloc] initWithFrame:nameLabel.frame];
        btnForName .backgroundColor=[UIColor clearColor];
        [btnForName addTarget:self action:@selector(clickNameLabel:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btnForName];
        
        
        
        UILabel *attrLabel=[[UILabel alloc] initWithFrame:CGRectMake(110, 35, UI_SCREEN_WIDTH-110-30, 45)];
        attrLabel.textColor=[UIColor lightGrayColor];
        attrLabel.numberOfLines = 0;
        attrLabel.font=[UIFont systemFontOfSize:14];
        attrLabel.backgroundColor=[UIColor clearColor];
        [self.scrollView addSubview:attrLabel];
        self.thLab = attrLabel;
        
        
        
        imageArrowView=[[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-16-78, 50, 8, 15)];
        imageArrowView.backgroundColor=[UIColor clearColor];
        imageArrowView.layer.cornerRadius=0;
        imageArrowView.contentMode=UIViewContentModeCenter;
        imageArrowView.image=[UIImage imageNamed:@"csl_arrow_down.png"];
        [self.scrollView addSubview:imageArrowView];
        
        UIButton *btnI1=[[UIButton alloc] initWithFrame:attrLabel.frame];
        btnI1 .backgroundColor=[UIColor clearColor];
        [btnI1 addTarget:self action:@selector(selectAttr:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btnI1];
        
        self.numChangeV=[[ShopCartNumChangeView alloc] initWithFrame:CGRectMake(110, 45, UI_SCREEN_WIDTH-110-78, 24)];
        self.numChangeV.textF.delegate=self;
        [self.scrollView addSubview:self.numChangeV];
        
        UILabel *moneyLable=[[UILabel alloc] initWithFrame:CGRectMake(110, 15, UI_SCREEN_WIDTH-120, 20)];
        moneyLable.textColor=Red_Color;
        moneyLable.textAlignment=NSTextAlignmentLeft;
        moneyLable.font=[UIFont boldSystemFontOfSize:16];
        moneyLable.backgroundColor=[UIColor clearColor];
        [self.scrollView addSubview:moneyLable];
        self.priceLab = moneyLable;
        
        self.numSelect=[[NumSelectView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-57, 45, 47, 24)];
        [self.scrollView addSubview:self.numSelect];
        [self.numSelect setText:@"1"];
        
        self.finishBtn=[[UIButton alloc] initWithFrame:self.numSelect.frame];
        self.finishBtn.backgroundColor=[UIColor whiteColor];
        [self.finishBtn addTarget:self action:@selector(finishEdit:) forControlEvents:UIControlEventTouchUpInside];
        [self.finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [self.finishBtn setTitleColor:[UIColor colorFromHexCode:@"fc2a33"] forState:UIControlStateNormal];
        self.finishBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [self.scrollView addSubview:self.finishBtn];
        
        self.exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.exitBtn.frame = CGRectMake(UI_SCREEN_WIDTH-15-20, 15, 20, 20);
        [self.exitBtn setBackgroundImage:[UIImage imageNamed:@"button-guanbi@2x"] forState:UIControlStateNormal];
        [self.scrollView addSubview:self.exitBtn];
    }
    return self;
}


-(void)selectAttr:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(selectAttrAtIndex:)]) {
        [self.delegate selectAttrAtIndex:self.tag];
    }
}

-(void)clickNameLabel:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(selectNameLabel:)]) {
        [self.delegate selectNameLabel:self.tag];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(beginEditWithIndex:)]) {
        [self.delegate beginEditWithIndex:self.tag];
    }
}


-(void)finishEdit:(UIButton *)btn{
    self.myDic[@"num"]=[NSString stringWithFormat:@"%@",[self.numChangeV getNewNum]];
    //点击完成获取到numchangeview得内容
    if ([self.delegate respondsToSelector:@selector(changeCommodityNumWithIndex:num:)]) {
        [self.delegate changeCommodityNumWithIndex:self.tag num:[self.numChangeV getNewNum]];
    }
}


-(void)updateWithDic:(NSMutableDictionary *)dic isEdit:(BOOL)bol{
    self.myDic=dic;
    nameLabel.text=[NSString stringWithFormat:@"%@",self.myDic[@"title"]];
    [self.numSelect setText:[NSString stringWithFormat:@"%@",self.myDic[@"num"]]];
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"picurl"]]];
    [self.picImg af_setImageWithURL:url];
    
    NSString *is_point_type = [NSString stringWithFormat:@"%@", [dic objectForKey:@"is_point_type"]];
    if ([is_point_type isEqualToString:@"1"]) {
        self.priceLab.text = [NSString stringWithFormat:@"积分: %2f", [[self.myDic objectForKey:@"price_single"] floatValue]];
    }else {
        self.priceLab.text = [NSString stringWithFormat:@"单价: ￥%.2f", [[self.myDic objectForKey:@"price_single"] floatValue]];
    }
    
    
    //购物车选中状态
    NSString *select=[NSString stringWithFormat:@"%@",[self.myDic valueForKey:@"select"]];
    self.choseComBtn.selected = [select isEqualToString:@"1"];
    [self.numChangeV setInitialText:[NSString stringWithFormat:@"%@",self.myDic[@"num"]]];
    self.numChangeV.hidden = !bol;
    self.finishBtn.hidden = !bol;
    
    if (dic[@"specification"])
    {
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:dic[@"specification"]];
        NSInteger offset = 0;
        NSArray *strArray = [dic[@"specification"] componentsSeparatedByString:@" "];
        for (int i = 0; i < strArray.count; i++)
        {
            NSRange range = NSMakeRange(offset, [[strArray objectAtIndex:i] length]);
            [attrString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:range];
            [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"686868"] range:range];
            offset += ([[strArray objectAtIndex:i] length] + 1);
        }
        
        self.thLab.attributedText = attrString;
    }
}

/*商品清单*/
-(void)updateWithDicFromGoodList:(NSMutableDictionary *)dic isEdit:(BOOL)bol{
    self.myDic=dic;
    nameLabel.text=[NSString stringWithFormat:@"%@",self.myDic[@"subject"]];
    [self.numSelect setText:[NSString stringWithFormat:@"%@",self.myDic[@"count"]]];
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"picurl"]]];
    [self.picImg af_setImageWithURL:url];
    
    NSString *is_point_type = [NSString stringWithFormat:@"%@", [dic objectForKey:@"is_point_type"]];
    if (bol) {
        if ([is_point_type isEqualToString:@"1"]) {
            self.priceLab.text = [NSString stringWithFormat:@"积分: %.f", [[self.myDic objectForKey:@"single_price"] floatValue]];
        }else {
            self.priceLab.text = [NSString stringWithFormat:@"单价: ￥%.2f", [[self.myDic objectForKey:@"single_price"] floatValue]];
        }
        
    }else{
        
        if ([is_point_type isEqualToString:@"1"]) {
            self.priceLab.text = [NSString stringWithFormat:@"积分: %.f", [[self.myDic objectForKey:@"price"] floatValue]];
        }else {
            self.priceLab.text = [NSString stringWithFormat:@"单价: ￥%.2f", [[self.myDic objectForKey:@"price"] floatValue]];
        }
        
    }
    //购物车选中状态
    NSString *select=[NSString stringWithFormat:@"%@",[self.myDic valueForKey:@"select"]];
    self.choseComBtn.selected = [select isEqualToString:@"1"];
    [self.numChangeV setInitialText:[NSString stringWithFormat:@"%@",self.myDic[@"count"]]];
    self.numChangeV.hidden = YES;
    self.finishBtn.hidden = YES;
    imageArrowView.hidden=YES;
    
    if ([dic[@"attr"] isKindOfClass:[NSArray class]])
    {
        NSArray *tempArr=dic[@"attr"];
        //        NSMutableString *tempM=[[NSMutableString alloc] initWithString:@""];
        NSString *tempM=[tempArr componentsJoinedByString:@" "];
        //        for (int i=0; i<tempArr.count; i++) {
        //            [tempM appendString:[NSString stringWithFormat:@"%@",[tempArr objectAtIndex:i]]];
        //        }
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:tempM];
        NSInteger offset = 0;
        NSArray *strArray = [tempM componentsSeparatedByString:@" "];
        for (int i = 0; i < strArray.count; i++)
        {
            NSRange range = NSMakeRange(offset, [[strArray objectAtIndex:i] length]);
            [attrString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:range];
            [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"686868"] range:range];
            offset += ([[strArray objectAtIndex:i] length] + 1);
        }
        
        self.thLab.attributedText = attrString;
        
    }
}


#pragma mark -
-(void)choseCommodity:(UIButton *)btn {
    btn.selected = !btn.selected;
    self.myDic[@"select"] = btn.selected ? @"1" : @"0";
    if ([self.delegate respondsToSelector:@selector(selectStatusDidchange:)])
    {
        [self.delegate selectStatusDidchange:self.tag];
    }
}

-(void)updataWhenOnly:(NSDictionary *)dic
{
    nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"pro_subject"]];
    
    NSString *is_point_type = [NSString stringWithFormat:@"%@", [dic objectForKey:@"is_point_type"]];
    if ([is_point_type isEqualToString:@"1"]) {
        self.priceLab.text = [NSString stringWithFormat:@"积分: %.f",[[dic objectForKey:@"gonghuo_price"] floatValue]];
    }else {
        self.priceLab.text = [NSString stringWithFormat:@"单价: ￥%.2f",[[dic objectForKey:@"gonghuo_price"] floatValue]];
    }
    
    
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"pro_picurl"]]];
    [self.picImg af_setImageWithURL:url];
    self.thLab.text = @"";
    imageArrowView.hidden=YES;
}


-(void)updataWhenHome:(NSDictionary *)dic
{
    nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"subject"]];
    
    
    NSString *is_point_type = [NSString stringWithFormat:@"%@", [dic objectForKey:@"is_point_type"]];
    if ([is_point_type isEqualToString:@"1"]) {
        self.priceLab.text = [NSString stringWithFormat:@"积分: %.f",[[dic objectForKey:@"gonghuo_price"] floatValue]];
    }else {
        self.priceLab.text = [NSString stringWithFormat:@"单价: ￥%.2f",[[dic objectForKey:@"gonghuo_price"] floatValue]];
    }
    
    
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"picurl"]]];
    DLog(@"in url %@",url);
    [self.picImg af_setImageWithURL:url];
    imageArrowView.hidden=YES;
    
}
-(void)updataWhenClassify:(NSDictionary*)dic {
    nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"goods_name"]];
    NSString *is_point_type = [NSString stringWithFormat:@"%@", [dic objectForKey:@"is_point_type"]];
    if ([is_point_type isEqualToString:@"1"]) {
        self.priceLab.text = [NSString stringWithFormat:@"积分: %.f",[[dic objectForKey:@"goods_price"] floatValue]];
    }else {
        self.priceLab.text = [NSString stringWithFormat:@"单价: ￥%.2f",[[dic objectForKey:@"goods_price"] floatValue]];
    }
    
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"goods_img"]]];
    DLog(@"in url %@",url);
    [self.picImg af_setImageWithURL:url];
    imageArrowView.hidden=YES;
}
-(void)setGGWith:(NSString *)one andTwo:(NSString *)two andThree:(NSString *)three
{
    DLog(@"in cell");
    if([two isEqualToString:@""] && [three isEqualToString:@""] && [one isEqualToString:@""])
    {
        self.thLab.text = @"";
    }else if([two isEqualToString:@""] && [three isEqualToString:@""])
    {
        NSString* thStr = [NSString stringWithFormat:@"已选 : \"%@\"",one];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:thStr attributes:nil];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"686868"] range:NSMakeRange(0,thStr.length)];
        //        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0,thStr.length)];
        
        self.thLab.attributedText = str;
    }else if([three isEqualToString:@""])
    {
        NSString* thStr = [NSString stringWithFormat:@"已选 : \"%@\"  \"%@\"",one,two];
        
        //        NSString* str1 = one;
        //
        //        NSString* str2 = two;
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:thStr attributes:nil];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"686868"] range:NSMakeRange(0,thStr.length)];
        
        //        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0,str1.length)];
        //
        //        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(str1.length+2,str2.length)];
        
        self.thLab.attributedText = str;
    }else
    {
        NSString* thStr = [NSString stringWithFormat:@"已选 : \"%@\"  \"%@\"  \"%@\"",one,two,three];
        
        //        NSString* str1 = one;
        //
        //        NSString* str2 = two;
        //
        //        NSString* str3 = three;
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:thStr attributes:nil];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"686868"] range:NSMakeRange(0,thStr.length)];
        //        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0,str1.length)];
        //        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(str1.length+2,str2.length)];
        //        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(str1.length + str2.length+4,str3.length)];
        
        self.thLab.attributedText = str;
    }
}
- (void)setGGWith:(NSString *)guigeStr {
    if ([guigeStr isEqualToString:@""]) {
        self.thLab.text = @"";
    }else {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:guigeStr attributes:nil];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"686868"] range:NSMakeRange(0,guigeStr.length)];
        self.thLab.attributedText = str;
    }
}
//根据字体长度设置labTitle宽度
- (float)getLengthWithStr:(NSString *)str {
    CGRect rect = [str boundingRectWithSize:CGSizeMake(15, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} context:nil];
    
    return ceilf(rect.size.height);
}
- (void)resetDeleteButtonStatus:(NSInteger)status
{
    if (status == 0)
    {
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
    }
    else if (status == 1)
    {
        [self.scrollView setContentOffset:CGPointMake(60, 0)];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)clickDeleteButton:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(clickDeleteButton:)]) {
        [self.delegate clickDeleteButton:self.tag];
    }
}

#pragma mark - UITapGestureRecognizer
- (void)pushToGoodsDetailViewController
{
    NSLog(@"UITapGestureRecognizer");
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (![self.delegate respondsToSelector:@selector(clickDeleteButton:)])
    {
        scrollView.contentSize = CGSizeMake(self.frame.size.width, 82);
        return;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGPoint point = scrollView.contentOffset;
    if (point.x >= 30)
    {
        [scrollView setContentOffset:CGPointMake(60, point.y) animated:YES];
    }
    else
    {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

@end
