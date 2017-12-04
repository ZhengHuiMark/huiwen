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
    
    _searchBar.placeholder = @"12345";
    
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    _searchBar.layer.cornerRadius = 3;
    _searchBar.layer.masksToBounds = YES;
    _searchBar.layer.borderColor = [UIColor whiteColor].CGColor;

    
}



@end
