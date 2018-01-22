//
//  expertBtnView.m
//  expertTypeDemo
//
//  Created by 刘培策 on 2018/1/6.
//  Copyright © 2018年 UniqueCe. All rights reserved.
//

#import "expertBtnView.h"

#define BtnHeight 30
#define BtnSpac 10  // btn之间的间距
#define ViewSpac 15   // btn距离屏幕左右的间距

#define BtnWidth ([UIScreen mainScreen].bounds.size.width - ViewSpac*2 - BtnSpac*2)/3

#define kScancelBtnArrayName  @"kScancelBtnArrayName"

@implementation expertBtnView {
    
    NSMutableArray *_tempBtnMArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _tempBtnMArray = [NSMutableArray array];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelNotificationClickAction:) name:kScancelBtnArrayName object:nil];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor yellowColor];
}

- (void)setRowNum:(int)rowNum {
    
    _rowNum = rowNum;
    
    NSLog(@"rowNum %u",rowNum);
}

- (void)setArrayDataSource:(NSArray *)arrayDataSource {
    
    _arrayDataSource = arrayDataSource;
    
    NSLog(@"arrayDataSource %@",arrayDataSource);
        
    int row = 0;
    int col = -1;
    
    for (int i = 0; i < arrayDataSource.count; i++) {
        
        UIButton *btn = [UIButton new];
        [btn setTitle:arrayDataSource[i] forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.backgroundColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        
        // 第二种方法 使用多行
        if (i % self.rowNum == 0 && i != 0) {
            row += 1;
            col = i%self.rowNum - 1;
        }
        col += 1;
        
        btn.frame = CGRectMake(ViewSpac+BtnWidth*col+BtnSpac*col, BtnSpac*row+BtnHeight*row, BtnWidth, BtnHeight);
        
        [self addSubview:btn];
        [_tempBtnMArray addObject:btn];
    }
}

- (void)buttonClickAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    NSLog(@"sender %@",sender.titleLabel.text);
    [[NSNotificationCenter defaultCenter] postNotificationName:kSBtnTitleName object:self userInfo:@{@"name":sender.titleLabel.text}];
}

- (void)cancelNotificationClickAction:(NSNotification *)action {
    
    for (UIButton *btn in _tempBtnMArray) {
        btn.selected = NO;
    }
}

@end
