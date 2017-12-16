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

static NSInteger kMaxCount = 3;


@interface ZHMyConsultDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray<MLImageModel *> *imageModels;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation ZHMyConsultDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        ZHAskTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: NSStringFromClass([ZHAskTextViewTableViewCell class])
                                                                           forIndexPath: indexPath];
        
        
        return cell;
    }
    
    
    ZHImageUploadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: NSStringFromClass([ZHImageUploadTableViewCell class])
                                                                       forIndexPath: indexPath];
    
    
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
    
    [cell.contentView addSubview:_collectionView];

    
    [cell addSubview:self.collectionView];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 150;
    }
    
    return 50;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

- (UITableView *)tableView {
    //
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height ) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        _tableView.rowHeight = 180;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            NSBundle *bundle = [NSBundle mainBundle];
        
        
        [_tableView registerNib: [UINib nibWithNibName: NSStringFromClass([ZHAskTextViewTableViewCell class]) bundle: bundle]
             forCellReuseIdentifier: NSStringFromClass([ZHAskTextViewTableViewCell class])];
        
        [_tableView registerNib: [UINib nibWithNibName: NSStringFromClass([ZHImageUploadTableViewCell class]) bundle: bundle]
             forCellReuseIdentifier: NSStringFromClass([ZHImageUploadTableViewCell class])];
    
    }
    
    return _tableView;
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
        _layout.itemSize = CGSizeMake(35, 35);
    }
    return _layout;
}


- (NSMutableArray<MLImageModel *> *)imageModels {
    if (!_imageModels) {
        _imageModels = [NSMutableArray arrayWithObject: [MLImageModel new]];
        
    }
    return _imageModels;
}


@end
