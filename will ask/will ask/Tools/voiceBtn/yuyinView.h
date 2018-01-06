//
//  yuyinView.h
//  录音demo
//
//  Created by 刘培策 on 2017/11/9.
//  Copyright © 2017年 lzhl_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface yuyinView : UIView

@property(nonatomic,strong) NSString *pathStr;


- (NSString *)mediaPath:(NSString *)originPath;


@end
