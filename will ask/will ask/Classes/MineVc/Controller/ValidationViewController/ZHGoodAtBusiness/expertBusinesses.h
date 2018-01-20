//
//  expertBusinesses.h
//  will ask
//
//  Created by yangxudong on 2018/1/14.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class expertBusinessesDetail;
@interface expertBusinesses : NSObject
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSArray *expertBusinesses;
@end
