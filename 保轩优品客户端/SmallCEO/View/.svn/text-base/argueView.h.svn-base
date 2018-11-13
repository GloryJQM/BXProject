//
//  argueView.h
//  SmallCEO
//
//  Created by 俊严 on 15/10/26.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingBar.h"
#import "pyItemRatingScoreCustomView.h"

@class ArgueModel;

//@protocol argueViewDelegate <NSObject>
//
//- (void)getViewData:(NSArray *)dataArray;
//- (void)getNewModel:(ArgueModel *)model;
//@end

@interface argueView : UIView<UITextViewDelegate, RatingBarDelegate, pyStarRatingCustomViewDelegate,pyItemRatingScoreCustomViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong)UIImageView * goodsImageView;
@property (nonatomic, strong)NSMutableArray*scoreItemArr;
@property (nonatomic, strong)NSMutableString *starString;
@property (nonatomic, strong)UIButton *preButton;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *priceLabel;
@property (nonatomic, assign)NSInteger zongHeStartNum;

@property (nonatomic, strong)UITextView * argueTextView;

@property (nonatomic, strong)UIButton * isNiMingBtn;
//@property (nonatomic, assign) id<argueViewDelegate>delegate;


- (instancetype)initWithFrame:(CGRect)frame;

- (void)assignmentWithDataArray:(NSArray *)array;
- (void)assignmentWithModel:(ArgueModel *)model;

@end
