//
//  ZHPersonalInformationVc.m
//  will ask
//
//  Created by 郑晖 on 2017/9/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHPersonalInformationVc.h"
#import "ZHEditTableViewCell.h"
#import "EditPersonal.h"
#import "UserInfoModel.h"
#import "NSDate+BRAdd.h"
//#import "BaseView.h"
#import "OssService.h"
#import "ZHPersonalHeaderTableViewCell.h"
#import "ZHNetworkTools.h"

// HeaderCellid
static NSString *HeaderCellid = @"HeaderCellid";
//
static NSString *nameCellid = @"nameCellid";




@interface ZHPersonalInformationVc ()<UIActionSheetDelegate,UIPickerViewDelegate,UINavigationControllerDelegate>


{
    OssService * service;
    NSString * uploadFilePath;
    
}
@property(nonatomic,strong)NSData *imageData;


@property (nonatomic, strong) UserInfoModel *UserInfoModel;

@property (nonatomic, weak)ZHPersonalHeaderTableViewCell *PersonalHeadlerCell;

@property (nonatomic, weak)ZHEditTableViewCell *EditCell;


@end

@implementation ZHPersonalInformationVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor blueColor];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 62, 20)] ;
    titleLabel.text  = @"个人信息";
    //    titleLabel.backgroundColor  = [UIColor blueColor]   ;
    
    titleLabel.textColor = [UIColor blackColor] ;
    
    titleLabel.font= [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(clickButton)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];

    
    [self configurUI];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    NSString * const endPoint = @"http://oss-cn-qingdao.aliyuncs.com";
    NSString * const callbackAddress = @"http://oss-demo.aliyuncs.com:23450";
    
    service = [[OssService alloc] initWithViewController:self withEndPoint:endPoint];
    [service setCallbackAddress:callbackAddress];
    

}


- (void)clickButton{
    
    NSString * objectKey = @"2" ;
    [service asyncPutImage:objectKey localFilePath:uploadFilePath];
    
    NSMutableDictionary *dict = [ZHNetworkTools parameters];
    
    [dict setObject: objectKey
             forKey: @"avatar"];
    [dict setObject: self.EditCell.NameTextF.text
             forKey: @"nickname"];
//    [dict setObject: _PasswordT.text
//             forKey: @"password"];

    NSString *url = @"http://119.57.140.230:7000/api/ut/user/saveUserInfo";

    [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dict andCallBlock:^(id response, NSError *error) {
        // 2. 判断错误
        if (error) {
            NSLog(@"网络请求异常: %@", error);
            
            return;
        }
        NSLog(@"%@",response);
//        [UserManager sharedManager].userModel = [UserModel yy_modelWithJSON:response[@"data"]];
//        [[UserManager sharedManager]saveUserModel];
        
    }];
    
}

- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName {
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPath atomically:NO];
    uploadFilePath = fullPath;
    NSLog(@"uploadFilePath : %@", uploadFilePath);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"image width:%f, height:%f", image.size.width, image.size.height);
    [self saveImage:image withName:@"currentImage"];
    
    [self.PersonalHeadlerCell.UserAvatarImg setImage:image forState:UIControlStateNormal];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)touch123{
    

    //    NSString * objectKey = @"1" ;
    //    [service asyncPutImage:objectKey localFilePath:uploadFilePath];
    //    
}



- (void)configurUI{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHPersonalHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:HeaderCellid];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHEditTableViewCell" bundle:nil] forCellReuseIdentifier:nameCellid];

    
    self.tableView.rowHeight = 50;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case kValidationViewControllerSection_Avatar: {
            return kValidationViewControllerSectionRowCountInSectionAvatar;
        }
            break;
            
        case kValidationViewControllerSection_UserInfo: {
            return kValidationViewControllerSectionRowCountInSectionUserInfo;
        }
            break;
    }
 
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 && indexPath.section == 0) {
        
        return 150;
    }
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        ZHPersonalHeaderTableViewCell *HeadCell = self.PersonalHeadlerCell =  [tableView dequeueReusableCellWithIdentifier:HeaderCellid forIndexPath:indexPath];    // 不写这句直接崩掉，找不到循环引用的cell
        if (HeadCell == nil) {
            HeadCell = [[ZHPersonalHeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderCellid];
        }
        HeadCell.indexPath = indexPath;
        HeadCell.UserInfoModel = self.UserInfoModel;
        
        
        HeadCell.AvatarClick = ^(NSIndexPath *indexPath){
          
            NSString * title = @"选择";
            NSString * cancelButtonTitle = @"取消";
            NSString * picButtonTitle = @"拍照";
            NSString * photoButtonTitle = @"从相册选择";
            
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction * picAction = [UIAlertAction actionWithTitle:picButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                imagePickerController.delegate = self;
                imagePickerController.allowsEditing = YES;
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:imagePickerController animated:YES completion:^{}];
            }];
            UIAlertAction * photoAction = [UIAlertAction actionWithTitle:photoButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                imagePickerController.delegate = self;
                imagePickerController.allowsEditing = YES;
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:imagePickerController animated:YES completion:^{}];
            }];
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [alert addAction:cancelAction];
                [alert addAction:picAction];
                [alert addAction:photoAction];
            } else {
                [alert addAction:cancelAction];
                [alert addAction:photoAction];
            }
            [self presentViewController:alert animated:YES completion:nil];

            
        };
        
    }else if (indexPath.section == 1){
        
        ZHEditTableViewCell *nameCell = self.EditCell =[tableView dequeueReusableCellWithIdentifier:nameCellid forIndexPath:indexPath];    // 不写这句直接崩掉，找不到循环引用的cell
        if (nameCell == nil) {
            nameCell = [[ZHEditTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nameCellid];
        }
        nameCell.indexPath = indexPath;
        nameCell.UserInfoModel = self.UserInfoModel;
        

        __weak __typeof(&*self)weakSelf = self;
//        nameCell.didClick = ^(NSIndexPath *indexPath){
//            // End editing
//            [weakSelf.view endEditing: YES];
//            
//            //  Action sheet
//            UIActionSheet *actionSheet = [[UIActionSheet alloc]
//                                          initWithTitle:@"性别"
//                                          delegate:self
//                                          cancelButtonTitle:nil
//                                          destructiveButtonTitle:nil
//                                          otherButtonTitles:@"男", @"女",nil];
//            
//            actionSheet.actionSheetStyle = UIBarStyleDefault;
//            [actionSheet showInView:self.view];
//        };
//
//        nameCell.DateClick = ^(NSIndexPath *indexPath){
//////            [weakSelf.view endEditing: YES];
////            UIDatePicker *pich = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
////            pich.backgroundColor = [UIColor whiteColor];
////            pich.datePickerMode = UIDatePickerModeDate;
////            [self.view addSubview:pich];
//
//        };
        return nameCell;
    }

    
    return cell?cell:[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                            reuseIdentifier: @"Cell"];

    }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
   
    }
    
}


- (UserInfoModel *)UserInfoModel {
    if (!_UserInfoModel) {
        _UserInfoModel = [UserInfoModel new];
    }
    return _UserInfoModel;
}


@end
