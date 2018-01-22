//
//  historyView.h
//  NewGoldUnion
//
//  Created by 刘培策 on 17/5/21.
//  Copyright © 2017年 lzhl_iOS_LPC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "Addition.h"

@interface historyView : UIView

@property(nonatomic, copy) void(^seachTextFieldBlock)(NSString *textString);

@property(nonatomic, strong) NSMutableArray *historyMarray;

- (void)addToHistory:(NSString *)word;

@end
