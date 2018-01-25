//
//  ZHMyConsultingVoiceTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/18.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMyConsultingVoiceTableViewCell.h"
#import "ZHAllMyDetailModel.h"
#import "MLAvatarDisplayView.h"

@interface ZHMyConsultingVoiceTableViewCell()

@property (nonatomic, strong) MLAvatarDisplayView *avatarDisplayView;


@end

@implementation ZHMyConsultingVoiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setVoiceModel:(ZHAllMyDetailModel *)voiceModel{
    _voiceModel = voiceModel;
    
    [self.expertAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,voiceModel.expertAvatar]]];
    self.expertName.text = voiceModel.expertNickname;
    
    self.cerTitle.text = voiceModel.expertCertifiedNames;
    
    [self.askStateImg setImage:[UIImage imageNamed:@"chase"]];
    
    self.time.text = voiceModel.addAnswerTime;
    
    NSArray *PhotoArray = [self.voiceModel.addAnswerPhotos componentsSeparatedByString:@","];
    if (voiceModel.addAnswerPhotos) {
        [PhotoArray arrayByAddingObject:voiceModel.addAnswerPhotos];
    }
    NSInteger index = -1;
    NSLog(@"%zd",index);
    for (UIImageView *imageView in self.images) {
        index++;
        if (PhotoArray.count <= index) {
            imageView.hidden = YES;
            [self.imageButtons[index] setHidden: YES];
            continue;
        }
        imageView.hidden = NO;
        [self.imageButtons[index] setHidden: NO];
        [imageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@",bucketNameConsultLoad,OSS,PhotoArray[index]]]];
    }

    
    
}

- (IBAction)buttonActions:(UIButton *)sender {
    
    UIImageView *imageView = self.images[sender.tag];
    
    [self.avatarDisplayView showFromImageView:imageView];
}


#pragma mark - Lazy load
- (MLAvatarDisplayView *)avatarDisplayView {
    if (!_avatarDisplayView) {
        _avatarDisplayView = [MLAvatarDisplayView ml_singleImageDisplayView];
    }
    return _avatarDisplayView;
}


@end
