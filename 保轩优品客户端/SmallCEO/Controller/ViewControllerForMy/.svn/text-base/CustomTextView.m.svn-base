#import "CustomTextView.h"

@interface CustomTextView ()

@end

@implementation CustomTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initMethod];
    }
    
    return self;
}

- (void)initMethod
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextViewTextDidChangeNotification object:self];
}

- (void)drawRect:(CGRect)rect
{
    if (self.hasText)
    {
        [super drawRect:rect];
    }
    else
    {
        UIEdgeInsets insets = self.textContainerInset;
        CGFloat textLeftDistance = insets.left + 5;
        CGFloat textTopDistance = insets.top;
        CGRect prefixPlaceholderRect = CGRectZero;
        if ([self.prefixPlaceholder isValid])
        {
            NSMutableDictionary *attr = [NSMutableDictionary dictionary];
            attr[NSFontAttributeName] = self.font;
            attr[NSForegroundColorAttributeName] = [UIColor blackColor];
            
            prefixPlaceholderRect = [self.prefixPlaceholder boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil];
            CGRect actualRect = CGRectMake(textLeftDistance, textTopDistance, prefixPlaceholderRect.size.width, prefixPlaceholderRect.size.height);
            [self.prefixPlaceholder drawInRect:actualRect withAttributes:attr];
            
            textLeftDistance += prefixPlaceholderRect.size.width + 10;
            textTopDistance += 5;
        }
        
        NSMutableDictionary *attr = [NSMutableDictionary dictionary];
        attr[NSFontAttributeName] = [self.prefixPlaceholder isValid] ? [UIFont systemFontOfSize:12.0] : self.font;
        attr[NSForegroundColorAttributeName] = SUB_TITLE;
        
        CGRect placeholderRect = CGRectMake(textLeftDistance, textTopDistance, rect.size.width - insets.left - insets.right - textLeftDistance, rect.size.height - 16);
        [self.placeholder drawInRect:placeholderRect withAttributes:attr];
    }
}

#pragma mark - Set方法
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

#pragma mark - Private Methods
-(void)textViewTextDidChange:(NSNotification *)notification
{
    [self setNeedsDisplay];
}

#pragma mark -
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
