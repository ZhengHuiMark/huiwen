//
//  businessViewCell.m
//  GoodAtBusinessDemo
//
//  Created by 刘培策 on 2018/1/1.
//  Copyright © 2018年 UniqueCe. All rights reserved.
//

#import "businessViewCell.h"
#import "ButtonBusinessView.h"
#import "Masonry.h"


#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface businessViewCell ()

@property(nonatomic,strong) ButtonBusinessView *btnView;

@end

@implementation businessViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    self.backgroundColor = [UIColor lightGrayColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.btnView = [ButtonBusinessView new];
    self.btnView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.btnView];
    [self.btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.contentView);
    }];
}

- (void)setDataSoureArray:(NSArray *)dataSoureArray {
    
    _dataSoureArray = dataSoureArray;

    self.btnView.BtnArray = dataSoureArray;
}

@end
