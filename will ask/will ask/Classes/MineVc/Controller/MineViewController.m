//
//  MineViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/8/22.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "MineViewController.h"
#import "ZHHeaderTableViewCell.h"
#import "ZHMoneyTableViewCell.h"
#import "ZHExpertsTableViewCell.h"
#import "ZHMineTableViewCell.h"
#import "MineModel.h"
#import "UserManager.h"
#import "UserModel.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "ImageTools.h"
#import "ZHNetworkTools.h"
#import "Macro.h"
#import "ZHMyWalletViewController.h"
#import "ZHMyOrderViewController.h"
#import "UserInfoModel.h"
#import "YYModel.h"

#import "ZHExpertServiceViewController.h"
#import "ZHExpertUserInfoHomePageViewController.h"
#import "ZHSetupViewController.h"

//头部cell
static NSString *HeaderCellid = @"HeaderCellid";
//收入cell
static NSString *MoneyCellid = @"MoneyCellid";
//专家cell
static NSString *ExpertsCellid = @"ExpertsCellid";
//列表cell
static NSString *MineListCellid = @"MineListCellid";

@interface MineViewController ()



@end

@implementation MineViewController
{
    NSMutableArray<MineModel *> *_arrList;

}

-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] postNotificationName: @"loginSuccess"
                                                        object: nil];
    [self.tableView reloadData];

}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    
    [[NSNotificationCenter defaultCenter] postNotificationName: @"loginSuccess"
                                                        object: nil];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.view addSubview: [UIView new]];
    
    if (self.tableView.style == UITableViewStylePlain) {
        UIEdgeInsets contentInset = self.tableView.contentInset;
        contentInset.top = -22;
        [self.tableView setContentInset:contentInset];
    }

    
    [self loadData];
    
    [self loadUserInfo];

    
    [self configUI];
    
    
}


- (void)loadUserInfo {
    
    ///api/ut/user/getMyHeadInfo
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/ut/user/getMyHeadInfo",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            
            NSLog(@"%@",error);
        }
        
        
//        _UserInfoModel = [UserInfoModel yy_modelWithJSON:response[@"data"]];
        
        [UserManager sharedManager].userModel.cardBalance = response[@"data"][@"cardBalance"];
        [UserManager sharedManager].userModel.concernNum = response[@"data"][@"concernNum"];
        [UserManager sharedManager].userModel.avatar = response[@"data"][@"avatar"];
        [UserManager sharedManager].userModel.expertCertified = response[@"data"][@"expertCertified"];
        [UserManager sharedManager].userModel.expertCheckStatus = response[@"data"][@"expertCheckStatus"];
        [UserManager sharedManager].userModel.expertCheckStatus = response[@"data"][@"expertCheckStatus"];
        [UserManager sharedManager].userModel.expertNickname = response[@"data"][@"expertNickname"];
        [UserManager sharedManager].userModel.myEarnings = response[@"data"][@"myEarnings"];
        [UserManager sharedManager].userModel.consults = response[@"data"][@"consults"];
        [UserManager sharedManager].userModel.nickname = response[@"data"][@"nickname"];
        [UserManager sharedManager].userModel.realPhoto = response[@"data"][@"realPhoto"];

        NSLog(@"response = %@",response);
        [[UserManager sharedManager]saveUserModel];
        
        [self.tableView reloadData];
    }];
    
    
}


- (void)configUI{
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:HeaderCellid];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHMoneyTableViewCell" bundle:nil] forCellReuseIdentifier:MoneyCellid];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHExpertsTableViewCell" bundle:nil] forCellReuseIdentifier:ExpertsCellid];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHMineTableViewCell" bundle:nil] forCellReuseIdentifier:MineListCellid];

    self.tableView.rowHeight = 50;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 190;
//}

// cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 && indexPath.section == 0) {
        
            return 200;
    }
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    //    if ([UserManager sharedManager].userModel.autograph) {
    //        return 3;
    //    }else{
    return 4;
    //    }
}


// 点击跳转控制器
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        
            NSString *className = @"ZHPersonalInformationVc";
            
            [self pushToSetControllerWithIndexPath:indexPath className:className];
        
    }else if (indexPath.section == 2){
        switch (indexPath.row) {
            case 0:{
                
                
                NSString *className = @"ValidationViewController";
                [self pushToSetControllerWithIndexPath:indexPath className:className];
                
                break;
            }
            default:
                break;
        }
    }else if (indexPath.section == 3){
        
        switch (indexPath.row) {
            case 0:{
                
                NSString *className = @"ZHMyFreeAskViewController";
                [self pushToSetControllerWithIndexPath:indexPath className:className];
                break;
            }
            case 1:{
                NSString *className = @"ZHMyRewardAskViewController";
                [self pushToSetControllerWithIndexPath:indexPath className:className];
                break;
            }
            case 2:{
                NSString *className = @"ZHMyConsultingViewController";
                [self pushToSetControllerWithIndexPath:indexPath className:className];
                
                break;
            }
            case 3:{
//                // 测试
//                NSString *className = @"ZHUserHomePageViewController";
//                [self pushToSetControllerWithIndexPath:indexPath className:className];
                
                NSString *className = @"ZHExpertUserInfoHomePageViewController";
                [self pushToSetControllerWithIndexPath:indexPath className:className];
//
//                    NSString *className = @"ZHExpertServiceViewController";
//                [self pushToSetControllerWithIndexPath:indexPath className:className];
//                NSString *className = @"ZHSetupViewController";
//                [self pushToSetControllerWithIndexPath:indexPath className:className];
                break;
            }
            case 4:{
                NSString *className = @"ZHMyFocusExpertViewController";
                [self pushToSetControllerWithIndexPath:indexPath className:className];
                
                break;
            }
            case 5:{
                
                NSString *className = @"ZHMyVipCardViewController";
                [self pushToSetControllerWithIndexPath:indexPath className:className];
                
                break;
            }
            case 6:{
                
                NSString *className = @"ZHMyWalletViewController";
                [self pushToSetControllerWithIndexPath:indexPath className:className];
                
                break;
            }
            case 7:{
                
                NSString *className = @"ZHMyOrderViewController";
                [self pushToSetControllerWithIndexPath:indexPath className:className];
                
                break;
            }
       
            default:
                break;
        }
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    if (indexPath.section == 0) {
        //HeaderCell
        ZHHeaderTableViewCell *HeadCell = [tableView dequeueReusableCellWithIdentifier:HeaderCellid forIndexPath:indexPath];    // 不写这句直接崩掉，找不到循环引用的cell
        if (HeadCell == nil) {
            HeadCell = [[ZHHeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderCellid];
        }
        HeadCell.placeholderView.backgroundColor = [UIColor orangeColor];

        HeadCell.usermodel = [UserManager sharedManager].userModel;

        
        return HeadCell;
    }else if (indexPath.section == 1){
        
        ZHMoneyTableViewCell *mCell = [tableView dequeueReusableCellWithIdentifier:MoneyCellid forIndexPath:indexPath];
        if (mCell == nil) {
            mCell = [[ZHMoneyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoneyCellid];
        }
        
        mCell.usermodel = [UserManager sharedManager].userModel;
        
        
        return mCell;
    }else if (indexPath.section == 2){
        
    ZHExpertsTableViewCell *eCell = [tableView dequeueReusableCellWithIdentifier:ExpertsCellid forIndexPath:indexPath];
    if (eCell == nil) {
        eCell = [[ZHExpertsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ExpertsCellid];
    }
    return eCell;
    }
    
    
    ZHMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MineListCellid forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    MineModel *model = [[MineModel alloc]init];
    
    model = _arrList[indexPath.row];
    
    cell.model = model;
    
    
    return cell;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 1;
    }
    return 8;
 
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0.1;
        case 1:
            return 10;
        case 2:
            return 10;
    }
    return 0;
}





- (void)loadData{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Mine.plist" withExtension:nil];
    
    NSArray *arr = [NSArray arrayWithContentsOfURL:url];
    
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        MineModel *model = [[MineModel alloc]initMineModelWithDict:obj];
        [arrM addObject:model];
        
    }];
    
    _arrList = arrM.copy;
    
}


#pragma mark - 实现点击跳转到控制器
-(void)pushToSetControllerWithIndexPath:(NSIndexPath *)indexPath className:(NSString *)className{
    
    Class clz = NSClassFromString(className);
    UIViewController *controller = [[clz alloc]init];
    NSLog(@"%@",controller);
    [self.navigationController pushViewController:controller animated:YES];
    
    
    
}



@end
