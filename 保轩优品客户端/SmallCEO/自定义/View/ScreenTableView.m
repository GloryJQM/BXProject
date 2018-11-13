//
//  ScreenTableView.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/14.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "ScreenTableView.h"
@interface ScreenTableView()<UITableViewDelegate, UITableViewDataSource>{
    NSArray *_array;
    NSString *_isdefault;
}
@property (nonatomic, strong) UITableView *tableView;

@end
@implementation ScreenTableView
- (instancetype)initWithY:(CGFloat)y NSarray:(NSArray *)array block:(void (^) (NSInteger cid))block isdefault:(NSString *)isdefault {
    self = [super initWithFrame:CGRectMake(0, y, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - 64)];
    if (self) {
        self.finishBlock = block;
        _array = array;
        _isdefault = isdefault;
        [self creationTableView];
    }
    return self;
}

- (void)creationTableView {
    UIButton *backView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, self.height)];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.7;
    [backView addTarget:self action:@selector(remoView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backView];
    
    CGFloat height = _array.count * 45 > UI_SCREEN_HEIGHT - 300 ? UI_SCREEN_HEIGHT - 300 : _array.count * 45;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, height)];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _array[indexPath.row][@"cat_name"];
    if ([_isdefault isEqualToString:_array[indexPath.row][@"cid"]]) {
        cell.textLabel.textColor = App_Main_Color;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    }else {
        cell.textLabel.textColor = Color161616;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cid = [NSString stringWithFormat:@"%@", _array[indexPath.row][@"cid"]];
    if (self.finishBlock) {
        self.finishBlock([cid integerValue]);
    }
    [self removeFromSuperview];
}

- (void)remoView {
    [self removeFromSuperview];
}

@end
