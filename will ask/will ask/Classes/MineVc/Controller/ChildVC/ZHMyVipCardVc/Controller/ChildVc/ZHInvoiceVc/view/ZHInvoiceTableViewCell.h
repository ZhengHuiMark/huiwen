//
//  ZHInvoiceTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/14.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHInvoiceModel;

@interface ZHInvoiceTableViewCell : UITableViewCell

@property (nonatomic,strong)NSIndexPath *indexPath;

@property (weak, nonatomic) IBOutlet UITextField *contentTextFiled;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property( nonatomic,strong)ZHInvoiceModel *model;

@property (nonatomic, copy) void(^textFieldClickBlock)(NSString *tempStr);

@end
