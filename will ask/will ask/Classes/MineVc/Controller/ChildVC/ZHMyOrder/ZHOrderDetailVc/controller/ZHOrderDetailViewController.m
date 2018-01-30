//
//  ZHOrderDetailViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/12/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHOrderDetailViewController.h"
#import "ZHOrderDetailPayTableViewCell.h"
#import "ZHOrderDetailLearnTableViewCell.h"
#import "ZHOrderDetailCaseTableViewCell.h"
#import "ZHOrderDetailRewardOrInformationTableViewCell.h"
#import "ZHOrderDetailVipCardTableViewCell.h"
#import "ZHOrderDetailCaseModel.h"
#import "ZHOrderDetailLearnModel.h"
#import "ZHOrderDetailRewardModel.h"
#import "ZHOrderDetailConsultModel.h"
#import "ZHOrderDetailVipCardModel.h"
#import "ZHOrderDetailModel.h"
#import "ZHOrderPayModel.h"
#import "ZHOrderPaymentViewController.h"

#import "Macro.h"
#import "ZHNetworkTools.h"
#import "YYModel.h"


static NSString *payCellid = @"payCellid";
static NSString *learnCellid = @"learnCellid";
static NSString *caseCellid = @"caseCellid";
static NSString *rewardAndInfomationCellid = @"rewardAndInfomationCellid";
static NSString *vipcardCellid = @"vipcardCellid";



@interface ZHOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property (nonatomic, strong) UIButton *focusBtn;

@property (nonatomic, strong) UIView *focusView;

@property (nonatomic, strong) UIButton *consultingBtn;


@end

@implementation ZHOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
    [self loadData];
    [self.view addSubview:self.tableView];
   
}

#pragma mark - 立即支付
- (void)consultingBtnClickAction{
    
    ZHOrderPayModel *model = [[ZHOrderPayModel alloc]init];
    model.descriptions = _orderDetailModel.descriptions;
    model.goodsName = _orderDetailModel.goodsName;
    model.amount = _orderDetailModel.amount;
    
    ZHOrderPaymentViewController *payVc = [[ZHOrderPaymentViewController alloc]init];
    payVc.payModel = model;

    [self.navigationController pushViewController:payVc animated:YES];
    
}


- (void)configUI{
    
    _focusView = [UIView new];
    _focusView.frame = CGRectMake(0,CGRectGetMaxY(self.view.frame)-49, ScreenHeight, 49);
    _focusView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:self.focusView];
    
    _focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _focusBtn.frame = CGRectMake(0, 1, ScreenWidth / 2, 49);
    _focusBtn.backgroundColor = [UIColor whiteColor];
    _focusBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [_focusBtn setTitle:[NSString stringWithFormat:@"￥%@",_orderDetailModel.amount] forState:UIControlStateNormal];
    [_focusBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_focusBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    [self.focusView addSubview:self.focusBtn];
    
//    if (_bigModel.expertUserInfoModel.followed == YES) {
//        _focusBtn.selected = YES;
//    }else{
//        _focusBtn.selected = NO;
//    }
    
    _consultingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _consultingBtn.frame = CGRectMake(ScreenWidth / 2, 0, ScreenWidth / 2, 50);
    _consultingBtn.backgroundColor = [UIColor orangeColor];
    [_consultingBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [_consultingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_consultingBtn addTarget:self action:@selector(consultingBtnClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.focusView addSubview:self.consultingBtn];
    
}

- (void)loadData{
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:_payModel.orderNum forKey:@"orderNum"];
    [dic setObject:_payModel.type forKey:@"type"];
    NSString *url = [NSString stringWithFormat:@"%@/api/ut/order/getOrderDetails",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        NSLog(@"%@",response);
        
        _orderDetailModel = [ZHOrderDetailModel yy_modelWithJSON:response[@"data"]];
        if ([_orderDetailModel.status isEqualToString:@"0"]) {
            [self configUI];
        }
        
        _orderDetailModel.rewardModel = [ZHOrderDetailRewardModel yy_modelWithJSON:response[@"data"][@"detailsRewardAsk"]];
        
        _orderDetailModel.vipCardModel = [ZHOrderDetailVipCardModel yy_modelWithJSON:response[@"data"][@"detailsMembercard"]];
        _orderDetailModel.caseModel = [ZHOrderDetailCaseModel yy_modelWithJSON:response[@"data"][@"detailsCaseAnalysis"]];
        
        _orderDetailModel.consultModel = [ZHOrderDetailConsultModel yy_modelWithJSON:response[@"data"][@"detailsConsult"]];
        
        _orderDetailModel.learnModel = [ZHOrderDetailLearnModel yy_modelWithJSON:response[@"data"][@"detailsRewardAskLearn"]];
        
        [self.tableView reloadData];
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 130;
    }
    
    if (indexPath.section == 1) {
      
        if (_orderDetailModel.vipCardModel) {
            // vip 83高度
            //计算高度
            NSString *wenzi = _orderDetailModel.vipCardModel.descriptions;
            CGFloat marin = 21.5;
            CGFloat labelWidth = [UIScreen mainScreen].bounds.size.width - marin * 2;
            CGFloat labelHeight = [wenzi boundingRectWithSize: CGSizeMake(labelWidth, 300)
                                                      options: NSStringDrawingUsesLineFragmentOrigin
                                                   attributes: @{NSFontAttributeName : [UIFont systemFontOfSize: 14]}
                                                      context: nil].size.height;

            return 83 + labelHeight;
        }else if (_orderDetailModel.rewardModel){
            // 悬赏，160
            
            NSString *wenzi = _orderDetailModel.rewardModel.content;
            CGFloat marin = 17;
            CGFloat labelWidth = [UIScreen mainScreen].bounds.size.width - marin * 2;
            CGFloat labelHeight = [wenzi boundingRectWithSize: CGSizeMake(labelWidth, 300)
                                                      options: NSStringDrawingUsesLineFragmentOrigin
                                                   attributes: @{NSFontAttributeName : [UIFont systemFontOfSize: 14]}
                                                      context: nil].size.height;

            return 160 + labelHeight;
        }else if (_orderDetailModel.caseModel){
            // 案例 186高度

            return 186;
        }else if (_orderDetailModel.consultModel){
            NSString *wenzi = _orderDetailModel.consultModel.question;
            CGFloat marin = 17;
            CGFloat labelWidth = [UIScreen mainScreen].bounds.size.width - marin * 2;
            CGFloat labelHeight = [wenzi boundingRectWithSize: CGSizeMake(labelWidth, 300)
                                                      options: NSStringDrawingUsesLineFragmentOrigin
                                                   attributes: @{NSFontAttributeName : [UIFont systemFontOfSize: 14]}
                                                      context: nil].size.height;

            // 咨询，160
            return 160 + labelHeight;
        }else if (_orderDetailModel.learnModel){
            NSString *wenzi = _orderDetailModel.learnModel.content;
            CGFloat marin = 17.5;
            CGFloat labelWidth = [UIScreen mainScreen].bounds.size.width - marin * 2;
            CGFloat labelHeight = [wenzi boundingRectWithSize: CGSizeMake(labelWidth, 300)
                                                      options: NSStringDrawingUsesLineFragmentOrigin
                                                   attributes: @{NSFontAttributeName : [UIFont systemFontOfSize: 14]}
                                                      context: nil].size.height;

            // 学习一下 100高度
            return 100 + labelHeight;
        }
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }
    
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        ZHOrderDetailPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:payCellid forIndexPath:indexPath];
        cell.model = _orderDetailModel;
        return cell;
    }
    
    if (_orderDetailModel.rewardModel) {
        ZHOrderDetailRewardOrInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rewardAndInfomationCellid forIndexPath:indexPath];
        if ([_orderDetailModel.type isEqualToString:@"1"]) {
            cell.titleLabel.text = @"悬赏问内容";
        }
        
        cell.rewardModel = _orderDetailModel.rewardModel;
        
        return cell;
    }else if (_orderDetailModel.consultModel){
        ZHOrderDetailRewardOrInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rewardAndInfomationCellid forIndexPath:indexPath];
        
        if ([_orderDetailModel.type isEqualToString:@"4"]) {
            cell.titleLabel.text = @"咨询内容";
        }
        cell.consultModel = _orderDetailModel.consultModel;
        
        return cell;
    }else if (_orderDetailModel.learnModel){
        ZHOrderDetailLearnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:learnCellid forIndexPath:indexPath];
        
        cell.model = _orderDetailModel.learnModel;
        return cell;
        
    }else if (_orderDetailModel.caseModel){
        ZHOrderDetailCaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:caseCellid forIndexPath:indexPath];
        
        cell.caseModel = _orderDetailModel.caseModel;
        
        return cell;
        
        
    }else if (_orderDetailModel.vipCardModel){
        ZHOrderDetailVipCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:vipcardCellid forIndexPath:indexPath];
        
        cell.vipModel = _orderDetailModel.vipCardModel;
        
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
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHOrderDetailPayTableViewCell" bundle:nil] forCellReuseIdentifier:payCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHOrderDetailLearnTableViewCell" bundle:nil] forCellReuseIdentifier:learnCellid];
        [_tableView registerNib:[UINib nibWithNibName:@"ZHOrderDetailCaseTableViewCell" bundle:nil] forCellReuseIdentifier:caseCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHOrderDetailRewardOrInformationTableViewCell" bundle:nil] forCellReuseIdentifier:rewardAndInfomationCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHOrderDetailVipCardTableViewCell" bundle:nil] forCellReuseIdentifier:vipcardCellid];
     
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    }
    
    return _tableView;
}


@end
