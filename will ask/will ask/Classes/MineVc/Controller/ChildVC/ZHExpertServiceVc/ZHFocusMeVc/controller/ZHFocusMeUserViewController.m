//
//  ZHFocusMeUserViewController.m
//  will ask
//
//  Created by 郑晖 on 2018/1/10.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHFocusMeUserViewController.h"
#import "ZHFocusMeListTableViewCell.h"
#import "ZHFocusMeUserModel.h"

static NSString *focusMeCellid = @"focusMeCellid";

@interface ZHFocusMeUserViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger _pageNo;
}

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray <ZHFocusMeUserModel *>*focusMeListModels;


@end

@implementation ZHFocusMeUserViewController

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


- (void)loadData{
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:@(_pageNo) forKey:@"pageNo"];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/ut/follow/getFollowMyUserList",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        
        if (error) {
            NSLog(@"%@",error);
        }
        
        
        NSArray <ZHFocusMeUserModel *> *models = [NSArray yy_modelArrayWithClass:[ZHFocusMeUserModel class] json:response[@"data"]];
        
        //  3.2 判断是刷新 还是 加载更多
        if (_pageNo == 1) { // 刷新
            self.focusMeListModels = [NSMutableArray arrayWithArray:models];
        } else { // 加载更多
            
            [self.focusMeListModels addObjectsFromArray: models];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _focusMeListModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZHFocusMeUserModel *model = _focusMeListModels[indexPath.row];
    
    ZHFocusMeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:focusMeCellid forIndexPath:indexPath];
    
    cell.model = model;
    
    return cell;
    
}


- (UITableView *)tableView {
    //
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        _tableView.rowHeight = 180;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //    NSBundle *bundle = [NSBundle mainBundle];
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHFocusMeListTableViewCell" bundle:nil] forCellReuseIdentifier:focusMeCellid];
        
    }
    
    return _tableView;
}


- (NSMutableArray<ZHFocusMeUserModel *> *)focusMeListModels {
    
    if (!_focusMeListModels) {
        _focusMeListModels = [NSMutableArray array];
    }
    
    return _focusMeListModels;
}
@end
