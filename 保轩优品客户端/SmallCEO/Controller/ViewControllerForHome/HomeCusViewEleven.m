//
//  HomeCusViewEleven.m
//  WanHao
//
//  Created by Cai on 14-8-19.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "HomeCusViewEleven.h"

#define S_Height  213
#define row_width 0.0
#define BigItem_Height 213
#define BigItem_Width  213.0

#define CUR_Btn_Tag     110000


#define smallItem_Width 107.0
#define smallItem_Heigth 106.5

@implementation HomeCusViewEleven

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        _image0 = [[UIImageView alloc] initWithFrame:CGRectMake(4.0-4.0, 0.0, BigItem_Width, BigItem_Height)];
        _image0.backgroundColor = [UIColor clearColor];
        _image0.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_image0];
        
        UIButton *imgbtn0 = [UIButton buttonWithType:UIButtonTypeCustom];
        imgbtn0.frame = CGRectMake(4.0-4.0, 0.0, BigItem_Width, BigItem_Height);
        imgbtn0.backgroundColor = [UIColor clearColor];
        imgbtn0.tag = CUR_Btn_Tag;
        [imgbtn0 addTarget:self action:@selector(imgbtnclick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:imgbtn0];
        
        
        _image1 = [[UIImageView alloc] initWithFrame:CGRectMake(4.0+BigItem_Width+row_width-4.0, 0.0, smallItem_Width, smallItem_Heigth)];
        _image1.backgroundColor = [UIColor whiteColor];
        _image1.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_image1];
        
//        _itemLab0 = [[UILabel alloc] initWithFrame:CGRectMake(_image1.frame.origin.x+10.0, _image1.frame.size.height+_image1.frame.origin.y, smallItem_Width-20.0, 20.0)];
//        _itemLab0.backgroundColor = [UIColor clearColor];
//        _itemLab0.textAlignment = NSTextAlignmentCenter;
//        _itemLab0.font = [UIFont systemFontOfSize:12.0f];
//        [self addSubview:_itemLab0];
        
        UIButton *imgbtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        imgbtn1.frame = CGRectMake(4.0+BigItem_Width+row_width-4.0, 0.0, smallItem_Width, smallItem_Heigth);
        imgbtn1.backgroundColor = [UIColor clearColor];
        imgbtn1.tag = CUR_Btn_Tag+1;
        [imgbtn1 addTarget:self action:@selector(imgbtnclick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:imgbtn1];
        
        
        _image2 = [[UIImageView alloc] initWithFrame:CGRectMake(4.0+BigItem_Width+row_width-4.0, smallItem_Heigth, smallItem_Width, smallItem_Heigth)];
        _image2.backgroundColor = [UIColor whiteColor];
        _image2.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_image2];
        
//        _itemLab1 = [[UILabel alloc] initWithFrame:CGRectMake(_image2.frame.origin.x+10.0, _image2.frame.size.height+_image2.frame.origin.y, smallItem_Width-20.0, 20.0)];
//        _itemLab1.backgroundColor = [UIColor clearColor];
//        _itemLab1.textAlignment = NSTextAlignmentCenter;
//        _itemLab1.font = [UIFont systemFontOfSize:12.0f];
//        [self addSubview:_itemLab1];
        
        UIButton *imgbtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        imgbtn2.frame = CGRectMake(4.0+BigItem_Width+row_width-4.0, smallItem_Heigth, smallItem_Width, smallItem_Heigth);
        imgbtn2.backgroundColor = [UIColor clearColor];
        imgbtn2.tag = CUR_Btn_Tag+2;
        [imgbtn2 addTarget:self action:@selector(imgbtnclick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:imgbtn2];
        
    }
    return self;
}

-(void)imgbtnclick:(UIButton *)btn
{
    if ([self.cuselevenDelegate respondsToSelector:@selector(cuselevenitemButton:CurView:)]) {
        [self.cuselevenDelegate cuselevenitemButton:btn CurView:self];
    }
}

-(void)elevenViewLaodDatas:(NSDictionary *)tempDic
{
    if (![[tempDic objectForKey:@"content"] isKindOfClass:[NSArray class]]) {
        return;
    }
    NSArray *contentArr = [tempDic objectForKey:@"content"];
    if (contentArr.count == 0) {
        return;
    }
    
    if (contentArr.count >= 1) {
        NSString *icon_url0 = [NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:0] objectForKey:@"picurl"]];
        [_image0 setImageWithURL:[NSURL URLWithString:icon_url0] placeholderImage:[UIImage imageNamed:@"defaultImage_426.png"]];
    }
    
    if (contentArr.count >= 2) {
        NSString *icon_url1 = [NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:1] objectForKey:@"picurl"]];
        [_image1 setImageWithURL:[NSURL URLWithString:icon_url1] placeholderImage:[UIImage imageNamed:@"defaultImage_213.png"]];
    }
    
    if (contentArr.count >= 3) {
        NSString *icon_url2 = [NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:2] objectForKey:@"picurl"]];
        [_image2 setImageWithURL:[NSURL URLWithString:icon_url2] placeholderImage:[UIImage imageNamed:@"defaultImage_213.png"]];
    }
    
    
//    _itemLab0.text = [NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:1] objectForKey:@"title"]];
//    _itemLab1.text = [NSString stringWithFormat:@"%@",[[[tempDic objectForKey:@"content"] objectAtIndex:2] objectForKey:@"title"]];
    
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
