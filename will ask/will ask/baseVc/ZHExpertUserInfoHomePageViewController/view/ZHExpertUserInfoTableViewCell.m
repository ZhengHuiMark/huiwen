//
//  ZHExpertUserInfoTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/21.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHExpertUserInfoTableViewCell.h"
#import "ZHExpertUserInfoModel.h"
#import "Macro.h"
#import "ImageTools.h"
#import "UIImageView+WebCache.h"

@implementation ZHExpertUserInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //参数:圆角半径
    [self.shadowView.layer setCornerRadius:self.shadowView.bounds.size.width / 2];
    
    //切圆角如果是切带图片的控件，必须加上下面的代码才有效
    [self.userAvatar.layer setCornerRadius:self.userAvatar.bounds.size.width / 2];
    self.userAvatar.layer.masksToBounds = YES;
    
    self.clipsToBounds = YES;
    self.contentView.clipsToBounds = YES;
}

- (void)setExpertUserInfoModel:(ZHExpertUserInfoModel *)expertUserInfoModel{
    _expertUserInfoModel = expertUserInfoModel;
    
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.expertUserInfoModel.avatar]]];
    
    self.userName.text = self.expertUserInfoModel.nickname;
    
    self.hoor.text = self.expertUserInfoModel.honor;
    
    self.company.text = [NSString stringWithFormat:@"%@  职务: %@", self.expertUserInfoModel.company,self.expertUserInfoModel.duty];
    
//    self.position.text = [NSString stringWithFormat:@"职务:%@",self.expertUserInfoModel.duty];
    
    NSString * string = self.expertUserInfoModel.certifiedNames;
    string = [string stringByReplacingOccurrencesOfString:@" "withString:@"|"];
    string = [string substringToIndex:[string length] - 1];
//    self.expertUserInfoModel.certifiedNames = string;
    self.cerTitle.text = string;
//                                                     @"抢答：10次  接受咨询：30次  案例详解：5本",
     self.Numbers.text =  [NSString stringWithFormat:@"抢答:%@次 接受咨询:%@次 案例详解:%@本",self.expertUserInfoModel.answerNumber,self.expertUserInfoModel.caseAnalysisNumber,self.expertUserInfoModel.acceptConsultNumber];
//    if (self.expertUserInfoModel.caseAnalysisNumber) {
//        
//        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.Numbers.text];
//        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:242.0f / 255.0f green:90.0f / 255.0f blue:41.0f / 255.0f alpha:1.0f] range:NSMakeRange(3, 3)];
//        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:242.0f / 255.0f green:90.0f / 255.0f blue:41.0f / 255.0f alpha:1.0f] range:NSMakeRange(13, 3)];
//        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:242.0f / 255.0f green:90.0f / 255.0f blue:41.0f / 255.0f alpha:1.0f] range:NSMakeRange(20, 2)];
    
//        self.Numbers.text = att
//    }
    self.PersonalProfile.text = self.expertUserInfoModel.intro;
}
@end
