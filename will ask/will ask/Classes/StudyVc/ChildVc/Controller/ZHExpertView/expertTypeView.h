//
//  expertTypeView.h
//  expertTypeDemo
//
//  Created by 刘培策 on 2018/1/6.
//  Copyright © 2018年 UniqueCe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface expertTypeView : UIView

@property(nonatomic,strong) NSArray *btnStrArray;

/** 从上级计算 有多少行 */
@property(nonatomic,assign)int  rowNum;

@end
