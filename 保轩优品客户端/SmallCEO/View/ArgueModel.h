//
//  ArgueModel.h
//  SmallCEO
//
//  Created by XuMengFan on 15/11/8.
//  Copyright © 2015年 lemuji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArgueModel : NSObject

@property (nonatomic, copy) NSString * aid;/**< 商品图片下载地址*/

@property (nonatomic, copy) NSString * picurl;/**< 商品图片下载地址*/
@property (nonatomic, copy) NSString * goodsImageName;/**< 商品图片名字*/
@property (nonatomic, copy) NSString * goodsName;/**< 商品名字*/
@property (nonatomic, copy) NSString * goodsPrice;/**< 商品价格*/
@property (nonatomic, assign) NSInteger totalValueNum;/**< 综合评价*/
@property (nonatomic, copy) NSString * adviceStr;/**< 商品评价*/
@property (nonatomic, assign) NSInteger descriptionNum;/**< 描述相符*/
@property (nonatomic, assign) NSInteger speedNum;/**< 发货速度*/
@property (nonatomic, assign) NSInteger consultNum;/**< 服务咨询*/

@property (nonatomic, copy) NSString * goodsPicurl;/**< 商品图片下载地址*/
@property (nonatomic, strong) UIImage * goodsImage;/**< 拍照的图片*/






@end
