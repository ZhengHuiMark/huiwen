//
//  ZHPaymentOptionsTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHPaymentOptionsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *payImage;
@property (weak, nonatomic) IBOutlet UILabel *payTitle;

@property (nonatomic,strong)NSIndexPath *indexPath;
@end
