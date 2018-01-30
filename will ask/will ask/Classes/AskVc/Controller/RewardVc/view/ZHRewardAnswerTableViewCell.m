//
//  ZHRewardAnswerTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/11/2.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHRewardAnswerTableViewCell.h"
#import "ZHFreeAnswerModel.h"
#import "ZHFreeDetailModel.h"
#import "ImageTools.h"
#import "Macro.h"
#import "MLAvatarDisplayView.h"
#import "UIImageView+WebCache.h"
#import "UIView+LayerEffects.h"

@interface ZHRewardAnswerTableViewCell ()


@property (nonatomic, strong) MLAvatarDisplayView *avatarDisplayView;


@end

@implementation ZHRewardAnswerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.learnButton setCornerRadius:22.5];
    
    [self.setBestBtn setCornerRadius:12.5];
    self.setBestBtn.layer.borderWidth = 1.0;
    self.setBestBtn.layer.borderColor = [UIColor redColor].CGColor;
    [self.userAvatar setCornerRadius:12];
}

- (void)setDetailModel:(ZHFreeDetailModel *)detailModel {
    
    _detailModel = detailModel;
//    
    if (_detailModel.owner == YES) {
        
        self.learnButton.hidden = YES;
        self.backGroundImg.hidden = YES;
        
        if (self.answerModel.best == YES) {
            self.best.hidden = NO;
            self.setBestBtn.hidden = YES;
        }
        
    }
    
}


- (void)setAnswerModel:(ZHFreeAnswerModel *)answerModel {
    _answerModel = answerModel;
    
    
    self.content.text = [NSString stringWithFormat:@"      %@",self.answerModel.content];
    
    NSString *wenzi = self.answerModel.content;
    CGFloat marin = 17.5;
    CGFloat labelWidth = [UIScreen mainScreen].bounds.size.width - marin * 2;
    CGFloat labelHeight = [wenzi boundingRectWithSize: CGSizeMake(labelWidth, 300)
                                              options: NSStringDrawingUsesLineFragmentOrigin
                                           attributes: @{NSFontAttributeName : [UIFont systemFontOfSize: 14]}
                                              context: nil].size.height;
    
    [self.content mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(labelHeight);
    }];
    
    self.expertName.text = self.answerModel.certifiedNames;
    self.expertHoor.text = self.answerModel.honor;
    
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.answerModel.avatar]]];
    
    self.userName.text = self.answerModel.nickname;
    
    //    self.expertName.text = self.answerModel.
    self.labelNumber = [self.answerModel.praiseNumber integerValue];
    self.clickNumber.text = self.answerModel.praiseNumber;
    
    self.learnNumber.text = [NSString stringWithFormat:@"%@人已学习",self.answerModel.learnNumber];
    
    self.releaseTime.text = self.answerModel.time;
    
    
    if (self.answerModel.owner == YES  || _detailModel.owner == YES) {
        self.learnButton.hidden = YES;
        self.backGroundImg.hidden = YES;
    }else{
        self.learnButton.hidden = NO;
        self.backGroundImg.hidden = NO;
    }
    
    if (self.answerModel.learned == YES || self.answerModel.owner == YES || _detailModel.owner == YES) {
        self.learnButton.hidden = YES;
        self.backGroundImg.hidden = YES;
    }else{
        self.learnButton.hidden = NO;
        self.backGroundImg.hidden = NO;
    }
    
    if (self.answerModel.best == YES && _detailModel.owner == YES ) {
        self.best.hidden = NO;
        self.setBestBtn.hidden = YES;
    }else if(self.answerModel.best == YES && _detailModel.owner == NO){
        self.best.hidden = NO;
        self.setBestBtn.hidden = YES;
    }else if (self.answerModel.best == NO && _detailModel.owner == YES){
        self.best.hidden = YES;
        self.setBestBtn.hidden = NO;
    }else if (self.answerModel.best == NO && _detailModel.owner == NO){
        self.best.hidden = YES;
        self.setBestBtn.hidden = YES;
    }
        
   
    NSArray *PhotoArray = [self.answerModel.photos componentsSeparatedByString:@","];
    
    NSInteger index = -1;
    NSLog(@"%zd",index);
    for (UIImageView *imageView in self.answerImgs) {
        index++;
        if (PhotoArray.count <= index) {
            imageView.hidden = YES;
            [self.ansImgButtons[index] setHidden: YES];
            continue;
        }
        imageView.hidden = NO;
        [self.ansImgButtons[index] setHidden: NO];
        [imageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@",bucketNameRewardLoad,OSS,PhotoArray[index]]]];
    }
    

}

- (IBAction)imgsBtnAction:(UIButton *)sender {
    
    
    UIImageView *imageView = self.answerImgs[sender.tag];
    
    [self.avatarDisplayView showFromImageView:imageView];
    
}

- (IBAction)learnBtnAction:(UIButton *)sender {
    
    !self.didClick?:self.didClick();
    
}


#pragma mark - Lazy load
- (MLAvatarDisplayView *)avatarDisplayView {
    if (!_avatarDisplayView) {
        _avatarDisplayView = [MLAvatarDisplayView ml_singleImageDisplayView];
    }
    return _avatarDisplayView;
}


- (IBAction)clickPriseAction:(UIButton *)sender {
    sender.selected = !sender.selected;

    
    if (sender.selected == YES) {
        NSMutableDictionary *dic = [ZHNetworkTools parameters];
        [dic setObject:self.answerModel.answerId forKey:@"objectId"];
        [dic setObject:@"2" forKey:@"type"];
        
        NSString *url = [NSString stringWithFormat:@"%@/api/ut/praise/add",kIP];
        
        [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
            
            if (error) {
                NSLog(@"%@",error);
            }
            
            NSLog(@"%@",response);
            if ([response[@"success"] integerValue] == 1) {
                _labelNumber++;
                self.clickNumber.text = [NSString stringWithFormat:@"%ld",_labelNumber];
            }
            
        }];
        
    }else{
        NSMutableDictionary *dic = [ZHNetworkTools parameters];
        [dic setObject:self.answerModel.answerId forKey:@"objectId"];
        [dic setObject:@"2" forKey:@"type"];
        
        NSString *url = [NSString stringWithFormat:@"%@/api/ut/praise/cancel",kIP];
        
        [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
            
            if (error) {
                NSLog(@"%@",error);
            }
            
            NSLog(@"%@",response);
            if ([response[@"success"] integerValue] == 1) {
                _labelNumber--;
                self.clickNumber.text = [NSString stringWithFormat:@"%ld",_labelNumber];
            }
            
        }];
    }
    
}


@end
