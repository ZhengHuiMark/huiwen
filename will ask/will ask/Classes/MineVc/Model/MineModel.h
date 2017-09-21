//
//  MineModel.h
//  will ask
//
//  Created by 郑晖 on 2017/9/15.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineModel : NSObject

-(instancetype)initMineModelWithDict:(NSDictionary *)dict;

//标题
@property(nonatomic,strong)NSString *name;
//图片
@property(nonatomic,strong)NSString *icon;
//右箭头
@property(nonatomic,strong)NSString *nextButton;


@end
