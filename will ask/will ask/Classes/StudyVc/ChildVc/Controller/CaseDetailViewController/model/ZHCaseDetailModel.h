//
//  ZHCaseDetailModel.h
//  will ask
//
//  Created by 郑晖 on 2018/1/17.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHCaseDetailModel : NSObject

@property (nonatomic,copy)NSString *title;

@property (nonatomic,copy)NSString *words;

@property (nonatomic,copy)NSString *readingTime;

@property (nonatomic,copy)NSString *content;

@property (nonatomic,assign)BOOL favorite;

@end
