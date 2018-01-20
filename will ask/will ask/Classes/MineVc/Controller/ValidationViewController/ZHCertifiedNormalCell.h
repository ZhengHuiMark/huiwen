//
//  ZHCertifiedNormalCell.h
//  hui
//
//  Created by yangxudong on 2018/1/1.
//  Copyright © 2018年 yangxudong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 认证专家第一种cell(文字)
 */

@class expert;
@interface ZHCertifiedNormalCell : UITableViewCell <UITextFieldDelegate>
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, strong) NSIndexPath *index;
@property (nonatomic, copy) NSString *editEndTitle;
@property (nonatomic, copy) void((^ChangeTitleSucessBlock)(NSString *title));
@property (nonatomic, strong) expert *expertModel;
@end
