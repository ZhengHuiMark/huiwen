//
//  ButtonView.h
//  btnCellDemo
//
//  Created by lzhl_iOS on 2017/12/28.
//  Copyright © 2017年 lzhl_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonBusinessView : UIView

// cell 的数据源
@property(nonatomic,strong) NSArray *BtnArray;

// header选择Btn 的数据源
@property(nonatomic,strong) NSMutableArray *choseBtnMArray;


@end
