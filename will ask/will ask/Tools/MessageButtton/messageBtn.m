//
//  messageBtn.m
//  will ask
//
//  Created by 郑晖 on 2018/1/27.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "messageBtn.h"
#import "JPushMessageModel.h"
#import "ZHJPushCustomMessageViewController.h"



@implementation messageBtn

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupMessageBtnUI];
    }
    return self;
}

- (void)setupMessageBtnUI {
    
    [self setImage:[UIImage imageNamed:@"news2"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"news-study"] forState:UIControlStateSelected];
        
    [self addTarget:self action:@selector(messageBtnClickAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self loadMesageData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadMesageData) name:kJPushMessage object:nil];
}

- (void)loadMesageData {
    
    NSArray *arr =[NSKeyedUnarchiver unarchiveObjectWithFile:kPersonInfoPath];
    NSMutableArray *dataSoureMArray = [NSMutableArray arrayWithArray:arr];
    
    
    __weak __typeof(self) weakself= self;
    
    __block int idx = 0;
    dispatch_async(dispatch_queue_create(0, 0), ^{
        // 子线程执行任务（比如获取较大数据）
        for (JPushMessageModel *model in dataSoureMArray) {
        
            if (model.isRead == NO) {

                // 通知主线程刷新 神马的
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.selected = YES;
                });
                return;
            } else {
                idx++;
            }
            
            if (idx == dataSoureMArray.count) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                     weakself.selected = NO;
                });
            }
        }
    });
}

- (void)messageBtnClickAction {
    
    if (self.MessBtnClickBlock) {
        self.MessBtnClickBlock();
    }
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
