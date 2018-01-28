//
//  ZHCertificateCell.h
//  ZH
//
//  Created by yangxudong on 2018/1/11.
//  Copyright © 2018年 yangxudong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 身份证cell
 */
@class CertifiedExpertsModel, expert, ZHImageCategory;
@interface ZHCertificateCell : UITableViewCell

@property (nonatomic, assign) BOOL isCertification; // 是否认证
@property (nonatomic, strong) NSArray *categoryArr;
@property (nonatomic, strong) UIImage *frontImg;
@property (nonatomic, strong) UIImage *reverseImg;
@property (nonatomic, copy) NSString *objectKey;
@property (nonatomic, copy) NSString *uploadFilePath;
@property (nonatomic, strong) expert *expert;
@property (nonatomic, strong) ZHImageCategory *imageFront;
@property (nonatomic, strong) ZHImageCategory *imageBack;
@property (nonatomic, strong) NSArray *isCertificationCateArr;
/**
 选中专家类别
 */
@property (nonatomic, copy) void((^SelectedExpertCategoryBlcok)(CertifiedExpertsModel *model,BOOL isSed));

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier categoryArr:(NSArray *)arr;
@end

