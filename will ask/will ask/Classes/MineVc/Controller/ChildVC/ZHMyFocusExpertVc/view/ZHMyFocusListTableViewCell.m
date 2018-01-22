//
//  ZHMyFocusListTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/18.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMyFocusListTableViewCell.h"
#import "ZHMyFocusModel.h"
#import "ImageTools.h"
#import "UIImageView+WebCache.h"
#import "Macro.h"

@implementation ZHMyFocusListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ZHMyFocusModel *)model {
    _model = model;
    
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.model
                                                              .avatar]]];
    self.userName.text = self.model.nickname;
    
    self.hoor.text = self.model.honor;
    
    self.cerTitle.text = self.model.certifiedNames;

}


- (IBAction)cancelFocusAction:(UIButton *)sender {
    
    !self.didClick?:self.didClick();
    
}

- (IBAction)ImmediatelyConsultAction:(UIButton *)sender {
    
    !self.consultDidClick?:self.consultDidClick();

    
}


@end
