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
#import "ZHMyConsultDetailViewController.h"
#import "ZHRewardDetailViewController.h"
#import "ZHOrderPaymentViewController.h"
#import "ZHCaseDetaiPageleViewController.h"
#import "ZHMoreCaseViewController.h"
#import "ZHMoreRewardListViewController.h"
#import "ZHOrderPayModel.h"


static NSString *expertUserInfoCellid = @"expertUserInfoCellid";

static NSString *userInfoRewardCellid = @"userInfoRewardCellid";

static NSString *userInfoRewardContntCellid = @"userInfoRewardContntCellid";

static NSString *expertUserInfoCaseCellid = @"expertUserInfoCaseCellid";

static NSString *businessCellid = @"businessCellid";

static NSString *userInfoNoModelCelId = @"userInfoNoModelCelId";


@interface ZHExpertUserInfoHomePageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIView *focusView;

@property(nonatomic,strong)UIButton *focusBtn;

@property(nonatomic,strong)UIButton *consultingBtn;

@property(nonatomic,weak)UIView *headerView;


@end

@implementation ZHExpertUserInfoHomePageViewController

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
 
    
   
    
    [self loadData];
    [self.view addSubview:self.tableView];
    
    if (self.tableView.style == UITableViewStylePlain) {
        UIEdgeInsets contentInset = self.tableView.contentInset;
        contentInset.top = -22;
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

//这里
- (void)setupUI{
    
    
    _focusView = [UIView new];
    _focusView.frame = CGRectMake(0,CGRectGetMaxY(self.view.frame)-49, ScreenHeight, 49);
    _focusView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:self.focusView];
    
    _focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _focusBtn.frame = CGRectMake(0, 1, ScreenWidth / 2, 49);
    _focusBtn.backgroundColor = [UIColor whiteColor];
    _focusBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [_focusBtn setTitle:@"关注" forState:UIControlStateNormal];
    [_focusBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [_focusBtn setImage:[UIImage imageNamed:@"follow"] forState:UIControlStateNormal];
    [_focusBtn setImage:[UIImage imageNamed:@"follower"] forState:UIControlStateSelected];
    [_focusBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_focusBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    [_focusBtn addTarget:self action:@selector(focusBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.focusView addSubview:self.focusBtn];
    
    if (_bigModel.expertUserInfoModel.followed == YES) {
        _focusBtn.selected = YES;
    }else{
        _focusBtn.selected = NO;
    }
    
    _consultingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _consultingBtn.frame = CGRectMake(ScreenWidth / 2, 0, ScreenWidth / 2, 50);
    _consultingBtn.backgroundColor = [UIColor orangeColor];
    [_consultingBtn setTitle:[NSString stringWithFormat:@"￥%@咨询",_bigModel.expertUserInfoModel.consultPrice] forState:UIControlStateNormal];
    [_consultingBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [_consultingBtn addTarget:self action:@selector(consultingBtnClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.focusView addSubview:self.consultingBtn];
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
        [self setupUI];

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
        moreBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 40 - 10, 15, 50 , 30);
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
        moreBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 40 - 18, 10, 50 , 30);
        [moreBtn setTitle:@"更多>>" forState:UIControlStateNormal];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [moreBtn addTarget:self action:@selector(moreCaseAction) forControlEvents:UIControlEventTouchUpInside];
        
        [headerView addSubview:moreBtn];
        
        return headerView;
        
    }
    
    return view;
    
    
}

- (void)moreCaseAction{
    
    ZHMoreCaseViewController *caseVc = [[ZHMoreCaseViewController alloc]init];
    caseVc.userId = _expertID;
    
    [self.navigationController pushViewController:caseVc animated:YES];
    
}

- (void)moreRewardAction{
    
    ZHMoreRewardListViewController *rewardVc = [[ZHMoreRewardListViewController alloc]init];
    rewardVc.userId = _expertID;
    [self.navigationController pushViewController:rewardVc animated:YES];

    
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
        
        cell.selectionStyle =UITableViewCellSelectionStyleNone;

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
            cell.bigModel = _bigModel;
            cell.expertRewardModel = _bigModel.expertRewardModel;
            cell.selectionStyle =UITableViewCellSelectionStyleNone;

            cell.didClick = ^{
                
                ZHRewardDetailViewController *rewardVc = [[ZHRewardDetailViewController alloc]init];
                
                rewardVc.uidStringz = _bigModel.expertRewardModel.rewardAskId;
                [self.navigationController pushViewController:rewardVc animated:YES];
                
            };
        
            cell.payDidClick = ^{
                
                NSMutableDictionary *dic = [ZHNetworkTools parameters];
                [dic setObject:_bigModel.expertRewardModel.answerId forKey:@"rewardAskAnswerId"];
                NSString *url = [NSString stringWithFormat:@"%@/api/rewardask/ut/learn",kIP];
                
                [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                    
                    if (error) {
                        NSLog(@"%@",error);
                    }
                    
                    ZHOrderPayModel *model = [ZHOrderPayModel yy_modelWithJSON:response[@"data"]];
                    model.descriptions = @"悬赏问-学习一下";
                    model.goodsName = @"悬赏订单";
                    model.amount = @"0.01";
                    
                    ZHOrderPaymentViewController *payVc = [[ZHOrderPaymentViewController alloc]init];
                    payVc.payModel = model;
                    
                    [self.navigationController pushViewController:payVc animated:YES];
                    
                }];
            };
        
            return cell;
  
    }else if(indexPath.section == 2 && !_bigModel.expertRewardModel){

            ZHUserInfoNoModelTableViewCell *Nocell = [tableView dequeueReusableCellWithIdentifier:userInfoNoModelCelId forIndexPath:indexPath];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;

            Nocell.titleLabel.text = @"12312313";
            return Nocell;
  
    }

    if (indexPath.section == 3 && _bigModel.expertCaseModel) {
            ZHExpertUserInfoCaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:expertUserInfoCaseCellid forIndexPath:indexPath];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;

            cell.caseModel = _bigModel.expertCaseModel;
    
        return cell;
    }else if(indexPath.section == 3 && !_bigModel.expertCaseModel){
        
        ZHUserInfoNoModelTableViewCell *Nocell = [tableView dequeueReusableCellWithIdentifier:userInfoNoModelCelId forIndexPath:indexPath];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        Nocell.titleLabel.text = @"455654665464646";

        return Nocell;
        
    }
    
    
    return cell?cell:[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                            reuseIdentifier: @"Cell"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return;
    }
    
    if (indexPath.section == 1) {
        return;
    }
    
    if (indexPath.section == 2) {
        return;
    }
    
    if (indexPath.section == 3) {
        
        ZHCaseDetaiPageleViewController *caseDetailVc = [[ZHCaseDetaiPageleViewController alloc]init];
        caseDetailVc.urlId = _bigModel.expertCaseModel.caseId;
        caseDetailVc.time = _bigModel.expertCaseModel.readingTime;
        caseDetailVc.title = _bigModel.expertCaseModel.title;
        caseDetailVc.words = _bigModel.expertCaseModel.caseWords;
        
        [self.navigationController pushViewController:caseDetailVc animated:YES];

    }
    
    
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

- (void)focusBtnClickAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    
    if (sender.selected == YES) {
        NSMutableDictionary *dic = [ZHNetworkTools parameters];
        [dic setObject:self.expertID forKey:@"expertId"];
        
        NSString *url = [NSString stringWithFormat:@"%@/api/ut/follow/follow",kIP];
       
        [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
            
            if (error) {
                NSLog(@"%@",error);
            }
            
            NSLog(@"%@",response);
           
            
            
        }];
        
    }else{
        NSMutableDictionary *dic = [ZHNetworkTools parameters];
        [dic setObject:self.expertID forKey:@"expertId"];
        
        NSString *url = [NSString stringWithFormat:@"%@/api/ut/follow/unfollow",kIP];
        
        [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
            
            if (error) {
                NSLog(@"%@",error);
            }
            
            NSLog(@"%@",response);
            
        }];
    }
    
}

- (void)consultingBtnClickAction {
    
    NSLog(@"consultingBtnClickAction");
    
    ZHMyConsultDetailViewController *consultDetailVc = [[ZHMyConsultDetailViewController alloc]init];
    consultDetailVc.expertID = self.expertID;
    consultDetailVc.expertNickName = _bigModel.expertUserInfoModel.nickname;
    [self.navigationController pushViewController:consultDetailVc animated:YES];
    
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
