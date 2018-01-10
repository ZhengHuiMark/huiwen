//
//  ZHLearnToMeViewController.m
//  will ask
//
//  Created by 郑晖 on 2018/1/10.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHLearnToMeViewController.h"
#import "ZHLearnToMeTableViewCell.h"
#import "ZHLearnToMeModel.h"

static NSString *learnCellid = @"learnCellid";

@interface ZHLearnToMeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _pageNo;
}

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray <ZHLearnToMeModel *> *learnModels;



@end

@implementation ZHLearnToMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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


- (void)loadData{
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:@(_pageNo) forKey:@"pageNo"];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/ut/follow/getFollowMyUserList",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
        NSArray *models = [NSArray yy_modelArrayWithClass:[ZHLearnToMeModel class] json:response[@"data"]];
        //  3.2 判断是刷新 还是 加载更多
        if (_pageNo == 1) { // 刷新
            self.learnModels = [NSMutableArray arrayWithArray:models];
        } else { // 加载更多
            
            [self.learnModels addObjectsFromArray: models];
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _learnModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZHLearnToMeModel *model = _learnModels[indexPath.row];
    ZHLearnToMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:learnCellid forIndexPath:indexPath];
    
    cell.model = model;
    
    return cell;
    
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        _tableView.rowHeight = 180;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHLearnToMeTableViewCell" bundle:nil] forCellReuseIdentifier:learnCellid];
        
    }
    
    return _tableView;
}

- (NSMutableArray<ZHLearnToMeModel *> *)learnModels {
    
    if (!_learnModels) {
        _learnModels = [NSMutableArray array];
    }
    
    return _learnModels;
}

@end
