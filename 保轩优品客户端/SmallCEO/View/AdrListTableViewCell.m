//
//  AdrListTableViewCell.m
//  Lemuji
//
//  Created by chensanli on 15/7/15.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "AdrListTableViewCell.h"

@implementation AdrListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.backgroundColor = WHITE_COLOR;
//        UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 90)];
//        UIButton* delBtn = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH-60-60, 0, 60, 90)];
//        [delBtn setTitle:@"删除" forState:UIControlStateNormal];
//        [delBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
//        [delBtn setBackgroundColor:Red_Color];
//        [backView addSubview:delBtn];
//        self.delBtn = delBtn;
//        // [delBtn addTarget:self action:@selector(delIt) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:backView];
//        
//        UIButton* editBtn = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH-60, 0, 60, 90)];
//        self.editBtn = editBtn;
//        editBtn.titleLabel.font = LMJ_CT 14];
//        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
//        [editBtn setTitleColor:[UIColor colorFromHexCode:@"#000000"] forState:UIControlStateNormal];
//        [editBtn setBackgroundColor:WHITE_COLOR];
//        [backView addSubview:editBtn];
//        //        [editBtn addTarget:self action:@selector(editIt) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIView* fontView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 90)];
        fontView.backgroundColor = WHITE_COLOR;
        [self addSubview:fontView];
        self.sliderView = fontView;
        
//        UISwipeGestureRecognizer* swLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(delSelf)];
//        swLeft.numberOfTouchesRequired = 1;
//        swLeft.direction = UISwipeGestureRecognizerDirectionLeft;
//        
//        [forntView addGestureRecognizer:swLeft];
//        
//        UISwipeGestureRecognizer* swRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(backSelf)];
//        swRight.numberOfTouchesRequired = 1;
//        swRight.direction = UISwipeGestureRecognizerDirectionRight;
//        
//        [forntView addGestureRecognizer:swRight];
        
        //        UIImageView* imgVi = [[UIImageView alloc]initWithFrame:CGRectMake(10, 22, 25, 25)];
        //        imgVi.image = [UIImage imageNamed:@"gj_adr1.png"];
        //        [forntView addSubview:imgVi];
        
        //        self.choseView = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH-45, 30, 25, 25)];
        //        self.choseView.image = [UIImage imageNamed:@"gj_pay_is.png"];
        //        self.choseView.userInteractionEnabled = YES;
        //        [forntView addSubview:self.choseView];
        //        self.choseView.hidden = YES;
        
        self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(12, 12, 150, 25)];
        self.nameLab.text = @"收货人：欧阳夏丹";
        //        _nameLab.backgroundColor = [UIColor yellowColor];
        self.nameLab.textColor = [UIColor colorFromHexCode:@"#505059"];
        self.nameLab.font = LMJ_XT 16];
        [fontView addSubview:self.nameLab];
        
        self.phoneLab = [[UILabel alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH-30-100, 12, 120, 25)];
        self.phoneLab.text = @"15885586655";
        self.phoneLab.textAlignment = NSTextAlignmentRight;
        self.phoneLab.textColor = [UIColor colorFromHexCode:@"#505059"];
        self.phoneLab.font = LMJ_XT 16];
        [fontView addSubview:self.phoneLab];
        
        self.adrLab = [[UILabel alloc]initWithFrame:CGRectMake(12, 40, UI_SCREEN_WIDTH-24, 40)];
        self.adrLab.text = @"收货地址:浙江省杭州市西湖文化新街道文三西路金都新城601";
        self.adrLab.numberOfLines = 0;
        //        _adrLab.backgroundColor = [UIColor cyanColor];
        self.adrLab.textColor = [UIColor colorFromHexCode:@"#505059"];
        self.adrLab.font = LMJ_XT 14];
        [fontView addSubview:self.adrLab];
        
        UIView* line = [[UIView alloc]initWithFrame:CGRectMake(15, 89, UI_SCREEN_WIDTH-15, 1)];
        line.backgroundColor = LINE_SHALLOW_COLOR;
        [fontView addSubview:line];
    }
    return self;
}

//-(void)delSelf
//{
//    Animation_Appear .2];
//    [self.sliderView setTransform:CGAffineTransformMake(1, 0, 0, 1, -120, 0)];
//    [UIView commitAnimations];
//}
//
//
//
//-(void)backSelf
//{
//    Animation_Appear .2];
//    [self.sliderView setTransform:CGAffineTransformMake(1, 0, 0, 1, 0, 0)];
//    [UIView commitAnimations];
//}

//-(void)delIt
//{
//    DLog(@"111");
//}

-(void)upDataWith:(NSDictionary *)dic
{
    if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"is_default"]] isEqualToString:@"1"])
    {
        NSString* thStr = [NSString stringWithFormat:@"[默认地址]%@%@%@",[dic objectForKey:@"area_name"],[dic objectForKey:@"address"],[dic objectForKey:@"house_number"]];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:thStr attributes:nil];
        [str addAttribute:NSForegroundColorAttributeName value:Red_Color range:NSMakeRange(0,6)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"#505059"] range:NSMakeRange(6,thStr.length-6)];
        self.adrLab.attributedText = str;
    }else
    {
        self.adrLab.text = [NSString stringWithFormat:@"收货地址:%@%@%@",[dic objectForKey:@"area_name"],[dic objectForKey:@"address"], [dic objectForKey:@"house_number"]];
    }
    self.nameLab.text = [NSString stringWithFormat:@"收货人：%@",[dic objectForKey:@"contact_name"]];
    self.phoneLab.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"phone_num"]];

    
}



@end
