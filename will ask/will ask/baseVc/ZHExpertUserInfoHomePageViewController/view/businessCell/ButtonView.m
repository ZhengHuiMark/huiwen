//
//  ButtonView.m
//  btnCellDemo
//
//  Created by lzhl_iOS on 2017/12/28.
//  Copyright © 2017年 lzhl_iOS. All rights reserved.
//

#import "ButtonView.h"

#define LabelWidth ([UIScreen mainScreen].bounds.size.width - 15*2 - 10*3)/4
#define LabelHeight 30
#define LabelSpac 10  // label之间的间距
#define ViewSpac 15   // label距离屏幕左右的间距

@implementation ButtonView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if ([super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
//    self.backgroundColor = [UIColor yellowColor];
}

- (void)setBtnStr:(NSString *)btnStr {
    
    _btnStr = btnStr;
    
    NSArray *temp = [btnStr componentsSeparatedByString:@","];
    
    
    /** 可以干掉 ⬇️ */
    NSMutableArray *tempMArray = [NSMutableArray array];
    if (temp.count > 8) {
        for (int i = 0; i < 8; i++) {
            [tempMArray addObject:temp[i]];
        }
    }else {
        tempMArray = temp.copy;
    }
    /** 可以干掉 ⬆️ */
    
    int row = 0;
    int col = -1;
    
    for (int i = 0; i < tempMArray.count; i++) {
        
        UILabel *btnLa = [UILabel new];
        btnLa.text = tempMArray[i];
        btnLa.layer.borderColor = [UIColor orangeColor].CGColor;
        btnLa.layer.borderWidth = 1.0f;
        btnLa.layer.cornerRadius = LabelHeight/2;
        btnLa.layer.masksToBounds = YES;
        btnLa.textAlignment = NSTextAlignmentCenter;
        btnLa.font = [UIFont systemFontOfSize:15];
/* 第一终方法 只能使用两行
        if (i > 3) {
            int j = abs(i%4-1); //第二行的布局
            btnLa.frame = CGRectMake(ViewSpac+LabelWidth*j+LabelSpac*j, 10*2+LabelHeight, LabelWidth, LabelHeight);
        }else {
            btnLa.frame = CGRectMake(ViewSpac+LabelWidth*i+LabelSpac*i, 10, LabelWidth, LabelHeight);
        }
 */
        // 第二种方法 使用多行
        if (i % 4 == 0 && i != 0) {
            row += 1;
            col = i%4 - 1;
        }
        col += 1;
        
        btnLa.frame = CGRectMake(ViewSpac+LabelWidth*col+LabelSpac*col, 10*(row+1)+LabelHeight*row, LabelWidth, LabelHeight);
        
        [self addSubview:btnLa];
    }
}


@end
