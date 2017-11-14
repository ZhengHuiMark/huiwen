//
//  ZHRewardCellTableViewCell.m
//  demoReward
//
//  Created by 郑晖 on 2017/10/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHChooseTypeTableViewCell.h"
#import "ZHChooseTypeBtnContainer.h"
#import "ZHChooseTypeBtnModel.h"
#import "ZHChooseTypeSubTagModel.h"
#import "ZHChooseTypeBtn.h"

@interface ZHChooseTypeTableViewCell()
    
@property (nonatomic, strong) NSMutableArray<ZHChooseTypeBtn *> *subTagButtons;



@end

@implementation ZHChooseTypeTableViewCell

- (void)setTagModel:(ZHChooseTypeBtnModel *)tagModel {
    _tagModel = tagModel;
    
    [self createSubTagButton: tagModel.subTags];
}

- (void)createSubTagButton:(NSArray<ZHChooseTypeSubTagModel *> *)tagModels {
    
    for (NSInteger index=0; index<tagModels.count; index++) {
        
        ZHChooseTypeBtn *tagButton = nil;
        if (self.subTagButtons.count > index) {
            tagButton = [self.subTagButtons objectAtIndex: index];
        } else {
            tagButton = [ZHChooseTypeBtn tagButtonWithType: MLTagButtonTypeTitleOnly];
            tagButton.action = ^(ZHChooseTypeBtn *tagButton, ZHChooseTypeBtnModel *tagModel){ 
                !self.cellClick?:self.cellClick(self, tagButton, tagModel);
                [self.tableView reloadData];
            };
            [self.contentView addSubview: tagButton];
            [self.subTagButtons addObject: tagButton];
        }
        
        tagButton.tagModel = [tagModels objectAtIndex: index];
    }
}

- (NSMutableArray<ZHChooseTypeBtn *> *)subTagButtons {
    if (!_subTagButtons) {
        _subTagButtons = [NSMutableArray array];
    }
    return _subTagButtons;
}


@end
