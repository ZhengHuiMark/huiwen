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

#import "ZHRewardDetailViewController.h"

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
    self.jjjLabel.text = [NSString stringWithFormat:@"悬赏人:%@",tagModel.nickname];
    if ([tagModel.type  isEqual: @"涉税实务"]) {
        [self.typeImgV setImage:[UIImage imageNamed:@"sssw"]];
    }else if ([tagModel.type isEqual:@"税收优惠"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"ssyh"]];
        
    }else if  ([tagModel.type isEqual:@"发票管理"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"fpgl"]];
        
    }else if  ([tagModel.type isEqual:@"税收筹划"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"ssch"]];
        
    }else if  ([tagModel.type isEqual:@"纳税申报"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"nssb"]];
        
    }else if  ([tagModel.type isEqual:@"跨境税收"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"kjss"]];
        
    }else if  ([tagModel.type isEqual:@"税务其他"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"qtsw"]];
        
    }else if  ([tagModel.type isEqual:@"年报审计"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"nbsj"]];
        
    }else if  ([tagModel.type isEqual:@"上市审计"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"sssj"]];
        
    }else if  ([tagModel.type isEqual:@"债券审计"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"zqsj"]];
        
    }else if  ([tagModel.type isEqual:@"验资审计"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"yzsj"]];
        
    }else if  ([tagModel.type isEqual:@"内容审计"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"nksj"]];
        
    }else if  ([tagModel.type isEqual:@"其他审计"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"qtsj"]];
        
    }else if  ([tagModel.type isEqual:@"会计核算"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"kjhs"]];
        
    }else if  ([tagModel.type isEqual:@"政策咨询"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"zczx"]];
        
    }else if  ([tagModel.type isEqual:@"财务管理"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"cwgl"]];
        
    }else if  ([tagModel.type isEqual:@"报表编制"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"bbbz"]];
        
    }else if  ([tagModel.type isEqual:@"会计其他"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"qtkj"]];
        
    }else if  ([tagModel.type isEqual:@"资产评估"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([tagModel.type isEqual:@"单项评估"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([tagModel.type isEqual:@"整体评估"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([tagModel.type isEqual:@"价值评估"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([tagModel.type isEqual:@"其他评估"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([tagModel.type isEqual:@"财务软件"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"cwrj"]];
        
    }else if  ([tagModel.type isEqual:@"审计软件"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"sjrj"]];
        
    }else if  ([tagModel.type isEqual:@"office软件"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"office"]];
        
    }else if  ([tagModel.type isEqual:@"其他软件"]){
        [self.typeImgV setImage:[UIImage imageNamed:@"qtrj"]];
        
    }

    
    self.RewardMoneyImgV.text = [NSString stringWithFormat:@" 赏金%@",tagModel.amount];
    
    
    self.clickBtn.tag = [self.tagModel.rewardAskId integerValue];
    
    self.frame = tagModel.frame;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    self.placeholderView.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width - 50) / 3, 150.5);
    
    self.typeImgV.frame = CGRectMake(0, 14.5, 40, 30);

    self.imgView.frame = (CGRect){CGRectGetWidth(self.placeholderView.frame) -39.5, 8,39.5 , 34.5};
    
    self.RewardMoneyImgV.frame = (CGRect){CGRectGetWidth(self.placeholderView.frame) -39.5 ,20,50 , 10};
    
    CGSize size = CGSizeMake(_placeholderView.bounds.size.width - 20, 80);
    CGRect rectSize = [_ContentLaebl.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:12] } context:nil];
    
    self.ContentLaebl.frame = CGRectMake(6, CGRectGetMaxY(self.imgView.frame) + 6,self.frame.size.width - 20,rectSize.size.height);
    
    self.jjjLabel.frame = CGRectMake(6, CGRectGetMaxY(self.placeholderView.frame) - 13,CGRectGetWidth(self.placeholderView.frame), 13);
    
//    self.UserNameLabel.frame = CGRectMake(CGRectGetMaxX(self.jjjLabel.frame) + 3, CGRectGetMaxY(self.placeholderView.frame) - 13 , 60, 13);
    
    self.clickBtn.frame = CGRectMake( CGRectGetWidth(self.placeholderView.frame)/ 2-75/2,CGRectGetMaxY(self.placeholderView.frame)+10 , 75, 25);

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
//        _RewardMoneyImgV.textAlignment = NSTextAlignmentCenter;
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
//        _jjjLabel.text = @"悬赏人:";
        _jjjLabel.textAlignment = NSTextAlignmentLeft;
        _jjjLabel.font = [UIFont systemFontOfSize: 10];
        _jjjLabel.textColor = [UIColor blackColor];
//        _jjjLabel.backgroundColor = [UIColor redColor];
    }
    return _jjjLabel;
}


- (UIButton *)clickBtn {
    if (!_clickBtn) {
        _clickBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        [_clickBtn setTitle:@"我要揭榜" forState:UIControlStateNormal];
        [_clickBtn setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
        _clickBtn.titleLabel.font = [UIFont systemFontOfSize: 12.0];
//                [_clickBtn setBackgroundColor:[UIColor blueColor]];
        _clickBtn.layer.cornerRadius = 10;
        [_clickBtn.layer setBorderColor:[UIColor redColor].CGColor];
        [_clickBtn.layer setBorderWidth:.5];
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
    NSString *Notification_postVc = @"postVc";
    
    /** 发送的通知 */
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_postVc object:[self viewController] userInfo:@{@"rewardAskId":self.tagModel.rewardAskId}];
}

- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
