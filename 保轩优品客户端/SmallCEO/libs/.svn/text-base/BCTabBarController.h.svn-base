#import <UIKit/UIKit.h>

@interface BCTabBarController : UIViewController
{
    BOOL bUpdateTabBtn;
}

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *tabView;
@property (nonatomic, strong) UIView *tabsView;
@property (nonatomic) NSUInteger selectedIndex;

@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) UIViewController *selectedViewController;
@property (nonatomic, readonly) BOOL visible;
@property (nonatomic) BOOL bUpdateTabBtn;

- (UIView *)loadTabs;
- (void)showTabView:(BOOL)show animated:(BOOL)animated;

@end
