//
//  alertButtonView.m
//  alertTest
//
//  Created by 刘培策 on 2018/1/19.
//  Copyright © 2018年 UniqueCe. All rights reserved.
//

#import "alertButtonView.h"

@interface alertButtonView ()

@property(nonatomic,strong) UIView *numView;

@property(nonatomic,strong) UIView *payView;

@property(nonatomic,strong) UIButton *redBtn;

@property(nonatomic,strong) UIButton *addBtn;

@property(nonatomic,strong) UILabel *numLabel;

@end

@implementation alertButtonView {
    
    NSInteger _num;
    CGFloat _price;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _num = 1;   [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    self.center = [UIApplication sharedApplication].keyWindow.center;
    self.bounds = [UIApplication sharedApplication].keyWindow.bounds;
    [self addTarget:self action:@selector(removeAlertButtonView) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupPayViewUI];
    [self setupNumViewUI];
}

- (void)setupPayViewUI {
    
    [self addSubview:self.payView];
    self.payView.frame = CGRectMake(0, ScreenHeight+150, ScreenWidth-40, 100);
    
    UIView *horLineView = [UIView new];
    horLineView.backgroundColor = [UIColor redColor];
    [self.payView addSubview:horLineView];
    [horLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.payView.mas_centerY);
        make.left.right.equalTo(self.payView);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *payBtn = [UIButton new];
    [payBtn setTitle:@"购买" forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(payBtnClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.payView addSubview:payBtn];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payView.mas_top);
        make.left.right.equalTo(self.payView);
        make.bottom.equalTo(horLineView.mas_top);
    }];
    
    UIButton *cancelBtn = [UIButton new];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.payView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horLineView.mas_bottom);
        make.left.right.equalTo(self.payView);
        make.bottom.equalTo(self.payView.mas_bottom);
    }];
}

- (void)setupNumViewUI {
    
    [self addSubview:self.numView];
    self.numView.frame = CGRectMake(0, ScreenHeight+200, ScreenWidth-40, 100);
//    [self.numView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.mas_right).offset(-20);
//        make.left.equalTo(self.mas_left).offset(20);
//        make.bottom.equalTo(self.payView.mas_top).offset(-30);
//        make.height.mas_equalTo(150);
//    }];
    
    self.leftLabel = [UILabel new];
    [self.leftLabel setTextColor:[UIColor orangeColor]];
    [self.numView addSubview:self.leftLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numView.mas_left).offset(15);
        make.top.equalTo(self.numView.mas_top).offset(15);
    }];

    self.rightLabel = [UILabel new];
    [self.rightLabel setTextColor:[UIColor orangeColor]];
    [self.numView addSubview:self.rightLabel];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.numView.mas_right).offset(-15);
        make.top.equalTo(self.numView.mas_top).offset(15);
    }];

    _numLabel = [UILabel new];
    _numLabel.text = [NSString stringWithFormat:@"%lu",_num];
    _numLabel.textAlignment = NSTextAlignmentCenter;
    _numLabel.backgroundColor = [UIColor redColor];
    [self.numView addSubview:self.numLabel];
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.numView.mas_centerY).offset(10);
        make.centerX.equalTo(self.numView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    _redBtn = [[UIButton alloc] init];
    [_redBtn setTitle:@"-" forState: UIControlStateNormal];
    [_redBtn addTarget:self action:@selector(redBtnClickAction) forControlEvents:UIControlEventTouchUpInside];
    _redBtn.backgroundColor = [UIColor darkGrayColor];
    [self.numView addSubview:self.redBtn];
    [_redBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.numLabel.mas_centerY);
        make.right.equalTo(self.numLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    _addBtn = [[UIButton alloc] init];
    [_addBtn setTitle:@"+" forState: UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addBtnClickAction) forControlEvents:UIControlEventTouchUpInside];
    _addBtn.backgroundColor = [UIColor darkGrayColor];
    [self.numView addSubview:self.addBtn];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.numLabel.mas_centerY);
        make.left.equalTo(self.numLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
}

- (void)payBtnClickAction {
    
    if (self.numBlock) {
        self.numBlock(_num,self.rightLabel.text);
    }
    [self removeAlertButtonView];
}

- (void)cancelBtnClickAction {
    
    [self removeAlertButtonView];
}

- (void)redBtnClickAction {
    
    _num--;
    if (_num == 1) {
        self.redBtn.enabled = NO;
    }
    
    self.numLabel.text = [NSString stringWithFormat:@"%lu",_num];
    self.rightLabel.text = [NSString stringWithFormat:@"%0.2f", _num*_price];
}

- (void)addBtnClickAction {
    
    self.redBtn.enabled = YES;
    _num++;
    self.numLabel.text = [NSString stringWithFormat:@"%lu",_num];
    self.rightLabel.text = [NSString stringWithFormat:@"%0.2f",_num*_price];
}

- (void)showsAlertView {

    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.layer.opacity = 1.0;
        self.payView.frame = CGRectMake(20, ScreenHeight-150, ScreenWidth-40, 100);
        self.numView.frame = CGRectMake(20, ScreenHeight-320, ScreenWidth-40, 150);
    }];
    
    _price = [self.rightLabel.text floatValue];
}

- (void)removeAlertButtonView {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.layer.opacity = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}



- (UIView *)numView{
    
    if (!_numView) {
        _numView = [UIView new];
        _numView.backgroundColor = [UIColor whiteColor];
        _numView.layer.masksToBounds = YES;
        _numView.layer.cornerRadius = 15.0f;
    }
    return _numView;
}

- (UIView *)payView{
    
    if (!_payView) {
        _payView = [UIView new];
        _payView.backgroundColor = [UIColor whiteColor];
        _payView.layer.masksToBounds = YES;
        _payView.layer.cornerRadius = 15.0f;
    }
    return _payView;
}


@end
