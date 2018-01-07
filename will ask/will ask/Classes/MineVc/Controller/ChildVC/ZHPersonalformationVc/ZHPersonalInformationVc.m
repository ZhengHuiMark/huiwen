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
#import "OssService.h"
#import "ZHPersonalHeaderTableViewCell.h"
#import "ZHNetworkTools.h"
#import "BRPickerView.h"
#import "NSDate+BRAdd.h"
#import "LBViewController+ImagePicker.h"

#import "UserManager.h"
#import "UserModel.h"
#import "ImageTools.h"
#import "Macro.h"
#import "SVProgressHUD.h"

#import "YYModel.h"

// HeaderCellid
static NSString *HeaderCellid = @"HeaderCellid";
//
static NSString *nameCellid = @"nameCellid";




@interface ZHPersonalInformationVc ()<UIActionSheetDelegate,UIPickerViewDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    OssService * service;
    NSString * uploadFilePath;
    
    NSMutableDictionary *_tempDict;
    
}
@property(nonatomic,strong)NSData *imageData;



@property (nonatomic, weak)ZHPersonalHeaderTableViewCell *PersonalHeadlerCell;

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, weak)ZHEditTableViewCell *EditCell;

@property (nonatomic, weak)ZHEditTableViewCell *sex;


@end

@implementation ZHPersonalInformationVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.tableView];

    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 62, 20)] ;
    titleLabel.text  = @"个人信息";
    //    titleLabel.backgroundColor  = [UIColor blueColor]   ;
    
    titleLabel.textColor = [UIColor blackColor] ;
    
    titleLabel.font= [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(clickButton)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];

    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = backBtn;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    NSString * const endPoint = @"http://oss-cn-qingdao.aliyuncs.com";
    NSString * const callbackAddress = @"http://oss-demo.aliyuncs.com:23450";
    
    service = [[OssService alloc] initWithViewController:self withEndPoint:endPoint];
    [service setCallbackAddress:callbackAddress];
    
    [self loadUserInfo];
 
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveTextName:) name:@"textName" object:nil];
    _tempDict = [NSMutableDictionary dictionary];
}


- (void)loadUserInfo{
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/ut/user/getUserInfo",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
        NSLog(@"%@",response);
        
        _UserInfoModel = [UserInfoModel yy_modelWithJSON:response[@"data"]];
        
        
        [self.tableView reloadData];
    }];
    
    
}

- (void)clickButton{
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] *1000;

    NSString * objectKey = [NSString stringWithFormat:@"%@%@%f",[UserManager sharedManager].userModel.resourceId,@"avatar",interval];
    if (uploadFilePath) {
        
        [service asyncPutImage:objectKey localFilePath:uploadFilePath bucketName:bucketNameUser comletion:^(BOOL isSuccess) {
            
            if (isSuccess) {
                NSMutableDictionary *dict = [ZHNetworkTools parameters];
                
                [dict setObject: objectKey
                         forKey: @"avatar"];
                [dict addEntriesFromDictionary:_tempDict];
                
                NSString *url = [NSString stringWithFormat:@"%@/api/ut/user/saveUserInfo",kIP];
                
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
        }];
        
    }else{
        
        NSMutableDictionary *dict = [ZHNetworkTools parameters];
        
        [dict addEntriesFromDictionary:_tempDict];
        
        NSString *url = [NSString stringWithFormat:@"%@/api/ut/user/saveUserInfo",kIP];
        
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
    
//    [self.PersonalHeadlerCell.userAvatarImageView setImage:image forState:UIControlStateNormal];
    self.PersonalHeadlerCell.userAvatarImageView.image = image;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
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
        ZHPersonalHeaderTableViewCell *HeadCell = self.PersonalHeadlerCell =  [tableView dequeueReusableCellWithIdentifier:HeaderCellid forIndexPath:indexPath];// 不写这句直接崩掉，找不到循环引用的cell
        

        HeadCell.indexPath = indexPath;
        HeadCell.UserInfoModel = _UserInfoModel;
        
        
        HeadCell.AvatarClick = ^(NSIndexPath *indexPath){
          
            [self selectPhotoWithSuccessBlock:^(UIImagePickerController *imagePickerViewController, NSDictionary<NSString *,id> *info) {
                UIImage *image = info[UIImagePickerControllerEditedImage];
                
//                [self.PersonalHeadlerCell.UserAvatarImg setImage:image forState:UIControlStateNormal];
                self.PersonalHeadlerCell.userAvatarImageView.image = image;
                
            } cancelBlock:^(UIImagePickerController *imagePickerViewController) {}];
        
        


        };
        
    }
    
    if (indexPath.section == 1){
        
        ZHEditTableViewCell *nameCell =[tableView dequeueReusableCellWithIdentifier:nameCellid forIndexPath:indexPath];    // 不写这句直接崩掉，找不到循环引用的cell
//        if (indexPath.row == kValidationViewControllerRow_Gender) self.EditCell = nameCell;
        

        nameCell.indexPath = indexPath;
        nameCell.UserInfoModel = _UserInfoModel;
        

        __weak __typeof(&*self)weakSelf = self;
        
        
        nameCell.didClick = ^(NSIndexPath *indexPath){
            // End editing
            [weakSelf.view endEditing: YES];
            
            //  Action sheet
            UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:@"性别"
                                          delegate:self
                                          cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                          otherButtonTitles:@"女", @"男",nil];
            
            
            actionSheet.actionSheetStyle = UIBarStyleDefault;
            [actionSheet showInView:self.view];
        };


        nameCell.DateClick = ^(NSIndexPath *indexPath){
            [weakSelf.view endEditing: YES];
            [BRDatePickerView showDatePickerWithTitle:@"出生年月" dateType:UIDatePickerModeDate defaultSelValue:nameCell.NameTextF.text minDateStr:@"" maxDateStr:@"" isAutoSelect:YES resultBlock:^(NSString *selectValue) {
                nameCell.NameTextF.text = selectValue;
                [_tempDict setValue:selectValue forKey:@"birthdate"];
                
            }];

        };
        
        nameCell.LocationClick = ^(NSIndexPath *indexPath){
          
            [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@10, @0, @3] isAutoSelect:YES resultBlock:^(NSArray *selectAddressArr) {
                nameCell.NameTextF.text = [NSString stringWithFormat:@"%@-%@-%@", selectAddressArr[0], selectAddressArr[1], selectAddressArr[2]];
                [_tempDict setValue:nameCell.NameTextF.text forKey:@"locus"];
            }];
            
        };
        
        
        return nameCell;
    }

    
    return cell?cell:[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                            reuseIdentifier: @"Cell"];

    }


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex != 2) {
        self.UserInfoModel.sex = [actionSheet buttonTitleAtIndex: buttonIndex];
        _EditCell.NameTextF.text = self.UserInfoModel.sex;
        
        [_tempDict setValue:@(buttonIndex) forKey:@"sex"];
    }
    
//    [self.tableView reloadData];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:kValidationViewControllerRow_Gender inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
   
    }
    
}


#pragma mark - Lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame: CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height )
                                                  style: UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHPersonalHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:HeaderCellid];
        [_tableView registerNib:[UINib nibWithNibName:@"ZHEditTableViewCell" bundle:nil] forCellReuseIdentifier:nameCellid];
        
        
        _tableView.rowHeight = 50;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}





- (UserInfoModel *)UserInfoModel {
    if (!_UserInfoModel) {
        _UserInfoModel = [UserInfoModel new];
    }
    return _UserInfoModel;
}

- (void)saveTextName:(NSNotification *)user {
    
    NSLog(@"user %@",user.userInfo);
    [_tempDict addEntriesFromDictionary:user.userInfo];
    NSLog(@"tempDictionary %@",_tempDict);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
