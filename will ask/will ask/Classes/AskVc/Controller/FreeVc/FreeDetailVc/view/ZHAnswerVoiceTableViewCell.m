//
//  ZHAnswerVoiceTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/10/31.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHAnswerVoiceTableViewCell.h"
#import "ZHFreeDetailModel.h"
#import "ZHFreeAnswerModel.h"
#import "ImageTools.h"
#import "UIImageView+WebCache.h"
#import "MLAvatarDisplayView.h"
#import "ICRecordManager.h"
#import "VoiceConverter.h"
#import "yuyinView.h"
#import <AVFoundation/AVFoundation.h>
#import "OSSService.h"


@interface ZHAnswerVoiceTableViewCell ()<ICRecordManagerDelegate>{
    OssService * service;

}

@property (nonatomic, strong) MLAvatarDisplayView *avatarDisplayView;
@property (nonatomic, strong) UIImageView *currentVoiceIcon;

@property (strong, nonatomic) IBOutlet yuyinView *voiceView;


@end

@implementation ZHAnswerVoiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    NSString * const endPoint = @"http://oss-cn-qingdao.aliyuncs.com";
    NSString * const callbackAddress = @"http://oss-demo.aliyuncs.com:23450";
    
    service = [[OssService alloc] initWithViewController:self withEndPoint:endPoint];
    [service setCallbackAddress:callbackAddress];
    
}



- (void)setDetailModel:(ZHFreeDetailModel *)detailModel {
    _detailModel = detailModel;
}


- (void)setAnswerVoiceModel:(ZHFreeAnswerModel *)answerVoiceModel {
    _answerVoiceModel = answerVoiceModel;
    
    
    self.answerName.text = answerVoiceModel.nickname;
    [self.userAvatarImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,answerVoiceModel.avatar]]];
    self.answerExpert.text = answerVoiceModel.certifiedNames;
    
    self.answerTime.text = answerVoiceModel.time;
//    self.playVoiceBtn
    
    self.pathStr = [NSString stringWithFormat:@"%@%@%@",bucketNameFreeLoad,OSS,answerVoiceModel.voice];
    NSLog(@"%@",self.pathStr);
    
//    self.voiceView = [yuyinView new];
//    self.voiceView.pathStr = self.pathStr;

    [service getFileObjectKey:answerVoiceModel.voice buckName:bucketNameFree];
    
    
    NSArray *PhotoArray = [self.answerVoiceModel.photos componentsSeparatedByString:@","];
    
    NSInteger index = -1;
    NSLog(@"%zd",index);
    for (UIImageView *imageView in self.answerImage) {
        index++;
        if (PhotoArray.count <= index) {
            imageView.hidden = YES;
            [self.answerImgBtn[index] setHidden: YES];
            continue;
        }
        imageView.hidden = NO;
        [self.answerImgBtn[index] setHidden: NO];
        [imageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@",bucketNameRewardLoad,OSS,PhotoArray[index]]]];
    }
    
}


- (IBAction)imgBtnAction:(UIButton *)sender {
    
    UIImageView *imageView = self.answerImage[sender.tag];
    [self.avatarDisplayView showFromImageView: imageView];
}

- (IBAction)actionBtn:(UIButton *)sender {
    
    !self.didClick?:self.didClick();
}


#pragma mark - Lazy load
- (MLAvatarDisplayView *)avatarDisplayView {
    if (!_avatarDisplayView) {
        _avatarDisplayView = [MLAvatarDisplayView ml_singleImageDisplayView];
    }
    return _avatarDisplayView;
}


// play voice
- (void)chatVoiceTapedMediaPath:(NSString *)path
                      VoiceIcon:(UIImageView *)voiceIcon
                        redView:(UIView *)redView
{
    // 文件路径
    NSString *voicePath = [self mediaPath:path];
    NSString *amrPath   = [[voicePath stringByDeletingPathExtension] stringByAppendingPathExtension:@"amr"];
    [VoiceConverter ConvertAmrToWav:amrPath wavSavePath:voicePath];
    
    
    ICRecordManager *recordManager = [ICRecordManager shareManager];
    recordManager.playDelegate = self;
    
    [[ICRecordManager shareManager] startPlayRecorder:voicePath];
    [voiceIcon startAnimating];
    self.currentVoiceIcon = voiceIcon;
}

- (void)setPathStr:(NSString *)pathStr {
    
    _pathStr = pathStr;
    NSString *voicePath = [self mediaPath:pathStr];
    self.VoiceTimeL.text  = [NSString stringWithFormat:@"%ld''",[[ICRecordManager shareManager] durationWithVideo:[NSURL fileURLWithPath:voicePath]]];
    
//    self.voiceIcon.image = [UIImage imageNamed:@"voice3"];
//    UIImage *image1 = [UIImage imageNamed:@"voice1"];
//    UIImage *image2 = [UIImage imageNamed:@"voice2"];
//    UIImage *image3 = [UIImage imageNamed:@"voice3"];
//    self.voiceIcon.animationImages = @[image1, image2, image3];
//    self.voiceIcon.animationDuration = 0.8;
    
}
// 文件路径
- (NSString *)mediaPath:(NSString *)originPath
{
    // 这里文件路径重新给，根据文件名字来拼接
    NSString *name = [[originPath lastPathComponent] stringByDeletingPathExtension];
    return [[ICRecordManager shareManager] receiveVoicePathWithFileKey:name];
}

@end
