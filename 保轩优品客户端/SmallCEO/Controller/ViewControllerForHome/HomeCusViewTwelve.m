//
//  HomeCusViewTwelve.m
//  WanHao
//
//  Created by Cai on 14-9-19.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "HomeCusViewTwelve.h"
#import "UIImage+FlatUI.h"
#define S_Height  92.0
#define row_width 0.0
#define Item_Height 92.0
#define Item_Width  92.0

#define CUR_Btn_Tag     500


#define smallbtn_Width 155.0
#define smallbtn_Heigth 80

#define left_width 5.0
#define titlebtn_width 140.0
#define rigth_view_width    192.0
#define itembtn_width   56.0
#define itembtn_height  25.0
#define shu_width 4.0

#define allbtn_width  183.0
#define default_title_length 1
#define btn_bian_width 5.0
#define btn_new_width 61.0
#define btn_between 2.0

#define t_arrow_title_space 2.0
#define t_title_img_space 2.0
#define t_font_size 13.0
#define t_logo_img_width 13.0

@implementation HomeCusViewTwelve

- (id)initWithFrame:(CGRect)frame tbackcolor:(NSString *)tcolor imgbackcolor:(NSString *)imgbackcolor contentDic:(NSDictionary *)cdic
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor  = [UIColor whiteColor];
        
        NSDictionary *tempdic = [[NSDictionary alloc] initWithDictionary:cdic];
        
        UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(row_width, 0.0, self.frame.size.width - row_width *2.0,S_Height)];
        vi.backgroundColor = [UIColor whiteColor];
        vi.layer.masksToBounds = YES;
        
        [self addSubview:vi];
        
        
        UIView *contentview0 = [[UIView alloc] initWithFrame:CGRectMake(row_width, 0.0, Item_Width, Item_Height)];
        contentview0.backgroundColor = [UIColor clearColor];
        [self addSubview:contentview0];
        
        UIButton *itemBtn0 = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn0.frame = CGRectMake(0.0, 0.0, contentview0.frame.size.width, contentview0.frame.size.height);
        itemBtn0.backgroundColor = [UIColor clearColor];
        [itemBtn0 addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        itemBtn0.tag = CUR_Btn_Tag + 0;
        [contentview0 addSubview:itemBtn0];
        
        _itemImg0 = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, Item_Width, Item_Height)];
        _itemImg0.backgroundColor = [UIColor clearColor];
//        _itemImg0.contentMode = UIViewContentModeScaleAspectFit;
        [contentview0 addSubview:_itemImg0];
        
        
        UIView *contentview1 = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - row_width - 0.5 - rigth_view_width, _titleLab.frame.size.height+_titleLab.frame.origin.y+0.5, rigth_view_width, S_Height - 2.0)];
        contentview1.backgroundColor = [UIColor clearColor];
        [self addSubview:contentview1];
        
        //自适应
        NSString *titlestr = [NSString stringWithFormat:@"%@",[cdic objectForKey:@"title"]];
        int titlelength = titlestr.length;
        
        float titleview_width = 6.0+t_arrow_title_space+titlelength*t_font_size+t_title_img_space+t_logo_img_width;
        if (titleview_width >= rigth_view_width) {
            titleview_width = rigth_view_width;
        }
        
        UIView *titleview = [[UIView alloc] initWithFrame:CGRectMake(rigth_view_width-titleview_width, 0.0,titleview_width, 25.0)];
        titleview.backgroundColor = [UIColor colorFromHexCode:[NSString stringWithFormat:@"%@",[cdic objectForKey:@"title_color"]]];
        [contentview1 addSubview:titleview];
        
        
        
        UIImageView *arrowimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 6, 25.0)];
        arrowimg.image = [UIImage imageNamed:@"home_arrowlight.png"];
        arrowimg.backgroundColor = [UIColor clearColor];
        [titleview addSubview:arrowimg];
        
        //自适应文本长度
        float namelength = titlelength * t_font_size;
        if (namelength >= 160.0) {
            namelength = 160.0;
        }
        
        _kindNameLab = [[UILabel alloc] initWithFrame:CGRectMake(arrowimg.frame.size.width+arrowimg.frame.origin.x+t_arrow_title_space, 0.0, namelength, 25)];
        _kindNameLab.textColor = [UIColor whiteColor];
        _kindNameLab.font = [UIFont systemFontOfSize:t_font_size];
        _kindNameLab.backgroundColor = [UIColor clearColor];
        [titleview addSubview:_kindNameLab];
        
        
        UIImageView *titleimg = [[UIImageView alloc] initWithFrame:CGRectMake(_kindNameLab.frame.size.width+_kindNameLab.frame.origin.x + 1.0, 6.0, 13.0, 13.0)];
        NSString *title_logostr = [NSString stringWithFormat:@"%@",[tempdic objectForKey:@"title_logo"]];
        if (title_logostr != nil && title_logostr.length > 0) {
            [titleimg setImageWithURL:[NSURL URLWithString:title_logostr]];
        }
        titleimg.backgroundColor = [UIColor clearColor];
        titleimg.contentMode = UIViewContentModeScaleAspectFit;
        [titleview addSubview:titleimg];
        //        [contentview1 addSubview:titleimg];
        
        UIButton *kindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        kindBtn.frame = CGRectMake(0.0, 0.0, titleview.frame.size.width, titleview.frame.size.height);
        kindBtn.backgroundColor = [UIColor clearColor];
        [kindBtn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        kindBtn.tag = CUR_Btn_Tag + 1;
        [titleview addSubview:kindBtn];
        
        //        NSLog(@"%d",[cdic objectForKey:@"title_color"].);
        UIImage *himg = [UIImage imageWithColor:[UIColor colorFromHexCode:[NSString stringWithFormat:@"%@",[cdic objectForKey:@"title_color"]]] cornerRadius:0.0];
        UIImage *stateimg = [UIImage imageWithColor:[UIColor whiteColor] cornerRadius:0.0];
        
        _itemBtn0 = [UIButton buttonWithType:UIButtonTypeCustom];
        _itemBtn0.frame = CGRectMake(left_width , _kindNameLab.frame.size.height+_kindNameLab.frame.origin.y + 5.0,itembtn_width, itembtn_height);
        _itemBtn0.backgroundColor = [UIColor whiteColor];
        [_itemBtn0 setBackgroundImage:stateimg forState:UIControlStateNormal];
        [_itemBtn0 setBackgroundImage:himg forState:UIControlStateHighlighted];
        _itemBtn0.layer.borderColor = [UIColor colorFromHexCode:[NSString stringWithFormat:@"%@",[cdic objectForKey:@"title_color"]]].CGColor;
        _itemBtn0.layer.borderWidth = 0.5f;
        [_itemBtn0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_itemBtn0.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [_itemBtn0 addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _itemBtn0.tag = CUR_Btn_Tag + 2;
        [contentview1 addSubview:_itemBtn0];
        
        
        _itemBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _itemBtn1.layer.borderColor = [UIColor colorFromHexCode:[NSString stringWithFormat:@"%@",[cdic objectForKey:@"title_color"]]].CGColor;
        _itemBtn1.layer.borderWidth = 0.5f;
        [_itemBtn1 setBackgroundImage:stateimg forState:UIControlStateNormal];
        [_itemBtn1 setBackgroundImage:himg forState:UIControlStateHighlighted];
        [_itemBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _itemBtn1.frame = CGRectMake(left_width +itembtn_width + btn_between, _kindNameLab.frame.size.height+_kindNameLab.frame.origin.y + 5.0,itembtn_width, itembtn_height);
        [_itemBtn1.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        _itemBtn1.backgroundColor = [UIColor whiteColor];
        [_itemBtn1 addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _itemBtn1.tag = CUR_Btn_Tag + 3;
        [contentview1 addSubview:_itemBtn1];
        
        
        
        
        _itemBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_itemBtn2.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [_itemBtn2 setBackgroundImage:stateimg forState:UIControlStateNormal];
        [_itemBtn2 setBackgroundImage:himg forState:UIControlStateHighlighted];
        _itemBtn2.layer.borderColor = [UIColor colorFromHexCode:[NSString stringWithFormat:@"%@",[cdic objectForKey:@"title_color"]]].CGColor;
        _itemBtn2.layer.borderWidth = 0.5f;
        [_itemBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _itemBtn2.frame = CGRectMake(left_width +itembtn_width + btn_between+itembtn_width + btn_between, _kindNameLab.frame.size.height+_kindNameLab.frame.origin.y + 5.0,itembtn_width, itembtn_height);
        _itemBtn2.backgroundColor = [UIColor whiteColor];
        [_itemBtn2 addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _itemBtn2.tag = CUR_Btn_Tag + 4;
        [contentview1 addSubview:_itemBtn2];
        
        
        
        
        _itemBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _itemBtn3.frame = CGRectMake(left_width , _kindNameLab.frame.size.height+_kindNameLab.frame.origin.y + 5.0+itembtn_height + shu_width,itembtn_width, itembtn_height);
        [_itemBtn3 setBackgroundImage:stateimg forState:UIControlStateNormal];
        [_itemBtn3 setBackgroundImage:himg forState:UIControlStateHighlighted];
        _itemBtn3.backgroundColor = [UIColor whiteColor];
        _itemBtn3.layer.borderColor = [UIColor colorFromHexCode:[NSString stringWithFormat:@"%@",[cdic objectForKey:@"title_color"]]].CGColor;
        _itemBtn3.layer.borderWidth = 0.5f;
        [_itemBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_itemBtn3.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [_itemBtn3 addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _itemBtn3.tag = CUR_Btn_Tag + 5;
        [contentview1 addSubview:_itemBtn3];
        
        
        _itemBtn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_itemBtn4 setBackgroundImage:stateimg forState:UIControlStateNormal];
        [_itemBtn4 setBackgroundImage:himg forState:UIControlStateHighlighted];
        _itemBtn4.layer.borderColor = [UIColor colorFromHexCode:[NSString stringWithFormat:@"%@",[cdic objectForKey:@"title_color"]]].CGColor;
        _itemBtn4.layer.borderWidth = 0.5f;
        [_itemBtn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _itemBtn4.frame = CGRectMake(left_width +itembtn_width + btn_between, _kindNameLab.frame.size.height+_kindNameLab.frame.origin.y + 5.0+itembtn_height + shu_width,itembtn_width, itembtn_height);
        _itemBtn4.backgroundColor = [UIColor whiteColor];
        [_itemBtn4.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [_itemBtn4 addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _itemBtn4.tag = CUR_Btn_Tag + 6;
        [contentview1 addSubview:_itemBtn4];
        
        
        _itemBtn5 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_itemBtn5 setBackgroundImage:stateimg forState:UIControlStateNormal];
        [_itemBtn5 setBackgroundImage:himg forState:UIControlStateHighlighted];
        _itemBtn5.frame = CGRectMake(left_width +itembtn_width + btn_between+itembtn_width + btn_between, _kindNameLab.frame.size.height+_kindNameLab.frame.origin.y + 5.0+itembtn_height + shu_width,itembtn_width, itembtn_height);
        _itemBtn5.backgroundColor = [UIColor whiteColor];
        [_itemBtn5.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        _itemBtn5.layer.borderColor = [UIColor colorFromHexCode:[NSString stringWithFormat:@"%@",[cdic objectForKey:@"title_color"]]].CGColor;
        _itemBtn5.layer.borderWidth = 0.5f;
        [_itemBtn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_itemBtn5 addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _itemBtn5.tag = CUR_Btn_Tag + 7;
        [contentview1 addSubview:_itemBtn5];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}


-(void)itemBtnClick:(UIButton *)clickbtn
{
    
    if ([self.custwelveDelegate respondsToSelector:@selector(cusTwelveitemButton:CurView:)]) {
        [self.custwelveDelegate cusTwelveitemButton:clickbtn CurView:self];
    }
    
}

-(void)twelveViewLaodDatas:(NSDictionary *)tempDic
{
    //_itemnameLab0.text = [[[tempDic objectForKey:@"content"] objectAtIndex:0] objectForKey:@"title"];
    
    _itemBtn0.hidden = YES;
    _itemBtn1.hidden = YES;
    _itemBtn2.hidden = YES;
    _itemBtn3.hidden = YES;
    _itemBtn4.hidden = YES;
    _itemBtn5.hidden = YES;
    
    if (![[tempDic objectForKey:@"content"] isKindOfClass:[NSArray class]]) {
        return;
    }
    
    NSArray *contentArr = [tempDic objectForKey:@"content"];
    if (contentArr.count == 0) {
        return;
    }
    
    NSString *icon_url0 = [NSString stringWithFormat:@"%@",[tempDic objectForKey:@"picurl"]];
    [_itemImg0 setImageWithURL:[NSURL URLWithString:icon_url0]];
    
    _kindNameLab.text = [tempDic objectForKey:@"title"];
    
    NSArray *tempArr = [[NSArray alloc] initWithArray:[tempDic objectForKey:@"content"]];
    
    
    
    
    
    if (tempArr.count == 1) {
        NSString *curtitle1 = [[[tempDic objectForKey:@"content"] objectAtIndex:0] objectForKey:@"title"];
        float curtitlelength1 = (float)curtitle1.length;
        float alllength1 = curtitlelength1 + default_title_length * 2;
        float scale1 = curtitlelength1/alllength1;
        
        _itemBtn0.frame = CGRectMake(btn_bian_width, _itemBtn0.frame.origin.y, scale1*allbtn_width, itembtn_height);
        
    }
    if (tempArr.count == 2) {
        NSString *curtitle1 = [[[tempDic objectForKey:@"content"] objectAtIndex:0] objectForKey:@"title"];
        float curtitlelength1 = (float)curtitle1.length;
        NSString *curtitle2 = [[[tempDic objectForKey:@"content"] objectAtIndex:1] objectForKey:@"title"];
        float curtitlelength2 = (float)curtitle2.length;
        float alllength = curtitlelength1 + curtitlelength2 +default_title_length ;
        float scale1 = curtitlelength1/alllength;
        float scale2 = curtitlelength2/alllength;
        
        _itemBtn0.frame = CGRectMake(btn_bian_width, _itemBtn0.frame.origin.y, scale1*allbtn_width, itembtn_height);
        _itemBtn1.frame = CGRectMake(_itemBtn0.frame.size.width+_itemBtn0.frame.origin.x+btn_between, _itemBtn1.frame.origin.y, scale2*allbtn_width, itembtn_height);
        
    }
    if (tempArr.count == 3) {
        NSString *curtitle1 = [[[tempDic objectForKey:@"content"] objectAtIndex:0] objectForKey:@"title"];
        float curtitlelength1 = (float)curtitle1.length;
        NSString *curtitle2 = [[[tempDic objectForKey:@"content"] objectAtIndex:1] objectForKey:@"title"];
        float curtitlelength2 = (float)curtitle2.length;
        NSString *curtitle3 = [[[tempDic objectForKey:@"content"] objectAtIndex:2] objectForKey:@"title"];
        float curtitlelength3 = (float)curtitle3.length;
        float alllength = curtitlelength1 + curtitlelength2 +curtitlelength3 ;
        float scale1 = curtitlelength1/alllength;
        float scale2 = curtitlelength2/alllength;
        float scale3 = curtitlelength3/alllength;
        
        _itemBtn0.frame = CGRectMake(btn_bian_width, _itemBtn0.frame.origin.y, scale1*allbtn_width, itembtn_height);
        _itemBtn1.frame = CGRectMake(_itemBtn0.frame.size.width+_itemBtn0.frame.origin.x+btn_between, _itemBtn1.frame.origin.y, scale2*allbtn_width, itembtn_height);
        _itemBtn2.frame = CGRectMake(_itemBtn1.frame.size.width+_itemBtn1.frame.origin.x+btn_between, _itemBtn1.frame.origin.y, scale3*allbtn_width, itembtn_height);
        
    }
    
    if (tempArr.count == 4) {
        NSString *curtitle1 = [[[tempDic objectForKey:@"content"] objectAtIndex:0] objectForKey:@"title"];
        float curtitlelength1 = (float)curtitle1.length;
        NSString *curtitle2 = [[[tempDic objectForKey:@"content"] objectAtIndex:1] objectForKey:@"title"];
        float curtitlelength2 = (float)curtitle2.length;
        NSString *curtitle3 = [[[tempDic objectForKey:@"content"] objectAtIndex:2] objectForKey:@"title"];
        float curtitlelength3 = (float)curtitle3.length;
        float alllength = curtitlelength1 + curtitlelength2 +curtitlelength3 ;
        float scale1 = curtitlelength1/alllength;
        float scale2 = curtitlelength2/alllength;
        float scale3 = curtitlelength3/alllength;
        
        _itemBtn0.frame = CGRectMake(btn_bian_width, _itemBtn0.frame.origin.y, scale1*allbtn_width, itembtn_height);
        _itemBtn1.frame = CGRectMake(_itemBtn0.frame.size.width+_itemBtn0.frame.origin.x+btn_between, _itemBtn1.frame.origin.y, scale2*allbtn_width, itembtn_height);
        _itemBtn2.frame = CGRectMake(_itemBtn1.frame.size.width+_itemBtn1.frame.origin.x+btn_between, _itemBtn2.frame.origin.y, scale3*allbtn_width, itembtn_height);
        
        NSString *curtitle4 = [[[tempDic objectForKey:@"content"] objectAtIndex:3] objectForKey:@"title"];
        float curtitlelength4 = (float)curtitle4.length;
        float alllength2 = curtitlelength4 + default_title_length * 2;
        float scale4 = curtitlelength4/alllength2;
        
        _itemBtn3.frame = CGRectMake(btn_bian_width, _itemBtn3.frame.origin.y, scale4*allbtn_width, itembtn_height);
    }
    
    
    if (tempArr.count == 5) {
        NSString *curtitle1 = [[[tempDic objectForKey:@"content"] objectAtIndex:0] objectForKey:@"title"];
        float curtitlelength1 = (float)curtitle1.length;
        NSString *curtitle2 = [[[tempDic objectForKey:@"content"] objectAtIndex:1] objectForKey:@"title"];
        float curtitlelength2 = (float)curtitle2.length;
        NSString *curtitle3 = [[[tempDic objectForKey:@"content"] objectAtIndex:2] objectForKey:@"title"];
        float curtitlelength3 = (float)curtitle3.length;
        float alllength = curtitlelength1 + curtitlelength2 +curtitlelength3 ;
        float scale1 = curtitlelength1/alllength;
        float scale2 = curtitlelength2/alllength;
        float scale3 = curtitlelength3/alllength;
        
        _itemBtn0.frame = CGRectMake(btn_bian_width, _itemBtn0.frame.origin.y, scale1*allbtn_width, itembtn_height);
        _itemBtn1.frame = CGRectMake(_itemBtn0.frame.size.width+_itemBtn0.frame.origin.x+btn_between, _itemBtn1.frame.origin.y, scale2*allbtn_width, itembtn_height);
        _itemBtn2.frame = CGRectMake(_itemBtn1.frame.size.width+_itemBtn1.frame.origin.x+btn_between, _itemBtn1.frame.origin.y, scale3*allbtn_width, itembtn_height);
        
        NSString *curtitle4 = [[[tempDic objectForKey:@"content"] objectAtIndex:3] objectForKey:@"title"];
        float curtitlelength4 = (float)curtitle4.length;
        NSString *curtitle5 = [[[tempDic objectForKey:@"content"] objectAtIndex:4] objectForKey:@"title"];
        float curtitlelength5 = (float)curtitle5.length;
        
        float alllength2 = curtitlelength4 + curtitlelength5 +default_title_length ;
        
        float scale4 = curtitlelength4/alllength2;
        float scale5 = curtitlelength5/alllength2;
        
        _itemBtn3.frame = CGRectMake(btn_bian_width, _itemBtn3.frame.origin.y, scale4*allbtn_width, itembtn_height);
        _itemBtn4.frame = CGRectMake(_itemBtn3.frame.size.width+_itemBtn3.frame.origin.x+btn_between, _itemBtn4.frame.origin.y, scale5*allbtn_width, itembtn_height);
    }
    
    if (tempArr.count >= 6) {
        NSString *curtitle1 = [[[tempDic objectForKey:@"content"] objectAtIndex:0] objectForKey:@"title"];
        float curtitlelength1 = (float)curtitle1.length;
        NSString *curtitle2 = [[[tempDic objectForKey:@"content"] objectAtIndex:1] objectForKey:@"title"];
        float curtitlelength2 = (float)curtitle2.length;
        NSString *curtitle3 = [[[tempDic objectForKey:@"content"] objectAtIndex:2] objectForKey:@"title"];
        float curtitlelength3 = (float)curtitle3.length;
        float alllength = curtitlelength1 + curtitlelength2 +curtitlelength3 ;
        float scale1 = curtitlelength1/alllength;
        float scale2 = curtitlelength2/alllength;
        float scale3 = curtitlelength3/alllength;
        
        _itemBtn0.frame = CGRectMake(btn_bian_width, _itemBtn0.frame.origin.y, scale1*allbtn_width, itembtn_height);
        _itemBtn1.frame = CGRectMake(_itemBtn0.frame.size.width+_itemBtn0.frame.origin.x+btn_between, _itemBtn1.frame.origin.y, scale2*allbtn_width, itembtn_height);
        _itemBtn2.frame = CGRectMake(_itemBtn1.frame.size.width+_itemBtn1.frame.origin.x+btn_between, _itemBtn1.frame.origin.y, scale3*allbtn_width, itembtn_height);
        
        NSString *curtitle4 = [[[tempDic objectForKey:@"content"] objectAtIndex:3] objectForKey:@"title"];
        float curtitlelength4 = (float)curtitle4.length;
        NSString *curtitle5 = [[[tempDic objectForKey:@"content"] objectAtIndex:4] objectForKey:@"title"];
        float curtitlelength5 = (float)curtitle5.length;
        NSString *curtitle6 = [[[tempDic objectForKey:@"content"] objectAtIndex:5] objectForKey:@"title"];
        float curtitlelength6 = (float)curtitle6.length;
        
        float alllength2 = curtitlelength4 + curtitlelength5 +curtitlelength6 ;
        
        float scale4 = curtitlelength4/alllength2;
        float scale5 = curtitlelength5/alllength2;
        float scale6 = curtitlelength6/alllength2;
        
        _itemBtn3.frame = CGRectMake(btn_bian_width, _itemBtn3.frame.origin.y, scale4*allbtn_width, itembtn_height);
        _itemBtn4.frame = CGRectMake(_itemBtn3.frame.size.width+_itemBtn3.frame.origin.x+btn_between, _itemBtn4.frame.origin.y, scale5*allbtn_width, itembtn_height);
        _itemBtn5.frame = CGRectMake(_itemBtn4.frame.size.width+_itemBtn4.frame.origin.x+btn_between, _itemBtn5.frame.origin.y, scale6*allbtn_width, itembtn_height);
    }
    
    
    
    
    
    
    if (tempArr.count >= 1) {
        _itemBtn0.hidden = NO;
        [_itemBtn0 setTitle:[NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:0] objectForKey:@"title"]] forState:UIControlStateNormal];
    }
    if (tempArr.count >= 2) {
        _itemBtn1.hidden = NO;
        [_itemBtn1 setTitle:[NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:1] objectForKey:@"title"]] forState:UIControlStateNormal];
    }
    if (tempArr.count >= 3) {
        _itemBtn2.hidden = NO;
        [_itemBtn2 setTitle:[NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:2] objectForKey:@"title"]] forState:UIControlStateNormal];
    }
    if (tempArr.count >= 4) {
        _itemBtn3.hidden = NO;
        [_itemBtn3 setTitle:[NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:3] objectForKey:@"title"]] forState:UIControlStateNormal];
    }
    if (tempArr.count >= 5) {
        _itemBtn4.hidden = NO;
        [_itemBtn4 setTitle:[NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:4] objectForKey:@"title"]] forState:UIControlStateNormal];
    }
    if (tempArr.count >= 6) {
        _itemBtn5.hidden = NO;
        [_itemBtn5 setTitle:[NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:5] objectForKey:@"title"]] forState:UIControlStateNormal];
    }
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
