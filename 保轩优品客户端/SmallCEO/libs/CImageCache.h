//
//  FileRead_Write.h
//  CslProject
//
//  Created by csl on 14-12-17.
//  Copyright (c) 2014年 chenweidong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



//ios存储数据的方式
/*
 1.使用NSKeyedArchiver，就是归档压缩。压缩和解压都是整个，所以适合小数据；
 2.使用nsurserdefault standardDefault
 3.使用数据库 sqlite
 4.使用沙盒；
 这里使用的是沙盒
 
 */


@interface NSData (pathCustom)

-(void)writeToMyPathWithName:(NSString *)fileSaveName;

@end


@interface UIImageView (CImageCache)

-(void)c_setImageWithUrl:(NSString *)url;

@end



typedef void (^succellBlock)( UIImage * image );

typedef void(^failBlock)(void);

@interface CImageCache : NSObject{
    
}

+(id)sharedInstance;


-(UIImage *)getCacheImageWithUrlstring:(NSString *)urlString;
-(void)cacheNetImageWithUrl:(NSString *)urlString  success:(succellBlock)sblock fail:(failBlock)fblock;

/*删除*/
-(void)cleanFileByName:(NSString *)name;
-(void)cleanAllImage;
-(void)deleteDocumentWithDocname:(NSString *)subDir;


/*用于nsdata的分类*/
-(void)writeDataToFile:(NSData *)data  imageName:(NSString *)name;


@end
