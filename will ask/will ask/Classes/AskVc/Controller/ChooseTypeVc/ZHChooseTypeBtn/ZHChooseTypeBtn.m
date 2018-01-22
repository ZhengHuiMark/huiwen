//
//  ZHBtn.m
//  demoReward
//
//  Created by 郑晖 on 2017/10/11.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHChooseTypeBtn.h"
#import "ZHChooseTypeBtnModel.h"

@interface ZHChooseTypeBtn ()

@property (nonatomic, assign) MLTagButtonType btnType;
@property (strong, nonatomic) UIButton *btn;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UIImageView *imgView;


@end

@implementation ZHChooseTypeBtn
#pragma mark - Constructor
- (instancetype)initWithType:(MLTagButtonType)tagButtonType {
    if (self = [super init]) {
        self.btnType = tagButtonType;
        [self setupUI];
    }
    return self;
}
+ (instancetype)tagButtonWithType:(MLTagButtonType)tagButtonType {
    return [[ZHChooseTypeBtn alloc] initWithType: tagButtonType];
}

#pragma mark - Basic setup
- (void)setupUI {
    
    switch (self.btnType) {
        case MLTagButtonTypeImage: {
            [self addSubview: self.imgView];
        }
            break;
            
        default:
            break;
    }
    
    [self addSubview: self.title];
    [self addSubview: self.btn];
}

#pragma mark - Helpers
- (void)statusNormal {
    switch (_btnType) {
        case MLTagButtonTypeImage: {
//            self.backgroundColor = [UIColor colorWithRed: 245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
            self.layer.borderColor = [UIColor colorWithRed: 245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1].CGColor;

            self.layer.borderColor = [UIColor clearColor].CGColor;
            self.layer.borderWidth = 1.0f;
//            self.layer.cornerRadius = 5.0f;
        }
            break;
            
        case MLTagButtonTypeTitleOnly: {
            self.backgroundColor = [UIColor whiteColor];
//            self.layer.borderColor = [UIColor colorWithRed: 242.0/255.0 green:90.0/255.0 blue:41.0/255.0 alpha:0.5].CGColor;
            self.layer.borderColor = [UIColor colorWithRed: 245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1].CGColor;
            self.layer.borderWidth = 1.0f;
//            self.layer.cornerRadius = 5.0f;
            self.title.textColor = [UIColor darkGrayColor];
        }
            break;
    }
}

- (void)statusSelected {
    switch (_btnType) {
        case MLTagButtonTypeImage: {
            self.backgroundColor = [UIColor whiteColor];
            self.layer.borderColor = [UIColor orangeColor].CGColor;
            self.layer.borderWidth = 0.0f;
            self.layer.cornerRadius = 0.0f;
        }
            break;
            
        case MLTagButtonTypeTitleOnly: {
            self.backgroundColor = [UIColor whiteColor];
//            self.layer.borderColor = [UIColor orangeColor].CGColor;
//            self.layer.borderWidth = 1.0f;
//            self.layer.cornerRadius = 5.0f;
            self.title.textColor = [UIColor orangeColor];
        }
            break;
    }
}

#pragma mark - Actions
- (void)btnAction:(UIButton *)btn {
    
    BOOL status = self.tagModel.isSelected;
    
    switch (_btnType) {
        case MLTagButtonTypeImage: {
            [self.tagModel cancelAllTag];
            if (status) [self.tagModel cancelAllSubTag];
            else {
                self.tagModel.selected = YES;
            }
        }
            break;
            
        case MLTagButtonTypeTitleOnly: {
            if (!status) {
                [self.tagModel cancelAllSubTag];
                self.tagModel.selected = YES;
            }
        }
            
        default:
            break;
    }
    
    !self.action?:self.action(self, self.tagModel);
}

#pragma mark - Override Setter/Getter Methods
- (void)setBtnType:(MLTagButtonType)btnType {
    _btnType = btnType;
    [self statusNormal];
}

- (MLTagButtonType)tagButtonType {
    return _btnType;
}

- (void)setTagModel:(ZHChooseTypeBtnModel *)tagModel {
    _tagModel = tagModel;
    self.hidden = NO;
    self.frame = tagModel.frame;
    
    self.title.text = tagModel.title;
    if (tagModel.isSelected) {
        [self statusSelected];
    } else {
        [self statusNormal];
    }
    
    switch (_btnType) {
        case MLTagButtonTypeImage: {
            // 设置图片
        }
            break;
            
        default:
            break;
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame: frame];
    
    switch (_btnType) {
        case MLTagButtonTypeImage: {
            self.imgView.frame = (CGRect){CGPointZero, 19, 19};
            self.imgView.center = (CGPoint){frame.size.width*0.5, frame.size.height*0.5 - 10};
            self.title.frame = (CGRect){0, CGRectGetMaxY(self.imgView.frame)+4, frame.size.width, 14};
            self.btn.frame = self.bounds;
        }
            break;
            
        case MLTagButtonTypeTitleOnly: {
            self.title.frame = self.bounds;;
            self.btn.frame = self.bounds;
        }
            break;
    }
}

#pragma mark - Lazy load
- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = [UIFont systemFontOfSize: 12];
        _title.textColor = [UIColor blackColor];
    }
    return _title;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [UIImageView new];
        _imgView.backgroundColor = [UIColor lightGrayColor];
    }
    return _imgView;
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType: UIButtonTypeCustom];
        [_btn addTarget: self
                 action: @selector(btnAction:)
       forControlEvents: UIControlEventTouchUpInside];
    }
    return _btn;
}
@end
