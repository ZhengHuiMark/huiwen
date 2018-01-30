//
//  ZHCertificateCell.m
//  ZH
//
//  Created by yangxudong on 2018/1/11.
//  Copyright © 2018年 yangxudong. All rights reserved.
//

#import "ZHCertificateCell.h"
#import "UIColor+Extension.h"
#import "CertifiedExpertsModel.h"
#import "expert.h"
#import "ZHImageCategory.h"
#import "LBViewController+ImagePicker.h"

#define Color(Custom) [UIColor colorWithHexString:Custom]
#define DefaultFont(font) [UIFont systemFontOfSize:font]
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define WEAKSELF __weak __typeof(self)weakSelf = self;
#define STRONGSELF __strong __typeof(weakSelf)strongSelf = weakSelf;


@implementation ZHCertificateCell {
    UIView *_idcordView;    // 身份证
    UIView *_lineView;
    UIView *_expertsIdView; // 专家身份
    UIImageView *_frontalIdImg;
    UIImageView *_backIdImg;
    NSMutableArray *_btnArr;
    UILabel *_certifiedLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier categoryArr:(NSArray *)arr {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _btnArr = [NSMutableArray new];
        self.categoryArr = arr;
        self.imageBack = [[ZHImageCategory alloc] init];
        self.imageFront = [[ZHImageCategory alloc] init];
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = Color(@"eeeeee");
    [self addSubview:_lineView];
    if (!self.isCertification) {
        [self creatZHIdentityCardViewYes];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_equalTo(_idcordView);
            make.top.mas_equalTo(_idcordView.mas_bottom);
            make.height.mas_equalTo(1);
        }];
    } else {
        [self creatZHIdentityCardViewNot];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_equalTo(_idcordView);
            make.top.mas_equalTo(_idcordView.mas_bottom);
            make.height.mas_equalTo(10);
        }];
    }
    [self creatExpertsIdView];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = Color(@"eeeeee");
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.mas_equalTo(1);
        make.height.mas_equalTo(1);
    }];
}

- (void)creatZHIdentityCardViewNot {
    _idcordView = [[UIView alloc] init];
    _idcordView.backgroundColor = Color(@"ffffff");
    [self addSubview:_idcordView];
    [_idcordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(self);
        make.height.mas_equalTo(180);
    }];
    
    UILabel *idcordLabel = [self creatSubLabel:@"*身份认证照片:" color:[UIColor colorWithHexString:@"333333"] font:15];
    
    NSMutableAttributedString *mastr = [[NSMutableAttributedString alloc] initWithString:idcordLabel.text];
    [mastr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
    idcordLabel.attributedText = mastr;
    [_idcordView addSubview:idcordLabel];
    [idcordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(10);
    }];
    
    UILabel *idDescLabel = [self creatSubLabel:@"仅认证时使用" color:[UIColor colorWithHexString:@"666666"] font:13];
    [_idcordView addSubview:idDescLabel];
    [idDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(idcordLabel);
    }];
    
    CGFloat margin = 20;
    CGFloat width = (kWidth - 20 * 2 - 15)/2;
    _frontalIdImg = [[UIImageView alloc] init];
    _frontalIdImg.tag = 101;
//    _frontalIdImg.backgroundColor = [UIColor redColor];
    _frontalIdImg.image = [UIImage imageNamed:@"zheng"];
    [_idcordView addSubview:_frontalIdImg];
    _frontalIdImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapFront = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setCertificationCard:)];
    [_frontalIdImg addGestureRecognizer:tapFront];
    [_frontalIdImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(idcordLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(margin);
        make.size.mas_equalTo(CGSizeMake(width, width/1.6));
    }];
    
    _backIdImg = [[UIImageView alloc] init];
    _backIdImg.tag = 102;
    _backIdImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapBack = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setCertificationCard:)];
    [_backIdImg addGestureRecognizer:tapBack];
//    _backIdImg.backgroundColor = [UIColor redColor];
    _backIdImg.image = [UIImage imageNamed:@"fan"];

    [_idcordView addSubview:_backIdImg];
    [_backIdImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(idcordLabel.mas_bottom).offset(15);
        make.right.mas_equalTo(-margin);
        make.size.mas_equalTo(CGSizeMake(width, width/1.6));
    }];
}

- (void)creatZHIdentityCardViewYes {
    _idcordView = [[UIView alloc] init];
    [self addSubview:_idcordView];
    [_idcordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(self);
        make.height.mas_equalTo(74.5);
    }];
    UILabel *idcordLabel = [self creatSubLabel:@"已认证专家身份:" color:[UIColor colorWithHexString:@"333333"] font:15];
//    NSMutableAttributedString *mastr = [[NSMutableAttributedString alloc] initWithString:idcordLabel.text];
//    [mastr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
//    idcordLabel.attributedText = mastr;
    [_idcordView addSubview:idcordLabel];
    [idcordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(19.5);
    }];
    
    _certifiedLabel = [self creatSubLabel:@"" color:[UIColor colorWithRed:242.0/255.0 green:90.0/255.0 blue:41.0/255.0 alpha:1] font:15];
    [_idcordView addSubview:_certifiedLabel];
    [_certifiedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(idcordLabel);
        make.top.mas_equalTo(idcordLabel.mas_bottom).offset(5);
    }];
}

// 专家身份view
- (void)creatExpertsIdView {
    _expertsIdView = [[UIView alloc] init];
    _expertsIdView.backgroundColor = Color(@"ffffff");
    [self addSubview:_expertsIdView];
    [_expertsIdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_lineView);
        make.top.mas_equalTo(_lineView.mas_bottom);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(100);
    }];
    
    UILabel *expertsLabel = [self creatSubLabel:@"*专家身份:" color:[UIColor colorWithHexString:@"333333"] font:15];
    NSMutableAttributedString *mastr = [[NSMutableAttributedString alloc] initWithString:expertsLabel.text];
    [mastr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];

    expertsLabel.attributedText = mastr;
    [_expertsIdView addSubview:expertsLabel];
    
    [expertsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
    }];
    
    UILabel *experDescL = [self creatSubLabel:@"仅验证身份时使用" color:[UIColor colorWithHexString:@"6666666"] font:13];
    [_expertsIdView addSubview:experDescL];
    [experDescL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(expertsLabel);
        make.right.mas_equalTo(-10);
    }];
    
//    NSArray *experArr = @[@" 注册会计师",@" 评估师",@" 财务师",@" 税务师"];
    UIButton *lastView;
    for (NSInteger i = 0; i < self.categoryArr.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.tag = i;
        CertifiedExpertsModel *model = self.categoryArr[i];
        [btn setTitle:model.name forState:UIControlStateNormal];
        [btn setTitleColor:Color(@"333333") forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"Expers_nor"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"Expers_sed"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnTouchSed:) forControlEvents:UIControlEventTouchUpInside];
        [_expertsIdView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastView) {
                make.left.mas_equalTo(lastView.mas_right);
            } else {
                make.left.mas_equalTo(10);
            }
            make.size.mas_equalTo(CGSizeMake((kWidth-20)/4, 30));
            make.top.mas_equalTo(expertsLabel.mas_bottom).offset(15);
        }];
        lastView = btn;
        [_btnArr addObject:btn];
    }
}

#pragma mark - Setter
- (void)setIsCertification:(BOOL)isCertification {
    _isCertification = isCertification;
    if (isCertification) {
        for (CertifiedExpertsModel *model in self.isCertificationCateArr) {
            if (_certifiedLabel.text.length>0) {
                _certifiedLabel.text = [NSString stringWithFormat:@"%@%@",_certifiedLabel.text,model.name];
            } else {
                _certifiedLabel.text = [NSString stringWithFormat:@"%@     %@",_certifiedLabel.text,model.name];
            }
        }
    }
}

#pragma mark - Private Method
- (void)btnTouchSed:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.SelectedExpertCategoryBlcok) {
        self.SelectedExpertCategoryBlcok(self.categoryArr[sender.tag], sender.selected);
    }
}

- (void)setCertificationCard:(UITapGestureRecognizer *)tap {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    WEAKSELF
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[self viewController] selectPhotoWithSuccessBlock:^(UIImagePickerController *imagePickerViewController, NSDictionary<NSString *,id> *info) {
            STRONGSELF
            NSArray *arr;
            UIImage *image = info[UIImagePickerControllerEditedImage];
            if (tap.view.tag == 101) {
                strongSelf->_frontalIdImg.image = image;
                arr = @[image,@"ic_front"];
            } else {
                strongSelf->_backIdImg.image = image;
                arr = @[image,@"ic_reverse"];
            }
            [[ZHNetworkTools sharedTools] imageChangeParameter:arr.mutableCopy hander:^(NSString *objectKey, NSString *uploadFilePath) {
                if (tap.view.tag == 101) {
                    self.imageFront.uploadFilePath = uploadFilePath;
                    self.imageFront.objectKey = objectKey;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotification_AddImage" object:self.imageFront];
                } else {
                    self.imageBack.uploadFilePath = uploadFilePath;
                    self.imageBack.objectKey = objectKey;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotification_AddImage" object:self.imageBack];
                }
                if (tap.view.tag == 101) {
                    self.expert.identityCardFront = objectKey;
                } else {
                    self.expert.identityCardReverse = objectKey;
                }
            }];
        } cancelBlock:^(UIImagePickerController *imagePickerViewController) {}];
    }];
    [alert addAction:cameraAction];
    [alert addAction:albumAction];
    [alert addAction:cancelAction];
    [[self viewController] presentViewController:alert animated:YES completion:nil];
}

- (UILabel *)creatSubLabel:(NSString *)title color:(UIColor *)color font:(CGFloat)font {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:font];
    label.text = title;
    label.textColor = color;
    return label;
}


@end


