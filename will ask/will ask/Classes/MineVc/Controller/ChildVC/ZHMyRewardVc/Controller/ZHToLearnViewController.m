//
//  ZHToLearnViewController.m
//  will ask
//
//  Created by 郑晖 on 2018/1/4.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHToLearnViewController.h"
#import "ZHLearnTableViewCell.h"
#import "ZHTotalIncomeTableViewCell.h"
#import "ZHToLearnModel.h"
#import "ZHTotalIncomeModel.h"

#import "ZHNetworkTools.h"
#import "Macro.h"
#import "YYModel.h"
#import "MJRefresh.h"

static NSString *totalIncomeCellid = @"totalIncomeCellid";

static NSString *toLearnCellid = @"toLearnCellid";

@interface ZHToLearnViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger _pageNumber;
}

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray <ZHToLearnModel *>*learnModels;




@end

@implementation ZHToLearnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    
    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageNumber = 1;
        
        [self loadTotalIncome];
        [self loadData];
        
    }];
    _tableView.mj_header.automaticallyChangeAlpha = YES;
    _tableView.mj_footer.automaticallyHidden = YES;
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageNumber++;
        
        [self loadTotalIncome];
        [self loadData];
    }];
    [_tableView.mj_header beginRefreshing];
}



- (void)loadTotalIncome{
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:_rewardAskId forKey:@"rewardAskId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/rewardask/ut/getRewardAskLearnIncome",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
        _model = [ZHTotalIncomeModel yy_modelWithJSON:response[@"data"]];
        
        [self.tableView reloadData];
        
    }];
    
    
}

- (void)loadData{
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:_rewardAskId forKey:@"rewardAskId"];
    [dic setObject:@(_pageNumber) forKey:@"pageNo"];

    NSString *url = [NSString stringWithFormat:@"%@/api/rewardask/ut/getRewardAskLearnUserList",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
        NSArray <ZHToLearnModel *>*models = [NSArray yy_modelArrayWithClass:[ZHToLearnModel class] json:response[@"data"]];
        
        //  3.2 判断是刷新 还是 加载更多
        if (_pageNumber == 1) { // 刷新
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    
    return _learnModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        ZHTotalIncomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:totalIncomeCellid forIndexPath:indexPath];
        
        cell.totalIncomeModel = _model;
        
        return cell;
    }
    
    if (indexPath.section == 1) {
        
        ZHToLearnModel *model = _learnModels[indexPath.row];
        ZHLearnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:toLearnCellid forIndexPath:indexPath];
        
        
        cell.learnModel = model;
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
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHLearnTableViewCell" bundle:nil] forCellReuseIdentifier:toLearnCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHTotalIncomeTableViewCell" bundle:nil] forCellReuseIdentifier:totalIncomeCellid];
    
    }
    
    return _tableView;
}


@end
