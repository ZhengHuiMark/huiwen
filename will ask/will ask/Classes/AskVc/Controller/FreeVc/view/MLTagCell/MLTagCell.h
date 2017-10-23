//
//  MLTagCell.h
//  xxxx
//
//  Created by CristianoRLong on 07/10/2017.
//  Copyright © 2017 CristianoRLong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLTagModelContainer, MLTagModel, MLTagButton, MLTagCell;


typedef void(^TagCellClick)(MLTagCell *cell, MLTagButton *tagButton, MLTagModel *tagModel);

@interface MLTagCell : UITableViewCell

@property (nonatomic, strong) MLTagModelContainer *tagContainer;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, copy) TagCellClick cellClick;

@end
