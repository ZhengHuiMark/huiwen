//
//  ZHExpertAnswerMeTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2018/1/23.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHExpertAnswerMeTableViewCell.h"
#import "ZHAllConsultingMeModel.h"
#import "MLAvatarDisplayView.h"
#import "ImageTools.h"

@interface ZHExpertAnswerMeTableViewCell()
@property (nonatomic, strong) MLAvatarDisplayView *avatarDisplayView;


@end
@implementation ZHExpertAnswerMeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ZHAllConsultingMeModel *)model{
    _model = model;
    
    self.expertNickName.text = model.expertNickname;
    self.expertCerTitle.text = model.expertCertifiedNames;
    [self.expertAnswerName sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,model.expertAvatar]]];
    self.expertAnswerContent.text = model.answerContent;
    [self.askimg setImage:[UIImage imageNamed:@"answer"]];
    
    NSArray *PhotoArray = [model.answerPhotos componentsSeparatedByString:@","];
    if (model.answerPhotos) {
        [PhotoArray arrayByAddingObject:model.answerPhotos];
    }
    NSLog(@"123  = %@",PhotoArray);
    
    NSInteger index = -1;
    NSLog(@"%zd",index);
    for (UIImageView *imageView in self.imgs) {
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
    
    UIImageView *imageView = self.imgs[sender.tag];
    
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
