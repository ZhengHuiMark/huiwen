//
//  NavBaseView.m
//  will ask
//
//  Created by 郑晖 on 2018/1/28.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "NavBaseView.h"
#import "ZHSearchPageViewController.h"
#import "ZHJPushCustomMessageViewController.h"



@implementation NavBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupNavViewUI];
    }
    return self;
}

- (void) setupNavViewUI {
    
    UIButton *seachBtn = [UIButton ButtonWithImage:@"search" Title:@"搜索案例、资讯、问答" TitleColor:[UIColor colorWithR:190 G:190 B:190 alpha:1] TitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0) ImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) Target:self Action:@selector(seachBtnClickAction)];
    seachBtn.layer.cornerRadius = 15.0f;
    seachBtn.layer.masksToBounds = YES;
    seachBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    seachBtn.backgroundColor = [UIColor colorWithR:245 G:245 B:245 alpha:1];
    [self addSubview:seachBtn];
    [seachBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(10);
        make.left.equalTo(self.mas_left).offset(17.5);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.mas_right).offset(-57.5);
    }];
    
    messageBtn *editorBtn = [messageBtn buttonWithType:UIButtonTypeCustom];
    [self addSubview:editorBtn];
    [editorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(seachBtn.mas_centerY);
        make.left.equalTo(seachBtn.mas_right);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(30);
    }];

    WEAKSELF
    editorBtn.MessBtnClickBlock = ^{
        ZHJPushCustomMessageViewController *JPushCustomVc = [[ZHJPushCustomMessageViewController alloc]init];
        [weakSelf.GetViewController.navigationController pushViewController:JPushCustomVc animated:YES];
    };
}

- (void) seachBtnClickAction {

    [self.GetViewController.navigationController pushViewController:[ZHSearchPageViewController new] animated:YES];
}

- (void) messageBtnClickAction {
    
    ZHJPushCustomMessageViewController *JPushCustomVc = [[ZHJPushCustomMessageViewController alloc]init];
    [self.GetViewController.navigationController pushViewController:JPushCustomVc animated:YES];
}

@end
