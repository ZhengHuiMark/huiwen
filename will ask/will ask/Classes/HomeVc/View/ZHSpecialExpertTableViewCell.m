//
//  ZHSpecialExpertTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2018/1/2.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHSpecialExpertTableViewCell.h"
#import "ZHStudyModel.h"
#import "Macro.h"
#import "UIImageView+WebCache.h"
#import "ImageTools.h"

@implementation ZHSpecialExpertTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setStuModel:(ZHStudyModel *)stuModel{
    _stuModel = stuModel;
    
    [self.expertAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameDwsoftLoad,OSS,self.stuModel.picture]]];
    
    self.expertName.text = self.stuModel.nickname;
    
    self.hoor.text = self.stuModel.honor;
    
    self.cerTitle.text = self.stuModel.certifiedNames;
    
    self.intro.text = self.stuModel.intro;
    
}
@end
