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
