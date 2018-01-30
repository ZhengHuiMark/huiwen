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
#import "ZHExpertsListTableViewCell.h"
#import "Masonry.h"
#import "ZHExpertServiceViewController.h"
#import "ZHExpertUserInfoHomePageViewController.h"
#import "ZHSetupViewController.h"
#import "ZHSearchViewController.h"
#import "UIView+LayerEffects.h"
#import "ZHRegisteredViewController.h"
#import "ZHCertifiedExpertsVC.h"

//头部cell
static NSString *HeaderCellid = @"HeaderCellid";
//收入cell
static NSString *MoneyCellid = @"MoneyCellid";
//专家cell
static NSString *ExpertsCellid = @"ExpertsCellid";
//列表cell
static NSString *MineListCellid = @"MineListCellid";
// 专家模式下显示的cellid
static NSString *ExpertBtnCellid = @"ExpertBtnCellid";

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIImageView *BackgroundImageView;

@end

@implementation MineViewController
{
    NSMutableArray<MineModel *> *_arrList;

}

-(void)viewWillAppear:(BOOL)animated{
    
        [self loadUserInfo];
    self.navigationController.navigationBar.hidden = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName: @"loginSuccess"
                                                        object: nil];
    if ([UserManager sharedManager].userModel) {
        _BackgroundImageView.hidden = YES;
        [self configUI];
        
    }else{
        [self.view addSubview:self.BackgroundImageView];
        _BackgroundImageView.hidden =NO;
        _BackgroundImageView.userInteractionEnabled = YES;
        [_BackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    }
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadSucess) name:@"NSNotification_LoginSuccess" object:nil];
//    [self.view addSubview: [UIView new]];
    
    if (self.tableView.style == UITableViewStylePlain) {
        UIEdgeInsets contentInset = self.tableView.contentInset;
        contentInset.top = -22;
        [self.tableView setContentInset:contentInset];
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self loadData];
    
    [self loadUserInfo];

    
}


- (void)loadSucess {
    self.tabBarController.selectedIndex = 1;
}

- (void)loadUserInfo {
    
    ///api/ut/user/getMyHeadInfo
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/ut/user/getMyHeadInfo",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            
            NSLog(@"%@",error);
        }
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


#pragma mark - 根据模型状态显示UI

- (UIImageView *)BackgroundImageView {
    self.tableView.hidden = YES;
    if (!_BackgroundImageView) {
        _BackgroundImageView = [[UIImageView alloc]init];
        _BackgroundImageView.image = [UIImage imageNamed:@"bj"];
        UIImageView *iconImg = [[UIImageView alloc] init];
        [_BackgroundImageView addSubview:iconImg];
        iconImg.backgroundColor = [UIColor redColor];
        iconImg.userInteractionEnabled = YES;
        [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(198);
            make.centerX.mas_equalTo(_BackgroundImageView);
            make.width.height.mas_equalTo(80);
        }];
        
        
        UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginBtn addTarget:self action:@selector(loginAccount) forControlEvents:UIControlEventTouchUpInside];

        [_BackgroundImageView addSubview:loginBtn];
        loginBtn.backgroundColor = [UIColor orangeColor];
        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        loginBtn.userInteractionEnabled = YES;
        [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginBtn setCornerRadius:20];
        
        [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(ScreenWidth-57.5*2, 40));
            make.centerX.mas_equalTo(iconImg);
            make.top.mas_equalTo(iconImg.mas_bottom).offset(93);
        }];
        
        UIButton *regisBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [regisBtn addTarget:self action:@selector(registedAccount) forControlEvents:UIControlEventTouchUpInside];

        [_BackgroundImageView addSubview:regisBtn];
        [regisBtn setTitle:@"注册" forState:UIControlStateNormal];
        regisBtn.userInteractionEnabled = YES;

        [regisBtn setTitleColor:[UIColor colorWithRed:59.0/255.0 green:189.0/255.0 blue:234.0/255.0 alpha:1] forState:UIControlStateNormal];
        
        [regisBtn setAllCornerWithRoundedCornersSize:20 pathSize:CGSizeMake(ScreenWidth-57.5*2, 40) strokeColor:[UIColor colorWithRed:59.0/255.0 green:189.0/255.0 blue:234.0/255.0 alpha:1]];

        [regisBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(ScreenWidth-57.5*2, 40));
            make.centerX.mas_equalTo(loginBtn);
            make.top.mas_equalTo(loginBtn.mas_bottom).offset(28);
        }];
    }
    return _BackgroundImageView;
}

- (void)loginAccount{
    
    ZHLoginViewController *loginVc = [[ZHLoginViewController alloc]init];
    
    [self.navigationController pushViewController:loginVc animated:YES];
    
}

- (void)registedAccount{
    
    ZHRegisteredViewController *registedVc = [[ZHRegisteredViewController alloc]init];
    
    [self.navigationController pushViewController:registedVc animated:YES];
    
}


- (void)configUI{
    
    
    self.tableView.hidden = NO;
    
}


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
        NSString *className;
        if ([[UserManager sharedManager].userModel.expertCheckStatus isEqual:@(1)]) {
            ZHCertifiedExpertsVC *vc = [[ZHCertifiedExpertsVC alloc] initWithCertification:YES];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
           className = @"ZHPersonalInformationVc";
        }
        [self pushToSetControllerWithIndexPath:indexPath className:className];
        
    }else if (indexPath.section == 2){
        switch (indexPath.row) {
            case 0:{
                
//                return;
                NSString *className = @"ZHCertifiedExpertsVC";
                [self pushToSetControllerWithIndexPath:indexPath className:className];
//
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
  
                NSString *className = @"ZHMyCollectionOfCasesViewController";
                [self pushToSetControllerWithIndexPath:indexPath className:className];

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
        
        HeadCell.didClick = ^(){
            NSString *className = @"ZHSetupViewController";
            [self pushToSetControllerWithIndexPath:indexPath className:className];
            
        };
        
        
        return HeadCell;
    }
    
    if (indexPath.section == 1){
        
        
        if ([[UserManager sharedManager].userModel.expertCertified isEqual:@(1)]) {
        
            ZHExpertsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ExpertBtnCellid forIndexPath:indexPath];
            if (cell == nil) {
                cell = [[ZHExpertsListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ExpertBtnCellid];
            }

            cell.userModel = [UserManager sharedManager].userModel;
            
            cell.didClick = ^(){
                NSString *className = @"ZHFocusMeUserViewController";
                [self pushToSetControllerWithIndexPath:indexPath className:className];
            };
            cell.incomeDidClick = ^(){
                NSString *className = @"ZHMyWalletViewController";
                [self pushToSetControllerWithIndexPath:indexPath className:className];
            };
            cell.newConultDidClick = ^(){
                
                NSString *className = @"ZHToAnswerViewController";
                [self pushToSetControllerWithIndexPath:indexPath className:className];
            };
            
            return cell;
        }
        if ([[UserManager sharedManager].userModel.expertCertified isEqual:@(0)]){
            
            ZHMoneyTableViewCell *mCell = [tableView dequeueReusableCellWithIdentifier:MoneyCellid forIndexPath:indexPath];
            if (mCell == nil) {
                mCell = [[ZHMoneyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoneyCellid];
            }
            mCell.selectionStyle = UITableViewCellSelectionStyleNone;

            
            mCell.usermodel = [UserManager sharedManager].userModel;
  
            mCell.cardClick = ^(){
                
                NSString *className = @"ZHMyVipCardViewController";
                [self pushToSetControllerWithIndexPath:indexPath className:className];
                
            };
            
            mCell.walletClick = ^(){
                
                NSString *className = @"ZHMyWalletViewController";
                [self pushToSetControllerWithIndexPath:indexPath className:className];
            };
      
            return mCell;
            
        }
        
       
    }
    if (indexPath.section == 2){
        
        if ([[UserManager sharedManager].userModel.expertCertified isEqual:@(1)]) {
            
            ZHExpertsTableViewCell *eCell = [tableView dequeueReusableCellWithIdentifier:ExpertsCellid forIndexPath:indexPath];
            if (eCell == nil) {
                eCell = [[ZHExpertsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ExpertsCellid];
            }
            eCell.selectionStyle = UITableViewCellSelectionStyleNone;

            [eCell.expertsBtn setTitle:@"专家服务" forState:UIControlStateNormal];
            
            eCell.BtnClick = ^{
                
                NSString *className = @"ZHExpertServiceViewController";
                [self pushToSetControllerWithIndexPath:indexPath className:className];
                
            };
            return eCell;

        }
        
        if ([[UserManager sharedManager].userModel.expertCertified isEqual:@(0)]) {
            
            ZHExpertsTableViewCell *eCell = [tableView dequeueReusableCellWithIdentifier:ExpertsCellid forIndexPath:indexPath];
            if (eCell == nil) {
                eCell = [[ZHExpertsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ExpertsCellid];
            }
            eCell.selectionStyle = UITableViewCellSelectionStyleNone;

            
            [eCell.expertsBtn setTitle:@"认证专家" forState:UIControlStateNormal];
            
            eCell.BtnClick = ^{
                ZHCertifiedExpertsVC *vc = [[ZHCertifiedExpertsVC alloc] initWithCertification:NO];
                [self.navigationController pushViewController:vc animated:YES];
                
            };
            return eCell;
            
        }
        
        
        
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

- (UITableView *)tableView {
    //
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        
        //    NSBundle *bundle = [NSBundle mainBundle];
        
        [self.tableView registerNib:[UINib nibWithNibName:@"ZHHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:HeaderCellid];
        [self.tableView registerNib:[UINib nibWithNibName:@"ZHMoneyTableViewCell" bundle:nil] forCellReuseIdentifier:MoneyCellid];
        [self.tableView registerNib:[UINib nibWithNibName:@"ZHExpertsTableViewCell" bundle:nil] forCellReuseIdentifier:ExpertsCellid];
        [self.tableView registerNib:[UINib nibWithNibName:@"ZHMineTableViewCell" bundle:nil] forCellReuseIdentifier:MineListCellid];
        [self.tableView registerNib:[UINib nibWithNibName:@"ZHExpertsListTableViewCell" bundle:nil] forCellReuseIdentifier:ExpertBtnCellid];
        
        
        self.tableView.rowHeight = 50;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    
    return _tableView;
}




#pragma mark - 实现点击跳转到控制器
-(void)pushToSetControllerWithIndexPath:(NSIndexPath *)indexPath className:(NSString *)className{
    
    Class clz = NSClassFromString(className);
    UIViewController *controller = [[clz alloc]init];
    NSLog(@"%@",controller);
    [self.navigationController pushViewController:controller animated:YES];
    
}



@end
