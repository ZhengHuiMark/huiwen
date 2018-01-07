//
//  ZHBtn.m
//  demoReward
//
//  Created by 郑晖 on 2017/10/11.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHBtn.h"
#import "ZHBtnModel.h"
#import "UIImageView+WebCache.h"
#import "ImageTools.h"
#import "UIView+LayerEffects.h"



@interface ZHBtn ()

@property (nonatomic, assign) MLTagButtonType btnType;

@property(strong,nonatomic)UIView *placeholderView;

@property(strong, nonatomic)UIImageView *typeImgV;

@property(strong,nonatomic)UILabel *RewardMoneyImgV;

@property(strong,nonatomic)UILabel *ContentLaebl;

@property(strong,nonatomic)UILabel *jjjLabel;

@property(strong,nonatomic)UILabel *UserNameLabel;

@property(strong,nonatomic)UIButton *clickBtn;

@property(strong,nonatomic)UIImageView *imgView;


@end

@implementation ZHBtn
#pragma mark - Constructor
- (instancetype)initWithType:(MLTagButtonType)tagButtonType {
    if (self = [super init]) {
        self.btnType = tagButtonType;
        [self setupUI];
    }
    return self;
}

+ (instancetype)tagButtonWithType:(MLTagButtonType)tagButtonType {
    return [[ZHBtn alloc] initWithType: tagButtonType];
}



- (void)setupUI{
    
    [self addSubview:_placeholderView];
    
    [_placeholderView addSubview:_typeImgV];
    
    [_placeholderView addSubview:_imgView];
    [_placeholderView sendSubviewToBack:_imgView];
    [_placeholderView addSubview:_RewardMoneyImgV];
//    [_placeholderView addSubview:_imgView];

    [_placeholderView addSubview:_ContentLaebl];

    [_placeholderView addSubview:_jjjLabel];
    [_placeholderView addSubview:_UserNameLabel];
    [self addSubview:_clickBtn];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchesViewClickAction:)];
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

- (void)setTagModel:(ZHBtnModel *)tagModel {
    _tagModel = tagModel;
    
    self.ContentLaebl.text = tagModel.content;
    self.UserNameLabel.text = tagModel.nickname;
    if ([tagModel.type  isEqual: @"审计"]) {
        [self.typeImgV setImage:[UIImage imageNamed:@"shenji-1"]];
    }else if ([tagModel.type isEqual:@"税务"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"shuiwu1"]];
        
    }else if  ([tagModel.type isEqual:@"软件"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"ruanjian-1"]];
        
    }else if  ([tagModel.type isEqual:@"评估"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"pinggu-1"]];
        
    }else if  ([tagModel.type isEqual:@"会计"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"kuaiji-1"]];
        
    }
    self.RewardMoneyImgV.text = [NSString stringWithFormat:@"赏金%@",tagModel.amount];
    
    self.clickBtn.tag = [self.tagModel.rewardAskId integerValue];
    
    self.frame = tagModel.frame;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    self.placeholderView.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width - 50) / 3, 150.5);
    
    self.typeImgV.frame = CGRectMake(0, 14.5, 40, 20);

    self.imgView.frame = (CGRect){CGRectGetMaxX(self.typeImgV.frame ) + 22.5, 8,39.5 , 34.5};
    
    self.RewardMoneyImgV.frame = (CGRect){CGRectGetMaxX(self.typeImgV.frame ) + 23.5 , 20,50 , 10};
    
    CGSize size = CGSizeMake(_placeholderView.bounds.size.width - 20, 80);
    CGRect rectSize = [_ContentLaebl.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:12] } context:nil];
    
    self.ContentLaebl.frame = CGRectMake(6, CGRectGetMaxY(self.imgView.frame) + 6,self.frame.size.width - 20,rectSize.size.height);
    
    self.jjjLabel.frame = CGRectMake(6, CGRectGetMaxY(self.placeholderView.frame) - 13, 40, 13);
    
    self.UserNameLabel.frame = CGRectMake(CGRectGetMaxX(self.jjjLabel.frame) + 3, CGRectGetMaxY(self.placeholderView.frame) - 13 , 60, 13);
    
    self.clickBtn.frame = CGRectMake( CGRectGetWidth(self.placeholderView.frame)/2-75/2,CGRectGetMaxY(self.placeholderView.frame)+10 , 75, 25);

}

- (UIImageView *)imgView {
    
    if (!_imgView) {
        _imgView = [UIImageView new];
        _imgView.image = [UIImage imageNamed:@"bonus"];
    }
    
    
    return _imgView;
}


- (UIView *)placeholderView{
    if (!_placeholderView) {
        _placeholderView = [UIView new];
        _placeholderView.backgroundColor = [UIColor colorWithRed:254/255.0 green:245/255.0 blue:230/255.0 alpha:1];
        
        _placeholderView.layer.masksToBounds = YES;
//        _placeholderView.layer.cornerRadius = 20;

        [_placeholderView setCornerRadius:10];
    }
    
    return _placeholderView;
    
}

- (UIImageView *)typeImgV{
    if (!_typeImgV) {
        _typeImgV = [UIImageView new];
    }
    
    return _typeImgV;
}

- (UILabel *)RewardMoneyImgV{
    if (!_RewardMoneyImgV) {
        _RewardMoneyImgV = [UILabel new];
        _RewardMoneyImgV.backgroundColor = [UIColor clearColor];
        [_RewardMoneyImgV setFont:[UIFont fontWithName:@"Helvetica-Bold" size:9]];
        _RewardMoneyImgV.textColor = [UIColor redColor];
    }
    
    return _RewardMoneyImgV;
}

- (UILabel *)ContentLaebl {
    if (!_ContentLaebl) {
        _ContentLaebl = [UILabel new];
        _ContentLaebl.numberOfLines = 0;

        _ContentLaebl.text = @"312312人员人员人dada三个三个个三个个三个个三个";
        _ContentLaebl.font = [UIFont systemFontOfSize: 12];
        _ContentLaebl.textColor = [UIColor blackColor];
        
     
    }
    return _ContentLaebl;
}

- (UILabel *)jjjLabel {
    if (!_jjjLabel) {
        _jjjLabel = [UILabel new];
        _jjjLabel.text = @"悬赏人:";
        _jjjLabel.textAlignment = NSTextAlignmentCenter;
        _jjjLabel.font = [UIFont systemFontOfSize: 10];
        _jjjLabel.textColor = [UIColor blackColor];
    }
    return _jjjLabel;
}

- (UILabel *)UserNameLabel {
    if (!_UserNameLabel) {
        _UserNameLabel = [UILabel new];
        _UserNameLabel.text = @"测试人员";
        _UserNameLabel.textAlignment = NSTextAlignmentCenter;
        _UserNameLabel.font = [UIFont systemFontOfSize: 10];
        _UserNameLabel.textColor = [UIColor blackColor];
    }
    return _UserNameLabel;
}

- (UIButton *)clickBtn {
    if (!_clickBtn) {
        _clickBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        [_clickBtn setTitle:@"我要揭榜" forState:UIControlStateNormal];
        [_clickBtn setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
        _clickBtn.titleLabel.font = [UIFont systemFontOfSize: 12.0];
                [_clickBtn setBackgroundColor:[UIColor blueColor]];
        _clickBtn.layer.cornerRadius = 10;
        [_clickBtn.layer setBorderColor:[UIColor redColor].CGColor];
        [_clickBtn.layer setBorderWidth:1];
        [_clickBtn.layer setMasksToBounds:YES];

    }
    return _clickBtn;
}

+ (CGFloat)heightFromString:(NSString*)text withFont:(UIFont*)font constraintToWidth:(CGFloat)width
{
    if (text && font) {
        CGRect rect  = [text boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
        
        return rect.size.height;
    }
    return 0;
}

- (void)touchesViewClickAction:(UITapGestureRecognizer *)tap {
    
    NSLog(@"touches %ld",self.clickBtn.tag);
}

@end
