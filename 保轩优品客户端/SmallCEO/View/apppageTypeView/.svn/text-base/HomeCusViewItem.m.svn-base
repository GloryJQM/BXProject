//
//  HomeCusViewItem.m
//  WanHao
//
//  Created by csl on 14-12-11.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "HomeCusViewItem.h"

@implementation HomeCusViewItem
@synthesize delegate;


-(id)initWithFrame:(CGRect)frame  dataDic:(NSDictionary *)dic{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self initUI:dic];
    }
    return self;
}

-(void)initUI:(NSDictionary *)_appDit{
    itemDic=[NSDictionary dictionaryWithDictionary:_appDit];
    if  (_itemScrollView){
        [_itemScrollView removeFromSuperview];
        _itemScrollView=nil;
    }
    int disToHead=4;
    _itemScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(disToHead, 0, self.frame.size.width-2*disToHead, 73.5 *2)];
    //    _itemScrollView.delegate = self;
    _itemScrollView.showsHorizontalScrollIndicator = NO;
    _itemScrollView.showsVerticalScrollIndicator = NO;
    _itemScrollView.alwaysBounceHorizontal=YES;
    _itemScrollView.scrollEnabled = YES;
    _itemScrollView.pagingEnabled=YES;
    _itemScrollView.backgroundColor=[UIColor whiteColor];
    [self  addSubview:_itemScrollView];
    
    int count = 0;
    
    NSMutableArray *defaultArr = [[NSMutableArray alloc] initWithCapacity:0];
    if (_appDit != nil && _appDit.count > 0) {
        [defaultArr removeAllObjects];
        [defaultArr addObjectsFromArray:[_appDit objectForKey:@"content"]];
        //        [defaultArr addObjectsFromArray:[_appDit objectForKey:@"content"]];
    }else{
        
    }
    NSInteger numOfModuleInOneLine=5;

    if (defaultArr.count<numOfModuleInOneLine) {
        self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 73.5);
        
        _itemScrollView.frame=CGRectMake(_itemScrollView.frame.origin.x, _itemScrollView.frame.origin.y, _itemScrollView.frame.size.width, 73.5);
        
    }else  {
        self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 73.5*2);
        
        _itemScrollView.frame=CGRectMake(_itemScrollView.frame.origin.x, _itemScrollView.frame.origin.y, _itemScrollView.frame.size.width, 73.5*2);
        
    }
    
    
    CGFloat width = (self.frame.size.width-2*disToHead - numOfModuleInOneLine*(91.0/2.0))/(numOfModuleInOneLine+1);

    count = (int)[defaultArr count];
    for (int i=0; i<defaultArr.count; i++) {

        int num = 10;
        int numOfPage=i/num;
        int numOfcol=i%numOfModuleInOneLine;
        int numOfRow=(i%num)/numOfModuleInOneLine;

        
        NSDictionary *tempdic = [NSDictionary dictionaryWithDictionary:[defaultArr objectAtIndex:i]];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(numOfPage*_itemScrollView.frame.size.width+ width*(numOfcol+1)+91.0/2.0*numOfcol, 0.0+4.0+numOfRow*73.5, 91.0/2.0, 91.0/2.0)];
        imageV.backgroundColor = [UIColor clearColor];
        if (_appDit != nil && _appDit.count > 0)
        {
            [imageV sd_setImageWithURL:[NSURL URLWithString:[tempdic objectForKey:@"icon_url"]]];
            
        }else{
            imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[tempdic objectForKey:@"icon_url"]]];
        }
        
        // imageV.image = [UIImage imageNamed:iconUrl[i]];
        [_itemScrollView addSubview:imageV];
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.frame =CGRectMake(numOfPage*_itemScrollView.frame.size.width+width*(numOfcol+1)+91.0/2.0*numOfcol-12, 52+4.0+73.5*numOfRow, 91.0/2.0+24, 30.0/2.0);
        nameLabel.font =[UIFont systemFontOfSize:11.0];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.backgroundColor = [UIColor clearColor];
        
        nameLabel.text = [[tempdic objectForKey:@"app_name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [_itemScrollView addSubview:nameLabel];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(numOfPage*_itemScrollView.frame.size.width+width*(numOfcol+1)+91.0/2.0*numOfcol, 73.5*numOfRow, 91.0/2.0, 135.0/2.0)];
        btn.backgroundColor = [UIColor clearColor];
        NSString *btnTitle=[NSString stringWithFormat:@"%d",[[tempdic objectForKey:@"has_child_url"] intValue]];
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        [btn setTitleColor :[UIColor clearColor] forState:UIControlStateNormal];
        btn.tag = [[tempdic objectForKey:@"app_id"] intValue];
        [btn addTarget:self action:@selector(gotoTheme:) forControlEvents:UIControlEventTouchUpInside];
        [_itemScrollView addSubview:btn];
    }
    
    int numOfPage=count/(2*numOfModuleInOneLine);
    int numOfcol=count%numOfModuleInOneLine;
    int numOfRow=(count%(2*numOfModuleInOneLine))/numOfModuleInOneLine;
    UIImageView *addimageV = [[UIImageView alloc] initWithFrame:CGRectMake(numOfPage*_itemScrollView.frame.size.width+width*(numOfcol+1)+91.0/2.0*numOfcol, 0.0+4.0+73.5*numOfRow, 91.0/2.0, 91.0/2.0)];
    addimageV.backgroundColor = [UIColor clearColor];
    addimageV.image = [UIImage imageNamed:@"add.png"];
    [_itemScrollView addSubview:addimageV];
    UILabel *addnameLabel = [[UILabel alloc]init];
    addnameLabel.frame =CGRectMake(numOfPage*_itemScrollView.frame.size.width+width*(numOfcol+1)+91.0/2.0*numOfcol, 52+4.0+73.5*numOfRow, 91.0/2.0, 30.0/2.0);
    addnameLabel.font =[UIFont systemFontOfSize:11.0];
    addnameLabel.textAlignment = NSTextAlignmentCenter;
    addnameLabel.backgroundColor = [UIColor clearColor];
    addnameLabel.text = @"添加";
    [_itemScrollView addSubview:addnameLabel];
    
    UIButton  *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(numOfPage*_itemScrollView.frame.size.width+width*(numOfcol+1)+91.0/2.0*numOfcol, 73.5*numOfRow, 91.0/2.0, 135.0/2.0)];
    addBtn.backgroundColor = [UIColor clearColor];
    [addBtn addTarget:self action:@selector(addItem:) forControlEvents:UIControlEventTouchUpInside];
    [_itemScrollView addSubview:addBtn];
    _itemScrollView.contentSize = CGSizeMake(_itemScrollView.frame.size.width*(numOfPage+1), 0);
}

-(void)addItem:(UIButton *)btn{
    
    if ([delegate respondsToSelector:@selector(addItem:)]) {
        [delegate addItem:btn];
    }
    
}

-(void)gotoTheme:(UIButton *)btn{
    
    //采购和淘淘代付跳转不一样
    if(btn.tag==10 || btn.tag==11){
        if ([delegate respondsToSelector:@selector(gotoTheme:)]) {
            [delegate gotoTheme:btn];
        }
        return;
    }
    
    NSArray *iconTypes=[itemDic valueForKey:@"content"];
    int linkType = -1;
    NSString *linkValue;
    NSString *linkTitle;
    for (int i=0; i<iconTypes.count; i++) {
        NSArray *temp=(NSArray *)[iconTypes objectAtIndex:i];
        //app_id比较
        int btnTag=(int)btn.tag;
        int curAppid=[[temp valueForKey:@"app_id"] intValue];
        
        if (btnTag==curAppid) {
            linkType=[[NSString stringWithFormat:@"%@",[temp valueForKey:@"link_type"] ] intValue];
            linkValue=[NSString stringWithFormat:@"%@",[temp valueForKey:@"link_value"] ] ;
            linkTitle=[NSString stringWithFormat:@"%@",[temp valueForKey:@"app_id"] ] ;
            break;
        }
    }
    
    if (linkType==-1) {
        return;
    }
    
    if ([delegate respondsToSelector:@selector(gotoGoodsList:linkvale:title:)]) {
        //首页linktype跳转的方法
        [delegate gotoGoodsList:linkType linkvale:linkValue title:linkTitle];
    }
    
}

@end
