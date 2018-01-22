//
//  ZHSearchTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/11/14.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHSearchTableViewCell.h"

@implementation ZHSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _searchBar.placeholder = @"搜索专家";
    
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    _searchBar.layer.cornerRadius = 3;
    _searchBar.layer.masksToBounds = YES;
    _searchBar.layer.borderColor = [UIColor whiteColor].CGColor;

    _lineImgView.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenBtnSelected) name:kScreenNameSelected object:nil];
}

- (IBAction)screeningAcion:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    !self.didClick?:self.didClick(sender);
}

- (void)screenBtnSelected {
    
    self.lineImgView.hidden = YES;
    self.screeningBtn.selected = NO;
}
- (IBAction)searchAction:(UIButton *)sender {
    
    
    !self.searchClick?:self.searchClick();
    
}


@end
