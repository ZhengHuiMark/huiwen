    //
//  ZHUserHomePageViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/12/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHUserHomePageViewController.h"
#import "ZHUserInfoTableViewCell.h"
#import "ZHUserInfoRewardVoiceTableViewCell.h"
#import "ZHUserInfoRewardContentTableViewCell.h"
#import "ZHUserInfoFreeAskTableViewCell.h"
#import "ZHUserInfoNoModelTableViewCell.h"
#import "ZHMoreRewardListViewController.h"

#import "ZHNetworkTools.h"
#import "Macro.h"
#import "YYModel.h"
#import "ZHUserInfoModel.h"
#import "ZHUserInfoFreeModel.h"
#import "ZHUserInfoRewardModel.h"
#import "ZHUserInfoBigModel.h"

#import "ZHRewardDetailViewController.h"
#import "ZHUserInfoFreeListViewController.h"

static NSString *userInfoCellid = @"userInfoCellid";

static NSString *userInfoRewardCellid = @"userInfoRewardCellid";

static NSString *userInfoRewardContntCellid = @"userInfoRewardContntCellid";

static NSString *userInfoRewardVoiceCellid = @"userInfoRewardVoiceCellid";

static NSString *userInfoFreeContentCellid = @"userInfoFreeContentCellid";

static NSString *userInfoNoModelCelId = @"userInfoNoModelCelId";



@interface ZHUserHomePageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,weak)UIView *headerView;


@end

@implementation ZHUserHomePageViewController

- (void)viewWillAppear:(BOOL)animated

{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    
    [self loadData];
//    
    if (self.tableView.style == UITableViewStylePlain) {
        UIEdgeInsets contentInset = self.tableView.contentInset;
        contentInset.top = -22 ;
        [self.tableView setContentInset:contentInset];
    }
    
    UIView *view = [[UIView alloc] init];
    _headerView = view;
    view.frame = CGRectMake(0, 0, ScreenWidth, 64);
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    
    UIButton *backBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn1.frame = CGRectMake(10, 30, 30, 30);
    [backBtn1 setImage:[UIImage imageNamed:@"return1"] forState:UIControlStateNormal];
    [backBtn1 addTarget:self action:@selector(backClickAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backBtn1];
    
}

- (void)backClickAction {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)loadData{
    
//    NSString *userId = @"110341478336696320";
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:_userId forKey:@"userId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/user/uto/getUserHomePage",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        NSLog(@"%@",response);
        
        _bigModel = [ZHUserInfoBigModel yy_modelWithJSON:response[@"data"]];
        
        _bigModel.freeModel = [ZHUserInfoFreeModel yy_modelWithJSON:response[@"data"][@"freeAsk"]];
        
        _bigModel.usefInfoModel = [ZHUserInfoModel yy_modelWithJSON:response[@"data"][@"userInfo"]];
        
        _bigModel.rewardModel = [ZHUserInfoRewardModel yy_modelWithJSON:response[@"data"][@"rewardAsk"]];
        
        [self.tableView reloadData];
    }];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0.1;
    }
    
    return 43;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView * view = nil;
    
    if (section == 1 ) {
        
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
    
    if (section == 2) {
        
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor whiteColor];
        //    headerView.frame = self.view.frame;
        //
        UILabel *nameLa = [[UILabel alloc]init];
        
        nameLa.frame = CGRectMake(20, 10 ,[UIScreen mainScreen].bounds.size.width, 20);
        
        nameLa.text = @"免费问";
        
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

- (void)moreFreeAction{
    
    ZHUserInfoFreeListViewController *moreFreeListVc = [[ZHUserInfoFreeListViewController alloc]init];
    moreFreeListVc.userId = _userId;

    [self.navigationController pushViewController:moreFreeListVc animated:YES];
    
}

- (void)moreRewardAction{
    
    ZHMoreRewardListViewController *moreRewardVc  = [[ZHMoreRewardListViewController alloc]init];
    moreRewardVc.userId = _userId;
    [self.navigationController pushViewController:moreRewardVc animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 235;
    }
    if (indexPath.section == 1 && _bigModel.rewardModel) {
        
        if (_bigModel.rewardModel.answerContent) {
            if (_bigModel.rewardModel.answerPhotos) {
                return 298;
            }else{
                return 228;
            }
        }
    
        if (_bigModel.rewardModel.answerVoice) {
            return 300;
        }
        
        if (!_bigModel.rewardModel.answerVoice) {
            return 100;
        }
    }else{
        return 100;
    }
    
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    
    if (section == 1) {
        return 1;
    }
    
    return 1;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        ZHUserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userInfoCellid forIndexPath:indexPath];
        
        cell.userInfoModel = _bigModel.usefInfoModel;
        return cell;
    }
    
    if (indexPath.section == 1) {
        
        if (_bigModel.owner == NO) {
            if (_bigModel.rewardModel.answerContent) {
                ZHUserInfoRewardContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userInfoRewardContntCellid forIndexPath:indexPath];
                cell.rewardModel = _bigModel.rewardModel;
                
                cell.didClick = ^{
                    
                    ZHRewardDetailViewController *rewardVc = [[ZHRewardDetailViewController alloc]init];
                    
                    rewardVc.uidStringz = _bigModel.rewardModel.rewardAskId;
                    [self.navigationController pushViewController:rewardVc animated:YES];
                    
                };
                
                return cell;
            }else if(_bigModel.rewardModel.answerVoice){
                ZHUserInfoRewardVoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userInfoRewardVoiceCellid forIndexPath:indexPath];
                
                cell.rewardModel = _bigModel.rewardModel;
                
                cell.didClick = ^{
                    ZHRewardDetailViewController *rewardVc = [[ZHRewardDetailViewController alloc]init];
                    
                    rewardVc.uidStringz = _bigModel.rewardModel.rewardAskId;
                    [self.navigationController pushViewController:rewardVc animated:YES];
                };
                
                return cell;
            }
            
            if(!_bigModel.rewardModel.answerContent ||!_bigModel.rewardModel.answerVoice){
                
                ZHUserInfoNoModelTableViewCell *Nocell = [tableView dequeueReusableCellWithIdentifier:userInfoNoModelCelId forIndexPath:indexPath];
              
                if (_bigModel.owner == YES) {
                    Nocell.titleLabel.text = @"您还没有悬赏问";
                }else{
                    Nocell.titleLabel.text = @"他还没有悬赏问";
                }
            
                return Nocell;
            }
        }else{
            if (_bigModel.rewardModel.answerContent) {
                ZHUserInfoRewardContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userInfoRewardContntCellid forIndexPath:indexPath];
                cell.rewardModel = _bigModel.rewardModel;
                
                cell.didClick = ^{
                    
                    ZHRewardDetailViewController *rewardVc = [[ZHRewardDetailViewController alloc]init];
                    
                    rewardVc.uidStringz = _bigModel.rewardModel.rewardAskId;
                    [self.navigationController pushViewController:rewardVc animated:YES];
                    
                };
                
                return cell;
            }else if(_bigModel.rewardModel.answerVoice){
                ZHUserInfoRewardVoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userInfoRewardVoiceCellid forIndexPath:indexPath];
                
                cell.rewardModel = _bigModel.rewardModel;
                
                cell.didClick = ^{
                    ZHRewardDetailViewController *rewardVc = [[ZHRewardDetailViewController alloc]init];
                    
                    rewardVc.uidStringz = _bigModel.rewardModel.rewardAskId;
                    [self.navigationController pushViewController:rewardVc animated:YES];
                };
                
                return cell;
            }
            
            if(!_bigModel.rewardModel.answerContent ||!_bigModel.rewardModel.answerVoice){
                
                ZHUserInfoNoModelTableViewCell *Nocell = [tableView dequeueReusableCellWithIdentifier:userInfoNoModelCelId forIndexPath:indexPath];

                if (_bigModel.owner == YES) {
                    Nocell.titleLabel.text = @"您还没有案例";
                }else{
                    Nocell.titleLabel.text = @"他还没有案例";
                }

                return Nocell;
            }
        }
      

    }
    
    if (indexPath.section == 2) {
        ZHUserInfoFreeAskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userInfoFreeContentCellid forIndexPath:indexPath];
        
        cell.freeModel = _bigModel.freeModel;
        return cell;
    }else if(!_bigModel.freeModel.freeAskId){
        
        if (_bigModel.owner == NO) {
            ZHUserInfoNoModelTableViewCell *Nocell = [tableView dequeueReusableCellWithIdentifier:userInfoNoModelCelId forIndexPath:indexPath];
            Nocell.titleLabel.text = @"他还没有免费问";
            return Nocell;

        }else{
            ZHUserInfoNoModelTableViewCell *Nocell = [tableView dequeueReusableCellWithIdentifier:userInfoNoModelCelId forIndexPath:indexPath];
            Nocell.titleLabel.text = @"您还没有免费问";
            return Nocell;
        }
        
        
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
        self.tableView.sectionHeaderHeight = 43;
 
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHUserInfoTableViewCell" bundle:nil] forCellReuseIdentifier:userInfoCellid];

        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHUserInfoRewardVoiceTableViewCell" bundle:nil] forCellReuseIdentifier:userInfoRewardVoiceCellid];
        [_tableView registerNib:[UINib nibWithNibName:@"ZHUserInfoRewardContentTableViewCell" bundle:nil] forCellReuseIdentifier:userInfoRewardContntCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHUserInfoFreeAskTableViewCell" bundle:nil] forCellReuseIdentifier:userInfoFreeContentCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHUserInfoNoModelTableViewCell" bundle:nil] forCellReuseIdentifier:userInfoNoModelCelId];
        
//        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    }
    
    return _tableView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offset = scrollView.contentOffset.y;
    UIColor *color = [UIColor redColor];
    
    if (offset > 50) {
        
        if (offset >= 100) {
            
            offset = 100;
        }
        CGFloat alpha = (offset - 50)/50;
        _headerView.backgroundColor = [color colorWithAlphaComponent:alpha];
    }else {
        _headerView.backgroundColor = [UIColor clearColor];
    }
    
    if (offset < -80) {
        _headerView.hidden = YES;
    }else {
        _headerView.hidden = NO;
    }
}


@end
