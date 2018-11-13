
#import <UIKit/UIKit.h>

typedef void(^AlertBlock)(NSInteger);

@interface UIAlertViewBlock : UIAlertView

@property(nonatomic,strong) AlertBlock block;

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
        clickButton:(AlertBlock)_block
  otherButtonTitles:(NSString *)otherButtonTitles;

@end
