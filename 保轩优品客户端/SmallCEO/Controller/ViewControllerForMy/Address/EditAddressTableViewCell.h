//
//  EditAddressTableViewCell.h
//  Price
//
//  Created by 俊严 on 17/3/2.
//  Copyright © 2017年 俊严. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditAddressTableViewCellDelegte <NSObject>

- (void)editeAddressBtn:(NSInteger)index;
- (void)deleteAddressBtn:(NSInteger)index;
- (void)defaultAddressBtn:(NSInteger)index;
@end
@interface EditAddressTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * nameLabel;
@property (nonatomic, strong)UILabel * phoneLabel;
@property (nonatomic, strong)UILabel * addressLabel;
@property (nonatomic, strong)UIButton * submmitBtn;
@property (nonatomic, strong)NSDictionary * dataDic;

- (void)updateWithData:(NSDictionary *)dic;

@property (nonatomic, assign)id<EditAddressTableViewCellDelegte> delegate;
@end
