//
//  ZHConsultingMeDetailTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2018/1/23.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHConsultingMeDetailTableViewCell.h"
#import "ZHAllConsultingMeModel.h"
#import "MLAvatarDisplayView.h"
#import "ImageTools.h"

@interface ZHConsultingMeDetailTableViewCell()

@property (nonatomic, strong) MLAvatarDisplayView *avatarDisplayView;

@end

@implementation ZHConsultingMeDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ZHAllConsultingMeModel *)model{
    _model = model;
    
    
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,model.userAvatar]]];
    self.userName.text = model.userNickname;
    self.cerTitle.text = model.userCertifiedNames;
    self.amount.text = [NSString stringWithFormat:@"%@元",model.amount];
    [self.askImg setImage:[UIImage imageNamed:@"ask"]];
    self.content.text = model.question;
    self.remainingTime.text = model.answerTimeRemaining;
    self.time.text = model.questionTime;
    
    NSArray *PhotoArray = [model.questionPhotos componentsSeparatedByString:@","];
    if (model.questionPhotos) {
        [PhotoArray arrayByAddingObject:model.questionPhotos];
    }
    NSLog(@"123  = %@",PhotoArray);
    
    NSInteger index = -1;
    NSLog(@"%zd",index);
    for (UIImageView *imageView in self.images) {
        index++;
        if (PhotoArray.count <= index) {
            imageView.hidden = YES;
            [self.BtnImages[index] setHidden: YES];
            continue;
        }
        imageView.hidden = NO;
        [self.BtnImages[index] setHidden: NO];
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
