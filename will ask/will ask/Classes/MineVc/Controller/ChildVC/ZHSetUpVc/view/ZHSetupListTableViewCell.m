//
//  ZHSetupListTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2018/1/2.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHSetupListTableViewCell.h"

@implementation ZHSetupListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    
    switch (indexPath.row) {
        case 0:{
            self.titleLabel.text = @"修改密码";
        }
            
            break;
        case 1:{
            self.titleLabel.text = @"联系我们";
        }
            
            break;
        case 2:{
            self.titleLabel.text = @"关于我们";
        }
            
            break;
        case 3:{
            self.titleLabel.text = @"帮助";
        }
            
            break;
            
        default:
            break;
    }
}

@end
