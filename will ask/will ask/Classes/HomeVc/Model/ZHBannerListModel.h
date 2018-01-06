//
//  ZHBannerListModel.h
//  will ask
//
//  Created by 郑晖 on 2018/1/6.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHBannerListModel : NSObject

// 链接地址
@property(nonatomic,copy)NSString *linkurl;
// 业务对象ID
@property(nonatomic,copy)NSString *objectId;
// 图片照片（推荐位管理）
@property(nonatomic,copy)NSString *picture;

/**
 轮播图类型
 1:专家、2:悬赏问、3:免费问、4:案例、5:链接
 */
@property(nonatomic,copy)NSString *type;


@end
