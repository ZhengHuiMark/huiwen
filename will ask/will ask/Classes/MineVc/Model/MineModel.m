//
//  MineModel.m
//  will ask
//
//  Created by 郑晖 on 2017/9/15.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "MineModel.h"

@implementation MineModel


-(instancetype)initMineModelWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}




@end
