//
//  ShopCartCell.h
//  Lemuji
//
//  Created by quanmai on 15/7/16.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumSelectView.h"
#import "ShopCartNumChangeView.h"


@protocol ShopCartCellDelegate <NSObject>

-(void)changeCommodityNumWithIndex:(NSInteger)index   num:(NSString *)num;

-(void)beginEditWithIndex:(NSInteger)index;

-(void)selectAttrAtIndex:(NSInteger)index;

-(void)selectNameLabel:(NSInteger)index;

@optional
- (void)selectStatusDidchange:(NSInteger)index;

- (void)clickDeleteButton:(NSInteger)index;

@end


@interface ShopCartCell : UITableViewCell<UITextFieldDelegate>{
    UILabel *nameLabel;
    
}

@property(nonatomic,assign) id<ShopCartCellDelegate> delegate;
@property(nonatomic,strong) UIButton *choseComBtn;
@property(nonatomic,strong) UIButton *finishBtn;
@property(nonatomic,strong) NSMutableDictionary *myDic;
@property(nonatomic,strong) NumSelectView *numSelect;

@property(nonatomic,strong) UILabel* priceLab;
@property(nonatomic,strong) UILabel* nameLab;
@property(nonatomic,strong) UIImageView* picImg;
@property(nonatomic,strong) UILabel* thLab;
@property(nonatomic,strong) UIImageView *imageArrowView;
@property(nonatomic,strong) ShopCartNumChangeView *numChangeV;
@property(nonatomic,strong) UIButton *exitBtn;

-(void)updateWithDic:(NSMutableDictionary *)dic isEdit:(BOOL)bol;

-(void)updataWhenOnly:(NSDictionary*)dic;
-(void)updataWhenHome:(NSDictionary*)dic;
-(void)updataWhenClassify:(NSDictionary*)dic;
-(void)setGGWith:(NSString*)one andTwo:(NSString*)two andThree:(NSString*)three;
- (void)setGGWith:(NSString *)guigeStr;

- (void)resetDeleteButtonStatus:(NSInteger)status;

/*商品清单*/
-(void)updateWithDicFromGoodList:(NSMutableDictionary *)dic isEdit:(BOOL)bol;

@end
