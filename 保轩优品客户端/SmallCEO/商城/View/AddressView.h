//
//  AddressView.h
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/12.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressView : UIButton
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *houseLabel;
@property (nonatomic, strong) UIButton *seleButton;
@property (nonatomic, strong) UIImageView *rightArrowImageView;
@property (nonatomic, copy) dispatch_block_t finishBlock;
- (instancetype)initWithY:(CGFloat)y is_point_type:(NSInteger)is_point_type Block:(void (^) (void))block;
- (void)setDictionary:(NSDictionary *)model;
- (void)setPointDictionary:(NSDictionary *)model;
@property (nonatomic, copy) NSString *tihuo_info;
@end

