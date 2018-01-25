//
//  ZHMeChaseAskTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2018/1/23.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHMeChaseAskTableViewCell.h"
#import "ZHAllConsultingMeModel.h"
#import "MLAvatarDisplayView.h"
#import "ImageTools.h"

@interface ZHMeChaseAskTableViewCell()
@property (nonatomic, strong) MLAvatarDisplayView *avatarDisplayView;


@end
@implementation ZHMeChaseAskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(ZHAllConsultingMeModel *)model{
    _model = model;
    
    [self.userChaseAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,model.userAvatar]]];
    
    self.userChaseName.text = model.userNickname;
    self.userChaseCerTitle.text = model.userCertifiedNames;
    self.userChaseContent.text = model.addQuestion;
    [self.userChaseAskImg setImage:[UIImage imageNamed:@"chase"]];
    self.userChaseTime.text = model.addQuestionTime;
    
    NSArray *PhotoArray = [model.addQuestionPhotos componentsSeparatedByString:@","];
    if (model.addQuestionPhotos) {
        [PhotoArray arrayByAddingObject:model.addQuestionPhotos];
    }
    NSLog(@"123  = %@",PhotoArray);
    
    NSInteger index = -1;
    NSLog(@"%zd",index);
    for (UIImageView *imageView in self.userChaseImgs) {
        index++;
        if (PhotoArray.count <= index) {
            imageView.hidden = YES;
            [self.userChaseBtnImgs[index] setHidden: YES];
            continue;
        }
        imageView.hidden = NO;
        [self.userChaseBtnImgs[index] setHidden: NO];
        [imageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@",bucketNameConsultLoad,OSS,PhotoArray[index]]]];
    }

    
}
- (IBAction)btnAction:(UIButton *)sender {
    
    UIImageView *imageView = self.userChaseImgs[sender.tag];
    
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
