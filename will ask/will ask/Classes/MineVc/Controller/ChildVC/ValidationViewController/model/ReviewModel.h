//
//  ReviewModel.h
//  XXXXXXX
//
//  Created by 郑晖 on 2017/10/14.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ReviewStatus) {
    ReviewStatusNormal,
    ReviewStatusSelected,
    ReviewStatusSuccess,
};

@interface ReviewModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray<UIImage *> *images;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) ReviewStatus status;

@end
