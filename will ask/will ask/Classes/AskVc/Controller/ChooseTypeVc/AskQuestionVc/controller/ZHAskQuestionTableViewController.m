//
//  ZHAskQuestionTableViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/10/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHAskQuestionTableViewController.h"
#import "ZHTitleTypeTableViewCell.h"
#import "ZHAskTextViewTableViewCell.h"
#import "ZHReleaseTableViewCell.h"
#import "ZHRewardAndDateTableViewCell.h"
#import "ZHImageUploadTableViewCell.h"
#import "ZHAskQuestionTableViewControllerHeader.h"
#import "MLImageCell.h"
#import "LBViewController+ImagePicker.h"
#import "ZHImageUploadTableViewCell.h"
#import "ZHRewardMoneyViewController.h"
#import "ZHAskQuestionModel.h"
#import "ZHNetworkTools.h"
#import "Macro.h"
#import "ImageTools.h"
#import "OssService.h"
#import "UserManager.h"
#import "UserModel.h"
#import "ImageTools.h"



static NSInteger kMaxCount = 3;


@interface ZHAskQuestionTableViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UITextViewDelegate,UIActionSheetDelegate>
{
    OssService * service;
    NSString * uploadFilePath;
    
}


@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSMutableArray<MLImageModel *> *imageModels;


@property(nonatomic,strong) ZHAskQuestionModel *model;

@property(nonatomic,strong) ZHRewardAndDateTableViewCell *dateCell;


@property(nonatomic,strong)NSMutableArray *mArray;


@end

@implementation ZHAskQuestionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 62, 20)] ;
    titleLabel.text  = @"免费问";
    //    titleLabel.backgroundColor  = [UIColor blueColor]   ;
    
    titleLabel.textColor = [UIColor blackColor] ;
    
    titleLabel.font= [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    self.view.backgroundColor = [UIColor blueColor];
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"1" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationController.navigationItem.leftBarButtonItem = backBtn;
//    self.navigationItem.backBarButtonItem = backBtn;
    
    [self setupUI];
    
    NSString * const endPoint = @"http://oss-cn-qingdao.aliyuncs.com";
    NSString * const callbackAddress = @"http://oss-demo.aliyuncs.com:23450";
    
    service = [[OssService alloc] initWithViewController:self withEndPoint:endPoint];
    [service setCallbackAddress:callbackAddress];
}



- (void)setupUI{

    
     self.tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];

    NSBundle *bundle = [NSBundle mainBundle];

    [self.tableView registerNib: [UINib nibWithNibName: NSStringFromClass([ZHTitleTypeTableViewCell class]) bundle: bundle]
     forCellReuseIdentifier: NSStringFromClass([ZHTitleTypeTableViewCell class])];
    
    [self.tableView registerNib: [UINib nibWithNibName: NSStringFromClass([ZHAskTextViewTableViewCell class]) bundle: bundle]
         forCellReuseIdentifier: NSStringFromClass([ZHAskTextViewTableViewCell class])];
    
    [self.tableView registerNib: [UINib nibWithNibName: NSStringFromClass([ZHReleaseTableViewCell class]) bundle: bundle]
         forCellReuseIdentifier: NSStringFromClass([ZHReleaseTableViewCell class])];
    
    [self.tableView registerNib: [UINib nibWithNibName: NSStringFromClass([ZHRewardAndDateTableViewCell class]) bundle: bundle]
         forCellReuseIdentifier: NSStringFromClass([ZHRewardAndDateTableViewCell class])];
  
    
    [self.tableView registerNib: [UINib nibWithNibName: NSStringFromClass([ZHImageUploadTableViewCell class]) bundle: bundle]
         forCellReuseIdentifier: NSStringFromClass([ZHImageUploadTableViewCell class])];
 
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return kZHAskQuestionTableViewControllerSectionCount;
//    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    
    switch (section) {
            
        case kValidationViewControllerSection_TypeTitle:{
            return kZHAskQuestionTableViewControllerSectionRowCountInSectionTypeTitle;
        }
            break;
            
        case kValidationViewControllerSection_TextView:{
            return kZHAskQuestionTableViewControllerSectionRowCountInSectionContentTextView;
        }
            break;
            
        case kValidationViewControllerSection_UpLoadImage:{
            return kZHAskQuestionTableViewControllerSectionRowCountInSectionUpLoadImage;
        }
        case kValidationViewControllerSectionRewardMoneyAndDate:{
            return kZHAskQuestionTableViewControllerSectionRowCountInSectionRewardMoneyAndDate;
        }
            break;
            
        case kValidationViewControllerSection_Release:{
            return kZHAskQuestionTableViewControllerSectionRowCountInSectionRelease;
        }
            break;
            
            //        case kValidationViewControllerSection_Certificate:{
            //            return kValidationViewControllerSectionRowCountInSectionCertificate;
            //        }
            //            break;
            
        default:
            break;
    }
    
    
    return 0;

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0;
        case 1:
            return 10;
        case 2:
            return 10;
        case 3:
            return 10;
        case 4:
            return 10;
    }
    return 0;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
  

    switch (indexPath.section) {
        case kValidationViewControllerSection_TypeTitle: {
            cell = [self obtainTitleTypeCellWithTableView: tableView atIndexPath: indexPath];
            
        }
            break;
            
        case kValidationViewControllerSection_TextView: {
            cell = [self obtainAskCellWithTableView:tableView atIndexPath:indexPath];
        }
            break;
         
        case kValidationViewControllerSection_UpLoadImage: {
            cell = [self obtainUpLoadImgCellWithTableView:tableView atIndexPath:indexPath];
            
        
            [cell addSubview:self.collectionView];
        }
        
            break;
            
        case kValidationViewControllerSectionRewardMoneyAndDate:{
            
            cell = [self obtainRewardAndDateCellWithTableView:tableView atIndexPath:indexPath];
            
            
        }
            break;
            
        case kValidationViewControllerSection_Release: {
            cell = [self obtainReleaseCellWithTableView:tableView atIndexPath:indexPath];
                    
            break;
                    


                default:
                    break;
            }
        }


    
    
    
    return cell?cell:[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                            reuseIdentifier: @"Cell"];

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];

    if (indexPath.section == kValidationViewControllerSectionRewardMoneyAndDate && indexPath.row == kValidationViewControllerRow_RewardMoney) {
        
        ZHRewardMoneyViewController *rewardVc = [[ZHRewardMoneyViewController alloc]init];
        
        //赋值Block，并将捕获的值赋值给UILabel
        rewardVc.returnValueBlock = ^(NSString *passedValue){
            
            self.model.amount = passedValue;
            NSLog(@"悬赏金是 = %@",passedValue);
            [self.tableView reloadData];
        };
        
      
        
        [self.navigationController pushViewController:rewardVc animated:YES];
    }
    
    if (indexPath.section == kValidationViewControllerSectionRewardMoneyAndDate && indexPath.row == kValidationViewControllerRow_RewardData) {
        
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@""
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"48小时", @"24小时",@"12小时",@"6小时",nil];
        
        
        actionSheet.actionSheetStyle = UIBarStyleDefault;
        [actionSheet showInView:self.view];
    
    }
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    self.model.timeLimit = [actionSheet buttonTitleAtIndex:buttonIndex];
//    _dateCell.RewardNumberL.text = _model.timeLimit;
    
    [self.tableView reloadData];
    
    
}

- (ZHTitleTypeTableViewCell *)obtainTitleTypeCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    
    ZHTitleTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: NSStringFromClass([ZHTitleTypeTableViewCell class])
                                                                        forIndexPath: indexPath];
    cell.titleType.text = self.titleTypeLabel;
    cell.titleSubType.text = self.titleSubTypeLabel;
    
    return  cell;
    
}


- (ZHAskTextViewTableViewCell *)obtainAskCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    
    ZHAskTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: NSStringFromClass([ZHAskTextViewTableViewCell class])
                                                                     forIndexPath: indexPath];
    cell.model = self.model;

    
    return  cell;
    
}

- (ZHImageUploadTableViewCell *)obtainUpLoadImgCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    
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

    
    return  cell;
    
}

- (ZHRewardAndDateTableViewCell *)obtainRewardAndDateCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    
    ZHRewardAndDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: NSStringFromClass([ZHRewardAndDateTableViewCell class])
                                                                     forIndexPath: indexPath];
    
    cell.tete = self;
    cell.indexPath = indexPath;
    cell.model = self.model;
    
 
    
    return  cell;
    
}


- (ZHReleaseTableViewCell *)obtainReleaseCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    
    ZHReleaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: NSStringFromClass([ZHReleaseTableViewCell class])
                                                                    forIndexPath: indexPath];
    cell.releaseBtnClick = ^(){
        
        NSString *url = [NSString stringWithFormat:@"%@/api/freeask/ut/submit",kIP];
        
        NSMutableDictionary *dic = [ZHNetworkTools parameters];
        [dic setObject:@"123" forKey:@"content"];
        [dic setObject:self.titleSubTypeLabel forKey:@"typeCode"];
        
//        NSMutableArray *images = [NSMutableArray array];
        NSInteger index=0;
        
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
                NSLog(@"2131312321323  ===%@",objectKey);
                
                NSString *bucketName = bucketNameFree;
                NSLog(@"%@",bucketName);
                
                [service asyncPutImage:objectKey localFilePath:uploadFilePath bucketName:bucketName comletion:^(BOOL isSuccess) {
                    
                    if (isSuccess) {
                        [self.mArray addObject:objectKey];
                        NSLog(@"marray = %@", _mArray);
                    }
                    
                }];
                
             
            }
        }
        
        
//
//        [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
//            
//            if (error) {
////                NSLog(@"%@",error);
//            }
//            
////            NSLog(@"response = %@",response);
//            
//            
//        }];
        
    };
    
    return  cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case kValidationViewControllerSection_TypeTitle: {
            return 50;
        }
            break;
            
        case kValidationViewControllerSection_TextView: {
            return 150;
        }
            break;
            
        case kValidationViewControllerSection_UpLoadImage:{
            return 50;
        
        }
            break;
        
        case kValidationViewControllerSectionRewardMoneyAndDate:{
            return 50;
        }
            break;
            
        case kValidationViewControllerSection_Release: {
        
            return 45;
        }
            break;
    }
    
    return 0;
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


- (ZHAskQuestionModel *)model {
    if (!_model) {
        _model = [ZHAskQuestionModel new];
    }
    return _model;
}

- (NSMutableArray *)mArray {
    
    if (!_mArray) {
        
        _mArray = [[NSMutableArray alloc]init];
    }
    
    return _mArray;
}


@end
