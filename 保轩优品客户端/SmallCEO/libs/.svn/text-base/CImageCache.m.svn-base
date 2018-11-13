//
//  FileRead_Write.m
//  CslProject
//
//  Created by csl on 14-12-17.
//  Copyright (c) 2014年 chenweidong. All rights reserved.
//

#import "CImageCache.h"

static CImageCache *share=nil;
static NSCache *cimageCache=nil;
static NSString *subDirectory=nil;




@implementation NSData (pathCustom)

-(void)writeToMyPathWithName:(NSString *)fileSaveName{
    [[CImageCache sharedInstance] writeDataToFile:self imageName:fileSaveName];
}

@end


@implementation UIImageView (CImageCache)

-(void)c_setImageWithUrl:(NSString *)urlString{
    self.image=nil;
   dispatch_async(dispatch_get_global_queue(0, 0), ^{
       UIImage *image= [[CImageCache sharedInstance] getCacheImageWithUrlstring:urlString];
       if (image==nil) {
           [self getNetImageWithUrl:[NSString stringWithFormat:@"%@",urlString]];
       }else{
           dispatch_async(dispatch_get_main_queue(), ^{
               self.image=image;
                [cimageCache setObject:image forKey:@"jack"];
           });
       }
   });
}


-(void)getNetImageWithUrl:(NSString *)urlString{
    
    
    static NSLock *tempLock=nil;
    
    tempLock=[[NSLock alloc] init];
    
    
    if (![urlString hasPrefix:@"http"]) {
        return;
    }
    
    __weak UIImageView *weakSelf=self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [[CImageCache sharedInstance ] cacheNetImageWithUrl:urlString success:^(UIImage *image) {
            strongSelf.image=image;
        } fail:^{
            strongSelf.image=nil;
        }];
    });
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(){
    
}

@end



@implementation CImageCache



+ (id) sharedInstance
{
    
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        share=[[self alloc] init];
        
        NSLog(@"CImageCache inited");
    });
    
    return share;
    
    
}

- (id)init
{
    @synchronized(self) {
        share=[super init];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        subDirectory = [documentsDirectory stringByAppendingPathComponent:@"CImageCache"];
        [fileManager createDirectoryAtPath:subDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        NSLog(@"Read_Write Directory:%@",subDirectory);
        cimageCache=[[NSCache alloc] init];
        return self;
    }
}






-(UIImage *)getCacheImageWithUrlstring:(NSString *)urlString{
    NSRange range=[urlString rangeOfString:@"/" options:NSBackwardsSearch];
    NSRange newrange;
    newrange.location=range.location+1;
    newrange.length=urlString.length-range.location-1;
    NSString *imageName=[urlString substringWithRange:newrange];
    
    
    UIImage *image=[self readImageWithname:imageName];
    
    if (image!=nil) {
        NSLog(@"success");
        return image;
    }else{
        NSLog(@"fail");
        return nil;
    }
}

-(void)cacheNetImageWithUrl:(NSString *)urlString  success:(succellBlock)sblock fail:(failBlock)fblock{
    
    
    NSString *tempUrlString=[NSString stringWithFormat:@"%@",urlString];
    NSURL *url = [NSURL URLWithString:tempUrlString];
    if (![urlString hasPrefix:@"http"]) {
        fblock();
    }
    NSLog(@"url:%@ urlstring:%@",url,urlString);

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(){
        
        __strong typeof(url) strongUrl=url;
        UIImage *imga = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:strongUrl]];
        NSRange range=[urlString rangeOfString:@"/" options:NSBackwardsSearch];
        NSRange newrange;
        newrange.location=range.location+1;
        newrange.length=strongUrl.absoluteString.length-range.location-1;
        NSString *imageName=[strongUrl.absoluteString substringWithRange:newrange];
        /*图片名字有.*/
        if (!(([imageName rangeOfString:@"."].location == NSNotFound) ? NO : YES)) {
            dispatch_async(dispatch_get_main_queue(), ^{
                fblock();
            });
            
        }
        if (imga==nil) {
            NSLog(@"nil result");
            dispatch_async(dispatch_get_main_queue(), ^{
                fblock();
            });
        }else{
            
            DLog(@"test2");
//            sblock(imga);
            dispatch_async(dispatch_get_main_queue(), ^{
                DLog(@"test1");
                sblock(imga);
               
            });
        }
        [self writeImage:imga imageName:imageName];
    });
    
}




#pragma mark - 基本功能  删除  读写

/*用于nsdata的分类*/
-(void)writeDataToFile:(NSData *)data  imageName:(NSString *)name{
    // 创建目录
    NSString *filePath = [subDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",name]];
    NSData *tempData=[[NSData alloc] initWithData:data];
    BOOL result = [tempData writeToFile: filePath    atomically:YES];
    if(result){
        NSLog(@"保存成功");
    }else{
        NSLog(@"保存失败");
    }
    
}

-(NSArray *)getAllFile{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *fileList;
    fileList =[fileManager contentsOfDirectoryAtPath:subDirectory error:NULL];
    return [NSArray arrayWithArray:fileList];
}

-(void)deleteDocumentWithDocname:(NSString *)subDir{
    NSString *documentDir =[subDirectory stringByAppendingPathComponent:subDir];
    BOOL s=[[NSFileManager defaultManager] removeItemAtPath:documentDir error:nil];
    if (s ) {
        NSLog(@"drop dir success");
    }else{
        NSLog(@"drop dir fail");
    }
}

-(void)cleanAllImage{
    //    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray *arr=[self getAllFile];
    for (int i=0; i<[arr count]; i++) {
        NSString *fileName=[arr objectAtIndex:i];
        [self cleanFileByName:fileName];
    }
}

-(void)cleanFileByName:(NSString *)name{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    //文件名
    NSString *uniquePath=[subDirectory stringByAppendingPathComponent:name];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
        NSLog(@"no  have");
        return ;
    }else {
        NSLog(@" have");
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele) {
            NSLog(@"dele success");
        }else {
            NSLog(@"dele fail");
        }
        
    }
}


-(UIImage *)readImageWithname:(NSString *)imagename{
    NSString *filePath = [subDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",imagename]];
    UIImage *image=[UIImage imageWithContentsOfFile:filePath];
    return image;
}


-(void)writeImage:(UIImage *)image  imageName:(NSString *)name{
    // 创建目录
    NSString *filePath = [subDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",name]];
    BOOL result = [UIImagePNGRepresentation(image) writeToFile: filePath    atomically:YES];
    DLog(@"result:%d",result);
    
}

@end
