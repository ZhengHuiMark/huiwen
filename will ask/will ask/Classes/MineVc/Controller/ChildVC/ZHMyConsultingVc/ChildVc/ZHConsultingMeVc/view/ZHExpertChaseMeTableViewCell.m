//
//  ZHExpertChaseMeTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2018/1/23.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHExpertChaseMeTableViewCell.h"
#import "ZHAllConsultingMeModel.h"
#import "MLAvatarDisplayView.h"
#import "ImageTools.h"

@interface ZHExpertChaseMeTableViewCell()


@property (nonatomic, strong) MLAvatarDisplayView *avatarDisplayView;

@end
@implementation ZHExpertChaseMeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ZHAllConsultingMeModel *)model{
    _model = model;
    
    self.expertChaseNickName.text = model.expertNickname;
    [self.expertChaseAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,model.expertAvatar]]];
    self.expertChaseCer.text = model.expertCertifiedNames;
    self.expertContentChase.text = model.addAnswerContent;
    self.expertTime.text = model.addAnswerTime;
    [self.expertImgChase setImage:[UIImage imageNamed:@"answer"]];  
    
    NSArray *PhotoArray = [model.addAnswerPhotos componentsSeparatedByString:@","];
    if (model.addAnswerPhotos) {
        [PhotoArray arrayByAddingObject:model.addAnswerPhotos];
    }
    NSLog(@"123  = %@",PhotoArray);
    
    NSInteger index = -1;
    NSLog(@"%zd",index);
    for (UIImageView *imageView in self.expertChaseImages) {
        index++;
        if (PhotoArray.count <= index) {
            imageView.hidden = YES;
            [self.expertChaseBtnImages[index] setHidden: YES];
            continue;
        }
        imageView.hidden = NO;
        [self.expertChaseBtnImages[index] setHidden: NO];
        [imageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@",bucketNameConsultLoad,OSS,PhotoArray[index]]]];
    }

}

- (IBAction)btnAction:(UIButton *)sender {
    
    UIImageView *imageView = self.expertChaseImages[sender.tag];
    
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
