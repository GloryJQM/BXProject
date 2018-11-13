//
//  HomeCusViewSec.m
//  WanHao
//
//  Created by Cai on 14-6-9.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "HomeCusViewSec.h"

#define S_Height  120.0
#define row_width 10.0
#define BigItem_Height 120.0
#define BigItem_Width  120.0

#define CUR_Btn_Tag     200


#define smallItem_Width 145.0
#define smallItem_Heigth 60

@implementation HomeCusViewSec

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        

        self.backgroundColor = [UIColor whiteColor];
        
        
        UIView *contentview0 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, BigItem_Width, BigItem_Height)];
        contentview0.backgroundColor = [UIColor clearColor];
//        contentview0.layer.borderColor = [UIColor colorFromHexCode:@"#d6d6d6"].CGColor;
//        contentview0.layer.borderWidth = 0.5f;
        [self addSubview:contentview0];
        
        UIButton *itemBtn0 = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn0.frame = CGRectMake(0.0, 0.0, contentview0.frame.size.width, contentview0.frame.size.height);
        itemBtn0.backgroundColor = [UIColor clearColor];
        [itemBtn0 addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        itemBtn0.tag = CUR_Btn_Tag + 0;
        [contentview0 addSubview:itemBtn0];
        
        _itemImg0 = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, BigItem_Width, BigItem_Height)];
        _itemImg0.backgroundColor = [UIColor clearColor];
//        _itemImg0.layer.borderColor = [UIColor colorFromHexCode:@"#d6d6d6"].CGColor;
//        _itemImg0.layer.borderWidth = 0.5f;
        [contentview0 addSubview:_itemImg0];
        
        UIView *contentbackview0 = [[UIView alloc] initWithFrame:CGRectMake(0, BigItem_Height-40, BigItem_Width, 40)];
        contentbackview0.backgroundColor = [UIColor clearColor];
        [contentview0 addSubview:contentbackview0];
        UIView *alphaview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BigItem_Width, 40)];
        alphaview.backgroundColor = [UIColor whiteColor];
        alphaview.alpha = 0.7;
        [contentbackview0 addSubview:alphaview];
        _itemnameLab0 = [[UILabel alloc] initWithFrame:CGRectMake(0.5, 0, BigItem_Width-1.0, 20.0)];
        //_itemnameLab0.text = @"特色水果生日蛋糕";
        _itemnameLab0.font = [UIFont systemFontOfSize:12.0];
        _itemnameLab0.textAlignment = NSTextAlignmentCenter;
        _itemnameLab0.textColor = [UIColor blackColor];
        _itemnameLab0.backgroundColor = [UIColor clearColor];
        [contentbackview0 addSubview:_itemnameLab0];
        
        _itemNowPLab0 = [[UILabel alloc] initWithFrame:CGRectMake(10.0, _itemnameLab0.frame.size.height+_itemnameLab0.frame.origin.y, 60.0, 20.0)];
        //_itemNowPLab0.text = @"¥129";
        _itemNowPLab0.font = [UIFont systemFontOfSize:13.0];
        _itemNowPLab0.textAlignment = NSTextAlignmentCenter;
        _itemNowPLab0.textColor = [UIColor colorFromHexCode:@"#ff6600"];
        _itemNowPLab0.backgroundColor = [UIColor clearColor];
        [contentbackview0 addSubview:_itemNowPLab0];
        
        
        _itemOldPLab0 = [[StrikeThroughLabel alloc] initWithFrame:CGRectMake(_itemNowPLab0.frame.size.width+_itemNowPLab0.frame.origin.x, _itemnameLab0.frame.size.height+_itemnameLab0.frame.origin.y+3.0, 50.0-1.0,15.0)];
        _itemOldPLab0.backgroundColor = [UIColor clearColor];
        _itemOldPLab0.strikeThroughEnabled = YES;
        _itemOldPLab0.textColor = [UIColor lightGrayColor];
        _itemOldPLab0.font = [UIFont systemFontOfSize:8.0];
        [contentbackview0 addSubview:_itemOldPLab0];
        
//        _itemOldPLab0 = [[UILabel alloc] initWithFrame:CGRectMake(_itemNowPLab0.frame.size.width+_itemNowPLab0.frame.origin.x, _itemnameLab0.frame.size.height+_itemnameLab0.frame.origin.y+3.0, 50.0-1.0,15.0)];
//        _itemOldPLab0.backgroundColor = [UIColor clearColor];
//        _itemOldPLab0.text = @"¥132";
//        _itemOldPLab0.font = [UIFont systemFontOfSize:10.0];
//        _itemOldPLab0.textAlignment = NSTextAlignmentCenter;
//        _itemOldPLab0.textColor = [UIColor lightGrayColor];
//        [contentbackview0 addSubview:_itemOldPLab0];
        
        
        
        
        UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(contentview0.frame.size.width+contentview0.frame.origin.x, 0.0, self.frame.size.width, smallItem_Heigth*2)];
        vi.backgroundColor = [UIColor clearColor];
        vi.layer.masksToBounds = YES;
//        vi.layer.borderColor = [UIColor colorFromHexCode:@"#d6d6d6"].CGColor;
//        vi.layer.borderWidth = 0.5f;
        [self addSubview:vi];
        
//        UIView *heng_line1 = [[UIView alloc] initWithFrame:CGRectMake(1.0, 1.0+smallItem_Heigth,smallItem_Width, 0.5)];
//        heng_line1.backgroundColor = [UIColor colorFromHexCode:@"#d6d6d6"];
//        [vi  addSubview:heng_line1];
        
        UIView *contentview1 = [[UIView alloc] initWithFrame:CGRectMake(vi.frame.origin.x, 0.0, self.frame.size.width-BigItem_Width, smallItem_Heigth)];
        contentview1.backgroundColor = [UIColor clearColor];
        [self addSubview:contentview1];
        
        UIButton *itemBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn1.frame = CGRectMake(0.0, 0.0, contentview1.frame.size.width, contentview1.frame.size.height);
        itemBtn1.backgroundColor = [UIColor clearColor];
        [itemBtn1 addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        itemBtn1.tag = CUR_Btn_Tag + 1;
        [contentview1 addSubview:itemBtn1];
        
        
        _itemnameLab1 = [[UILabel alloc] initWithFrame:CGRectMake(65, 13.0, self.frame.size.width - BigItem_Width-65, 20.0)];
        _itemnameLab1.backgroundColor = [UIColor clearColor];
        //_itemnameLab1.text = @"国产凤梨";
        _itemnameLab1.font = [UIFont systemFontOfSize:12.0];
        _itemnameLab1.textAlignment = NSTextAlignmentCenter;
        [contentview1 addSubview:_itemnameLab1];
        _itemNowPLab1 = [[UILabel alloc] initWithFrame:CGRectMake(65+30.0, _itemnameLab1.frame.size.height+_itemnameLab1.frame.origin.y,40.0 , 20.0)];
        //_itemNowPLab1.text = @"¥8";
        _itemNowPLab1.backgroundColor = [UIColor clearColor];
        _itemNowPLab1.textColor = [UIColor colorFromHexCode: @"#ff6600"];
        _itemNowPLab1.font = [UIFont systemFontOfSize:12.0];
        [contentview1 addSubview:_itemNowPLab1];
        
        
        _itemOldPLab1 = [[StrikeThroughLabel alloc] initWithFrame:CGRectMake(_itemNowPLab1.frame.size.width+_itemNowPLab1.frame.origin.x, _itemnameLab1.frame.size.height+_itemnameLab1.frame.origin.y+4.0,30.0 , 15.0)];
        _itemOldPLab1.backgroundColor = [UIColor clearColor];
        _itemOldPLab1.strikeThroughEnabled = YES;
        _itemOldPLab1.textColor = [UIColor lightGrayColor];
        _itemOldPLab1.font = [UIFont systemFontOfSize:8.0];
        [contentview1 addSubview:_itemOldPLab1];
        
//        _itemOldPLab1 = [[UILabel alloc] initWithFrame:CGRectMake(_itemNowPLab1.frame.size.width+_itemNowPLab1.frame.origin.x, _itemnameLab1.frame.size.height+_itemnameLab1.frame.origin.y+4.0,30.0 , 15.0)];
//        _itemOldPLab1.text = @"¥10";
//        _itemOldPLab1.textColor = [UIColor lightGrayColor];
//        _itemOldPLab1.font = [UIFont systemFontOfSize:9.0];
//        _itemOldPLab1.backgroundColor = [UIColor clearColor];
//        [contentview1 addSubview:_itemOldPLab1];
        
        _itemImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60.0, 60.0)];
        _itemImg1.backgroundColor = [UIColor clearColor];
        [contentview1 addSubview:_itemImg1];
        
        
        UIView *contentview2 = [[UIView alloc] initWithFrame:CGRectMake(vi.frame.origin.x, contentview1.frame.origin.y+contentview1.frame.size.height, self.frame.size.width - BigItem_Width, smallItem_Heigth)];
        contentview2.backgroundColor = [UIColor clearColor];
        [self addSubview:contentview2];
        
        UIButton *itemBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn2.frame = CGRectMake(0.0, 0.0, contentview2.frame.size.width, contentview2.frame.size.height);
        itemBtn2.backgroundColor = [UIColor clearColor];
        [itemBtn2 addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        itemBtn2.tag = CUR_Btn_Tag + 2;
        [contentview2 addSubview:itemBtn2];
        
        _itemnameLab2 = [[UILabel alloc] initWithFrame:CGRectMake(65, 13.0, self.frame.size.width - BigItem_Width-65, 20.0)];
        //_itemnameLab2.text = @"新鲜蔬菜";
        _itemnameLab2.font = [UIFont systemFontOfSize:12.0];
        _itemnameLab2.textAlignment = NSTextAlignmentCenter;
        _itemnameLab2.backgroundColor = [UIColor clearColor];
        [contentview2 addSubview:_itemnameLab2];
        _itemNowPLab2 = [[UILabel alloc] initWithFrame:CGRectMake(65+30.0, _itemnameLab2.frame.size.height+_itemnameLab2.frame.origin.y,40.0 , 20.0)];
        //_itemNowPLab2.text = @"¥2.2";
        _itemNowPLab2.textColor = [UIColor colorFromHexCode:@"#ff6600"];
        _itemNowPLab2.font = [UIFont systemFontOfSize:12.0];
        _itemNowPLab2.backgroundColor = [UIColor clearColor];
        [contentview2 addSubview:_itemNowPLab2];
        
        
        
        _itemOldPLab2 = [[StrikeThroughLabel alloc] initWithFrame:CGRectMake(_itemNowPLab2.frame.size.width+_itemNowPLab2.frame.origin.x+5.0, _itemnameLab2.frame.size.height+_itemnameLab2.frame.origin.y+4.0,30.0 , 15.0)];
        _itemOldPLab2.backgroundColor = [UIColor clearColor];
        _itemOldPLab2.strikeThroughEnabled = YES;
        _itemOldPLab2.textColor = [UIColor lightGrayColor];
        _itemOldPLab2.font = [UIFont systemFontOfSize:8.0];
        [contentview2 addSubview:_itemOldPLab2];
        
//        _itemOldPLab2 = [[UILabel alloc] initWithFrame:CGRectMake(_itemNowPLab2.frame.size.width+_itemNowPLab2.frame.origin.x+5.0, _itemnameLab2.frame.size.height+_itemnameLab2.frame.origin.y+4.0,30.0 , 15.0)];
//        _itemOldPLab2.text = @"¥2.5";
//        _itemOldPLab2.textColor = [UIColor lightGrayColor];
//        _itemOldPLab2.font = [UIFont systemFontOfSize:9.0];
//        _itemOldPLab2.backgroundColor = [UIColor clearColor];
//        [contentview2 addSubview:_itemOldPLab2];
        
        
        
        _itemImg2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60.0, 60.0)];
        _itemImg2.backgroundColor = [UIColor clearColor];
        [contentview2 addSubview:_itemImg2];
        
        
        
        
        
    }
    return self;
}

-(void)itemBtnClick:(UIButton *)clickbtn
{
    if ([self.cussecondDelegate respondsToSelector:@selector(cusseconditemButton:CurView:)]) {
        [self.cussecondDelegate cusseconditemButton:clickbtn CurView:self];
    }
    
}



-(void)secondViewLaodDatas:(NSDictionary *)tempDic
{
    if (![[tempDic objectForKey:@"content"] isKindOfClass:[NSArray class]]) {
        return;
    }
    NSArray *contentArr = [tempDic objectForKey:@"content"];
    if (contentArr.count == 0) {
        return;
    }
    
    NSString *name0 = [[[tempDic objectForKey:@"content"] objectAtIndex:0] objectForKey:@"title"];
//    if (name0.length > 13) {
//        NSString *subname0 = [NSString stringWithFormat:@"%@",[name0 substringToIndex:13]];
//        _itemnameLab0.text = subname0;
//    }else{
        _itemnameLab0.text = [[[tempDic objectForKey:@"content"] objectAtIndex:0] objectForKey:@"title"];
//    }
    NSString *nowpri0 = [NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:0] objectForKey:@"description"]];
    if (nowpri0.length > 0) {
        _itemNowPLab0.hidden = NO;
        _itemNowPLab0.text = [NSString stringWithFormat:@"￥%.1f",[[[[tempDic objectForKey:@"content"] objectAtIndex:0] objectForKey:@"description"] floatValue]] ;
    }else{
        _itemNowPLab0.hidden = YES;
    }
    NSString *oldpri0 = [NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:0] objectForKey:@"old_price"]];
    if (oldpri0.length > 0) {
        _itemOldPLab0.hidden = NO;
        _itemOldPLab0.text = [NSString stringWithFormat:@"￥%.1f",[[[[tempDic objectForKey:@"content"] objectAtIndex:0] objectForKey:@"old_price"] floatValue]] ;
    }else{
        _itemOldPLab0.hidden = YES;
    }
    
    
    NSString *icon_url0 = [NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:0] objectForKey:@"picurl"]];
    [_itemImg0 setImageWithURL:[NSURL URLWithString:icon_url0] placeholderImage:[UIImage imageNamed:@"defaultImage_240.png"]];
    
    if (contentArr.count >= 2) {
        NSString *name1 = [[[tempDic objectForKey:@"content"] objectAtIndex:1] objectForKey:@"title"];
//        if (name1.length > 11) {
//            NSString *subname1 = [NSString stringWithFormat:@"%@",[name1 substringToIndex:11]];
//            _itemnameLab1.text = subname1;
//        }else{
            _itemnameLab1.text = [[[tempDic objectForKey:@"content"] objectAtIndex:1] objectForKey:@"title"];
//        }
        NSString *nowpri1 = [NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:1] objectForKey:@"description"]];
        if (nowpri1.length > 0) {
            _itemNowPLab1.hidden = NO;
            _itemNowPLab1.text = [NSString stringWithFormat:@"￥%.1f",[[[[tempDic objectForKey:@"content"] objectAtIndex:1] objectForKey:@"description"] floatValue]] ;
        }else{
            _itemNowPLab1.hidden = YES;
        }
        NSString *oldpri1 = [NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:1] objectForKey:@"old_price"]];
        if (oldpri1.length > 0) {
            _itemOldPLab1.hidden = NO;
            _itemOldPLab1.text = [NSString stringWithFormat:@"￥%.1f",[[[[tempDic objectForKey:@"content"] objectAtIndex:1] objectForKey:@"old_price"]floatValue]] ;
        }else{
            _itemOldPLab1.hidden = YES;
        }
        
        NSString *icon_url1 = [NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:1] objectForKey:@"picurl"]];
        [_itemImg1 setImageWithURL:[NSURL URLWithString:icon_url1] placeholderImage:[UIImage imageNamed:@"defaultImage_120.png"]];
    }
    
    
    if (contentArr.count >= 3) {
        NSString *name2 = [[[tempDic objectForKey:@"content"] objectAtIndex:2] objectForKey:@"title"];
//        if (name2.length > 5) {
//            NSString *subname2 = [NSString stringWithFormat:@"%@",[name2 substringToIndex:5]];
//            _itemnameLab2.text = subname2;
//        }else{
            _itemnameLab2.text = [[[tempDic objectForKey:@"content"] objectAtIndex:2] objectForKey:@"title"];
//        }
        NSString *nowpri2 = [NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:2] objectForKey:@"description"]];
        if (nowpri2.length > 0) {
            _itemNowPLab2.hidden = NO;
            _itemNowPLab2.text = [NSString stringWithFormat:@"￥%.1f",[[[[tempDic objectForKey:@"content"] objectAtIndex:2] objectForKey:@"description"] floatValue]] ;
        }else{
            _itemNowPLab2.hidden = YES;
        }
        NSString *oldpri2 = [NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:2] objectForKey:@"old_price"]];
        if (oldpri2.length > 0) {
            _itemOldPLab2.hidden = NO;
            _itemOldPLab2.text = [NSString stringWithFormat:@"￥%.1f",[[[[tempDic objectForKey:@"content"] objectAtIndex:2] objectForKey:@"old_price"] floatValue]] ;
        }else{
            _itemOldPLab2.hidden = YES;
        }
        
        
        NSString *icon_url2 = [NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:2] objectForKey:@"picurl"]];
        [_itemImg2 setImageWithURL:[NSURL URLWithString:icon_url2] placeholderImage:[UIImage imageNamed:@"defaultImage_120.png"]];
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
