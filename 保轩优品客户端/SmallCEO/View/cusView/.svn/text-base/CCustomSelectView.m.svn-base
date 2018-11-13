//
//  CCustomSelectView.m
//  WanHao
//
//  Created by Cai on 15-1-6.
//  Copyright (c) 2015年 wuxiaohui. All rights reserved.
//

#import "CCustomSelectView.h"
#import "CCustomSelCell.h"

#define CCustomSelect_cell 40.0

@implementation CCustomSelectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame content:(NSArray *)arr
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
    
}

-(void)updataUIWithArr:(NSArray *)arr title:(NSString *)t{
    
    for (UIView *temp in [self subviews]) {
        [temp removeFromSuperview];
    }
    
    
    UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    backview.backgroundColor = [UIColor blackColor];
    backview.alpha = 0.5;
    [self addSubview:backview];
    _conArr = [[NSMutableArray alloc] initWithCapacity:0];
    [_conArr addObjectsFromArray:arr];
    
    
    float table_max_h = UI_SCREEN_HEIGHT - 64.0- 10.0 - 44.0 - 10.0 -10.0;
    
    float table_height = arr.count * CCustomSelect_cell;
    if (table_height > table_max_h) {
        table_height = table_max_h;
    }
    float origin_y = (table_max_h - table_height)/2.0;
    if (table_height + 10.0 == UI_SCREEN_HEIGHT - 64.0 -10.0 - 44.0 -10.0) {
        origin_y = 44+STATE_HEIGHT + 10.0;
    }else{
        origin_y = (self.frame.size.height-table_height -10.0)/2.0;
    }
    //10.0, origin_y, self.frame.size.width-20.0, table_height
    UIView *backview2 = [[UIView alloc] initWithFrame:CGRectMake(76.0/2.0, origin_y, self.frame.size.width-76.0+5.0, table_height +10.0)];
    backview2.backgroundColor = [UIColor clearColor];
    //    backview2.layer.cornerRadius = 5.0;
    [self addSubview:backview2];
    if (origin_y == 0) {
        origin_y = 10.0;
    }
    
//    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backview2.frame.size.width, 40.0)];
//    titleView.backgroundColor = [UIColor colorFromHexCode:@"#78c430"];
//    [backview2 addSubview:titleView];
//    
//    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10.0, titleView.frame.size.width, 20.0)];
//    titleLab.text = t;
//    titleLab.textAlignment = NSTextAlignmentCenter;
//    titleLab.backgroundColor = [UIColor clearColor];
//    titleLab.textColor = [UIColor whiteColor];
//    [titleView addSubview:titleLab];
    
    
    UIView *tableBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 2.0, backview2.frame.size.width-5.0, backview2.frame.size.height-2.0)];
    tableBackView.backgroundColor = [UIColor clearColor];
    tableBackView.layer.borderColor = [UIColor whiteColor].CGColor;
    tableBackView.layer.borderWidth = 1.0;
    [backview2 addSubview:tableBackView];
    
    //0.0, 40.0, self.frame.size.width -20.0, table_height
    _contentTable = [[UITableView alloc] initWithFrame:CGRectMake(5.0, 6.0, backview2.frame.size.width-5.0-10.0, table_height) style:UITableViewStylePlain];
    _contentTable.backgroundColor = [UIColor clearColor];
    _contentTable.delegate = self;
    _contentTable.dataSource = self;
    _contentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _contentTable.layer.cornerRadius = 5.0;
//    _contentTable.showsHorizontalScrollIndicator = NO;
//    _contentTable.showsVerticalScrollIndicator = NO;
    [backview2 addSubview:_contentTable];
    
    UIView  *cancelView = [[UIView alloc] initWithFrame:CGRectMake(backview2.frame.size.width - 25.0, 0, 25.0, 25.0)];
    cancelView.backgroundColor = [UIColor clearColor];
    [backview2 addSubview:cancelView];
    
    //titleView.frame.size.width - 60.0+20.0, 10.0, 20.0, 20.0
    UIImageView *cancelimg = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 25.0, 25.0)];
    cancelimg.image = [UIImage imageNamed:@"tao_selview_cancel.png"];
    [cancelView addSubview:cancelimg];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //backview2.frame.size.width - 60.0, 0.0, 60.0, 40.0
    cancelBtn.frame = CGRectMake(0, 0.0, 25.0, 25.0);
    cancelBtn.backgroundColor = [UIColor clearColor];
    [cancelBtn addTarget:self action:@selector(cancelbtnclick) forControlEvents:UIControlEventTouchUpInside];
    [cancelView addSubview:cancelBtn];
    
    /*//    float table_max_h = UI_SCREEN_HEIGHT - 64.0 - 10.0 - 30.0 -10.0-5.0;
    
    float table_max_h = UI_SCREEN_HEIGHT - 64.0- 10.0 - 44.0 - 10.0 - 40.0;
    
    float table_height = arr.count * CCustomSelect_cell;
    if (table_height > table_max_h) {
        table_height = table_max_h;
    }
    float origin_y = (table_max_h - table_height)/2.0;
    if (table_height + 40.0 == UI_SCREEN_HEIGHT - 64.0 -10.0 - 44.0 -10.0) {
        origin_y = 44+STATE_HEIGHT + 10.0;
    }else{
        origin_y = (self.frame.size.height-table_height - 40.0)/2.0;
    }
    UIView *backview2 = [[UIView alloc] initWithFrame:CGRectMake(10.0, origin_y, self.frame.size.width-20.0, table_height + 40.0)];
    backview2.backgroundColor = [UIColor whiteColor];
    //    backview2.layer.cornerRadius = 5.0;
    [self addSubview:backview2];
    if (origin_y == 0) {
        origin_y = 10.0;
    }
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backview2.frame.size.width, 40.0)];
    titleView.backgroundColor = [UIColor colorFromHexCode:@"#78c430"];
    [backview2 addSubview:titleView];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10.0, titleView.frame.size.width, 20.0)];
    titleLab.text = t;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.textColor = [UIColor whiteColor];
    [titleView addSubview:titleLab];
    
    
    UIImageView *cancelimg = [[UIImageView alloc] initWithFrame:CGRectMake(titleView.frame.size.width - 60.0+20.0, 10.0, 20.0, 20.0)];
    cancelimg.image = [UIImage imageNamed:@"selview_cancel.png"];
    [titleView addSubview:cancelimg];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(titleView.frame.size.width - 60.0, 0.0, 60.0, 40.0);
    cancelBtn.backgroundColor = [UIColor clearColor];
    [cancelBtn addTarget:self action:@selector(cancelbtnclick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:cancelBtn];
    
    _contentTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 40.0, self.frame.size.width -20.0, table_height) style:UITableViewStylePlain];
    _contentTable.backgroundColor = [UIColor clearColor];
    _contentTable.delegate = self;
    _contentTable.dataSource = self;
    _contentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _contentTable.layer.cornerRadius = 5.0;
    _contentTable.showsHorizontalScrollIndicator = NO;
    _contentTable.showsVerticalScrollIndicator = NO;
    [backview2 addSubview:_contentTable];*/
    
    
}

-(void)tableUpdateData:(NSArray *)contenArr
{
    [_conArr removeAllObjects];
    [_conArr addObjectsFromArray:contenArr];
    [_contentTable reloadData];
}

/*-(void)updataUIWithArr:(NSArray *)arr{
 
 for (UIView *temp in [self subviews]) {
 [temp removeFromSuperview];
 }
 
 
 UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
 backview.backgroundColor = [UIColor colorFromHexCode:@"#24435a"];
 backview.alpha = 0.6;
 [self addSubview:backview];
 _conArr = [[NSMutableArray alloc] initWithCapacity:0];
 [_conArr addObjectsFromArray:arr];
 
 
 
 float table_max_h = UI_SCREEN_HEIGHT - 64.0 - 10.0 - 30.0 -10.0-5.0;
 
 float table_height = arr.count * CCustomSelect_cell;
 if (table_height > table_max_h) {
 table_height = table_max_h;
 }
 float origin_y = (table_max_h - table_height)/2.0;
 if (table_height + 10.0+30.0+10.0+5.0 == UI_SCREEN_HEIGHT - 64.0) {
 origin_y = 44+STATE_HEIGHT;
 }else{
 origin_y = (self.frame.size.height-table_height - 10.0-30.0-10.0-5.0)/2.0;
 }
 UIView *backview2 = [[UIView alloc] initWithFrame:CGRectMake(0, origin_y, self.frame.size.width, table_height + 10.0 +30.0+10.0+5.0)];
 backview2.backgroundColor = [UIColor whiteColor];
 backview2.layer.cornerRadius = 5.0;
 [self addSubview:backview2];
 if (origin_y == 0) {
 origin_y = 10.0;
 }
 
 //        float table_height = arr.count * CCustomSelect_cell;
 //        if (table_height > table_max_h) {
 //            table_height = table_max_h;
 //        }
 //        float origin_y = (table_max_h - table_height)/2.0;
 //        UIView *backview2 = [[UIView alloc] initWithFrame:CGRectMake(0, 44+STATE_HEIGHT+origin_y, self.frame.size.width, table_height + 16.0 +30.0+10.0)];
 //        backview2.backgroundColor = [UIColor clearColor];
 //        backview2.layer.cornerRadius = 5.0;
 //        [self addSubview:backview2];
 //        if (origin_y == 0) {
 //            origin_y = 10.0;
 //        }
 
 _contentTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0, origin_y+5.0, self.frame.size.width , table_height) style:UITableViewStylePlain];
 _contentTable.backgroundColor = [UIColor clearColor];
 _contentTable.delegate = self;
 _contentTable.dataSource = self;
 _contentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
 _contentTable.layer.cornerRadius = 5.0;
 _contentTable.showsHorizontalScrollIndicator = NO;
 _contentTable.showsVerticalScrollIndicator = NO;
 [self addSubview:_contentTable];
 
 
 UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
 cancelBtn.frame = CGRectMake(20, _contentTable.frame.size.height+_contentTable.frame.origin.y+10.0, self.frame.size.width-40.0, 30.0);
 //    cancelBtn.backgroundColor = [UIColor colorFromHexCode:@"#2e80b2"];
 cancelBtn.backgroundColor = [UIColor colorFromHexCode:@"#E8251E"];
 [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
 [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
 cancelBtn.layer.cornerRadius = 5.0;
 [cancelBtn addTarget:self action:@selector(cancelbtnclick) forControlEvents:UIControlEventTouchUpInside];
 [self addSubview:cancelBtn];
 }*/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _conArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCustomSelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"c"];
    if (!cell) {
        cell = [[CCustomSelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"c"];
        cell.backgroundColor = [UIColor whiteColor];
    }
    if ([[_conArr objectAtIndex:indexPath.row] isKindOfClass:[NSDictionary class]]) {
        [cell reloadData:[NSString stringWithFormat:@"%@",[[_conArr objectAtIndex:indexPath.row] objectForKey:@"name"]]];
    }else{
        [cell reloadData:[NSString stringWithFormat:@"%@",[_conArr objectAtIndex:indexPath.row]]];
    }
    if (indexPath.row != _conArr.count - 1) {
        [cell lineIsDisappear:NO];
    }else{
        [cell lineIsDisappear:YES];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}

-(void)cancelbtnclick
{
    if ([_ccselViewDelegate respondsToSelector:@selector(CCustomSelectViewCancel)]) {
        [_ccselViewDelegate CCustomSelectViewCancel];
    }
    if ([_ccselViewDelegate respondsToSelector:@selector(CCustomSelectViewCancelWithIndex:)]) {
        [_ccselViewDelegate CCustomSelectViewCancelWithIndex:self.tag];
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"cell被点击了");
    if ([_ccselViewDelegate respondsToSelector:@selector(CCustomSelectViewCellDidSelect:customview:)]) {
        [_ccselViewDelegate CCustomSelectViewCellDidSelect:indexPath.row customview:self];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
