//
//  ZHMyWalletViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/12/1.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMyWalletViewController.h"
#import "ZHMyWalletTableViewCell.h"
#import "ZHWalletListTableViewCell.h"
#import "ZHNetworkTools.h"
#import "Macro.h"
#import "ZHWalletModel.h"
#import "YYModel.h"
#import "ZHTransactionViewController.h"
#import "ZHWithdrawalViewController.h"

static NSString *WalletCellid = @"WalletCellid";

static NSString *WalletListCellid = @"WalletListCellid";

@interface ZHMyWalletViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)ZHWalletModel *model;



@end

@implementation ZHMyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的钱包";
    self.view.backgroundColor = [UIColor whiteColor];

    
    [self loadData];
    [self.view addSubview: self.tableView];
}

- (void)loadData{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/ut/user/getWalletBalance",kIP];
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
        _model = [ZHWalletModel yy_modelWithJSON:response];

        NSLog(@"123 = %@",response);
        
        [self.tableView reloadData];

    }];
    

    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    

    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    return 3;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 150;
    }
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        ZHMyWalletTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WalletCellid forIndexPath:indexPath];
        
        cell.model = self.model;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        
        return cell;
    }

    
    ZHWalletListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WalletListCellid forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.indexPath = indexPath;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return;
    }
    
    if (indexPath.section == 1) {
        
        switch (indexPath.row) {
            case 0:{
                
            }
                break;
            case 1:{
                
                ZHTransactionViewController *transactionVc = [[ZHTransactionViewController alloc]init];
                
                [self.navigationController pushViewController:transactionVc animated:YES];
                
            }
                break;
            case 2:{
                ZHWithdrawalViewController *withDrawalVc = [[ZHWithdrawalViewController alloc]init];
                
                [self.navigationController pushViewController:withDrawalVc animated:YES];
           
            }
                break;
                
            default:
                break;
        }
    }
    
    
}



- (UITableView *)tableView {
    //
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        //    NSBundle *bundle = [NSBundle mainBundle];
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHMyWalletTableViewCell" bundle:nil] forCellReuseIdentifier:WalletCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHWalletListTableViewCell" bundle:nil] forCellReuseIdentifier:WalletListCellid];
        
//        [_tableView registerNib:[UINib nibWithNibName:@"ZHIntroductionTableViewCell" bundle:nil] forCellReuseIdentifier:IntroductionCellid];
//        
//        [_tableView registerNib:[UINib nibWithNibName:@"ZHTypeTableViewCell" bundle:nil] forCellReuseIdentifier:typeCellid];
    }
    
    return _tableView;
}

- (ZHWalletModel *)model{
    if (!_model) {
        _model = [ZHWalletModel new];
        
    }
    
    return _model;
}

    @end
