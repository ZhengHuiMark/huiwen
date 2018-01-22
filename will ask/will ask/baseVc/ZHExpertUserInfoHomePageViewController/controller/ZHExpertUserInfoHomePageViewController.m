//
//  ZHExpertUserInfoHomePageViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/12/25.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHExpertUserInfoHomePageViewController.h"

#import "ZHExpertUserInfoTableViewCell.h"
#import "ZHUserInfoRewardContentTableViewCell.h"
#import "ZHExpertUserInfoCaseTableViewCell.h"
#import "businessCellViewCell.h"

#import "ZHNetworkTools.h"
#import "Macro.h"
#import "YYModel.h"

#import "ZHExpertRewardModel.h"
#import "ZHExpertUserInfoModel.h"
#import "ZHExpertCaseModel.h"
#import "ZHExpertBigUserModel.h"
#import "ZHUserInfoNoModelTableViewCell.h"


static NSString *expertUserInfoCellid = @"expertUserInfoCellid";

static NSString *userInfoRewardCellid = @"userInfoRewardCellid";

static NSString *userInfoRewardContntCellid = @"userInfoRewardContntCellid";

static NSString *expertUserInfoCaseCellid = @"expertUserInfoCaseCellid";

static NSString *businessCellid = @"businessCellid";

static NSString *userInfoNoModelCelId = @"userInfoNoModelCelId";


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
    
    


}

- (void)loadData{

//        NSString *expertID = @"92282645588742144";
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:_expertID forKey:@"userId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/user/uto/getExpertHomePage",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        NSLog(@"%@",response);
        _bigModel = [ZHExpertBigUserModel yy_modelWithJSON:response[@"data"]];
        
        _bigModel.expertUserInfoModel = [ZHExpertUserInfoModel yy_modelWithJSON:response[@"data"][@"userInfo"]];
        
        _bigModel.expertRewardModel = [ZHExpertRewardModel yy_modelWithJSON:response[@"data"][@"rewardAsk"]];
        
        
        
        [self.tableView reloadData];
        
    }];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0.1;
    }
    if (section == 1) {
        return 0.1;
    }
    
    return 43;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView * view = nil;
    
    if (section == 2) {
        
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor whiteColor];
        //    headerView.frame = self.view.frame;
        //
        UILabel *nameLa = [[UILabel alloc]init];
        
        nameLa.frame = CGRectMake(20, 10 ,[UIScreen mainScreen].bounds.size.width, 20);
        
        nameLa.text = @"悬赏问";
        
        [headerView addSubview:nameLa];
        
        UIView * lineView = [[UIView alloc]init];
        lineView.frame = CGRectMake(0, 43, [UIScreen mainScreen].bounds.size.width, 1);
        lineView.backgroundColor = [UIColor grayColor];
        
        [headerView addSubview:lineView];
        
        UIButton *moreBtn = [[UIButton alloc]init];
        moreBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 40 - 18, 18, 50 , 20);
        [moreBtn setTitle:@"更多>>" forState:UIControlStateNormal];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [moreBtn addTarget:self action:@selector(moreRewardAction) forControlEvents:UIControlEventTouchUpInside];
        
        [headerView addSubview:moreBtn];
        
        return headerView;
        
    }
    
    if (section == 3) {
        
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor whiteColor];
        //    headerView.frame = self.view.frame;
        //
        UILabel *nameLa = [[UILabel alloc]init];
        
        nameLa.frame = CGRectMake(20, 10 ,[UIScreen mainScreen].bounds.size.width, 20);
        
        nameLa.text = @"案例";
        
        [headerView addSubview:nameLa];
        
        UIView * lineView = [[UIView alloc]init];
        lineView.frame = CGRectMake(0, 43, [UIScreen mainScreen].bounds.size.width, 1);
        lineView.backgroundColor = [UIColor grayColor];
        
        [headerView addSubview:lineView];
        
        UIButton *moreBtn = [[UIButton alloc]init];
        moreBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 40 - 18, 18, 50 , 20);
        [moreBtn setTitle:@"更多>>" forState:UIControlStateNormal];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [moreBtn addTarget:self action:@selector(moreFreeAction) forControlEvents:UIControlEventTouchUpInside];
        
        [headerView addSubview:moreBtn];
        
        return headerView;
        
    }
    
    return view;
    
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    if (section == 2) {
        return 1;
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
        
        NSString *tmpStr = self.bigModel.expertUserInfoModel.business;
        NSArray *tempArray = [tmpStr componentsSeparatedByString:@","];
        
        return tempArray.count > 4 ? 170 : 130;

    }
    
    if (indexPath.section == 2 && _bigModel.expertRewardModel) {
        
            return 300;
 
    }
    
    if (indexPath.section == 3 && _bigModel.expertCaseModel) {
        return 160;
    }else{
        return 100;
    }
    
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        ZHExpertUserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:expertUserInfoCellid forIndexPath:indexPath];
        
        
        cell.expertUserInfoModel = _bigModel.expertUserInfoModel;
        
        return cell;
    }
    
    if (indexPath.section == 1) {
        businessCellViewCell *cell = [tableView dequeueReusableCellWithIdentifier:businessCellid forIndexPath:indexPath];
        cell.btnStrDataSoure = _bigModel.expertUserInfoModel.business;
        
        return cell;
    }
    
    
    if (indexPath.section == 2 && _bigModel.expertRewardModel) {

            ZHUserInfoRewardContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userInfoRewardContntCellid forIndexPath:indexPath];
            
            cell.expertRewardModel = _bigModel.expertRewardModel;
            
            return cell;

    }else if (indexPath.section == 3 && _bigModel.expertCaseModel) {
        ZHExpertUserInfoCaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:expertUserInfoCaseCellid forIndexPath:indexPath];
        
        cell.caseModel = _bigModel.expertCaseModel;
        
        return cell;
    }else {

            ZHUserInfoNoModelTableViewCell *Nocell = [tableView dequeueReusableCellWithIdentifier:userInfoNoModelCelId forIndexPath:indexPath];
            
            return Nocell;
  
    }
    
    return cell?cell:[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                            reuseIdentifier: @"Cell"];
}


- (UITableView *)tableView {
    //
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        _tableView.sectionHeaderHeight = 43;
        
        //        _tableView.rowHeight = 299;
        
        //    NSBundle *bundle = [NSBundle mainBundle];
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHExpertUserInfoTableViewCell" bundle:nil] forCellReuseIdentifier:expertUserInfoCellid];
        
//        [_tableView registerNib:[UINib nibWithNibName:@"ZHUserInfoRewardAskTableViewCell" bundle:nil] forCellReuseIdentifier:userInfoRewardCellid];
        //

               
        [_tableView registerNib:[UINib nibWithNibName:@"ZHUserInfoRewardContentTableViewCell" bundle:nil] forCellReuseIdentifier:userInfoRewardContntCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHExpertUserInfoCaseTableViewCell" bundle:nil] forCellReuseIdentifier:expertUserInfoCaseCellid];
        //
        [_tableView registerNib:[UINib nibWithNibName:@"ZHUserInfoNoModelTableViewCell" bundle:nil] forCellReuseIdentifier:userInfoNoModelCelId];
        
        [_tableView registerClass:[businessCellViewCell class] forCellReuseIdentifier:businessCellid];

        
    }
    
    return _tableView;
}




@end
