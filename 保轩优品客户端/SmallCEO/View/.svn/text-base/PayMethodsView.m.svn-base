//
//  PayMethodsView.m
//  SmallCEO
//
//  Created by huang on 2017/3/2.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "PayMethodsView.h"

static const CGFloat kPayMethodCellHeight = 70.0;

@interface PayMethodsView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIWindow *overlayWindow;

@property (nonatomic, copy)   NSArray *payMethodImages;

@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, assign) NSInteger selectdNum;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PayMethodsView

@synthesize overlayWindow;

+ (PayMethodsView *)sharedView {
    static dispatch_once_t once;
    static PayMethodsView *sharedView;
    dispatch_once(&once, ^ { sharedView = [[PayMethodsView alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; });
    return sharedView;
}

- (void)setupMainView
{
    
//    self.payMethods = @[@"使用现金支付", @"使用金币支付", @"使用代金券抵扣"];
//    self.payMethodImages = @[@"icon-xianjinzhifu.png", @"icon-jinbizhifu.png", @"icon-daijinquandikou.png"];
    self.selectdNum = 0;
    CGFloat titleLabelHeight = 40.0;
    CGFloat extraHeight = 50.0;
    CGFloat tableHeight = 200;
    CGFloat mainViewHeight = tableHeight + titleLabelHeight + extraHeight;
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT - mainViewHeight + mainViewHeight, UI_SCREEN_WIDTH, mainViewHeight)];
    mainView.backgroundColor = [UIColor whiteColor];
    [self.overlayWindow addSubview:mainView];
    self.mainView = mainView;
    
    UIFont *labelFont = [UIFont systemFontOfSize:16.0];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, mainView.width, titleLabelHeight)];
    titleLabel.font = labelFont;
    titleLabel.text = @"选择付款方式";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [mainView addSubview:titleLabel];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(5, 5, 30, 30);
    [cancelButton setImage:[UIImage imageNamed:@"button-guanbi@2x.png"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(hideSelectView) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:cancelButton];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleLabel.maxY - 0.5, mainView.width, 0.5)];
    lineView.backgroundColor = SUB_TITLE;
    [mainView addSubview:lineView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, titleLabel.maxY, mainView.width, tableHeight)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    [mainView addSubview:_tableView];
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _tableView.maxY, UI_SCREEN_WIDTH, 50)];
    sureBtn.backgroundColor = [UIColor colorWithRed:253/255.0 green:121/255.0 blue:123 / 255.0 alpha:1];
    [sureBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"确认付款" forState:UIControlStateNormal];
    [mainView addSubview:sureBtn];
}

#pragma mark - Getter
- (UIWindow *)overlayWindow {
    if(!overlayWindow) {
        overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayWindow.backgroundColor = [UIColor clearColor];
        overlayWindow.windowLevel = UIWindowLevelNormal + 1;
        overlayWindow.userInteractionEnabled = YES;
    
    }
    return overlayWindow;
}

#pragma mark - 显示或隐藏的方法
+ (void)show
{
    [[PayMethodsView sharedView] showSelectView];
}

+ (void)dismiss
{
    [[PayMethodsView sharedView] hideSelectView];
}

- (void)showSelectView
{
    self.alpha = 0.7;
    self.backgroundColor = [UIColor grayColor];
    if(!self.superview)
        [self.overlayWindow insertSubview:self atIndex:0];
    
    [self setupMainView];
    [self.overlayWindow makeKeyAndVisible];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideSelectView)];
//    [overlayWindow addGestureRecognizer:tap];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.mainView.y -= self.mainView.height;
    }];
}

- (void)hideSelectView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.mainView.y += self.mainView.height;
    } completion:^(BOOL finished) {
        if (finished)
        {
            NSMutableArray *windows = [[NSMutableArray alloc] initWithArray:[UIApplication sharedApplication].windows];
            [windows removeObject:overlayWindow];
            [overlayWindow.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            overlayWindow = nil;
            
            [windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIWindow *window, NSUInteger idx, BOOL *stop) {
                if([window isKindOfClass:[UIWindow class]] && window.windowLevel == UIWindowLevelNormal) {
                    [window makeKeyWindow];
                    *stop = YES;
                }
            }];

        }
    }];
}
#pragma mark - 确认按钮相应事件
- (void)btnAction {
    if (self.selectBlock)
    {
        self.selectBlock(_selectdNum);
    }
    [self hideSelectView];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.payMethods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"PayMethodsViewCellStr";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    imageView.tag = indexPath.row;
    imageView.image = [UIImage imageNamed:@"button-weixuanzhong@2x"];
    if (indexPath.row == _selectdNum) {
        imageView.image = [UIImage imageNamed:@"gj_pay_is@2x"];
    }
    cell.accessoryView = imageView;
    
    
    NSURL *urlstr = [NSURL URLWithString:self.payMethods[indexPath.row][@"icon"]];
    UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(12, 20, 30, 30)];
    [headImage sd_setImageWithURL:urlstr];
    [cell.contentView addSubview:headImage];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(54, 25, 150, 20)];
    nameLabel.text = self.payMethods[indexPath.row][@"name"];
    [cell.contentView addSubview:nameLabel];
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectdNum = indexPath.row;
    [_tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kPayMethodCellHeight;
}

@end
