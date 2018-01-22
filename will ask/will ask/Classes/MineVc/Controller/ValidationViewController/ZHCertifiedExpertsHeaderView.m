//
//  ZHCertifiedExpertsHeaderView.m
//  ZH
//
//  Created by yangxudong on 2018/1/1.
//  Copyright © 2018年 yangxudong. All rights reserved.
//

#import "ZHCertifiedExpertsHeaderView.h"
#import "UIColor+Extension.h"
#import "expert.h"
#import "UIView+LayerEffects.h"
#import "LBViewController+ImagePicker.h"
#import "ZHImageCategory.h"

#define Color(Custom) [UIColor colorWithHexString:Custom]
#define DefaultFont(font) [UIFont systemFontOfSize:font];
#define WEAKSELF __weak __typeof(self)weakSelf = self;
#define STRONGSELF __strong __typeof(weakSelf)strongSelf = weakSelf;

@implementation ZHCertifiedExpertsHeaderView {
    UIButton *_iconBtn;
    UIImageView *_cameraImg;
    UILabel *_descLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
        self.imageCategory = [[ZHImageCategory alloc] init];
    }
    return self;
}

- (void)configUI {
    self.backgroundColor = Color(@"ffffff");
    
    _iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _iconBtn.layer.cornerRadius = 37.5;
    _iconBtn.layer.masksToBounds = YES;
    _iconBtn.titleLabel.font = DefaultFont(11);
    _iconBtn.titleLabel.textColor = Color(@"333333");
    [_iconBtn setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    [_iconBtn addTarget:self action:@selector(setCertificationCard:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_iconBtn];
    [_iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.height.mas_equalTo(75);
    }];
    
    _descLabel = [[UILabel alloc] init];
    _descLabel.text = @"请上传真实照片";
    _descLabel.font = DefaultFont(11);
    _descLabel.textColor = [UIColor redColor];
    [self addSubview:_descLabel];
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(-10);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    lineView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.mas_equalTo(self);
        make.height.mas_equalTo(10);
    }];
}

#pragma mark - Private Method
- (void)customMethod {
    
}


- (void)setCertificationCard:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    WEAKSELF
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[self viewController] selectPhotoWithSuccessBlock:^(UIImagePickerController *imagePickerViewController, NSDictionary<NSString *,id> *info) {
            STRONGSELF
            UIImage *image = info[UIImagePickerControllerEditedImage];
            [strongSelf->_iconBtn setImage:image forState:UIControlStateNormal];
            NSArray *arr = @[image,@"realphoto"];
            [[ZHNetworkTools sharedTools] imageChangeParameter:arr.mutableCopy hander:^(NSString *objectKey, NSString *uploadFilePath) {
                self.expert.realPhoto = objectKey;
                self.imageCategory.uploadFilePath = uploadFilePath;
                self.imageCategory.objectKey = objectKey;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotification_AddImage" object:self.imageCategory];
            }];
        } cancelBlock:^(UIImagePickerController *imagePickerViewController) {}];
    }];
    [alert addAction:cameraAction];
    [alert addAction:albumAction];
    [alert addAction:cancelAction];
    [[self viewController] presentViewController:alert animated:YES completion:nil];
//    [NSString stringWithFormat:@"%@%@%@",bucketNameUser,OSS,]
}


@end
