//
//  expertBtnView.h
//  expertTypeDemo
//
//  Created by 刘培策 on 2018/1/6.
//  Copyright © 2018年 UniqueCe. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *kSBtnTitleName = @"kSBtnTitleName";

@interface expertBtnView : UIView

/** 一行几个 */
@property(nonatomic,assign)int rowNum;

@property(nonatomic,strong) NSArray *arrayDataSource;

@end
