//
//  choseButton.m
//  GoodAtBusinessDemo
//
//  Created by 刘培策 on 2018/1/1.
//  Copyright © 2018年 UniqueCe. All rights reserved.
//

#import "choseButton.h"
#import "UIView+LPC.h"


@implementation choseButton

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    if (self.imageView.X < self.titleLabel.X) {
        
        self.titleLabel.X = self.imageView.X;
        
        self.imageView.X = self.titleLabel.maxX + 10;
    }
}

@end
