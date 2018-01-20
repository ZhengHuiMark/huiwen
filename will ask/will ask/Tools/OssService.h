//
//  OssService.h
//  OssIOSDemo
//
//  Created by 凌琨 on 15/12/15.
//  Copyright © 2015年 Ali. All rights reserved.
//

#ifndef OssService_h
#define OssService_h
#import <AliyunOSSiOS/OSSService.h>
#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

#import <AVFoundation/AVFoundation.h>

typedef void(^UploadImageCompletion)(BOOL isSuccess);

@interface OssService : NSObject<AVAudioRecorderDelegate,AVAudioPlayerDelegate>

@property(nonatomic,strong) AVAudioPlayer *player;
- (id)initWithViewController:(UIViewController *)view
                withEndPoint:(NSString *)enpoint;

- (void)setCallbackAddress:(NSString *)address;

- (void)asyncPutImage:(NSString *)objectKey
        localFilePath:(NSString *)filePath;

- (void)asyncPutImage:(NSString *)objectKey
        localFilePath:(NSString *)filePath
             bucketName:(NSString *)bucketName
            comletion:(UploadImageCompletion)completion;

- (void)asyncGetImage:(NSString *)objectKey;

- (void)resumableUpload:(NSString *)objectKey
          localFilePath:(NSString *)filePath
               partSize:(int)size;
// 文件下载
- (void)getFileObjectKey:(NSString *)ObjectKey buckName:(NSString *)buckName filePath:(NSString *)filePath;

- (void)normalRequestCancel;
- (void)ResumableUploadCancel;
- (void)resumableUploadPause;

@end

#endif /* OssService_h */
