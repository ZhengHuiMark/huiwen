//
//  ZHConsultingMeAnswerVoiceTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2018/1/23.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHConsultingMeAnswerVoiceTableViewCell.h"
#import "ZHAllConsultingMeModel.h"
#import "MLAvatarDisplayView.h"
#import "ImageTools.h"

@interface ZHConsultingMeAnswerVoiceTableViewCell ()

@property (nonatomic, strong) MLAvatarDisplayView *avatarDisplayView;


@end
@implementation ZHConsultingMeAnswerVoiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(ZHAllConsultingMeModel *)model{
    _model = model;
    
    self.expertName.text = model.expertNickname;
    [self.expertAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,model.expertAvatar]]];
    self.cerTitle.text = model.expertCertifiedNames;
    [self.askImg setImage:[UIImage imageNamed:@"answer"]];
    self.time.text = model.answerTime;
    
    NSArray *PhotoArray = [model.answerPhotos componentsSeparatedByString:@","];
    if (model.answerPhotos) {
        [PhotoArray arrayByAddingObject:model.answerPhotos];
    }
    NSLog(@"123  = %@",PhotoArray);
    
    NSInteger index = -1;
    NSLog(@"%zd",index);
    for (UIImageView *imageView in self.images) {
        index++;
        if (PhotoArray.count <= index) {
            imageView.hidden = YES;
            [self.btnImgs[index] setHidden: YES];
            continue;
        }
        imageView.hidden = NO;
        [self.btnImgs[index] setHidden: NO];
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
