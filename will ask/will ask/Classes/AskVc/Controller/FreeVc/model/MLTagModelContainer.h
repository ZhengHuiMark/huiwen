//
//  MLTagModelContainer.h
//  xxxx
//
//  Created by CristianoRLong on 07/10/2017.
//  Copyright © 2017 CristianoRLong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MLTagModel;

@interface MLTagModelContainer : NSObject

@property (nonatomic, strong) NSArray<MLTagModel *> *tagModels;
@property (nonatomic, assign) CGFloat cellHeight;

@end
