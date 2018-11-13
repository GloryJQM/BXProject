//
//  GeneralInfoTableViewCell.h
//  SmallCEO
//
//  Created by huang on 15/8/21.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

typedef NS_ENUM(NSUInteger, GeneralInfoViewType)
{
    GeneralInfoViewTypeDefalut,
    GeneralInfoViewTypeWithDetailLabel
};

#import <UIKit/UIKit.h>

@interface GeneralInfoTableViewCell : UIView

@property (nonatomic, strong)   UILabel     *leftTextLabel;
@property (nonatomic, strong)   UILabel     *detailTextLabel;
@property (nonatomic, strong)   UIImageView *rightImageView;
@property (nonatomic, readonly) GeneralInfoViewType viewType;

- (instancetype)initWithFrame:(CGRect)frame type:(GeneralInfoViewType)type;

@end
