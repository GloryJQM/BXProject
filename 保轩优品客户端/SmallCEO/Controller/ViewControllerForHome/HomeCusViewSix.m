//
//  HomeCusViewSix.m
//  WanHao
//
//  Created by Cai on 14-6-9.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "HomeCusViewSix.h"
#import "UIImage+FlatUI.h"

#define S_Height  106.0
#define row_width 0.0
#define Item_Height 106.0
#define Item_Width  106.0

#define CUR_Btn_Tag     600


#define smallbtn_Width 155.0
#define smallbtn_Heigth 80

#define titlebtn_width 140.0
#define left_view_width    (210.0*adapterFactor)
#define itembtn_width   201.0/3.0
#define itembtn_height  28.0

#define shu_width 4.0
#define left_width 5.0

#define allbtn_width  (201.0*adapterFactor)
#define default_title_length 1.0
#define btn_bian_width 2.0
#define btn_new_width 61.0
#define btn_between 2.0

#define t_arrow_title_space 2.0
#define t_title_img_space 2.0
#define t_font_size 15.0
#define t_logo_img_width 18.0
#define t_logo_img_height  18.0

#define titleview_height  38.0

#define t_img_rightbian_space 2.0

#define c_title_width 178.0
#define c_t_leftarrow_width 8.0

#define title_btn_updowm_space 4.0




@implementation HomeCusViewSix

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame tbackcolor:(NSString *)tcolor imgbackcolor:(NSString *)imgbackcolor contentDic:(NSDictionary *)cdic
{

    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor whiteColor];
        
        NSDictionary *tempdic = [[NSDictionary alloc] initWithDictionary:cdic];
        
        
        UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(row_width, 0.0, self.frame.size.width - row_width *2.0, S_Height)];
        vi.backgroundColor = [UIColor clearColor];
        vi.layer.masksToBounds = YES;
//        vi.layer.borderColor = [UIColor colorFromHexCode:@"#d6d6d6"].CGColor;
//        vi.layer.borderWidth = 0.5f;
        [self addSubview:vi];
        
        
        UIView *contentview0 = [[UIView alloc] initWithFrame:CGRectMake(row_width, 0.0, left_view_width, S_Height)];
        contentview0.backgroundColor = [UIColor clearColor];
        [self addSubview:contentview0];
        
        NSString *titlestr = [NSString stringWithFormat:@"%@",[cdic objectForKey:@"title"]];
        int titlelength = titlestr.length;
        
        float titleview_width = c_t_leftarrow_width+t_arrow_title_space+titlelength*t_font_size+t_title_img_space+t_logo_img_width+t_img_rightbian_space;
        if (titleview_width >= left_view_width) {
            titleview_width = left_view_width;
        }
        
        titleview = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, titleview_width, titleview_height)];
        titleview.backgroundColor = [UIColor colorFromHexCode:[NSString stringWithFormat:@"%@",[cdic objectForKey:@"title_color"]]];
        [contentview0 addSubview:titleview];
        

        
        
        
        UIImageView *titleimg = [[UIImageView alloc] initWithFrame:CGRectMake(t_img_rightbian_space, (titleview_height - t_logo_img_height)/2.0, t_logo_img_width, t_logo_img_height)];
        NSString *title_logostr = [NSString stringWithFormat:@"%@",[tempdic objectForKey:@"title_logo"]];
        if (title_logostr != nil && title_logostr.length > 0) {
            [titleimg setImageWithURL:[NSURL URLWithString:title_logostr]];
        }
        titleimg.backgroundColor = [UIColor clearColor];
        titleimg.contentMode = UIViewContentModeScaleAspectFit;
        [titleview addSubview:titleimg];
        
        float img_x = titleimg.frame.origin.x+titleimg.frame.size.width;
        if (title_logostr.length == 0) {
            titleview.frame = CGRectMake(titleview.frame.origin.x, titleview.frame.origin.y, titleview.frame.size.width - t_logo_img_width-2.0, titleview.frame.size.height);
            img_x = 0.0;
        }
        
        float namelength = titlelength * t_font_size;
        if (namelength >= c_title_width) {
            namelength = c_title_width;
        }
        
        _kindNameLab = [[UILabel alloc] initWithFrame:CGRectMake(img_x+t_arrow_title_space, 0.0, namelength, titleview_height)];
        _kindNameLab.textColor = [UIColor whiteColor];
        _kindNameLab.font = [UIFont systemFontOfSize:t_font_size];
        _kindNameLab.backgroundColor = [UIColor clearColor];
        [titleview addSubview:_kindNameLab];
        

        
        arrowimg = [[UIImageView alloc] initWithFrame:CGRectMake(_kindNameLab.frame.size.width+_kindNameLab.frame.origin.x+t_title_img_space, 0, c_t_leftarrow_width, titleview_height)];
        arrowimg.image = [UIImage imageNamed:@"home_arrowleft.png"];
        arrowimg.backgroundColor = [UIColor clearColor];
        [titleview addSubview:arrowimg];
        
        UIButton *kindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        kindBtn.frame = CGRectMake(0.0, 0.0, titleview.frame.size.width, titleview.frame.size.height);
        kindBtn.backgroundColor = [UIColor clearColor];
        [kindBtn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        kindBtn.tag = CUR_Btn_Tag + 0;
        [titleview addSubview:kindBtn];
        
        UIImage *himg = [UIImage imageWithColor:[UIColor colorFromHexCode:[NSString stringWithFormat:@"%@",[cdic objectForKey:@"title_color"]]] cornerRadius:0.0];
        UIImage *stateimg = [UIImage imageWithColor:[UIColor whiteColor] cornerRadius:0.0];
        
        _itemBtn0 = [UIButton buttonWithType:UIButtonTypeCustom];
        _itemBtn0.frame = CGRectMake(btn_bian_width , titleview.frame.size.height+titleview.frame.origin.y + title_btn_updowm_space,itembtn_width, itembtn_height);
        _itemBtn0.backgroundColor = [UIColor whiteColor];
        [_itemBtn0 setBackgroundImage:stateimg forState:UIControlStateNormal];
        [_itemBtn0 setBackgroundImage:himg forState:UIControlStateHighlighted];
        _itemBtn0.layer.borderColor = [UIColor colorFromHexCode:[NSString stringWithFormat:@"%@",[cdic objectForKey:@"title_color"]]].CGColor;
        _itemBtn0.layer.borderWidth = 0.5f;
        [_itemBtn0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_itemBtn0.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_itemBtn0 addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _itemBtn0.tag = CUR_Btn_Tag + 1;
        [contentview0 addSubview:_itemBtn0];
        
        
        _itemBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _itemBtn1.frame = CGRectMake(btn_bian_width +itembtn_width + btn_between, titleview.frame.size.height+titleview.frame.origin.y + title_btn_updowm_space,itembtn_width, itembtn_height);
        _itemBtn1.backgroundColor = [UIColor whiteColor];
        [_itemBtn1 setBackgroundImage:stateimg forState:UIControlStateNormal];
        [_itemBtn1 setBackgroundImage:himg forState:UIControlStateHighlighted];
        _itemBtn1.layer.borderColor = [UIColor colorFromHexCode:[NSString stringWithFormat:@"%@",[cdic objectForKey:@"title_color"]]].CGColor;
        _itemBtn1.layer.borderWidth = 0.5f;
        [_itemBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_itemBtn1.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_itemBtn1 addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _itemBtn1.tag = CUR_Btn_Tag + 2;
        [contentview0 addSubview:_itemBtn1];
        
        
        
        
        _itemBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _itemBtn2.frame = CGRectMake(btn_bian_width +itembtn_width + btn_between+itembtn_width + btn_between, titleview.frame.size.height+titleview.frame.origin.y + title_btn_updowm_space,itembtn_width, itembtn_height);
        _itemBtn2.backgroundColor = [UIColor whiteColor];
        [_itemBtn2 setBackgroundImage:stateimg forState:UIControlStateNormal];
        [_itemBtn2 setBackgroundImage:himg forState:UIControlStateHighlighted];
        _itemBtn2.layer.borderColor = [UIColor colorFromHexCode:[NSString stringWithFormat:@"%@",[cdic objectForKey:@"title_color"]]].CGColor;
        _itemBtn2.layer.borderWidth = 0.5f;
        [_itemBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_itemBtn2.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_itemBtn2 addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _itemBtn2.tag = CUR_Btn_Tag + 3;
        [contentview0 addSubview:_itemBtn2];
        
        
        
        
        _itemBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _itemBtn3.frame = CGRectMake(btn_bian_width , titleview.frame.size.height+titleview.frame.origin.y + title_btn_updowm_space+itembtn_height + title_btn_updowm_space,itembtn_width, itembtn_height);
        _itemBtn3.backgroundColor = [UIColor whiteColor];
        [_itemBtn3 setBackgroundImage:stateimg forState:UIControlStateNormal];
        [_itemBtn3 setBackgroundImage:himg forState:UIControlStateHighlighted];
        _itemBtn3.layer.borderColor = [UIColor colorFromHexCode:[NSString stringWithFormat:@"%@",[cdic objectForKey:@"title_color"]]].CGColor;
        _itemBtn3.layer.borderWidth = 0.5f;
        [_itemBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_itemBtn3.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_itemBtn3 addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _itemBtn3.tag = CUR_Btn_Tag + 4;
        [contentview0 addSubview:_itemBtn3];
        
        
        _itemBtn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        _itemBtn4.frame = CGRectMake(btn_bian_width +itembtn_width + btn_between, titleview.frame.size.height+titleview.frame.origin.y + title_btn_updowm_space+itembtn_height + title_btn_updowm_space,itembtn_width, itembtn_height);
        _itemBtn4.backgroundColor = [UIColor whiteColor];
        [_itemBtn4 setBackgroundImage:stateimg forState:UIControlStateNormal];
        [_itemBtn4 setBackgroundImage:himg forState:UIControlStateHighlighted];
        _itemBtn4.layer.borderColor = [UIColor colorFromHexCode:[NSString stringWithFormat:@"%@",[cdic objectForKey:@"title_color"]]].CGColor;
        _itemBtn4.layer.borderWidth = 0.5f;
        [_itemBtn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_itemBtn4.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_itemBtn4 addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _itemBtn4.tag = CUR_Btn_Tag + 5;
        [contentview0 addSubview:_itemBtn4];
        
        
        _itemBtn5 = [UIButton buttonWithType:UIButtonTypeCustom];
        _itemBtn5.frame = CGRectMake(btn_bian_width +itembtn_width + btn_between+itembtn_width + btn_between, titleview.frame.size.height+titleview.frame.origin.y + title_btn_updowm_space+itembtn_height + title_btn_updowm_space,itembtn_width, itembtn_height);
        _itemBtn5.backgroundColor = [UIColor whiteColor];
        [_itemBtn5 setBackgroundImage:stateimg forState:UIControlStateNormal];
        [_itemBtn5 setBackgroundImage:himg forState:UIControlStateHighlighted];
        _itemBtn5.layer.borderColor = [UIColor colorFromHexCode:[NSString stringWithFormat:@"%@",[cdic objectForKey:@"title_color"]]].CGColor;
        _itemBtn5.layer.borderWidth = 0.5f;
        [_itemBtn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_itemBtn5.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_itemBtn5 addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _itemBtn5.tag = CUR_Btn_Tag + 6;
        [contentview0 addSubview:_itemBtn5];
        
        
        
        UIView *contentview1 = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width  - Item_Width,0.0, Item_Width, Item_Height)];
        contentview1.backgroundColor = [UIColor clearColor];
        [self addSubview:contentview1];
        
        
        
        _itemImg0 = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, Item_Width, Item_Height)];
        _itemImg0.backgroundColor = [UIColor clearColor];
//        _itemImg0.contentMode = UIViewContentModeScaleAspectFit;
        [contentview1 addSubview:_itemImg0];
        
        UIButton *itemBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn1.frame = CGRectMake(0.0, 0.0, contentview1.frame.size.width, contentview1.frame.size.height);
        itemBtn1.backgroundColor = [UIColor clearColor];
        [itemBtn1 addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        itemBtn1.tag = CUR_Btn_Tag + 7;
        [contentview1 addSubview:itemBtn1];
    }
    return self;

}


-(void)itemBtnClick:(UIButton *)clickbtn
{
    if ([self.cussixDelegate respondsToSelector:@selector(cussixitemButton:CurView:)]) {
        [self.cussixDelegate cussixitemButton:clickbtn CurView:self];
    }
    
}

-(void)sixViewLaodDatas:(NSDictionary *)tempDic
{

    _itemBtn0.hidden = YES;
    _itemBtn1.hidden = YES;
    _itemBtn2.hidden = YES;
    _itemBtn3.hidden = YES;
    _itemBtn4.hidden = YES;
    _itemBtn5.hidden = YES;
    
    
    NSString *icon_url0 = [NSString stringWithFormat:@"%@",[tempDic objectForKey:@"picurl"]];
    [_itemImg0 setImageWithURL:[NSURL URLWithString:icon_url0] placeholderImage:[UIImage imageNamed:@"defaultImage_212.png"]];
    
    
    _kindNameLab.text = [tempDic objectForKey:@"title"];
    
    
    if (![[tempDic objectForKey:@"content"] isKindOfClass:[NSArray class]]) {
        return;
    }
    
    
    
   NSArray *tempArr = [[NSArray alloc] initWithArray:[tempDic objectForKey:@"content"]];
    
    NSArray *contentArr = [tempDic objectForKey:@"content"];
    if (contentArr.count == 0) {
        return;
    }
    
    
    
    if (tempArr.count == 1) {
        NSString *curtitle1 = [[[tempDic objectForKey:@"content"] objectAtIndex:0] objectForKey:@"title"];
        float curtitlelength1 = (float)curtitle1.length;
        float alllength1 = curtitlelength1 + default_title_length *1.0;
        float scale1 = curtitlelength1/alllength1;
        
        int btn0width = scale1*allbtn_width;
        _itemBtn0.frame = CGRectMake(btn_bian_width, _itemBtn0.frame.origin.y, btn0width, itembtn_height);
        
    }
    if (tempArr.count == 2) {
        NSString *curtitle1 = [[[tempDic objectForKey:@"content"] objectAtIndex:0] objectForKey:@"title"];
        float curtitlelength1 = (float)curtitle1.length;
        NSString *curtitle2 = [[[tempDic objectForKey:@"content"] objectAtIndex:1] objectForKey:@"title"];
        float curtitlelength2 = (float)curtitle2.length;
        float alllength = curtitlelength1 + curtitlelength2 +default_title_length ;
        float scale1 = curtitlelength1/alllength;
        float scale2 = curtitlelength2/alllength;
        
        int btn0width = scale1*allbtn_width;
        int btn1width = scale2*allbtn_width;
        
        _itemBtn0.frame = CGRectMake(btn_bian_width, _itemBtn0.frame.origin.y, btn0width, itembtn_height);
        _itemBtn1.frame = CGRectMake(btn_bian_width+btn0width+btn_between, _itemBtn1.frame.origin.y, btn1width, itembtn_height);
        
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
        
        int btn0width = scale1*allbtn_width;
        int btn1width = scale2*allbtn_width;
        int btn2width = scale3*allbtn_width;
        
        _itemBtn0.frame = CGRectMake(btn_bian_width, _itemBtn0.frame.origin.y, btn0width, itembtn_height);
        _itemBtn1.frame = CGRectMake(btn_bian_width+btn0width+btn_between, _itemBtn1.frame.origin.y, btn1width, itembtn_height);
        _itemBtn2.frame = CGRectMake(btn_bian_width+btn0width+btn_between+btn1width+btn_between, _itemBtn1.frame.origin.y, btn2width, itembtn_height);
        
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
        
        int btn0width = scale1*allbtn_width;
        int btn1width = scale2*allbtn_width;
        int btn2width = scale3*allbtn_width;
        
        _itemBtn0.frame = CGRectMake(btn_bian_width, _itemBtn0.frame.origin.y, btn0width, itembtn_height);
        _itemBtn1.frame = CGRectMake(btn_bian_width+btn0width+btn_between, _itemBtn1.frame.origin.y, btn1width, itembtn_height);
        _itemBtn2.frame = CGRectMake(btn_bian_width+btn0width+btn_between+btn1width+btn_between, _itemBtn2.frame.origin.y, btn2width, itembtn_height);
        
        NSString *curtitle4 = [[[tempDic objectForKey:@"content"] objectAtIndex:3] objectForKey:@"title"];
        float curtitlelength4 = (float)curtitle4.length;
        float alllength2 = curtitlelength4 + default_title_length ;
        float scale4 = curtitlelength4/alllength2;
        
        int btn4width = scale4*allbtn_width;
        
        _itemBtn3.frame = CGRectMake(btn_bian_width, _itemBtn3.frame.origin.y,btn4width, itembtn_height);
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
        int btn0width = scale1*allbtn_width;
        int btn1width = scale2*allbtn_width;
        int btn2width = scale3*allbtn_width;
        _itemBtn0.frame = CGRectMake(btn_bian_width, _itemBtn0.frame.origin.y, btn0width, itembtn_height);
        _itemBtn1.frame = CGRectMake(btn_bian_width+btn0width+btn_between, _itemBtn1.frame.origin.y, btn1width, itembtn_height);
        _itemBtn2.frame = CGRectMake(btn_bian_width+btn0width+btn_between+btn1width+btn_between, _itemBtn1.frame.origin.y, btn2width, itembtn_height);
        
        NSString *curtitle4 = [[[tempDic objectForKey:@"content"] objectAtIndex:3] objectForKey:@"title"];
        float curtitlelength4 = (float)curtitle4.length;
        NSString *curtitle5 = [[[tempDic objectForKey:@"content"] objectAtIndex:4] objectForKey:@"title"];
        float curtitlelength5 = (float)curtitle5.length;
        
        float alllength2 = curtitlelength4 + curtitlelength5 +default_title_length ;
        
        float scale4 = curtitlelength4/alllength2;
        float scale5 = curtitlelength5/alllength2;
        
        int btn4width = scale4*allbtn_width;
        int btn5width = scale5*allbtn_width;
        
        
        _itemBtn3.frame = CGRectMake(btn_bian_width, _itemBtn3.frame.origin.y, btn4width, itembtn_height);
        _itemBtn4.frame = CGRectMake(btn_bian_width+btn4width+btn_between, _itemBtn4.frame.origin.y, btn5width, itembtn_height);
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
        
        int btn0width = scale1*allbtn_width;
        int btn1width = scale2*allbtn_width;
        int btn2width = scale3*allbtn_width;
        
        _itemBtn0.frame = CGRectMake(btn_bian_width, _itemBtn0.frame.origin.y, btn0width, itembtn_height);
        _itemBtn1.frame = CGRectMake(btn_bian_width+btn0width+btn_between, _itemBtn1.frame.origin.y, btn1width, itembtn_height);
        _itemBtn2.frame = CGRectMake(btn_bian_width+btn0width+btn_between+btn1width+btn_between, _itemBtn1.frame.origin.y,btn2width, itembtn_height);
        
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
        
        int btn4width = scale4*allbtn_width;
        int btn5width = scale5*allbtn_width;
        int btn6width = scale6*allbtn_width;
        
        _itemBtn3.frame = CGRectMake(btn_bian_width, _itemBtn3.frame.origin.y, btn4width, itembtn_height);
        _itemBtn4.frame = CGRectMake(btn_bian_width+btn4width+btn_between, _itemBtn4.frame.origin.y, btn5width, itembtn_height);
        _itemBtn5.frame = CGRectMake(btn_bian_width+btn4width+btn_between+btn5width+btn_between, _itemBtn5.frame.origin.y, btn6width, itembtn_height);
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
