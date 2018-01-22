//
//  ZHRecordMoneyViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/12/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHRecordMoneyViewController.h"
#import "ZHRecordListTableViewCell.h"
#import "ZHRecordListModel.h"
#import "ZHNetworkTools.h"
#import "Macro.h"
#import "MJRefresh.h"
#import "YYModel.h"

static NSString *recordListCellid = @"recordListCellid";

@interface ZHRecordMoneyViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger _pageNo;
}

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray <ZHRecordListModel *> *listModels;


@end

@implementation ZHRecordMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    
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

- (void)loadData {
    //   /api/ut/memberCard/getMemberCardConsumeRecords
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:@(_pageNo) forKey:@"pageNo"];
    NSString *url = [NSString stringWithFormat:@"%@/api/ut/memberCard/getMemberCardConsumeRecords",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
        NSLog(@"%@",response);
        
        NSArray<ZHRecordListModel *>* models = [NSArray yy_modelArrayWithClass:[ZHRecordListModel class] json:response[@"data"]];
       
        if (_pageNo == 1) { // 刷新
            self.listModels = [NSMutableArray arrayWithArray:models];
        } else { // 加载更多
            
            [self.listModels addObjectsFromArray: models];
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ZHRecordListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:recordListCellid forIndexPath:indexPath];
    
    if (cell == nil) {
        
        cell = [[ZHRecordListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recordListCellid];
    }

    ZHRecordListModel *model = _listModels[indexPath.row];

    cell.model = model;
    
    return cell;
    
}


- (UITableView *)tableView {
    //
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        _tableView.rowHeight = 60;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //    NSBundle *bundle = [NSBundle mainBundle];
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHRecordListTableViewCell" bundle:nil] forCellReuseIdentifier:recordListCellid];
        
    }
    
    return _tableView;
}

- (NSMutableArray<ZHRecordListModel *> *)listModels {
    
    if (!_listModels) {
        _listModels = [NSMutableArray array];
    }
    
    return _listModels;
}


@end
