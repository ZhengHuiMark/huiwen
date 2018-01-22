//
//  alertButtonView.h
//  alertTest
//
//  Created by 刘培策 on 2018/1/19.
//  Copyright © 2018年 UniqueCe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface alertButtonView : UIButton

//@property(nonatomic,strong) NSArray <NSString *>*dataSoure;
@property(nonatomic,strong) UILabel *leftLabel;

@property(nonatomic,strong) UILabel *rightLabel;

@property(nonatomic,copy) void(^numBlock)(NSInteger num);

- (void)showsAlertView;




@end
