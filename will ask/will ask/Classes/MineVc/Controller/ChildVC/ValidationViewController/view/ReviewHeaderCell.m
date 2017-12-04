//
//  ReviewHeaderCell.m
//  XXXXXXX
//
//  Created by 郑晖 on 2017/10/14.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ReviewHeaderCell.h"
#import "ReviewModel.h"

@interface ReviewHeaderCell ()

@property (weak, nonatomic) IBOutlet UIButton *anniu1;
@property (weak, nonatomic) IBOutlet UIButton *anniu2;
@property (weak, nonatomic) IBOutlet UIButton *anniu3;
@property (weak, nonatomic) IBOutlet UIButton *anniu4;

@property (nonatomic, strong) NSMutableArray<UIButton *> *buttons;

@end

@implementation ReviewHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)actionbutton:(UIButton *)sender {
    
    NSInteger index = sender.tag;
    ReviewModel *model = self.models[index];
    if (model.status == ReviewStatusSuccess) return;
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        model.status = ReviewStatusSelected;
    } else {
        model.status = ReviewStatusNormal;
    }
    
    [self.tableView reloadData];
}

- (void)setModels:(NSArray<ReviewModel *> *)models {
    
    _models = models;
    
    for (NSInteger index=0; index<models.count; index++) {
        
        UIButton *btn = nil;
        if (index >= self.buttons.count) {
            btn = [UIButton new];
        } else {
            btn = self.buttons[index];
        }
        
        btn.tag = index;
        btn.selected = !(models[index].status == ReviewStatusNormal);
        [self.contentView addSubview: btn];
    }
    
    self.anniu1.selected = !(models[0].status == ReviewStatusNormal);
    self.anniu2.selected = !(models[1].status == ReviewStatusNormal);
    self.anniu3.selected = !(models[2].status == ReviewStatusNormal);
    self.anniu4.selected = !(models[3].status == ReviewStatusNormal);

}

@end
