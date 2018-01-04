 //
//  HomeViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/8/22.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "HomeViewController.h"
#import "ZHLoginViewController.h"
#import "ZHMessageTableViewController.h"
#import "OssService.h"
#import "LBViewController+ImagePicker.h"
#import "ImageModel.h"

#import "ZHRewardCellTableViewCell.h"
#import "ZHSpecialExpertTableViewCell.h"
#import "ZHJumpFourTableViewCell.h"

@interface HomeViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    OssService * service;
    NSString * uploadFilePath;

}
@property(nonatomic,strong)NSData *imageData;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor redColor];
    [self configUI];
//    NSString * const endPoint = @"http://oss-cn-qingdao.aliyuncs.com";
//    NSString * const callbackAddress = @"http://oss-demo.aliyuncs.com:23450";
//
//        service = [[OssService alloc] initWithViewController:self withEndPoint:endPoint];
//        [service setCallbackAddress:callbackAddress];
    
}

//
//// 跳转信息页
//- (void)toMessage
//{
////    ZHMessageTableViewController *messageVc = [[ZHMessageTableViewController alloc]init];
////    
////    [self.navigationController pushViewController: messageVc animated:YES];
//    
//
//}

//// 测试用 跳转登录页
- (void)actionModal{
    
    ZHLoginViewController *loginVc = [[ZHLoginViewController alloc]init];
    
    [self.navigationController pushViewController:loginVc animated:YES];
    
    
    
}
//
//- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName {
//    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
//    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
//    [imageData writeToFile:fullPath atomically:NO];
//    uploadFilePath = fullPath;
//    NSLog(@"uploadFilePath : %@", uploadFilePath);
//}
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    [picker dismissViewControllerAnimated:YES completion:^{}];
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    NSLog(@"image width:%f, height:%f", image.size.width, image.size.height);
//    [self saveImage:image withName:@"currentImage"];
//   
//}
//
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    [self dismissViewControllerAnimated:YES completion:^{}];
//}

//- (void)touch123{
// 
//    NSString * title = @"选择";
//    NSString * cancelButtonTitle = @"取消";
//    NSString * picButtonTitle = @"拍照";
//    NSString * photoButtonTitle = @"从相册选择";
//    
//    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction * picAction = [UIAlertAction actionWithTitle:picButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//        imagePickerController.delegate = self;
//        imagePickerController.allowsEditing = YES;
//        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//        [self presentViewController:imagePickerController animated:YES completion:^{}];
//    }];
//    UIAlertAction * photoAction = [UIAlertAction actionWithTitle:photoButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//        imagePickerController.delegate = self;
//        imagePickerController.allowsEditing = YES;
//        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        [self presentViewController:imagePickerController animated:YES completion:^{}];
//    }];
//    
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        [alert addAction:cancelAction];
//        [alert addAction:picAction];
//        [alert addAction:photoAction];
//    } else {
//        [alert addAction:cancelAction];
//        [alert addAction:photoAction];
//    }
//    [self presentViewController:alert animated:YES completion:nil];
//
////    NSString * objectKey = @"1" ;
////    [service asyncPutImage:objectKey localFilePath:uploadFilePath];
////    
//}
//
////- (void)touch123456{
////        NSString * objectKey = @"1" ;
//////        [service asyncPutImage:objectKey localFilePath:uploadFilePath comletion:^(BOOL isSuccess) {
////            // 拦截图片是否上传成功
////        }];
////}


- (void)configUI{

    UIButton *editorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editorBtn addTarget:self action:@selector(toMessage) forControlEvents:UIControlEventTouchUpInside];
    [editorBtn setImage:[UIImage imageNamed:@"news"] forState:UIControlStateNormal];
    [editorBtn sizeToFit];
    UIBarButtonItem *editBtnItem = [[UIBarButtonItem alloc] initWithCustomView:editorBtn];
    self.navigationItem.rightBarButtonItem = editBtnItem;
    
    UIButton *button  = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(actionModal) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    UIButton *button1  = [[UIButton alloc]initWithFrame:CGRectMake(200, 200, 100, 100)];
    
    button1.backgroundColor = [UIColor blueColor];
    [button1 addTarget:self action:@selector(touch123456) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button1];

}






@end
