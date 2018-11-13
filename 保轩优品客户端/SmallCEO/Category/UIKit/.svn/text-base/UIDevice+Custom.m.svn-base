//
//  UIDevice+Custom.m
//  CSLFrameWorkProject
//
//  Created by csl on 14-12-15.
//  Copyright (c) 2014年 chenweidong. All rights reserved.
//

#import "UIDevice+Custom.h"
#import <sys/sysctl.h>

@implementation UIDevice (Custom)


- (NSArray *)runningProcesses {
    
    int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0};
    size_t miblen = 4;
    
    size_t size;
    int st = sysctl(mib, miblen, NULL, &size, NULL, 0);
    
    struct kinfo_proc * process = NULL;
    struct kinfo_proc * newprocess = NULL;
    
    do {
        
        size += size / 10;
        newprocess = realloc(process, size);
        
        if (!newprocess){
            
            if (process){
                free(process);
            }
            
            return nil;
        }
        
        process = newprocess;
        st = sysctl(mib, miblen, process, &size, NULL, 0);
        
    } while (st == -1 && errno == ENOMEM);
    
    if (st == 0){
        
        if (size % sizeof(struct kinfo_proc) == 0){
            int nprocess = size / sizeof(struct kinfo_proc);
            
            if (nprocess){
                
                NSMutableArray * array = [[NSMutableArray alloc] init];
                
                for (int i = nprocess - 1; i >= 0; i--){
                    
                    NSString * processID = [[NSString alloc] initWithFormat:@"%d", process[i].kp_proc.p_pid];
                    NSString * processName = [[NSString alloc] initWithFormat:@"%s", process[i].kp_proc.p_comm];
                    NSString *p_stat=[[NSString alloc] initWithFormat:@"%c", process[i].kp_proc.p_stat];
                    
                    NSDictionary * dict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:processID, processName,p_stat, nil]
                                                                        forKeys:[NSArray arrayWithObjects:@"ProcessID", @"ProcessName",@"p_stat", nil]];

                    [array addObject:dict];

                }
                
                free(process);
                return array ;
            }
        }
    }
    
    return nil;
}


+(void)descripe{
    UIDevice *device_=[[UIDevice alloc] init];
    
    NSLog(@"设备所有者的名称－－%@",device_.name);
    
    NSLog(@"设备的类别－－－－－%@",device_.model);
    
    NSLog(@"设备的的本地化版本－%@",device_.localizedModel);
    
    NSLog(@"设备运行的系统－－－%@",device_.systemName);
    
    NSLog(@"当前系统的版本－－－%@",device_.systemVersion);
    
    NSLog(@"设备识别码－－－－－%@",device_.identifierForVendor.UUIDString);
    
    NSLog(@"当前系统的分辨率－－－%f",[UIScreen mainScreen].bounds.size.width*[UIScreen mainScreen].scale);
    
    
    
    NSLog(@"NSUserName－－－－－%@",NSUserName());
    
//    1，获取家目录路径的函数：
    NSString *homeDir = NSHomeDirectory();
    
    NSLog(@"沙盒路径－－－－－%@",homeDir);
//    2，获取Documents目录路径的方法：
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
     NSLog(@"docDir－－－－－%@",docDir);
//    3，获取Caches目录路径的方法：
    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths1 objectAtIndex:0];
    NSLog(@"cachesDir－－－－－%@",cachesDir);
//    4，获取tmp目录路径的方法：
    NSString *tmpDir = NSTemporaryDirectory();
    NSLog(@"tmpDir－－－－－%@",tmpDir);
}

-(void)removeCache{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

-(float)getCache{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    float docCache=[self folderSizeAtPath:docDir];
    
    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths1 objectAtIndex:0];
    
    
    float cachesDirCache=[self folderSizeAtPath:cachesDir];
    
    return docCache+cachesDirCache;
    
    
}


- (long long) fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

- (float ) folderSizeAtPath:(NSString*) folderPath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString* fileName;
    
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
        
    }
    
    return folderSize/(1024.0*1024.0);
    
}

@end
