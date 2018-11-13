#import "UIAlertViewBlock.h"

@interface UIAlertViewBlock ()
@property (copy, nonatomic) void (^completion)(BOOL, NSInteger);
@end

@implementation UIAlertViewBlock

@synthesize block;

-(void)dealloc
{
    self.block = nil;
}

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
        clickButton:(AlertBlock)_block
  otherButtonTitles:(NSString *)otherButtonTitles {
    
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles,nil];
    
    if (self) {
        self.block = _block;
    }
    
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    self.block(buttonIndex);
}

@end