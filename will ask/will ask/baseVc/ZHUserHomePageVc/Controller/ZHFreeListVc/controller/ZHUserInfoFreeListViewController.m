//
//  ZHUserInfoFreeListViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/12/25.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHUserInfoFreeListViewController.h"
#import "ZHMoreFreeListTableViewCell.h"
#import "ZHMoerFreeListModel.h"
#import "ZHNetworkTools.h"
#import "Macro.h"
#import "YYModel.h"
#import "FreeDetailViewController.h"
#import "ZHCaseListTableViewCell.h"

static NSString *moreFreeListCellid = @"moreFreeListCellid";
@interface ZHUserInfoFreeListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger _pageNumber;
}

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray <ZHMoerFreeListModel *>*mListModels;



@end

@implementation ZHUserInfoFreeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"免费问";
    
    [self.view addSubview:self.tableView];

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
    ///api/freeask/getUserHomePageMoreFreeAsk
//    NSString *userId = @"110341478336696320";

    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:_userId forKey:@"userId"];
    [dic setObject:@(_pageNumber) forKey:@"pageNo"];
    NSString *url = [NSString stringWithFormat:@"%@/api/freeask/getUserHomePageMoreFreeAsk",kIP];


[[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
    
    if (error) {
        NSLog(@"%@",error);
    }
    
    NSArray <ZHMoerFreeListModel *>*models = [NSArray yy_modelArrayWithClass:[ZHMoerFreeListModel class] json:response[@"data"]];
    
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
    
    return self.mListModels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZHMoerFreeListModel *model = self.mListModels[indexPath.row];
    
    ZHMoreFreeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moreFreeListCellid forIndexPath:indexPath];
    
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    FreeDetailViewController *freeDetailVc = [[FreeDetailViewController alloc]init];
    freeDetailVc.uidString = self.mListModels[indexPath.row].freeAskId;
    
    [self.navigationController pushViewController:freeDetailVc animated:YES];
    
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
        
        //    NSBundle *bundle = [NSBundle mainBundle];
        
        //
        [_tableView registerNib:[UINib nibWithNibName:@"ZHMoreFreeListTableViewCell" bundle:nil] forCellReuseIdentifier:moreFreeListCellid];
        //
        
        
    }
    
    return _tableView;
}



@end
