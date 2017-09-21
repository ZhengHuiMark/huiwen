//
//  ZHMineTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/9/14.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMineTableViewCell.h"
#import "MineModel.h"

@interface ZHMineTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *nextButton;

@end

@implementation ZHMineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

-(void)setModel:(MineModel *)model{
    
    _model = model;
    _icon.image = [UIImage imageNamed:model.icon];
    _name.text = model.name;
    _nextButton.image = [UIImage imageNamed:model.nextButton];
}

@end
