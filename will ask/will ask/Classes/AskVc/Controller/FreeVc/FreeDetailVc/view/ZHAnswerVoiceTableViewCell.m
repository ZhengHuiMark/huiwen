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
    

//    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"444.amr"];

//    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.amr",answerVoiceModel.voice]];

//   [service getFileObjectKey:answerVoiceModel.voice buckName:bucketNameFree filePath:fullPath];
    


    
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



@end
