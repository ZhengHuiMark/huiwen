//
//  ZHInvoiceMailTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/14.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHInvoiceModel;

@interface ZHInvoiceMailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UITextField *contentTextFiled;

@property(nonatomic,strong)NSIndexPath *indexPath;

@property(nonatomic,strong)ZHInvoiceModel *model;

@property (nonatomic, copy) void(^textFieldClickBlock)(NSString *tempStr);

@end
