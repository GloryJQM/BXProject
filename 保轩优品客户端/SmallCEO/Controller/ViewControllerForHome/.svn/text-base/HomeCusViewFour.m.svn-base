//
//  HomeCusViewFour.m
//  WanHao
//
//  Created by Cai on 14-6-9.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "HomeCusViewFour.h"

#define S_Height  130.0
#define Item_Height 50.0
#define Item_Width  297.0/2.0
#define row_width 10.0
#define Item_Label_W    80.0
#define Item_Label_H    40.0
#define Item_Img_W      50.0
#define Item_Img_H      50.0
#define CUR_Btn_Tag     400
#define lab_img_width   16.0


@implementation HomeCusViewFour

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(row_width, 0.0, self.frame.size.width - row_width *2, Item_Height*3+3.0)];
        vi.backgroundColor = [UIColor clearColor];
        vi.layer.masksToBounds = YES;
        vi.layer.borderColor = [UIColor colorFromHexCode:@"#d6d6d6"].CGColor;
        vi.layer.borderWidth = 1.0f;
        [self addSubview:vi];
        
        UIView *shu_line1 = [[UIView alloc] initWithFrame:CGRectMake(1.0+Item_Width, 0, 0.5 , Item_Height*3.0+1.0)];
        shu_line1.backgroundColor = [UIColor colorFromHexCode:@"#d6d6d6"];
        [vi addSubview:shu_line1];
        
        
        UIView *heng_line1 = [[UIView alloc] initWithFrame:CGRectMake(1.0, 1.0+Item_Height,self.frame.size.width - row_width*2.0 , 0.5)];
        heng_line1.backgroundColor = [UIColor colorFromHexCode:@"#d6d6d6"];
        [vi  addSubview:heng_line1];
        UIView *heng_line2 = [[UIView alloc] initWithFrame:CGRectMake(1.0,1.0+Item_Height+1.0+Item_Height, self.frame.size.width - row_width*2.0, 0.5)];
        heng_line2.backgroundColor = [UIColor colorFromHexCode:@"#d6d6d6"];
        [vi addSubview:heng_line2];
        
        //1
        UIView *contentview0 = [[UIView alloc] initWithFrame:CGRectMake(1.0, 1.0, Item_Width, Item_Height)];
        contentview0.backgroundColor = [UIColor clearColor];
        [vi addSubview:contentview0];
        
        _orderLab0 = [[UILabel alloc] initWithFrame:CGRectMake(1.0, (Item_Height - Item_Label_H)/2.0, Item_Label_W, Item_Label_H)];
        _orderLab0.textColor = [UIColor blackColor];
        _orderLab0.textAlignment = NSTextAlignmentCenter;
        _orderLab0.font = [UIFont systemFontOfSize:12.0];
        _orderLab0.backgroundColor = [UIColor clearColor];
        _orderLab0.numberOfLines = 0;
        [contentview0 addSubview:_orderLab0];
        _orderImg0 = [[UIImageView alloc] initWithFrame:CGRectMake( Item_Label_W +lab_img_width, 0.0, Item_Img_W, Item_Img_H)];
        _orderImg0.contentMode = UIViewContentModeScaleAspectFit;
        _orderImg0.backgroundColor = [UIColor clearColor];
        [contentview0 addSubview:_orderImg0];
        
        UIButton *itemBtn0 = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn0.frame = CGRectMake(0.0, 0.0, Item_Width, Item_Height);
        itemBtn0.backgroundColor = [UIColor clearColor];
        [itemBtn0 addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        itemBtn0.tag = CUR_Btn_Tag + 0;
        [contentview0 addSubview:itemBtn0];
        
        
        
        
        
        
        //2
        UIView *contentview1 = [[UIView alloc] initWithFrame:CGRectMake(1.0+Item_Width+1.0, 1.0, Item_Width, Item_Height)];
        contentview1.backgroundColor = [UIColor clearColor];
        [vi addSubview:contentview1];
        
        _orderLab1 = [[UILabel alloc] initWithFrame:CGRectMake(1.0, (Item_Height - Item_Label_H)/2.0, Item_Label_W, Item_Label_H)];
        _orderLab1.textColor = [UIColor blackColor];
        _orderLab1.textAlignment = NSTextAlignmentCenter;
        _orderLab1.font = [UIFont systemFontOfSize:12.0];
        _orderLab1.backgroundColor = [UIColor clearColor];
        _orderLab1.numberOfLines = 0;
        [contentview1 addSubview:_orderLab1];
        _orderImg1 = [[UIImageView alloc] initWithFrame:CGRectMake( Item_Label_W+lab_img_width, 0.0, Item_Img_W, Item_Img_H)];
        _orderImg1.contentMode = UIViewContentModeScaleAspectFit;
        _orderImg1.backgroundColor = [UIColor clearColor];
        [contentview1 addSubview:_orderImg1];
        
        UIButton *itemBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn1.frame = CGRectMake(0.0, 0.0,  Item_Width, Item_Height);
        itemBtn1.backgroundColor = [UIColor clearColor];
        [itemBtn1 addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        itemBtn1.tag = CUR_Btn_Tag + 1;
        [contentview1 addSubview:itemBtn1];
        
        //3
        UIView *contentview2 = [[UIView alloc] initWithFrame:CGRectMake(1.0, 1.0+Item_Height+1.0, Item_Width, Item_Height)];
        contentview2.backgroundColor = [UIColor clearColor];
        [vi addSubview:contentview2];
        
        _orderLab2 = [[UILabel alloc] initWithFrame:CGRectMake(1.0, (Item_Height - Item_Label_H)/2.0, Item_Label_W, Item_Label_H)];
        _orderLab2.textColor = [UIColor blackColor];
        _orderLab2.textAlignment = NSTextAlignmentCenter;
        _orderLab2.font = [UIFont systemFontOfSize:12.0];
        _orderLab2.backgroundColor = [UIColor clearColor];
        _orderLab2.numberOfLines = 0;
        [contentview2 addSubview:_orderLab2];
        _orderImg2 = [[UIImageView alloc] initWithFrame:CGRectMake( Item_Label_W+lab_img_width, 0.0, Item_Img_W, Item_Img_H)];
        _orderImg2.contentMode = UIViewContentModeScaleAspectFit;
        _orderImg2.backgroundColor = [UIColor clearColor];
        [contentview2 addSubview:_orderImg2];
        
        UIButton *itemBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn2.frame = CGRectMake(0.0, 0.0,  Item_Width, Item_Height);
        itemBtn2.backgroundColor = [UIColor clearColor];
        [itemBtn2 addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        itemBtn2.tag = CUR_Btn_Tag + 2;
        [contentview2 addSubview:itemBtn2];
        
        
        //4
        UIView *contentview3 = [[UIView alloc] initWithFrame:CGRectMake(1.0+Item_Width+1.0, 1.0 +Item_Height + 1.0, Item_Width, Item_Height)];
        contentview3.backgroundColor = [UIColor clearColor];
        [vi addSubview:contentview3];
        
        _orderLab3 = [[UILabel alloc] initWithFrame:CGRectMake(1.0, (Item_Height - Item_Label_H)/2.0, Item_Label_W, Item_Label_H)];
        _orderLab3.textColor = [UIColor blackColor];
        _orderLab3.textAlignment = NSTextAlignmentCenter;
        _orderLab3.font = [UIFont systemFontOfSize:12.0];
        _orderLab3.backgroundColor = [UIColor clearColor];
        _orderLab3.numberOfLines = 0;
        [contentview3 addSubview:_orderLab3];
        _orderImg3 = [[UIImageView alloc] initWithFrame:CGRectMake( Item_Label_W+lab_img_width, 0.0, Item_Img_W, Item_Img_H)];
        _orderImg3.contentMode = UIViewContentModeScaleAspectFit;
        _orderImg3.backgroundColor = [UIColor clearColor];
        [contentview3 addSubview:_orderImg3];
        
        UIButton *itemBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn3.frame = CGRectMake(0.0, 0.0, Item_Width, Item_Height);
        itemBtn3.backgroundColor = [UIColor clearColor];
        [itemBtn3 addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        itemBtn3.tag = CUR_Btn_Tag + 3;
        [contentview3 addSubview:itemBtn3];
        
        
        //5
        UIView *contentview4 = [[UIView alloc] initWithFrame:CGRectMake(1.0, 1.0 +Item_Height + 1.0+Item_Height+1.0, Item_Width, Item_Height)];
        contentview4.backgroundColor = [UIColor clearColor];
        [vi addSubview:contentview4];
        
        _orderLab4 = [[UILabel alloc] initWithFrame:CGRectMake(1.0, (Item_Height - Item_Label_H)/2.0, Item_Label_W, Item_Label_H)];
        _orderLab4.textColor = [UIColor blackColor];
        _orderLab4.textAlignment = NSTextAlignmentCenter;
        _orderLab4.font = [UIFont systemFontOfSize:12.0];
        _orderLab4.backgroundColor = [UIColor clearColor];
        _orderLab4.numberOfLines = 0;
        [contentview4 addSubview:_orderLab4];
        _orderImg4 = [[UIImageView alloc] initWithFrame:CGRectMake( Item_Label_W+lab_img_width, 0.0, Item_Img_W, Item_Img_H)];
        _orderImg4.contentMode = UIViewContentModeScaleAspectFit;
        _orderImg4.backgroundColor = [UIColor clearColor];
        [contentview4 addSubview:_orderImg4];
        
        UIButton *itemBtn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn4.frame = CGRectMake(0.0, 0.0,  Item_Width, Item_Height);
        itemBtn4.backgroundColor = [UIColor clearColor];
        [itemBtn4 addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        itemBtn4.tag = CUR_Btn_Tag + 4;
        [contentview4 addSubview:itemBtn4];
        
        
        //6
        UIView *contentview5 = [[UIView alloc] initWithFrame:CGRectMake(1.0+Item_Width+1.0, 1.0 +Item_Height + 1.0+Item_Height+1.0, Item_Width, Item_Height)];
        contentview5.backgroundColor = [UIColor clearColor];
        [vi addSubview:contentview5];
        
        _orderLab5 = [[UILabel alloc] initWithFrame:CGRectMake(1.0, (Item_Height - Item_Label_H)/2.0, Item_Label_W, Item_Label_H)];
        _orderLab5.textColor = [UIColor blackColor];
        _orderLab5.textAlignment = NSTextAlignmentCenter;
        _orderLab5.font = [UIFont systemFontOfSize:12.0];
        _orderLab5.backgroundColor = [UIColor clearColor];
        _orderLab5.numberOfLines = 0;
        [contentview5 addSubview:_orderLab5];
        _orderImg5 = [[UIImageView alloc] initWithFrame:CGRectMake( Item_Label_W+lab_img_width, 0.0, Item_Img_W, Item_Img_H)];
        _orderImg5.contentMode = UIViewContentModeScaleAspectFit;
        _orderImg5.backgroundColor = [UIColor clearColor];
        [contentview5 addSubview:_orderImg5];
        
        UIButton *itemBtn5 = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn5.frame = CGRectMake(0.0, 0.0,  Item_Width, Item_Height);
        itemBtn5.backgroundColor = [UIColor clearColor];
        [itemBtn5 addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        itemBtn5.tag = CUR_Btn_Tag + 5;
        [contentview5 addSubview:itemBtn5];
        
        
    }
    return self;
}

-(void)itemBtnClick:(UIButton *)clickbtn
{
    if ([self.cusfourDelegate respondsToSelector:@selector(itemButton:CurView:)]) {
        [self.cusfourDelegate itemButton:clickbtn CurView:self];
    }
    
}

-(void)fourViewLaodDatas:(NSDictionary *)tempDic
{
    if (![[tempDic objectForKey:@"content"] isKindOfClass:[NSArray class]]) {
        return;
    }
    
    NSArray *contentArr = [tempDic objectForKey:@"content"];
    if (contentArr.count == 0) {
        return;
    }
    if (contentArr.count >= 1) {
        _orderLab0.text = [[[tempDic objectForKey:@"content"] objectAtIndex:0] objectForKey:@"title"];
        NSString *icon_url0 = [NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:0] objectForKey:@"picurl"]];
        [_orderImg0 setImageWithURL:[NSURL URLWithString:icon_url0] placeholderImage:[UIImage imageNamed:@"defaultImage_100.png"]];
    }
    
    
    if (contentArr.count >= 2) {
        _orderLab1.text = [[[tempDic objectForKey:@"content"] objectAtIndex:1] objectForKey:@"title"];
        NSString *icon_url1 = [NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:1] objectForKey:@"picurl"]];
        [_orderImg1 setImageWithURL:[NSURL URLWithString:icon_url1] placeholderImage:[UIImage imageNamed:@"defaultImage_100.png"]];
    }
    
    if (contentArr.count >= 3) {
        _orderLab2.text = [[[tempDic objectForKey:@"content"] objectAtIndex:2] objectForKey:@"title"];
        NSString *icon_url2 = [NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:2] objectForKey:@"picurl"]];
        [_orderImg2 setImageWithURL:[NSURL URLWithString:icon_url2] placeholderImage:[UIImage imageNamed:@"defaultImage_100.png"]];
    }
    
    if (contentArr.count >= 4) {
        _orderLab3.text = [[[tempDic objectForKey:@"content"] objectAtIndex:3] objectForKey:@"title"];
        NSString *icon_url3 = [NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:3] objectForKey:@"picurl"]];
        [_orderImg3 setImageWithURL:[NSURL URLWithString:icon_url3] placeholderImage:[UIImage imageNamed:@"defaultImage_100.png"]];
    }
    
    if (contentArr.count >= 5) {
        _orderLab4.text = [[[tempDic objectForKey:@"content"] objectAtIndex:4] objectForKey:@"title"];
        NSString *icon_url4 = [NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:4] objectForKey:@"picurl"]];
        [_orderImg4 setImageWithURL:[NSURL URLWithString:icon_url4] placeholderImage:[UIImage imageNamed:@"defaultImage_100.png"]];
    }
    
    if (contentArr.count >= 6) {
        _orderLab5.text = [[[tempDic objectForKey:@"content"] objectAtIndex:5] objectForKey:@"title"];
        NSString *icon_url5 = [NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:5] objectForKey:@"picurl"]];
        [_orderImg5 setImageWithURL:[NSURL URLWithString:icon_url5] placeholderImage:[UIImage imageNamed:@"defaultImage_100.png"]];
    }
    
    
    
    
//    _orderLab0.text = [tempDic objectForKey:@"title"];
//    _orderImg0.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[tempDic objectForKey:@"pic_url"]]];
//    
//    _orderLab1.text = [tempDic objectForKey:@"title"];
//    _orderImg1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[tempDic objectForKey:@"pic_url"]]];
//    
//    _orderLab2.text = [tempDic objectForKey:@"title"];
//    _orderImg2.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[tempDic objectForKey:@"pic_url"]]];
//    
//    _orderLab3.text = [tempDic objectForKey:@"title"];
//    _orderImg3.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[tempDic objectForKey:@"pic_url"]]];
//    
//    _orderLab4.text = [tempDic objectForKey:@"title"];
//    _orderImg4.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[tempDic objectForKey:@"pic_url"]]];
//    
//    _orderLab5.text = [tempDic objectForKey:@"title"];
//    _orderImg5.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[tempDic objectForKey:@"pic_url"]]];
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
