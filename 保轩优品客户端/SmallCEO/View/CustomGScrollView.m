//
//  CustomGScrollView.m
//  WanHao
//
//  Created by Cai on 14-6-12.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "CustomGScrollView.h"
#define V_Width  320
#define V_Height 50
#define B_Width 50
#define B_Height 30
#define B_Betweenm  5
#define content_font 15.0

#define B_Width2 50
#define B_Height2 30
#define B_Betweenm2  5
#define content_font2 15.0

@implementation CustomGScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



-(id)initWithFrame:(CGRect)frame Items:(NSDictionary *)itemdic viewType:(int)viewT
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (viewT == 1) {

            
            _curBtnIndex = 0;
            NSString *namestr = [NSString stringWithFormat:@"%@:",[itemdic objectForKey:@"name"]];
            _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 36.0, 30.0)];
            if (namestr.length * 14.0 > 36.0) {
                _titleLab.frame = CGRectMake(0, 0, namestr.length * 14.0, 30.0);
            }
            _titleLab.text = [NSString stringWithFormat:@"%@:",[itemdic objectForKey:@"name"]];
            _titleLab.textColor = [UIColor colorFromHexCode:@"#646464"];
            _titleLab.font = [UIFont systemFontOfSize:14.0];
            _titleLab.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_titleLab];
            
            _contentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(_titleLab.frame.origin.x+_titleLab.frame.size.width, 0, self.frame.size.width-_titleLab.frame.origin.x-_titleLab.frame.size.width, 30)];
            _contentScroll.scrollEnabled=NO;
            _contentScroll.showsVerticalScrollIndicator = YES;
            _contentScroll.showsHorizontalScrollIndicator = YES;
            _contentScroll.backgroundColor = [UIColor clearColor];
            [self addSubview:_contentScroll];
            
            
            NSArray *temparr = [[NSArray alloc] initWithArray:[itemdic objectForKey:@"data"]];
            
            float origin_x = 5.0;
            //        float origin_y=5.0;
            float origin_y=0.0;
            for (int i = 0; i < temparr.count; i++) {
                NSDictionary *itemdic = [temparr objectAtIndex:i];
                UIButton *kindbtn = [UIButton buttonWithType:UIButtonTypeCustom];
                NSString *contentstr = [NSString stringWithFormat:@"%@",[itemdic objectForKey:@"name"]];
                
                
                if (contentstr.length > 2) {
                    //判断是否换行
                    if((origin_x+contentstr.length * content_font+5.0)>_contentScroll.frame.size.width){
                        kindbtn.frame = CGRectMake(5.0 , origin_y+30+5.0, contentstr.length * content_font+5.0, B_Height);
                        origin_x=5.0+contentstr.length * content_font+5.0+5.0;
                        origin_y+=30 + 5.0;
                    }else{
                        kindbtn.frame = CGRectMake(origin_x , origin_y, contentstr.length * content_font+5.0, B_Height);
                        origin_x += contentstr.length * content_font+5.0+5.0;
                    }
                    
                    
                    
                }else{
                    //判断是否换行
                    if ((origin_x+B_Width)>_contentScroll.frame.size.width) {
                        kindbtn.frame = CGRectMake(5.0 , origin_y+30+5.0, B_Width, B_Height);
                        origin_x=5.0+B_Width+5.0;
                        origin_y+=30 + 5.0;
                    }else{
                        kindbtn.frame = CGRectMake(origin_x , origin_y, B_Width, B_Height);
                        origin_x += B_Width+5.0;
                    }
                }
                [kindbtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
                kindbtn.backgroundColor = [UIColor clearColor];
                kindbtn.tag = 100 +i;
                kindbtn.layer.borderColor = [UIColor colorFromHexCode:@"#c0c0c0"].CGColor;
                kindbtn.layer.borderWidth = 0.5;
                kindbtn.layer.cornerRadius = 5.0;
                [kindbtn setTitle:[NSString stringWithFormat:@"%@",[itemdic objectForKey:@"name"]] forState:UIControlStateNormal];
                
                [kindbtn setTitleColor:[UIColor colorFromHexCode:@"#646464"] forState:UIControlStateNormal];
                [kindbtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
                [kindbtn addTarget:self action:@selector(kindBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [_contentScroll addSubview:kindbtn];
            }
            self.frame=CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, origin_y+30+5.0);
            _contentScroll.contentSize = CGSizeMake(origin_x, 30);
            _contentScroll.frame=CGRectMake(_contentScroll.frame.origin.x, _contentScroll.frame.origin.y, _contentScroll.frame.size.width, origin_y+30+5.0);
            
        }else {
            _curBtnIndex = 0;
            NSString *namestr = [NSString stringWithFormat:@"%@:",[itemdic objectForKey:@"name"]];
            _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 12.0, 280.0, 15.0)];
            if (namestr.length * 15.0 > 280.0) {
                _titleLab.frame = CGRectMake(15.0, 0, namestr.length * 15.0, 30.0);
            }
            _titleLab.text = [NSString stringWithFormat:@"%@:",[itemdic objectForKey:@"name"]];
            _titleLab.textColor = [UIColor colorFromHexCode:@"#666666"];
            _titleLab.font = [UIFont systemFontOfSize:15.0];
            _titleLab.backgroundColor = [UIColor clearColor];
            [self addSubview:_titleLab];
            
            _contentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(15.0, _titleLab.frame.origin.y+_titleLab.frame.size.height + 12.0, self.frame.size.width - 15.0*2.0, 40)];
            _contentScroll.scrollEnabled=NO;
            _contentScroll.showsVerticalScrollIndicator = YES;
            _contentScroll.showsHorizontalScrollIndicator = YES;
            _contentScroll.backgroundColor = [UIColor clearColor];
            [self addSubview:_contentScroll];
            
            
            NSArray *temparr = [[NSArray alloc] initWithArray:[itemdic objectForKey:@"data"]];
            
            float origin_x = 0.0;
            float origin_y=0.0;
            
            for (int i = 0; i < temparr.count; i++) {
                NSDictionary *itemdic = [temparr objectAtIndex:i];
                UIButton *kindbtn = [UIButton buttonWithType:UIButtonTypeCustom];
                NSString *contentstr = [NSString stringWithFormat:@"%@",[itemdic objectForKey:@"name"]];
                
                
                if (contentstr.length > 2) {
                    //判断是否换行
                    if((origin_x+contentstr.length * content_font2+5.0)>_contentScroll.frame.size.width){
                        kindbtn.frame = CGRectMake(0.0 , origin_y+40, contentstr.length * content_font2+5.0, B_Height2);
                        origin_x=5.0+contentstr.length * content_font2+5.0+5.0;
                        origin_y+=40;
                    }else{
                        kindbtn.frame = CGRectMake(origin_x , origin_y, contentstr.length * content_font2+5.0, B_Height2);
                        origin_x += contentstr.length * content_font2+5.0+5.0;
                    }
                    
                    
                    
                }else{
                    //判断是否换行
                    if ((origin_x+B_Width2)>_contentScroll.frame.size.width) {
                        kindbtn.frame = CGRectMake(5.0 , origin_y+40, B_Width2, B_Height2);
                        origin_x=5.0+B_Width2+5.0;
                        origin_y+=40;
                    }else{
                        kindbtn.frame = CGRectMake(origin_x , origin_y, B_Width2, B_Height2);
                        origin_x += B_Width2+5.0;
                    }
                }
                [kindbtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
                kindbtn.backgroundColor = [UIColor whiteColor];
                kindbtn.tag = 100 +i;
                kindbtn.layer.borderColor = [UIColor colorFromHexCode:@"#c0c0c0"].CGColor;
                kindbtn.layer.borderWidth = 0.5;
                kindbtn.layer.cornerRadius = 5.0;
                [kindbtn setTitle:[NSString stringWithFormat:@"%@",[itemdic objectForKey:@"name"]] forState:UIControlStateNormal];
                [kindbtn setTitleColor:[UIColor colorFromHexCode:@"#666666"] forState:UIControlStateNormal];
                [kindbtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
                [kindbtn addTarget:self action:@selector(kindBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [_contentScroll addSubview:kindbtn];
            }
            self.frame=CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, origin_y+40 + 40.0);
            _contentScroll.contentSize = CGSizeMake(origin_x, 30);
            _contentScroll.frame=CGRectMake(_contentScroll.frame.origin.x, _contentScroll.frame.origin.y, _contentScroll.frame.size.width, origin_y+40);
            
            UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, UI_SCREEN_WIDTH, 0.5)];
            lineLab.backgroundColor = [UIColor colorFromHexCode:@"#d8d8d8"];
            [self addSubview:lineLab];
            
        }
        
    }
    return self;
    
}


-(void)kindBtnClick:(UIButton *)btn
{
    
    
    if (_curBtnIndex == 0) {
        btn.selected = !btn.selected;
        btn.layer.borderColor = [UIColor redColor].CGColor;
        _curBtnIndex = btn.tag;
    }else{
        if (_curBtnIndex == btn.tag) {
            return;
        }else{
            
            UIButton *fontbtn = (UIButton *)[self viewWithTag:_curBtnIndex];
            fontbtn.layer.borderColor = [UIColor colorFromHexCode:@"#d6d6d6"].CGColor;
            fontbtn.selected = !fontbtn.selected;
            btn.layer.borderColor = [UIColor redColor].CGColor;
            btn.selected = !btn.selected;
            _curBtnIndex = btn.tag;
        }
        
    }
    
    if ([self.customDelegate respondsToSelector:@selector(contentBtnIndex:currentView:)]) {
        [self.customDelegate contentBtnIndex:_curBtnIndex currentView:self];
    }
    
}



//            _curBtnIndex = 0;
//            NSString *namestr = [NSString stringWithFormat:@"%@:",[itemdic objectForKey:@"name"]];
//            _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 36.0, 30.0)];
//            if (namestr.length * 13.0 > 36.0) {
//                _titleLab.frame = CGRectMake(0, 0, namestr.length * 13.0, 30.0);
//            }
//            _titleLab.text = [NSString stringWithFormat:@"%@:",[itemdic objectForKey:@"name"]];
//            _titleLab.textColor = [UIColor blackColor];
//            _titleLab.font = [UIFont systemFontOfSize:13.0];
//            [self addSubview:_titleLab];
//
//            _contentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(_titleLab.frame.origin.x+_titleLab.frame.size.width, 0, self.frame.size.width-_titleLab.frame.origin.x-_titleLab.frame.size.width, 30)];
//            _contentScroll.showsVerticalScrollIndicator = YES;
//            _contentScroll.showsHorizontalScrollIndicator = YES;
//            _contentScroll.backgroundColor = [UIColor clearColor];
//            [self addSubview:_contentScroll];
//
//
//            NSArray *temparr = [[NSArray alloc] initWithArray:[itemdic objectForKey:@"data"]];
//
//            float origin_x = 5.0;
//
//            for (int i = 0; i < temparr.count; i++) {
//                NSDictionary *itemdic = [temparr objectAtIndex:i];
//                UIButton *kindbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//                NSString *contentstr = [NSString stringWithFormat:@"%@",[itemdic objectForKey:@"name"]];
//
//                if (contentstr.length > 2) {
//                    kindbtn.frame = CGRectMake(origin_x , 5.0, contentstr.length * content_font+5.0, B_Height);
//                    origin_x += contentstr.length * content_font+5.0+5.0;
//                }else{
//                    kindbtn.frame = CGRectMake(origin_x , 5.0, B_Width, B_Height);
//                    origin_x += B_Width+5.0;
//                }
//                [kindbtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
//                kindbtn.backgroundColor = [UIColor whiteColor];
//                kindbtn.tag = 100 +i;
//                kindbtn.layer.borderColor = [UIColor colorFromHexCode:@"#d6d6d6"].CGColor;
//                kindbtn.layer.borderWidth = 0.5;
//                [kindbtn setTitle:[NSString stringWithFormat:@"%@",[itemdic objectForKey:@"name"]] forState:UIControlStateNormal];
//                [kindbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//                [kindbtn addTarget:self action:@selector(kindBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//                [_contentScroll addSubview:kindbtn];
//            }
//            _contentScroll.contentSize = CGSizeMake(origin_x, 30);


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
