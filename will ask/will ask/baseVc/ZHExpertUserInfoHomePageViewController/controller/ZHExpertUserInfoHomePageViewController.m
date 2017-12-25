//
//  ZHExpertUserInfoHomePageViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/12/21.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHExpertUserInfoHomePageViewController.h"
#import "ZHExpertUserInfoTableViewCell.h"
#import "ZHUserInfoRewardAskTableViewCell.h"
#import "ZHUserInfoRewardContentTableViewCell.h"
#import "ZHExpertCaseTableViewCell.h"

#import "ZHNetworkTools.h"
#import "Macro.h"
#import "YYModel.h"

#import "ZHExpertRewarModel.h"
#import "ZHExpertUserInfoModel.h"
#import "ZHExpertUserInfoCaseModel.h"
#import "ZHExpertUserinfoBigModel.h"

static NSString *expertUserInfoCellid = @"expertUserInfoCellid";

static NSString *userInfoRewardCellid = @"userInfoRewardCellid";

static NSString *userInfoRewardContntCellid = @"userInfoRewardContntCellid";

static NSString *expertUserInfoCaseCellid = @"expertUserInfoCaseCellid";

@interface ZHExpertUserInfoHomePageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ZHExpertUserInfoHomePageViewController

- (void)viewWillAppear:(BOOL)animated

{
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];
    [self.view addSubview:self.tableView];
    
    
    if (self.tableView.style == UITableViewStylePlain) {
        UIEdgeInsets contentInset = self.tableView.contentInset;
        contentInset.top = - 64 ;
        [self.tableView setContentInset:contentInset];
    }
}

- (void)loadData{
    
    NSString *expertID = @"92282645588742144";
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:expertID forKey:@"userId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/user/uto/getExpertHomePage",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        NSLog(@"%@",response);
        _bigModel = [ZHExpertUserinfoBigModel yy_modelWithJSON:response[@"data"]];
        
        _bigModel.expertUserInfoModel = [ZHExpertUserInfoModel yy_modelWithJSON:response[@"data"][@"userInfo"]];
        
        _bigModel.expertRewardModel = [ZHExpertRewarModel yy_modelWithJSON:response[@"data"][@"rewardAsk"]];
        
        [self.tableView reloadData];
        
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        NSString *wenzi  = self.bigModel.expertUserInfoModel.intro;
        CGFloat margin = 16;
        CGFloat labelWidth = [UIScreen mainScreen].bounds.size.width - margin *2;
        CGFloat labelHeight = [wenzi boundingRectWithSize: CGSizeMake(labelWidth, 100)
                                                  options: NSStringDrawingUsesLineFragmentOrigin
                                               attributes: @{NSFontAttributeName : [UIFont systemFontOfSize: 14]}
                                                  context: nil].size.height;
        
        return 339 + labelHeight;
    }
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            return 50;
        }else{
            
            return 250;
        }
        
        
    }

    return 370;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0;
    }
    
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        ZHExpertUserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:expertUserInfoCellid forIndexPath:indexPath];
        
        
        cell.expertUserInfoModel = _bigModel.expertUserInfoModel;
        
        return cell;
    }
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            ZHUserInfoRewardAskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userInfoRewardCellid forIndexPath:indexPath];
            
            cell.expertRewardModel = _bigModel.expertRewardModel;
            
            return cell;
        }
        
        
        if (indexPath.row == 1) {   
        
            ZHUserInfoRewardContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userInfoRewardContntCellid forIndexPath:indexPath];
            
            cell.expertRewardModel = _bigModel.expertRewardModel;
            return cell;
            
        }
        
    }
    
    if (indexPath.section == 2) {
        ZHExpertCaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:expertUserInfoCaseCellid forIndexPath:indexPath];
        
        cell.caseModel = _bigModel.expertCaseModel;
        
        return cell;
    }

    
    
    return cell?cell:[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                            reuseIdentifier: @"Cell"];
}



- (UITableView *)tableView {
    //
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        _tableView.sectionHeaderHeight = 43;
        
//        _tableView.rowHeight = 299;
        
        //    NSBundle *bundle = [NSBundle mainBundle];
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHExpertUserInfoTableViewCell" bundle:nil] forCellReuseIdentifier:expertUserInfoCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHUserInfoRewardAskTableViewCell" bundle:nil] forCellReuseIdentifier:userInfoRewardCellid];
//
//        [_tableView registerNib:[UINib nibWithNibName:@"ZHUserInfoRewardVoiceTableViewCell" bundle:nil] forCellReuseIdentifier:userInfoRewardVoiceCellid];
        [_tableView registerNib:[UINib nibWithNibName:@"ZHUserInfoRewardContentTableViewCell" bundle:nil] forCellReuseIdentifier:userInfoRewardContntCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHExpertCaseTableViewCell" bundle:nil] forCellReuseIdentifier:expertUserInfoCaseCellid];
//
//        [_tableView registerNib:[UINib nibWithNibName:@"ZHUserInfoNoModelTableViewCell" bundle:nil] forCellReuseIdentifier:userInfoNoModelCellid];
//        
        //        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
    }
    
    return _tableView;
}

@end
