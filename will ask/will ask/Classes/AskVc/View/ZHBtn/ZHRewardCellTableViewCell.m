//
//  ZHRewardCellTableViewCell.m
//  demoReward
//
//  Created by 郑晖 on 2017/10/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHRewardCellTableViewCell.h"
#import "ZHBtn.h"
#import "ZHBtnContainer.h"
#import "ZHBtnModel.h"
#import "ZHAskModel.h"

@interface ZHRewardCellTableViewCell()

    
@property (nonatomic, strong) NSMutableArray<ZHBtn *> *subTagButtons;



@end

@implementation ZHRewardCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createTagButton];
    }
    
    return self;
    
}

- (void)refreshUI {
    
    // 隐藏所有子标签按钮
    
    // 创建标签按钮
    [self createTagButton];
}



- (void)createTagButton {
    
    NSArray<ZHBtnModel *> *arrTagModels = self.tagContainer.BtnTagModels;
    for (NSInteger index=0; index<arrTagModels.count; index++) {
        
        ZHBtn *tagButton = nil;
        if (self.subTagButtons.count > index) {
            tagButton = [self.subTagButtons objectAtIndex: index];
        } else {
            tagButton = [ZHBtn tagButtonWithType: MLTagButtonTypeImage];
            tagButton.clipsToBounds = YES;
     
            [self.contentView addSubview: tagButton];
            [self.subTagButtons addObject: tagButton];
        }
        
        tagButton.tagModel = [arrTagModels objectAtIndex: index];
        
     
        
    }
}


- (void)setTagContainer:(ZHBtnContainer *)tagContainer {
    _tagContainer = tagContainer;
    self.autoresizingMask = NO;
    self.contentView.autoresizingMask = NO;
    
    NSArray<ZHBtnModel *> *arrTagModels = self.tagContainer.BtnTagModels;
    for (NSInteger index=0; index<arrTagModels.count; index++) {
        
        ZHBtn *tagButton = nil;
        if (self.subTagButtons.count > index) {
            tagButton = [self.subTagButtons objectAtIndex: index];
        } else {
            tagButton = [ZHBtn tagButtonWithType: MLTagButtonTypeImage];
            tagButton.clipsToBounds = YES;
            
            [self.contentView addSubview: tagButton];
            [self.subTagButtons addObject: tagButton];
        }
        
        tagButton.tagModel = [arrTagModels objectAtIndex: index];
        
        
        
    }
    
    [self refreshUI];
}



- (NSMutableArray<ZHBtn *> *)subTagButtons {
    if (!_subTagButtons) {
        _subTagButtons = [NSMutableArray array];
    }
    return _subTagButtons;
}


@end
