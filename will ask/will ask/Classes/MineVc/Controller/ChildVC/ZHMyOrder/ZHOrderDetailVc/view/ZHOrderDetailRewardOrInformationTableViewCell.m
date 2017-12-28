//
//  ZHOrderDetailRewardOrInformationTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHOrderDetailRewardOrInformationTableViewCell.h"
#import "ZHOrderDetailRewardModel.h"
#import "ZHOrderDetailConsultModel.h"

#import "ImageTools.h"
#import "UIImageView+WebCache.h"
#import "Macro.h"
#import "MLAvatarDisplayView.h"
#import "ImageTools.h"

@interface ZHOrderDetailRewardOrInformationTableViewCell()

@property (nonatomic, strong) MLAvatarDisplayView *avatarDisplayView;


@end

@implementation ZHOrderDetailRewardOrInformationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRewardModel:(ZHOrderDetailRewardModel *)rewardModel{
    _rewardModel = rewardModel;
    
    
    self.contentLabel.text = self.rewardModel.content;
    
    NSArray *PhotoArray = [self.rewardModel.photos componentsSeparatedByString:@","];
    if (self.rewardModel.photos) {
        [PhotoArray arrayByAddingObject:self.rewardModel.photos];
    }
    NSLog(@"123  = %@",PhotoArray);
    NSInteger index = -1;
    NSLog(@"%zd",index);
    for (UIImageView *imageView in self.images) {
        index++;
        if (PhotoArray.count <= index) {
            imageView.hidden = YES;
            [self.imageBtns[index] setHidden: YES];
            continue;
        }
        imageView.hidden = NO;
        [self.imageBtns[index] setHidden: NO];
        [imageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@",bucketNameFreeLoad,OSS,PhotoArray[index]]]];
    }
}

- (void)setConsultModel:(ZHOrderDetailConsultModel *)consultModel{
    _consultModel = consultModel;
    
    self.contentLabel.text = self.consultModel.question;
    
    NSArray *PhotoArray = [self.consultModel.photos componentsSeparatedByString:@","];
    if (self.consultModel.photos) {
        [PhotoArray arrayByAddingObject:self.consultModel.photos];
    }
    NSLog(@"123  = %@",PhotoArray);
    
    NSInteger index = -1;
    NSLog(@"%zd",index);
    for (UIImageView *imageView in self.images) {
        index++;
        if (PhotoArray.count <= index) {
            imageView.hidden = YES;
            [self.imageBtns[index] setHidden: YES];
            continue;
        }
        imageView.hidden = NO;
        [self.imageBtns[index] setHidden: NO];
        [imageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@",bucketNameFreeLoad,OSS,PhotoArray[index]]]];
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
