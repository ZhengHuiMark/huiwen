//
//  ZHMyVipCardViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/12/11.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMyVipCardViewController.h"
#import "ZHMyCardNumberTableViewCell.h"
#import "ZHVipCardDetailTableViewCell.h"
#import "ZHNetworkTools.h"
#import "Macro.h"
#import "ZHCardNumberModel.h"
#import "ZHVipCardModel.h"
#import "YYModel.h"
#import "ZHRecordMoneyViewController.h"
#import "ZHInvoiceViewController.h"

static NSString *cardNumberCellid = @"cardNumberCellid";

static NSString *vipCardDetailCellid = @"vipCardDetailCellid";


@interface ZHMyVipCardViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ZHMyVipCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview: self.tableView];
    
    [self setupUI];
    [self loadData];

}

- (void)setupUI{
    
    [self.navigationController setTitle:@"我的会员卡"];
    
}


- (void)loadData{
    
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/ut/memberCard/getMyMemberCardInfo",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        NSLog(@"%@",response);
        _cardModel = [ZHVipCardModel yy_modelWithJSON:response[@"data"]];
        
        _cardModel.cards = [NSArray yy_modelArrayWithClass:[ZHCardNumberModel class] json:response[@"data"][@"cards"]];
        
        [self.tableView reloadData];
    }];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0) {
        return;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    
    return self.cardModel.cards.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 50;
    }
    
    return 291;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        ZHMyCardNumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cardNumberCellid forIndexPath:indexPath];
        
        cell.model = _cardModel;
        
        cell.recordBtnClick = ^(){
            
            ZHRecordMoneyViewController *recordVc = [[ZHRecordMoneyViewController alloc]init];
            
            [self.navigationController pushViewController:recordVc animated:YES];
            
        };
        
        cell.invoiceBtnClick = ^(){
          
            ZHInvoiceViewController *invoceVc = [[ZHInvoiceViewController alloc]init];
            
            [self.navigationController pushViewController:invoceVc animated:YES];
            
        };
        
        return cell;
    }
    
    ZHVipCardDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:vipCardDetailCellid forIndexPath:indexPath];
    
    cell.numberModel = self.cardModel.cards[indexPath.row];
    
    return cell;
    
    
}


- (UITableView *)tableView {
    //
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        _tableView.rowHeight = 60;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //    NSBundle *bundle = [NSBundle mainBundle];
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHMyCardNumberTableViewCell" bundle:nil] forCellReuseIdentifier:cardNumberCellid];
         [_tableView registerNib:[UINib nibWithNibName:@"ZHVipCardDetailTableViewCell" bundle:nil] forCellReuseIdentifier:vipCardDetailCellid];
        
    }
    
    return _tableView;
}

@end
