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
    _model = model;
    
    [self.expertAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,model.expertAvatar]]];
    self.expertName.text = model.expertNickname;
//    self.cerTitle.
    [self.askStateImg setImage:[UIImage imageNamed:@"answer"]];
    self.time.text = model.answerTime;
    
    NSArray *PhotoArray = [self.model.answerPhotos componentsSeparatedByString:@","];
    if (model.answerPhotos) {
        [PhotoArray arrayByAddingObject:model.answerPhotos];
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
- (IBAction)btnAction:(UIButton *)sender {
    
    
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
