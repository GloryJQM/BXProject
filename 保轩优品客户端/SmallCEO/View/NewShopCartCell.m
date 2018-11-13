//
//  NewShopCartCell.m
//  SmallCEO
//
//  Created by nixingfu on 15/9/28.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "NewShopCartCell.h"
#import "NumSelectView.h"

@interface NewShopCartCell() <UIScrollViewDelegate,ShopCartNumChangeViewDelegate>{
    
}

@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)NSMutableArray *deleteButtonStatusArray;
@property (nonatomic, strong)UIButton *deleteButton;


@end

@implementation NewShopCartCell
@synthesize imageArrowView;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 60, 0, 60, 165-9)];
//        [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
//        [self.deleteButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
//        [self.deleteButton setBackgroundColor:Red_Color];
//        [self addSubview:self.deleteButton];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 130)];
        self.scrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH , 130);
        self.scrollView.delegate = self;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [self addSubview:self.scrollView];
        
        UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 130)];
        maskView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:maskView];
        UIButton *realDeleteButton = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH, 0, 60, 130)];
        [realDeleteButton addTarget:self action:@selector(clickDeleteButton:) forControlEvents:UIControlEventTouchDown];
        [self.scrollView addSubview:realDeleteButton];
        
        self.choseComBtn=[[UIButton alloc] initWithFrame:CGRectMake( 0, 1, 35, 126)];
        self.choseComBtn .backgroundColor=[UIColor clearColor];
        self.choseComBtn.layer.cornerRadius=0;
        [self.choseComBtn setImage:[UIImage imageNamed:@"gj_pay_uns.png"] forState:UIControlStateNormal];
        [self.choseComBtn setImage:[UIImage imageNamed:@"gj_pay_is.png"] forState:UIControlStateSelected];
        [self.choseComBtn addTarget:self action:@selector(choseCommodity:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:self.choseComBtn];
        
        
        UIImageView *imageV=[[UIImageView alloc] initWithFrame:CGRectMake(36, 20, 90, 90)];
        imageV.backgroundColor=[UIColor whiteColor];
        imageV.layer.cornerRadius=0;
        imageV.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
        imageV.layer.borderWidth = 1;
        imageV.layer.masksToBounds = YES;
        imageV.image=[UIImage imageNamed:@""];
        [self.scrollView addSubview:imageV];
        self.picImg = imageV;
        
        nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(imageV.maxX + 10, 25, UI_SCREEN_WIDTH-imageV.maxX - 20, 20)];
        nameLabel.textColor=[UIColor colorFromHexCode:@"252525"];
        nameLabel.font=[UIFont boldSystemFontOfSize:15];
        nameLabel.text=@"";
        nameLabel.backgroundColor=[UIColor clearColor];
        [self.scrollView addSubview:nameLabel];
        self.nameLab = nameLabel;
        
        formatLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.x, nameLabel.maxY + 15, UI_SCREEN_WIDTH-imageV.maxX - 20, 15)];
        formatLabel.textColor=[UIColor lightGrayColor];
        formatLabel.font=[UIFont boldSystemFontOfSize:14];
        formatLabel.text=@"规格：一盒装";
        formatLabel.backgroundColor=[UIColor clearColor];
        [self.scrollView addSubview:formatLabel];
        self.formatLab = formatLabel;
        
//        UIButton *btnForName = [[UIButton alloc] initWithFrame:nameLabel.frame];
//        btnForName .backgroundColor=[UIColor clearColor];
//        [btnForName addTarget:self action:@selector(clickNameLabel:) forControlEvents:UIControlEventTouchUpInside];
//        [self.scrollView addSubview:btnForName];
        
//        UILabel *attrLabel=[[UILabel alloc] initWithFrame:CGRectMake(145, 65, UI_SCREEN_WIDTH-145-50, 20)];
//        attrLabel.textColor=[UIColor lightGrayColor];
//        attrLabel.numberOfLines = 0;
//        attrLabel.font=[UIFont systemFontOfSize:14];
//        attrLabel.backgroundColor=[UIColor clearColor];
//        [self.scrollView addSubview:attrLabel];
//        self.thLab = attrLabel;
        
        
        
//        imageArrowView=[[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-50, 45, 8, 15)];
//        imageArrowView.backgroundColor=[UIColor clearColor];
//        imageArrowView.layer.cornerRadius=0;
//        imageArrowView.contentMode=UIViewContentModeCenter;
//        imageArrowView.image=[UIImage imageNamed:@"csl_arrow_down.png"];
//        [self.scrollView addSubview:imageArrowView];
        
//        UIButton *btnI1=[[UIButton alloc] initWithFrame:attrLabel.frame];
//        btnI1 .backgroundColor=[UIColor clearColor];
//        [btnI1 addTarget:self action:@selector(selectAttr:) forControlEvents:UIControlEventTouchUpInside];
//        [self.scrollView addSubview:btnI1];
        
        
        UILabel *moneyLable=[[UILabel alloc] initWithFrame:CGRectMake(nameLabel.x, formatLabel.maxY + 10, UI_SCREEN_WIDTH-nameLabel.x - 20 - 60, 20)];
        moneyLable.textColor=App_Main_Color;
        moneyLable.textAlignment=NSTextAlignmentLeft;
        //moneyLable.font=[UIFont systemFontOfSize:14];
        moneyLable.text=@"￥0.00";
        moneyLable.font = [UIFont systemFontOfSize:14];
        [self.scrollView addSubview:moneyLable];
        self.priceLab = moneyLable;
        
//        UILabel *allmoneyLable=[[UILabel alloc] initWithFrame:CGRectMake(15, 125, UI_SCREEN_WIDTH/2.0f-15, 15)];
//        allmoneyLable.textColor=Red_Color;
//        allmoneyLable.textAlignment=NSTextAlignmentLeft;
//        allmoneyLable.font=[UIFont boldSystemFontOfSize:15];
//        allmoneyLable.text=@"小计 ￥0.00";
//        allmoneyLable.backgroundColor=[UIColor clearColor];
//        [self.scrollView addSubview:allmoneyLable];
//        self.subtotalLab = allmoneyLable;
        
        CGFloat off_X = 0;
        if (IS_IPHONE4 || IS_IPHONE5) {
            off_X = 50;
        }else {
            off_X = 65;
        }
//        self.numSelect=[[NumSelectView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-off_X, 121, 40, 24)];
//        [self.scrollView addSubview:self.numSelect];
//        [self.numSelect setText:@"1"];
        
//        self.finishBtn=[[UIButton alloc] initWithFrame:self.numSelect.frame];
//        self.finishBtn.backgroundColor=[UIColor whiteColor];
//        [self.finishBtn addTarget:self action:@selector(finishEdit:) forControlEvents:UIControlEventTouchUpInside];
//        [self.finishBtn setTitle:@"完成" forState:UIControlStateNormal];
//        [self.finishBtn setTitleColor:Red_Color forState:UIControlStateNormal];
//        self.finishBtn.titleLabel.font=[UIFont systemFontOfSize:15];
//        [self.scrollView addSubview:self.finishBtn];
        
//        for (int i = 0; i < 3; i ++) {
//            UILabel *line = [UILabel new];
//            if (i == 2) {
//                line.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 1);
//            }else {
//                line.frame = CGRectMake(0, 106+i*49, UI_SCREEN_WIDTH, 1);
//            }
//            line.backgroundColor = LINE_SHALLOW_COLOR;
//            [self.scrollView addSubview:line];
//        }
        
        UILabel *footView = [UILabel new];
        footView.frame = CGRectMake(0, 156, UI_SCREEN_WIDTH, 9);
        footView.backgroundColor = [UIColor blackColor];
        footView.backgroundColor = [UIColor colorFromHexCode:@"f8f8f8"];
        [self.scrollView addSubview:footView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClick)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)didClick{
    if ([self.delegate respondsToSelector:@selector(didClickAtIndex:)]) {
        [self.delegate didClickAtIndex:self.tag];
    }
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
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"goods_img"]]];
    [self.picImg af_setImageWithURL:url];
    self.formatLab.text = [dic objectForKey:@"goods_attr_str"];
    self.subtotalLab.text = [NSString stringWithFormat:@"小计￥%.2f", [[self.myDic objectForKey:@"price_sum"]  floatValue]];
    if (![[self.myDic objectForKey:@"price"] isEqual:[NSNull null]]) {
        if ([[dic objectForKey:@"is_point_type"] integerValue] == 1) {
            NSString *str = [NSString stringWithFormat:@"%ld", [dic[@"price"] integerValue]];
            NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",str]];
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            attch.image = [UIImage imageNamed:@"Button-jifenyue@2x"];
            attch.bounds = CGRectMake(0, -4, 20, 20);
            NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
            [attri insertAttributedString:string atIndex:0];
            self.priceLab.attributedText = attri;
        }else {
            NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥ %@元",dic[@"price"]]];
//            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
//            attch.image = [UIImage imageNamed:@"Button-jinbiyue@2x"];
//            attch.bounds = CGRectMake(0, -4, 20, 20);
//            NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
//            [attri insertAttributedString:string atIndex:0];
            self.priceLab.attributedText = attri;
        }
    }
    
    NSString * xiangouStr = [NSString stringWithFormat:@"%@",[self.myDic valueForKey:@"goods_num"]];
    if (self.numChangeV) {
        [self.numChangeV removeFromSuperview];
    }
    int num = [xiangouStr isValid] ? [xiangouStr intValue] : 0;
    self.numChangeV=[[ShopCartNumChangeView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 80, self.priceLab.y, 70, 20)];
    self.numChangeV.delegate=self;
    self.numChangeV.canBuyNum = num;
    [self.scrollView addSubview:self.numChangeV];
    
    //购物车选中状态
    NSString *select=[NSString stringWithFormat:@"%@",[self.myDic valueForKey:@"select"]];
    self.choseComBtn.selected = [select isEqualToString:@"1"];
    [self.numChangeV setInitialText:[NSString stringWithFormat:@"%@",self.myDic[@"goods_num"]]];
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
            [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"73787c"] range:range];
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
    if (bol) {
        self.priceLab.text = [NSString stringWithFormat:@"￥%@", [self.myDic objectForKey:@"single_price"]];
    }else{
        self.priceLab.text = [NSString stringWithFormat:@"￥%@", [self.myDic objectForKey:@"price"]];
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
            [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"73787c"] range:range];
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
    self.priceLab.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"gonghuo_price"]];
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"pro_picurl"]]];
    [self.picImg af_setImageWithURL:url];
    self.thLab.text = @"";
    imageArrowView.hidden=YES;
}


-(void)updataWhenHome:(NSDictionary *)dic
{
    nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"subject"]];
    self.priceLab.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"gonghuo_price"]];
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"picurl"]]];
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
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"73787c"] range:NSMakeRange(0,thStr.length)];
        //        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0,thStr.length)];
        
        self.thLab.attributedText = str;
    }else if([three isEqualToString:@""])
    {
        NSString* thStr = [NSString stringWithFormat:@"已选 : \"%@\"  \"%@\"",one,two];
        
        //        NSString* str1 = one;
        //
        //        NSString* str2 = two;
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:thStr attributes:nil];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"73787c"] range:NSMakeRange(0,thStr.length)];
        
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
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"73787c"] range:NSMakeRange(0,thStr.length)];
        //        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0,str1.length)];
        //        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(str1.length+2,str2.length)];
        //        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(str1.length + str2.length+4,str3.length)];
        
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
        scrollView.contentSize = CGSizeMake(self.frame.size.width, 165);
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
- (void)changeNumWithString:(NSString *)num{
    DLog(@"%@",num);
    DLog(@"%ld",(long)self.tag);
    if ([self.delegate respondsToSelector:@selector(changeCommodityNumWithIndex:  num:)]) {
        [self.delegate changeCommodityNumWithIndex:self.tag   num:num];
    }
    
}


@end
