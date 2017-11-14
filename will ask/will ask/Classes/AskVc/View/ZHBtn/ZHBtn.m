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
    [_placeholderView addSubview:_clickBtn];

    
 
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
    
//    [self.typeImgV sd_setImageWithURL:<#(nullable NSURL *)#>]
    
    
    self.frame = tagModel.frame;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    self.placeholderView.frame = CGRectMake(0, 0, 108, 150.5);
    self.typeImgV.frame = CGRectMake(0, 14.5, 40, 20);
    
    
    
    self.imgView.frame = (CGRect){CGRectGetMaxX(self.typeImgV.frame ) + 22.5, 8,39.5 , 34.5};
    
    self.RewardMoneyImgV.frame = (CGRect){CGRectGetMaxX(self.typeImgV.frame ) + 13.5 , 8,90 , 10};
    
    CGSize size = CGSizeMake(_placeholderView.bounds.size.width - 20, 80);
    CGRect rectSize = [_ContentLaebl.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:12] } context:nil];
    
    self.ContentLaebl.frame = CGRectMake(6, CGRectGetMaxY(self.imgView.frame) + 6,self.frame.size.width - 20,rectSize.size.height);
    NSLog(@"rectsize = %zd",rectSize.size.height);
    
    self.jjjLabel.frame = CGRectMake(6, CGRectGetMaxY(self.placeholderView.frame) - 13, 40, 13);
    
    self.UserNameLabel.frame = CGRectMake(CGRectGetMaxX(self.jjjLabel.frame) + 3, CGRectGetMaxY(self.placeholderView.frame) - 13 , 60, 13);
    
    self.clickBtn.frame = CGRectMake(17,CGRectGetMaxY(self.placeholderView.frame) + 15 , 75, 25);

}

- (UIImageView *)imgView {
    
    if (!_imgView) {
        _imgView = [UIImageView new];
        _imgView.image = [UIImage imageNamed:@"bonus"];
//        _imgView.backgroundColor = [UIColor blueColor];
//        _imgView.transform = CGAffineTransformMakeRotation(- M_PI / 6);
//        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        
//        [_imgView sizeToFit];
    }
    
    
    return _imgView;
}


- (UIView *)placeholderView{
    if (!_placeholderView) {
        _placeholderView = [UIView new];
        _placeholderView.backgroundColor = [UIColor colorWithRed:254/255.0 green:245/255.0 blue:230/255.0 alpha:1];
        _placeholderView.layer.cornerRadius = 10;
    }
    
    return _placeholderView;
    
}

- (UIImageView *)typeImgV{
    if (!_typeImgV) {
        _typeImgV = [UIImageView new];
//        _typeImgV.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _typeImgV;
}

- (UILabel *)RewardMoneyImgV{
    if (!_RewardMoneyImgV) {
        _RewardMoneyImgV = [UILabel new];
        _RewardMoneyImgV.backgroundColor = [UIColor clearColor];
        
//        _RewardMoneyImgV.text = @"text\n text\n text";
//        _RewardMoneyImgV.text = @"10";
        [_RewardMoneyImgV setFont:[UIFont fontWithName:@"Helvetica-Bold" size:9]];
        _RewardMoneyImgV.textColor = [UIColor redColor];
//        _RewardMoneyImgV.textAlignment = NSTextAlignmentCenter;
        
//        _RewardMoneyImgV.transform = CGAffineTransformMakeRotation(- M_PI / 6);
//        _RewardMoneyImgV.contentMode = UIViewContentModeScaleAspectFill;

        
    }
    
    return _RewardMoneyImgV;
}

- (UILabel *)ContentLaebl {
    if (!_ContentLaebl) {
        _ContentLaebl = [UILabel new];
        _ContentLaebl.numberOfLines = 0;

        _ContentLaebl.text = @"312312人员人员人dada三个三个个三个个三个个三个";
//        _ContentLaebl.textAlignment = NSTextAlignmentLeft;
        _ContentLaebl.font = [UIFont systemFontOfSize: 12];
        _ContentLaebl.textColor = [UIColor blackColor];
//        _ContentLaebl.backgroundColor = [UIColor yellowColor];
        
     
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
        [_clickBtn setBackgroundColor:[UIColor blueColor]];
        [_clickBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_clickBtn addTarget: self
//                 action: @selector(btnAction:)
//       forControlEvents: UIControlEventTouchUpInside];
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

@end
