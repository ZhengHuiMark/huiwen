//
//  ZHMyChaseAskTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/18.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMyChaseAskTableViewCell.h"
#import "ZHAllMyDetailModel.h"
#import "ImageTools.h"
#import "UIImageView+WebCache.h"
#import "MLAvatarDisplayView.h"
#import "Macro.h"

@interface ZHMyChaseAskTableViewCell()

@property(nonatomic,strong)MLAvatarDisplayView *avatarDisplayView;


@end

@implementation ZHMyChaseAskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDetailModel:(ZHAllMyDetailModel *)detailModel{
    _detailModel = detailModel;
    
                self.userName.text = self.detailModel.userNickname;
                [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.detailModel.userAvatar]]];
                self.content.text = self.detailModel.addQuestion;
                self.askTime.text = self.detailModel.addQuestionTime;
    
                NSArray *PhotoArray = [self.detailModel.addQuestionPhotos componentsSeparatedByString:@","];
    
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
