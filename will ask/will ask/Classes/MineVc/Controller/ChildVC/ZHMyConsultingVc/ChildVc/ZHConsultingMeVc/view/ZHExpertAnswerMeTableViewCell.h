//
//  ZHExpertAnswerMeTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2018/1/23.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHAllConsultingMeModel;
NS_ASSUME_NONNULL_BEGIN
@interface ZHExpertAnswerMeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *expertAnswerName;

@property (weak, nonatomic) IBOutlet UILabel *expertNickName;
@property (weak, nonatomic) IBOutlet UILabel *expertCerTitle;
@property (weak, nonatomic) IBOutlet UILabel *expertAnswerContent;
@property (weak, nonatomic) IBOutlet UIImageView *askimg;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgs;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnImgs;

@property (nonnull,strong)ZHAllConsultingMeModel *model;

@end
NS_ASSUME_NONNULL_END
