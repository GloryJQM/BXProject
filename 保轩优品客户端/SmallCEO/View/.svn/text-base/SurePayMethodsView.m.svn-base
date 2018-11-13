//
//  SurePayMethodsView.m
//  SmallCEO
//
//  Created by huang on 2017/3/2.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "SurePayMethodsView.h"

static const CGFloat kPayMethodCellHeight = 50.0;

@interface SurePayMethodsView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIWindow *overlayWindow;

@property (nonatomic, copy)   NSArray *payMethodImages;

@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, copy)   NSString *priceStr;

@property (nonatomic, copy)   NSArray *payMethods;

@property (nonatomic, assign) NSUInteger selectedIndex;

@end

@implementation SurePayMethodsView

@synthesize overlayWindow;

+ (SurePayMethodsView *)sharedView {
    static dispatch_once_t once;
    static SurePayMethodsView *sharedView;
    dispatch_once(&once, ^ { sharedView = [[SurePayMethodsView alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; });
    return sharedView;
}

- (void)setupMainView
{
//    self.payMethods = @[@"支付宝", @"微信"];
//    self.payMethodImages = @[@"pho-zhifubao.png", @"pho-zhifubao.png"];
    self.selectedIndex = 0;
    CGFloat titleLabelHeight = 40.0;
    CGFloat extraHeight = 50.0;
    CGFloat surePayButtonHeight = 45.0;
    CGFloat priceLabelHeight = 50.0;
    CGFloat mainViewHeight = kPayMethodCellHeight * self.payMethods.count + priceLabelHeight + titleLabelHeight + extraHeight + surePayButtonHeight;
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT - mainViewHeight + mainViewHeight, UI_SCREEN_WIDTH, mainViewHeight)];
    mainView.backgroundColor = [UIColor whiteColor];
    [self.overlayWindow addSubview:mainView];
    self.mainView = mainView;
    
    UIFont *labelFont = [UIFont systemFontOfSize:16.0];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, mainView.width, titleLabelHeight)];
    titleLabel.font = labelFont;
    titleLabel.text = @"确认付款";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [mainView addSubview:titleLabel];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(5, 5, 30, 30);
    [cancelButton setImage:[UIImage imageNamed:@"button-guanbi@2x"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(hideSelectView) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:cancelButton];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(-1, titleLabel.maxY, mainView.width + 2, priceLabelHeight)];
    priceLabel.font = [UIFont systemFontOfSize:26.0];
    if ([self.priceStr containsString:@"¥"]) {
        priceLabel.text = self.priceStr;
    }else {
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self.priceStr];
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        attch.image = [UIImage imageNamed:@"Button-jifenyue@2x"];
        attch.bounds = CGRectMake(-5, -4, 26, 26);
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
        [attri insertAttributedString:string atIndex:0];
        priceLabel.attributedText = attri;
    }
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.layer.borderWidth = 0.5;
    priceLabel.layer.borderColor = SUB_TITLE.CGColor;
    [mainView addSubview:priceLabel];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, priceLabel.maxY, mainView.width, kPayMethodCellHeight * self.payMethods.count + extraHeight)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.tableFooterView = [UIView new];
    [mainView addSubview:tableView];
    tableView.scrollEnabled = NO;
    
    UIButton *surePayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    surePayButton.frame = CGRectMake(0, mainView.height - surePayButtonHeight, mainView.width, surePayButtonHeight);
    [surePayButton setTitle:@"立即付款" forState:UIControlStateNormal];
    [surePayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    surePayButton.backgroundColor = App_Main_Color;
    [surePayButton addTarget:self action:@selector(surePay) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:surePayButton];
}

#pragma mark -
- (void)surePay
{
    if (self.clickSureButtonBlock)
    {
        self.clickSureButtonBlock(self.selectedIndex);
    }
    
    [self hideSelectView];
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
+ (void)showWithPriceStr:(NSString *)price withMethod:(NSArray *)methodArr;
{
    [SurePayMethodsView sharedView].priceStr = price;
    [SurePayMethodsView sharedView].payMethods = methodArr;
    [[SurePayMethodsView sharedView] showSelectView];
}

+ (void)dismiss
{
    [[SurePayMethodsView sharedView] hideSelectView];
}

- (void)showSelectView
{
    self.alpha = 0.7;
    self.backgroundColor = [UIColor grayColor];
    if(!self.superview)
        [self.overlayWindow insertSubview:self atIndex:0];
    
    [self setupMainView];
    [self.overlayWindow makeKeyAndVisible];
    
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
            // Make sure to remove the overlay window from the list of windows
            // before trying to find the key window in that same list
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.payMethods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"SurePayMethodsViewCellStr";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    NSString *imageNameStr = indexPath.row == 0 ? @"button-xuanzhong.png" : @"button-weixuanzhong.png";
    imageView.image = [UIImage imageNamed:imageNameStr];
    cell.accessoryView = imageView;
    
    NSURL *urlstr = [NSURL URLWithString:self.payMethods[indexPath.row][@"icon"]];
    UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(12, 10, 30, 30)];
    [headImage sd_setImageWithURL:urlstr];
    [cell.contentView addSubview:headImage];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(54, 15, 150, 20)];
    nameLabel.text = self.payMethods[indexPath.row][@"name"];
    [cell.contentView addSubview:nameLabel];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndex = indexPath.row;
    [tableView.visibleCells enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        NSString *imageNameStr = indexPath.row == idx? @"button-xuanzhong.png" : @"button-weixuanzhong.png";
        imageView.image = [UIImage imageNamed:imageNameStr];

        obj.accessoryView = imageView;
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kPayMethodCellHeight;
}

@end
