//
//  ButtonView.m
//  btnCellDemo
//
//  Created by lzhl_iOS on 2017/12/28.
//  Copyright © 2017年 lzhl_iOS. All rights reserved.
//

#import "ButtonBusinessView.h"
#import "choseButton.h"
#import "expertBusinessesDetail.h"

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


#define LabelHeight 30
#define LabelSpac 2  // label之间的间距
#define ViewSpac 0   // label距离屏幕左右的间距
#define LabelWidth ([UIScreen mainScreen].bounds.size.width - ViewSpac*2 - LabelSpac*3)/4


/** --↓-- 被选中的Btn的布局参数 --↓-- */
//#define choseLabelHeight 30
#define choseLabelSpac 10  // label之间的间距
#define choseViewSpac 15   // label距离屏幕左右的间距
#define choseLabelWidth ([UIScreen mainScreen].bounds.size.width - choseViewSpac*2 - choseLabelSpac*2)/3
/** --↑-- 被选中的Btn的布局参数 --↑-- */

@implementation ButtonBusinessView {
    
    UIButton *_chosetn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if ([super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
//    self.backgroundColor = [UIColor darkGrayColor];
}

- (void)setBtnArray:(NSArray *)BtnArray {
    
    _BtnArray = BtnArray;
    
    int row = 0;
    int col = -1;
    
    for (int i = 0; i < BtnArray.count; i++) {
        expertBusinessesDetail *model = BtnArray[i];
        UIButton *btn = [UIButton new];
        [btn setTitle:model.name forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.backgroundColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        
        // 第二种方法 使用多行
        if (i % 4 == 0 && i != 0) {
            row += 1;
            col = i%4 - 1;
        }
        col += 1;
        
        btn.frame = CGRectMake(ViewSpac+LabelWidth*col+LabelSpac*col, LabelSpac*row+LabelHeight*row, LabelWidth, LabelHeight);
        
        [self addSubview:btn];
    }
}

- (void)buttonClickAction:(UIButton *)sender {
 
    sender.selected = !sender.selected;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"choseBtnNotificationName" object:self userInfo:@{@"Height":sender.titleLabel.text}];
}

- (void)setChoseBtnMArray:(NSMutableArray *)choseBtnMArray {
    
    _choseBtnMArray = choseBtnMArray;
    
    [self removeFromSuperview];
    
    int row = 0;
    int col = -1;
    
    for (int i = 0; i < choseBtnMArray.count; i++) {
        choseButton *btn = [choseButton new];
        [btn setTitle:choseBtnMArray[i] forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.backgroundColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(choseBtnMArrayClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:@"del"] forState:UIControlStateNormal];
        btn.layer.borderColor = [UIColor orangeColor].CGColor;
        btn.layer.borderWidth = 1.0f;
        btn.layer.cornerRadius = LabelHeight/2;
        btn.layer.masksToBounds = YES;
    
        if (i % 3 == 0 && i != 0) {
            row += 1;
            col = i%3 - 1;
        }
        col += 1;
        
        btn.frame = CGRectMake(choseViewSpac+choseLabelWidth*col+choseLabelSpac*col, choseLabelSpac*row+LabelHeight*row, choseLabelWidth, LabelHeight);
        
        [self addSubview:btn];
    }
}

- (void)choseBtnMArrayClickAction:(UIButton *)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"choseBtnNotificationName" object:self userInfo:@{@"Height":sender.titleLabel.text}];
}

@end
