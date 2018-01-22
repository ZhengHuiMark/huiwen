//
//  ZHImageCategory.h
//  will ask
//
//  Created by 郑晖 on 2018/1/21.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 图片类型对象
 */
@interface ZHImageCategory : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString *objectKey;
@property (nonatomic, copy) NSString *uploadFilePath;

@end
