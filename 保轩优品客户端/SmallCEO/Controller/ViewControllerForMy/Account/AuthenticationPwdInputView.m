//
//  AuthenticationPwdInputView.m
//  HuaQi
//
//  Created by 黄建芳 on 8/2/16.
//  Copyright © 2016 lemuji. All rights reserved.
//

#import "AuthenticationPwdInputView.h"

const CGFloat AuthenticationPwdInputViewHeight = 40;

static const NSInteger kNumberOfPassword = 6;

@interface AuthenticationPwdInputView () <UIKeyInput, UITextInputTraits>

@property (nonatomic, strong) NSMutableString *textStore;
@property (nonatomic, strong) NSMutableArray *numberLabels;

@end

@implementation AuthenticationPwdInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    frame.size.height = AuthenticationPwdInputViewHeight;
    if (self = [super initWithFrame:frame])
    {
        self.textStore = [NSMutableString new];
        self.numberLabels = [[NSMutableArray alloc] initWithCapacity:kNumberOfPassword];
        [self setupMainView];
    }
    
    return self;
}

- (void)setupMainView
{
    UIColor *customGrayColor = [UIColor colorFromHexCode:@"d4d4d7"];
    self.layer.borderWidth = 1;
    self.layer.borderColor = customGrayColor.CGColor;
    self.backgroundColor = [UIColor whiteColor];
    CGFloat intervalDistance = self.width / kNumberOfPassword;
    CGFloat lineViewOrignalX = intervalDistance;
    for (NSInteger i = 0; i < kNumberOfPassword; i++) {
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * intervalDistance, 0, intervalDistance, self.height)];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.font = [UIFont systemFontOfSize:20.0];
        [self addSubview:numberLabel];
        [self.numberLabels addObject:numberLabel];
        
        if (i != kNumberOfPassword - 1)
        {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineViewOrignalX, 0, 1, self.height)];
            lineView.backgroundColor = customGrayColor;
            [self addSubview:lineView];
            lineViewOrignalX += intervalDistance;
        }
    }
}

#pragma mark -
- (BOOL)hasText
{
    if (self.textStore.length > 0) {
        return YES;
    }
    return NO;
}

- (void)insertText:(NSString *)text
{
    if (self.textStore.length == kNumberOfPassword) return;
    
    [self.textStore appendString:text];
    [self updateInputViewContent];
    if (self.textStore.length == kNumberOfPassword)
    {
        if ([self.delegate respondsToSelector:@selector(inputCompletePassword:)])
        {
            [self.delegate inputCompletePassword:self.textStore];
        }
    };
}

- (void)deleteBackward
{
    if (self.textStore.length == 0) return;
    
    NSRange theRange = NSMakeRange(self.textStore.length - 1, 1);
    [self.textStore deleteCharactersInRange:theRange];
    [self updateInputViewContent];
}

#pragma mark - UIResponder methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(![self isFirstResponder]) [self becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

#pragma mark - UITextInputTraits
- (UIKeyboardType)keyboardType
{
    return UIKeyboardTypeNumberPad;
}

#pragma mark - Private Methods
- (void)updateInputViewContent
{
    for (NSInteger i = 0; i < self.numberLabels.count; i++) {
        UILabel *numberLabel = [self.numberLabels objectAtIndex:i];
        if (self.textStore.length == 0)
        {
            numberLabel.text = @"";
            continue;
        }
        
        if (i < self.textStore.length - 1)
        {
            numberLabel.text = @"*";
        }
        else if (i == self.textStore.length - 1)
        {
            NSRange range = NSMakeRange(i, 1);
            numberLabel.text = [self.textStore substringWithRange:range];
        }
        else
        {
            numberLabel.text = @"";
        }
    }
}

@end
