//
//  QRCodeScanViewController.h
//  JDQX
//
//  Created by pan on 13-11-12.
//  Copyright (c) 2013年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXingObjC.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@class QRCodeScanViewController;

@protocol QRCodeScanViewControllerDelegate <NSObject>

@optional
- (void)customViewController:(UIViewController *)controller didScanResult:(NSString *)result;
- (void)customViewControllerDidCancel:(UIViewController *)controller;

@end

@interface QRCodeScanViewController : UIViewController <ZXCaptureDelegate>
{
    BOOL _scaned;
    NSString *_result;
    NSString *_goodsId;
    int     saomaType;
}
@property (nonatomic, assign) id<QRCodeScanViewControllerDelegate> delegate;
@property (strong, nonatomic, readonly) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end
