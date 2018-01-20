//
//  ZHExpertCategoryCell.m
//  ZH
//
//  Created by yangxudong on 2018/1/11.
//  Copyright © 2018年 yangxudong. All rights reserved.
//

#import "ZHExpertCategoryCell.h"
#import "UIColor+Extension.h"
#import "Masonry.h"
#import "CertifiedExpertsModel.h"
#import "certifications.h"
#import "expert.h"
#import "LBViewController+ImagePicker.h"

#define Color(Custom) [UIColor colorWithHexString:Custom]
#define DefaultFont(font) [UIFont systemFontOfSize:font]
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@implementation ZHExpertCategoryCell {
    NSString *_title;
    UILabel *_cateLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.imageArr = [NSMutableArray new];
        self.certifications = [[certifications alloc] init];
        [self configUI];
    }
    return self;
}


- (void)configUI {
    _cateLabel = [self creatSubLabel:@"" color:@"333333" font:15];
    [self addSubview:_cateLabel];
    [_cateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
    }];
    
    CGFloat margin = 15;
    UIButton *lastView;
    for (NSInteger i = 0; i < 3; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.tag = i;
        btn.backgroundColor = [UIColor orangeColor];
        //        [btn setImage:[UIImage imageNamed:@"Expers_nor"] forState:UIControlStateNormal];
        //        [btn setImage:[UIImage imageNamed:@"Expers_sed"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(sedImage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastView) {
                make.left.mas_equalTo(lastView.mas_right).offset(margin);
            } else {
                make.left.mas_equalTo(margin);
            }
            make.width.height.mas_equalTo((kWidth-margin*4)/3);
            make.top.mas_equalTo(_cateLabel.mas_bottom).offset(margin);
        }];
        lastView = btn;
    }
    
    UILabel *descLabel = [self creatSubLabel:@"请上传身份证书1-3张,确保个人信息,发证日期及发证单位显示清晰完整" color:@"666666" font:13];
    [self addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastView.mas_bottom).offset(10);
        make.right.mas_equalTo(-margin);
        make.left.mas_equalTo(margin);
        make.bottom.mas_equalTo(-10);
    }];
}

- (void)setModel:(CertifiedExpertsModel *)model {
    _model = model;
    _cateLabel.text = model.name;
}

- (UILabel *)creatSubLabel:(NSString *)title color:(NSString *)color font:(CGFloat)font {
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.text = @"你好晖儿";
    label.font = [UIFont systemFontOfSize:font];
    label.text = title;
    label.textColor = Color(color);
    return label;
}

- (void)sedImage:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[self viewController] selectPhotoWithSuccessBlock:^(UIImagePickerController *imagePickerViewController, NSDictionary<NSString *,id> *info) {
            UIImage *image = info[UIImagePickerControllerEditedImage];
            [sender setImage:image forState:UIControlStateNormal];
            BOOL isReplace = NO;
            for (NSInteger i = 0; i < self.imageArr.count; i ++) {
                ZHImageCategory *imageModel = self.imageArr[i];
                if (sender.tag == imageModel.index) {
                    imageModel.image = image;
                    isReplace = YES;
                    break;
                }
            }
            if (!isReplace) {
                ZHImageCategory *imageModel = [[ZHImageCategory alloc] init];
                imageModel.index = sender.tag;
                imageModel.image = image;
                [self.imageArr addObject:imageModel];
            }
            NSArray *arr = @[image,@"cert",@(self.model.type)];
            [[ZHNetworkTools sharedTools] imageChangeParameter:arr.mutableCopy hander:^(NSString *objectKey, NSString *uploadFilePath) {
                if (sender.tag == 0) {
                    self.certifications.certificate1 = [NSString stringWithFormat:@"%@%ld",objectKey,sender.tag];
                } else if (sender.tag == 1) {
                    self.certifications.certificate2 = [NSString stringWithFormat:@"%@%ld",objectKey,sender.tag];
                } else if (sender.tag == 2) {
                    self.certifications.certificate3 = [NSString stringWithFormat:@"%@%ld",objectKey,sender.tag];
                }
                [self.expert.certifications removeObject:self.certifications];
                [self.expert.certifications addObject:self.certifications];
                self.uploadFilePath = uploadFilePath;
            }];
        } cancelBlock:^(UIImagePickerController *imagePickerViewController) {}];
    }];
    [alert addAction:cameraAction];
    [alert addAction:albumAction];
    [alert addAction:cancelAction];
    [[self viewController] presentViewController:alert animated:YES completion:nil];
}

- (CGFloat)calculateSelfHeight {
    CGFloat height = 0;
    height = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return height;
}

@end

@implementation ZHImageCategory


@end
