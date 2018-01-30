//
//  ZHWithdrawalViewController.m
//  will ask
//
//  Created by 郑晖 on 2018/1/4.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHWithdrawalViewController.h"
#import "ZHWithdrawalRecordTableViewCell.h"
#import "ZHWithdrawalModel.h"

#import "Macro.h"
#import "ZHNetworkTools.h"
#import "YYModel.h"
#import "MJRefresh.h"

static NSString *withdrawalRecordCellid = @"withdrawalRecordCellid";

@interface ZHWithdrawalViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger _pageNo;
}

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray <ZHWithdrawalModel *>* models;



@end

@implementation ZHWithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提现记录";
    
    [self.view addSubview: self.tableView];
    
    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageNo = 1;
        
        [self loadData];
        
    }];
    _tableView.mj_header.automaticallyChangeAlpha = YES;
    _tableView.mj_footer.automaticallyHidden = YES;
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageNo++;
        [self loadData];
    }];
    [_tableView.mj_header beginRefreshing];
}

- (void)loadData{
    
//    /api/ut/withdrawals/getWithdrawalsRecords
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:@(_pageNo) forKey:@"pageNo"];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/ut/withdrawals/getWithdrawalsRecords",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
        NSArray <ZHWithdrawalModel *> *models = [NSArray yy_modelArrayWithClass:[ZHWithdrawalModel class] json:response[@"data"]];
        
        if (_pageNo == 1) { // 刷新
            self.models = [NSMutableArray arrayWithArray:models];
        } else { // 加载更多
            
            [self.models addObjectsFromArray: models];
        }

        
        
        [self.tableView reloadData];
        
        
        if (!models || !models.count) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.tableView.mj_footer resetNoMoreData];
        }
        [self.tableView.mj_header endRefreshing];
        
        
        
    }];
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZHWithdrawalModel *model = _models[indexPath.row];
    
    ZHWithdrawalRecordTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:withdrawalRecordCellid forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[ZHWithdrawalRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:withdrawalRecordCellid];
    }

    
    cell.model = model;
    

    
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //    NSBundle *bundle = [NSBundle mainBundle];
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHWithdrawalRecordTableViewCell.h" bundle:nil] forCellReuseIdentifier:withdrawalRecordCellid];
 
    }
    
    return _tableView;
}

@end
