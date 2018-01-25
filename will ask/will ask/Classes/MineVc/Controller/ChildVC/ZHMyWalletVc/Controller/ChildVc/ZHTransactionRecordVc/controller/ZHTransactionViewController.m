//
//  ZHTransactionViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/12/4.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHTransactionViewController.h"
#import "ZHTransactionRecordTableViewCell.h"
#import "ZHNetworkTools.h"
#import "Macro.h"
#import "MJRefresh.h"
#import "YYModel.h"
#import "ZHTransactionModel.h"


static NSString *transCellid = @"transCellid";

@interface ZHTransactionViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger _pageNo;
}

@property(nonatomic,strong)NSMutableArray <ZHTransactionModel *> *listModels;

@property(nonatomic,strong)UISegmentedControl *segmentedControl;

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ZHTransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
    
    [self setupUI];
    [self.view addSubview:self.tableView];
    
 
    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageNo = 1;
        
        
        [self requestFormNetWorkIncomeFlag:@"" pageNo:_pageNo];
        
    }];
    _tableView.mj_header.automaticallyChangeAlpha = YES;
    _tableView.mj_footer.automaticallyHidden = YES;
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageNo++;
        
        [self requestFormNetWorkIncomeFlag:@"" pageNo:_pageNo];

    }];
    [_tableView.mj_header beginRefreshing];
}

- (void)setupUI{
    
    UIView *backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, 60)];
    
    backGroundView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:backGroundView];
    
    
    // 初始化，添加分段名，会自动布局
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"全部", @"收入",@"支出"]];
    self.segmentedControl.frame = CGRectMake(17,13,[UIScreen mainScreen].bounds.size.width - 35,35);
    
    self.segmentedControl.tintColor = [UIColor colorWithRed:242/255.0 green:90/255.0 blue:41/255.0  alpha:1];

    // 设置初始选中项
    self.segmentedControl.selectedSegmentIndex = 0;
    
    // 设置点击后恢复原样，默认为NO，点击后一直保持选中状态
    self.segmentedControl.momentary = NO;
    
    
    [self.segmentedControl addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventValueChanged];// 添加响应方法
    
    [backGroundView addSubview:self.segmentedControl];
//    [self.view addSubview:self.segmentedControl];
}

- (void)requestFormNetWorkIncomeFlag:(NSString *)IncomeFlag pageNo:(NSInteger)pageNo{
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:IncomeFlag forKey:@"incomeFlag"];
    [dic setObject:@(pageNo) forKey:@"pageNo"];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/ut/tradeRecord/getMyTradeRecordList",kIP];

    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        NSLog(@" response = %@",response);
        
        NSArray<ZHTransactionModel *>*models = [NSArray yy_modelArrayWithClass:[ZHTransactionModel class] json:response[@"data"]];
        
        //  3.2 判断是刷新 还是 加载更多
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

- (void)selectItem:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        NSLog(@"正在销售");
      
//        _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            _pageNo = 1;
//            
//           
//            [self requestFormNetWorkIncomeFlag:@"" pageNo:_pageNo];
//            
//        }];
   
        
        [_tableView.mj_header beginRefreshing];

        
    } else if (sender.selectedSegmentIndex == 1){
        
//        _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            _pageNo = 1;
//            
//            
//            [self requestFormNetWorkIncomeFlag:@"1" pageNo:_pageNo];
//            
//        }];
//        _tableView.mj_header.automaticallyChangeAlpha = YES;
//        _tableView.mj_footer.automaticallyHidden = YES;
//        
        [_tableView.mj_header beginRefreshing];

        NSLog(@"已下架");
    } else {
        
//        _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            _pageNo = 1;
//            
//            
//            [self requestFormNetWorkIncomeFlag:@"2" pageNo:_pageNo];
//            
//        }];
//        _tableView.mj_header.automaticallyChangeAlpha = YES;
//        _tableView.mj_footer.automaticallyHidden = YES;
        
        [_tableView.mj_header beginRefreshing];

        NSLog(@"嘿嘿嘿");
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listModels.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZHTransactionModel *model = _listModels[indexPath.row];

    
    ZHTransactionRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:transCellid forIndexPath:indexPath];
    
    
    cell.model = model;
    
    
    return cell;
}


- (UITableView *)tableView {
    //
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height - 130) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        _tableView.rowHeight = 60;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //    NSBundle *bundle = [NSBundle mainBundle];
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHTransactionRecordTableViewCell" bundle:nil] forCellReuseIdentifier:transCellid];
        
    }
    
    return _tableView;
}



- (NSMutableArray<ZHTransactionModel *> *)listModels {
    
    if (!_listModels) {
        _listModels = [NSMutableArray array];
    }
    
    return _listModels;
}


@end
