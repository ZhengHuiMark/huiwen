//
//  ZHMyConsultingAnswerVoiceTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/18.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMyConsultingAnswerVoiceTableViewCell.h"
#import "ZHAllMyDetailModel.h"
#import "MLAvatarDisplayView.h"

@interface ZHMyConsultingAnswerVoiceTableViewCell()

@property (nonatomic, strong) MLAvatarDisplayView *avatarDisplayView;


@end

@implementation ZHMyConsultingAnswerVoiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ZHAllMyDetailModel *)model{
    
    
    
}



#pragma mark - Lazy load
- (MLAvatarDisplayView *)avatarDisplayView {
    if (!_avatarDisplayView) {
        _avatarDisplayView = [MLAvatarDisplayView ml_singleImageDisplayView];
    }
    return _avatarDisplayView;
}
@end
