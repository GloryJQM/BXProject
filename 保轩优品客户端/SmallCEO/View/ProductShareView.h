//
//  ProductShareView.h
//  SmallCEO
//
//  Created by huang on 2017/3/2.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ShareType)
{
    ShareTypeWxFriend = 0,
    ShareTypeQQFriend,
    ShareTypeFriendCycle,
    ShareTypeSina
};

@interface ProductShareView : UIView

@property (nonatomic, copy) void (^selectBlock)(ShareType);

+ (ProductShareView *)sharedView;

+ (void)show;

+ (void)dismiss;

@end
