//
//  ZHCaseDetailTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2018/1/17.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHCaseDetailModel;
@interface ZHCaseDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (nonatomic,strong)ZHCaseDetailModel *model;

+ (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width;


@end
