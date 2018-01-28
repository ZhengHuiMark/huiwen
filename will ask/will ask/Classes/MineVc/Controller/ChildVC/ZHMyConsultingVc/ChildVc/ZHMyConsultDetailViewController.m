//
//  ZHMyConsultDetailViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/12/15.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMyConsultDetailViewController.h"
#import "MLImageCell.h"
#import "ZHAskTextViewTableViewCell.h"
#import "ZHImageUploadTableViewCell.h"
#import "LBViewController+ImagePicker.h"
#import "ZHNetworkTools.h"
#import "Macro.h"
#import "ImageTools.h"
#import "OssService.h"
#import "UserManager.h"
#import "UserModel.h"
#import "ImageTools.h"

#import "ZHOrderPayModel.h"
#import "ZHOrderPaymentViewController.h"

static NSInteger kMaxCount = 3;


@interface ZHMyConsultDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate>
{
    OssService * service;
    NSString * uploadFilePath;
}
@property(nonatomic,strong)UITableView *tableView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray<MLImageModel *> *imageModels;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) NSMutableArray *mArray;

@property (nonatomic, strong) UIButton *saveBtn;

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView *textBackView;
@property (nonatomic, strong) UILabel *strNumLabel;
@property (nonatomic, strong) UIView *imageBackView;


@end

@implementation ZHMyConsultDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    [self configUI];
    
    NSString * const endPoint = @"http://oss-cn-qingdao.aliyuncs.com";
    NSString * const callbackAddress = @"http://oss-demo.aliyuncs.com:23450";
    
    service = [[OssService alloc] initWithViewController:self withEndPoint:endPoint];
    [service setCallbackAddress:callbackAddress];
}

- (void)configUI{
    
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveBtn.frame = CGRectMake(0, 0, 40, 40);
    [self.saveBtn setTitle:@"发布" forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [self.saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.saveBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    self.textBackView = [[UIView alloc] init];
    self.textBackView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.textBackView];
    [self.textBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(13);
        make.height.mas_equalTo(150);
        make.right.left.mas_equalTo(self.view);
    }];
    
    _textView = [[UITextView alloc] init];
    _textView.placeholder = @"请输入您的问题";
    _textView.textContainerInset = UIEdgeInsetsMake(10, 10, 15, 10);
    _textView.textColor = [UIColor blackColor];
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.delegate = self;
    //    [_textView setBorder:ColorLine width:1];
    [self.textBackView addSubview:_textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, -10, 0));
    }];
    
    _strNumLabel = [[UILabel alloc] init];
    //    _strNumLabel.backgroundColor = [UIColor redColor];
    _strNumLabel.text = @"0/1000";
    [self.textBackView addSubview:_strNumLabel];
    [_strNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(-10);
        //        make.height.mas_equalTo(10);
    }];
    
    _imageBackView = [[UIView alloc]init];
    _imageBackView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_imageBackView];
    
    [_imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_textBackView).offset(100);
        make.right.left.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    _collectionView = [[UICollectionView alloc] initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50) collectionViewLayout: self.layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.contentInset = UIEdgeInsetsMake(0,18, 0, 0);
    [_collectionView registerNib:[UINib nibWithNibName: NSStringFromClass([MLImageCell class])
                                                bundle: [NSBundle mainBundle]]
      forCellWithReuseIdentifier: NSStringFromClass([MLImageCell class])];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    
    [_imageBackView addSubview:_collectionView];
    
    

    
}

- (void)saveBtnClick:(UIButton *)sender {
    /// 如果没有编辑就不能点击保存
    if (!sender.selected) {
        [SVProgressHUD showInfoWithStatus:@"请编写问题内容"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }

    // 发布拉起
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    WEAKSELF
    if (_expertID) {
        [dic setObject:_expertID forKey:@"expertId"];
        
        [dic setObject:_textView.text forKey:@"question"];
        NSString *url = [NSString stringWithFormat:@"%@/api/ut/consult/question",kIP];
        
        NSInteger index=0;
        __block NSInteger  imgCount = 0;
        if (self.imageModels.count == 1) {
            [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                
                if (error) {
                    NSLog(@"%@",error);
                }
                
                NSLog(@"response = %@",response);
                
                ZHOrderPayModel *model = [ZHOrderPayModel yy_modelWithJSON:response[@"data"]];
                model.descriptions = @"咨询订单";
                model.goodsName = self.expertNickName;
                model.amount = @"0.01";
                
                ZHOrderPaymentViewController *payVc = [[ZHOrderPaymentViewController alloc]init];
                payVc.payModel = model;
                
                payVc.popToView = ^{
                    [weakSelf.navigationController popViewControllerAnimated:true];
                };
                
                [self.navigationController pushViewController:payVc animated:YES];
                
            }];
            
        } else {
            for (MLImageModel *imageModel in self.imageModels) {
                if (imageModel.modelType == MLImageModelTypePlaceholder) continue;{
                    
                    
                    NSData *imageData = UIImageJPEGRepresentation(imageModel.image, 0.5);
                    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"123"];
                    [imageData writeToFile:fullPath atomically:NO];
                    uploadFilePath = fullPath;
                    //                NSLog(@"uploadFilePath : %@", uploadFilePath);
                    
                    
                    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] *1000;
                    
                    NSString * objectKey = [NSString stringWithFormat:@"%@%@%f%ld",[UserManager sharedManager].userModel.resourceId,@"AQ",interval,(long)index];
                    index++;
                    //            NSLog(@"2131312321323  ===%@",objectKey);
                    
                    NSString *bucketName = bucketNameConsult;
                    //            NSLog(@"%@",bucketName);
                    
                    [service asyncPutImage:objectKey localFilePath:uploadFilePath bucketName:bucketName comletion:^(BOOL isSuccess) {
                        
                        if (isSuccess) {
                            [self.mArray addObject:objectKey];
                            
                            if (self.mArray.count >= imgCount) {
                                [dic setObject: [_mArray componentsJoinedByString:@","] forKey: @"questionPhotos"];
                                [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                                    
                                    if (error) {
                                        NSLog(@"%@",error);
                                    }
                                    
                                    NSLog(@"response = %@",response);
                                    
                                    ZHOrderPayModel *model = [ZHOrderPayModel yy_modelWithJSON:response[@"data"]];
                                    model.descriptions = @"咨询订单";
                                    model.goodsName = self.expertNickName;
                                    model.amount = @"0.01";
                                    
                                    ZHOrderPaymentViewController *payVc = [[ZHOrderPaymentViewController alloc]init];
                                    payVc.payModel = model;
                                    payVc.popToView = ^{
                                        [weakSelf.navigationController popViewControllerAnimated:true];
                                    };
                                    
                                    [self.navigationController pushViewController:payVc animated:YES];
                                    
                                }];
                            }
                            
                        } else {
                            imgCount--;
                        }
                    }];
                }
            }
        }
    }
    
    if (_consultId) {
        [dic setObject:_consultId forKey:@"consultId"];
        [dic setObject:_textView.text forKey:@"question"];
        NSString *url = [NSString stringWithFormat:@"%@/api/ut/consult/addQuestion",kIP];
        
        NSInteger index=0;
        __block NSInteger  imgCount = 0;
        if (self.imageModels.count == 1) {
            [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                
                if (error) {
                    NSLog(@"%@",error);
                }
                
                NSLog(@"response = %@",response);
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }];
            
        } else {
            for (MLImageModel *imageModel in self.imageModels) {
                if (imageModel.modelType == MLImageModelTypePlaceholder) continue;{
                    
                    
                    NSData *imageData = UIImageJPEGRepresentation(imageModel.image, 0.5);
                    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"123"];
                    [imageData writeToFile:fullPath atomically:NO];
                    uploadFilePath = fullPath;
                    //                NSLog(@"uploadFilePath : %@", uploadFilePath);
                    
                    
                    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] *1000;
                    
                    NSString * objectKey = [NSString stringWithFormat:@"%@%@%f%ld",[UserManager sharedManager].userModel.resourceId,@"AQ",interval,(long)index];
                    index++;
                    //            NSLog(@"2131312321323  ===%@",objectKey);
                    
                    NSString *bucketName = bucketNameConsult;
                    //            NSLog(@"%@",bucketName);
                    
                    [service asyncPutImage:objectKey localFilePath:uploadFilePath bucketName:bucketName comletion:^(BOOL isSuccess) {
                        
                        if (isSuccess) {
                            [self.mArray addObject:objectKey];
                            
                            if (self.mArray.count >= imgCount) {
                                [dic setObject: [_mArray componentsJoinedByString:@","] forKey: @"questionPhotos"];
                                [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                                    
                                    if (error) {
                                        NSLog(@"%@",error);
                                    }
                                    
                                    NSLog(@"response = %@",response);
                                    
                                    [self.navigationController popViewControllerAnimated:YES];
                                    
                                }];
                            }
                            
                        } else {
                            imgCount--;
                        }
                    }];
                }
            }
        }
        
    }

//    }
    

}

// -- 改变字数- textViewDidChange
-(void)textViewDidChange:(UITextView *)textView{
    UITextRange *selectRange = [textView markedTextRange];
    UITextPosition *pos = [textView positionFromPosition:selectRange.start offset:0];
    if (selectRange && pos) return;
    if (textView.text.length >= 1000) {
        textView.text = [textView.text substringToIndex:1000];
    }
    NSUInteger count = textView.text.length;
    if (textView.text.length > 1000) {
        textView.text = [textView.text substringToIndex:1000];
        self.strNumLabel.text = [NSString stringWithFormat:@"1000/1000"];
    } else {
        self.strNumLabel.text = [NSString stringWithFormat:@"%ld/1000", (unsigned long)count];
    }
    if (textView.text.length>0) {
        self.saveBtn.selected = YES;
    } else {
        self.saveBtn.selected = NO;
    }

}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [self.view endEditing:YES];
        return NO;
    }
    return YES;
}



#pragma mark - UICollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MLImageCell *imageCell = [collectionView dequeueReusableCellWithReuseIdentifier: NSStringFromClass([MLImageCell class])
                                                                       forIndexPath: indexPath];
    imageCell.imageModel = self.imageModels[indexPath.item];
    return imageCell;
}

#pragma mark - UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 获取 Model
    MLImageModel *imageModel = self.imageModels[indexPath.item];
    
    // 判断 Model 的类型
    switch (imageModel.modelType) {
        case MLImageModelTypePlaceholder: { // 如果是 PlaceHolder 类型, 则需要调起相机或者相册让用户选图片, 我在这里是假装用户选择了一张图片.
            [self selectPhotoWithSuccessBlock:^(UIImagePickerController *imagePickerViewController, NSDictionary<NSString *,id> *info) {
                UIImage *image = info[UIImagePickerControllerEditedImage];
                
                
                
                // 创建数据模型
                MLImageModel *imageModel = [MLImageModel new];
                imageModel.image = image;
                
                // 重新配置数组, 你应该把这个图片放在数组的倒数第二位, 因为倒数第一位应该是占位图
                NSInteger count = self.imageModels.count;
                [self.imageModels insertObject: imageModel
                                       atIndex: count-1];
                
                // 在这里你需要判断是否已经超出了最大值, 如果超出了最大值, 你需要删除掉最后一个占位图
                if (self.imageModels.count > kMaxCount) {
                    [self.imageModels removeObjectAtIndex: self.imageModels.count-1];
                }
                
                [self.collectionView reloadData];
                
                
            } cancelBlock:^(UIImagePickerController *imagePickerViewController) {}];
            
        }
            break;
            
        case MLImageModelTypeImage: { // 如果是 Image 类型, 在这里可以做删除图片的操作, 也可以不做任何操作, 主要看你的业务逻辑, 我在这里写的是删除图片的操作.
            
            // 我在这里模拟做一下删除图片的操作, 你需要删除的是对应下标的图片
            [self.imageModels removeObjectAtIndex: indexPath.item];
            
            // 在这里判断最后一张是不是占位图, 如果是占位图则什么操作都不用做, 如果不是占位图, 则需要添加一个占位图的数据模型
            MLImageModel *imageModel = [self.imageModels lastObject];
            if (imageModel.modelType != MLImageModelTypePlaceholder) {
                
                MLImageModel *placeHolderModel = [MLImageModel new];
                [self.imageModels addObject: placeHolderModel];
            }
        }
            break;
    }
    
    // 刷新 CollectionView
    [self.collectionView reloadData];
}


#pragma mark - Lazy load
- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumInteritemSpacing = 10;
        _layout.minimumLineSpacing = 10;
        _layout.sectionInset = UIEdgeInsetsZero;
        _layout.itemSize = CGSizeMake(25, 25);
    }
    return _layout;
}


- (NSMutableArray<MLImageModel *> *)imageModels {
    if (!_imageModels) {
        _imageModels = [NSMutableArray arrayWithObject: [MLImageModel new]];
        
    }
    return _imageModels;
}

- (NSMutableArray *)mArray {
    
    if (!_mArray) {
        
        _mArray = [[NSMutableArray alloc]init];
    }
    
    return _mArray;
}


@end
