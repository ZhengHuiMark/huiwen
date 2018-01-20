//
//  ZHCertifiedNormalCell.m
//  hui
//
//  Created by yangxudong on 2018/1/1.
//  Copyright © 2018年 yangxudong. All rights reserved.
//

#import "ZHCertifiedNormalCell.h"
#import "UIColor+Extension.h"
#import "expert.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define Color(Custom) [UIColor colorWithHexString:Custom]
#define DefaultFont(font) [UIFont systemFontOfSize:font]
#define Margin 10

@implementation ZHCertifiedNormalCell {
    UILabel *_categoryTitleLabel;           /// 左侧分类标签
    UITextField *_informationTextField;     /// 需要填写
    UILabel *_showLabel;                    /// 用于展示选中结果的标签
    UIImageView *_pushImgV;
    UIView *_lineView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)configUI {  /// 所有的尺寸边距  你自己再改
    if (!_categoryTitleLabel) {
        _categoryTitleLabel = [[UILabel alloc] init];
        _categoryTitleLabel.textColor = Color(@"333333");
        _categoryTitleLabel.font = DefaultFont(12);
        [self.contentView addSubview:_categoryTitleLabel];
        [_categoryTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Margin);
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(80); // 看你需求  是否设置这个宽度
        }];
    }
    
    if (!_informationTextField) {
        _informationTextField = [[UITextField alloc] init];
        [_informationTextField addTarget:self action:@selector(signTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        _informationTextField.delegate = self;
        [self.contentView addSubview:_informationTextField];
        [_informationTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_categoryTitleLabel.mas_right);
            make.right.mas_equalTo(-Margin*2);
            make.top.bottom.mas_equalTo(self.contentView);
        }];
    }
    
    if (!_showLabel) {
        _showLabel = [[UILabel alloc] init];
        _showLabel.textColor = Color(@"333333");
        _showLabel.font = DefaultFont(12);
        [self.contentView addSubview:_showLabel];
        _showLabel.userInteractionEnabled = YES;
        [_showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_categoryTitleLabel.mas_right);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(-Margin*2);
        }];
    }
    
    if (!_pushImgV) {
        _pushImgV = [[UIImageView alloc] init];
        _pushImgV.backgroundColor = Color(@"678966");
        [self.contentView addSubview:_pushImgV];
        [_pushImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-Margin);
            make.centerY.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
    }
    
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = Color(@"eeeeee");
        [self.contentView addSubview:_lineView];
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
//    if (self.ChangeTitleSucessBlock) {
//        self.ChangeTitleSucessBlock(textField.text);
//    }
    if (self.index.row == 0) {
        self.expertModel.realname = textField.text;
    } else if (self.index.row == 1) {
        self.expertModel.nickname = textField.text;
    } else if (self.index.row == 5) {
        self.expertModel.company = textField.text;
    } else if (self.index.row == 6) {
        self.expertModel.duty = textField.text;
    }
    NSLog(@"%@",[self.expertModel yy_modelDescription]);
}

#pragma mark - Private Method
- (void)signTextFieldChanged:(UITextField *)textfield {
    NSInteger lengthNumber = [textfield isEqual:_informationTextField] ? 20 : 30;
    UITextRange *selectRange = [textfield markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textfield positionFromPosition:selectRange.start offset:0];
    if (selectRange && pos) {
        return;
    }
    if (textfield.text.length > lengthNumber) {
        textfield.text = [textfield.text substringToIndex:lengthNumber];
    }
    
    if ([textfield isEqual:_informationTextField]) {
        
    }
}

#pragma mark - Setter
/// 左侧默认
- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    _categoryTitleLabel.text = titleStr;
    NSMutableAttributedString *mastr = [[NSMutableAttributedString alloc] initWithString:_categoryTitleLabel.text];
    [mastr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
    _categoryTitleLabel.attributedText = mastr;
}

/// 编辑完成,右侧赋值
- (void)setEditEndTitle:(NSString *)editEndTitle {
    _editEndTitle = editEndTitle;
    _showLabel.text = editEndTitle;
}

- (void)setExpertModel:(expert *)expertModel {
    _expertModel = expertModel;
}

- (void)setIndex:(NSIndexPath *)index {
    _index = index;
    if (index.row == 0 || index.row == 1 || index.row == 5 || index.row == 6) {
        _informationTextField.hidden = NO;
        _showLabel.hidden = YES;
        _pushImgV.hidden = YES;
    } else {
        _informationTextField.hidden = YES;
        _showLabel.hidden = NO;
        if (index.row == 7 || index.row == 8) {
            _pushImgV.hidden = NO;
        } else {
            _pushImgV.hidden = YES;
        }
    }
    
    if (index.row == 4) {
        [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(10);
        }];
    } else {
        [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(1);
        }];
    }
}

@end
