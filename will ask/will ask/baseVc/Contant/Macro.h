//
//  Macro.h
//  test
//
//  Created by 郑晖 on 2017/3/31.
//  Copyright © 2017年 郑晖. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define kDegug 1 // 是否测试

#if kDegug
    #define kIP @"http://192.168.0.21:7000" // 本地环境
#else
    #define kIP @"http://119.57.140.230:7000" // 生产环境
#endif


#endif /* Macro_h */

//#define kIP @"http://123.206.94.48:8080" // 测试环境
//    #define kIP @"http://www.5idw.cn" // 生产环境

//123.206.94.48
