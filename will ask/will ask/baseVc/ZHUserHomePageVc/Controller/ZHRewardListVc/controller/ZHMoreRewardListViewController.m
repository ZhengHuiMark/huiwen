//
//  ZHMoreRewardListViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/12/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMoreRewardListViewController.h"
#import "ZHMoreRewardListModel.h"
#import "ZHRewardDetailViewController.h"
#import "ZHMoreRewardListTableViewCell.h"

static NSString *moreRewardCellId = @"moreRewardCellId";
@interface ZHMoreRewardListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger _pageNumber;
}

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray <ZHMoreRewardListModel *>*mListModels;

@end

@implementation ZHMoreRewardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];

    self.title = @"悬赏问答";
    
    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageNumber = 1;
        
        [self loadData];
        
    }];
    _tableView.mj_header.automaticallyChangeAlpha = YES;
    _tableView.mj_footer.automaticallyHidden = YES;
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageNumber++;
        [self loadData];
    }];
    [_tableView.mj_header beginRefreshing];
    
    
}

- (void)loadData {
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:_userId forKey:@"userId"];
    [dic setObject:@(_pageNumber) forKey:@"pageNo"];

    NSString *url = [NSString stringWithFormat:@"%@/api/rewardask/getUserHomePageMoreRewardAsk",kIP];
    
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
        NSLog(@"%@",response);
        NSArray <ZHMoreRewardListModel *>*models = [NSArray yy_modelArrayWithClass:[ZHMoreRewardListModel class] json:response[@"data"]];
        
        
        //  3.2 判断是刷新 还是 加载更多
        if (_pageNumber == 1) { // 刷新
            self.mListModels = [NSMutableArray arrayWithArray:models];
        } else { // 加载更多
            [self.mListModels addObjectsFromArray:models];
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
    
    return _mListModels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZHMoreRewardListModel *model = _mListModels[indexPath.row];
    
    ZHMoreRewardListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moreRewardCellId forIndexPath:indexPath];
    
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ZHRewardDetailViewController *rewardDetailVc = [[ZHRewardDetailViewController alloc]init];
    rewardDetailVc.uidStringz = self.mListModels[indexPath.row].rewardAskId;
    
    [self.navigationController pushViewController:rewardDetailVc animated:YES];
    
}

- (UITableView *)tableView {
    //
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        //        self.tableView.sectionHeaderHeight = 43;
        self.tableView.rowHeight = 152.5;
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHMoreRewardListTableViewCell" bundle:nil] forCellReuseIdentifier:moreRewardCellId];
        //
        
        
    }
    
    return _tableView;
}



@end
