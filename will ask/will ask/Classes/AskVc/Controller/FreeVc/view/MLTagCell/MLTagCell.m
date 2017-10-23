//
//  MLTagCell.m
//  xxxx
//
//  Created by CristianoRLong on 07/10/2017.
//  Copyright © 2017 CristianoRLong. All rights reserved.
//

#import "MLTagCell.h"
#import "MLTagButton.h"
#import "MLTagModelContainer.h"
#import "MLTagModel.h"
#import "MLSubTagModel.h"

@interface MLTagCell ()

@property (nonatomic, strong) NSMutableArray<MLTagButton *> *tagButtons;
@property (nonatomic, strong) NSMutableArray<MLTagButton *> *subTagButtons;

@end

@implementation MLTagCell
#pragma mark - Private methods
- (void)refreshUI {
    
    // 隐藏所有子标签按钮
    for (MLTagButton *tagButton in self.subTagButtons) {
        tagButton.hidden = YES;
    }
    
    // 创建标签按钮
    [self createTagButton];
}

- (void)createTagButton {
    
    NSArray<MLTagModel *> *arrTagModels = self.tagContainer.tagModels;
    for (NSInteger index=0; index<arrTagModels.count; index++) {
        
        MLTagButton *tagButton = nil;
        if (self.tagButtons.count > index) {
            tagButton = [self.tagButtons objectAtIndex: index];
        } else {
            tagButton = [MLTagButton tagButtonWithType: MLTagButtonTypeImage];
            tagButton.action = ^(MLTagButton *tagButton, MLTagModel *tagModel){
                !self.cellClick?:self.cellClick(self, tagButton, tagModel);
                [self.tableView reloadData];
            };
            [self.contentView addSubview: tagButton];
            [self.tagButtons addObject: tagButton];
        }
        
        tagButton.tagModel = [arrTagModels objectAtIndex: index];
        
        if (tagButton.tagModel.isSelected) {
            [self createSubTagButton: tagButton.tagModel.subTags];
        }
        
    }
}

- (void)createSubTagButton:(NSArray<MLSubTagModel *> *)tagModels {
    
    for (NSInteger index=0; index<tagModels.count; index++) {
        
        MLTagButton *tagButton = nil;
        if (self.subTagButtons.count > index) {
            tagButton = [self.subTagButtons objectAtIndex: index];
        } else {
            tagButton = [MLTagButton tagButtonWithType: MLTagButtonTypeTitleOnly];
            tagButton.action = ^(MLTagButton *tagButton, MLTagModel *tagModel){
                !self.cellClick?:self.cellClick(self, tagButton, tagModel);
                
                [self.tableView reloadData];
            };
            [self.contentView addSubview: tagButton];
            [self.subTagButtons addObject: tagButton];
        }
        
        tagButton.tagModel = [tagModels objectAtIndex: index];
    }
}

#pragma mark - Override Setter/Getter Methods
- (void)setTagContainer:(MLTagModelContainer *)tagContainer {
    _tagContainer = tagContainer;
    self.autoresizingMask = NO;
    self.contentView.autoresizingMask = NO;
    [self refreshUI];
}

#pragma mark - Lazy load
- (NSMutableArray<MLTagButton *> *)tagButtons {
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}

- (NSMutableArray<MLTagButton *> *)subTagButtons {
    if (!_subTagButtons) {
        _subTagButtons = [NSMutableArray array];
    }
    return _subTagButtons;
}

@end
