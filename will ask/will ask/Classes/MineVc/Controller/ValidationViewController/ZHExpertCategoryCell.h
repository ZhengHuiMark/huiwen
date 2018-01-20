//
//  ZHExpertCategoryCell.h
//  ZH
//
//  Created by yangxudong on 2018/1/11.
//  Copyright © 2018年 yangxudong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 专家身份证书分类cell
 */
@class certifications;
@class CertifiedExpertsModel;
@interface ZHExpertCategoryCell : UITableViewCell
@property (nonatomic, copy) NSString *titleCategory;
@property (nonatomic, strong) CertifiedExpertsModel *model;
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, copy) NSString *objectKey;
@property (nonatomic, copy) NSString *uploadFilePath;
@property (nonatomic, strong) certifications *certifications;
@property (nonatomic, strong) expert *expert;

- (CGFloat)calculateSelfHeight;
@end

@interface ZHImageCategory : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) NSInteger index;

@end
