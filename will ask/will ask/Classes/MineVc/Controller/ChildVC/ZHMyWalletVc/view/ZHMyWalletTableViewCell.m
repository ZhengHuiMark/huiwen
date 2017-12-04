//
//  ZHMyWalletTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/1.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMyWalletTableViewCell.h"
#import "ZHWalletModel.h"

@interface ZHMyWalletTableViewCell (){
    CGFloat _money;
}

@property (nonatomic, strong) NSTimer *timer;


@end

@implementation ZHMyWalletTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    

}



-(void)setModel:(ZHWalletModel *)model{
    BOOL needAnimation = !_model;
    _model = model;
    
    if (!needAnimation) {
        self.Balance.text = [NSString stringWithFormat: @"%.2f", [self.model.data doubleValue]];
        return;
    }
    
    
    self.Balance.text = self.model.data;
    
    _money = 0.0f;
    CGFloat max = [self.model.data doubleValue];
    
    self.timer = [NSTimer timerWithTimeInterval: 0.01f
                                        repeats: YES block:^(NSTimer * _Nonnull timer) {
                                            _money += 0.7;
                                            if (_money >= max) {
                                                self.Balance.text = [NSString stringWithFormat: @"%.2f", max];
                                                [timer invalidate];
                                            } else {
                                                self.Balance.text = [NSString stringWithFormat: @"%.2f", _money];
                                            }
                                        }];
    [[NSRunLoop currentRunLoop] addTimer: self.timer
                                 forMode:NSRunLoopCommonModes];

}

@end
