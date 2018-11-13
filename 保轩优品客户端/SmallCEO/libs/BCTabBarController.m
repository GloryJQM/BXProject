#import "BCTabBarController.h"
#import "BaseNavigationViewController.h"

@interface BCTabBarController ()

@property (nonatomic, readwrite) BOOL visible;

@end


@implementation BCTabBarController
@synthesize viewControllers, selectedViewController, visible,bUpdateTabBtn;

- (void)showTabView:(BOOL)show animated:(BOOL)animated
{
    BOOL state = [UIView areAnimationsEnabled];
    [UIView setAnimationsEnabled:animated];
    
    [UIView animateWithDuration:.2 animations:^{
        UIView *tabs = self.tabView;
        self.tabView.frame = CGRectMake(0, show ? self.view.bounds.size.height -tabs.frame.size.height : self.view.bounds.size.height+10, tabs.frame.size.width, tabs.frame.size.height);
    }];
    
    self.contentView.frame = CGRectMake(0, 0, self.tabView.frame.size.width, show ? self.view.frame.size.height -self.tabView.frame.size.height : self.view.frame.size.height);
    [UIView setAnimationsEnabled:state];
}

- (UIView *)loadTabs
{
    return nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        CGRect screenBounds = [UIScreen mainScreen].bounds;
        self.contentView = [[UIView alloc] initWithFrame:screenBounds];
        [self.view addSubview:self.contentView];
        
        self.tabView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:self.tabView];
        self.bUpdateTabBtn = NO;
        UIView *tabs = [self loadTabs];
        if (tabs != nil) {
            self.tabsView=tabs;
            [self.tabView addSubview:tabs];
            self.tabView.frame = CGRectMake(0, self.view.bounds.size.height -tabs.frame.size.height, tabs.frame.size.width, tabs.frame.size.height);
        }
        self.contentView.frame = CGRectMake(0, 0, self.tabView.frame.size.width, self.view.frame.size.height -self.tabView.frame.size.height);
    }
    return self;
}


- (void)setSelectedViewController:(UIViewController *)vc {
	UIViewController *oldVC = selectedViewController;
    
//    DLog(@"setselect:%@,vc:%@",selectedViewController,vc);
    
//    DLog(@"CONTENTvIEW:%@",_contentView);
    
    if (selectedViewController != vc) {
        selectedViewController = vc;
        if (!self.childViewControllers && visible) {
            [oldVC viewWillDisappear:NO];
            [selectedViewController viewWillAppear:NO];
        }
        
        for (UIView *subView in _contentView.subviews) {
            [subView removeFromSuperview];
        }
        vc.view.frame = _contentView.bounds;
        [_contentView addSubview:vc.view];
        
        if (!self.childViewControllers && visible) {
            [oldVC viewDidDisappear:NO];
            [selectedViewController viewDidAppear:NO];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    
    if (!self.childViewControllers)
        [self.selectedViewController viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    
    if (!self.childViewControllers)
        [self.selectedViewController viewDidAppear:animated];
    
	visible = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    
    if (!self.childViewControllers)
        [self.selectedViewController viewWillDisappear:animated];	
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
    
    if (![self respondsToSelector:@selector(addChildViewController:)])
        [self.selectedViewController viewDidDisappear:animated];
	visible = NO;
}


- (NSUInteger)selectedIndex {
	return [self.viewControllers indexOfObject:self.selectedViewController];
}

- (void)setSelectedIndex:(NSUInteger)aSelectedIndex {
	if (self.viewControllers.count > aSelectedIndex){
        NSLog(@"aSelectedIndex:%ld",aSelectedIndex);
		self.selectedViewController = [self.viewControllers objectAtIndex:aSelectedIndex];
    }
}

- (void)setViewControllers:(NSArray *)array {
    
	if (array != viewControllers) {
		viewControllers = [NSArray arrayWithArray:array];
	}
    
	self.selectedIndex = 0;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return [self.selectedViewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[self.selectedViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)willAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[self.selectedViewController willAnimateFirstHalfOfRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
	[self.selectedViewController willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
}

- (void)willAnimateSecondHalfOfRotationFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration {
	[self.selectedViewController willAnimateSecondHalfOfRotationFromInterfaceOrientation:fromInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[self.selectedViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

@end
