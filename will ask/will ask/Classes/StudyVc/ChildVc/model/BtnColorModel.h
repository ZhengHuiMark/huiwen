//
//  BtnColorModel.h
//  will ask
//
//  Created by 郑晖 on 2017/11/24.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ReviewStatus) {
    ReviewStatusNormal,
    ReviewStatusSelected,
    ReviewStatusSuccess,
};


@interface BtnColorModel : NSObject


@property (nonatomic, assign) ReviewStatus status;

@end
