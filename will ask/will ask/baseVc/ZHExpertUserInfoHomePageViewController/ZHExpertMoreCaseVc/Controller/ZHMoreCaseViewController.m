//
//  ZHMoreCaseViewController.m
//  will ask
//
//  Created by 郑晖 on 2018/1/29.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHMoreCaseViewController.h"
#import "ZHCaseListsModel.h"
#import "ZHCaseListTableViewCell.h"
#import "ZHCaseDetaiPageleViewController.h"
#import "ZHMoreCaseListModel.h"

static NSString *CaseListCellid = @"CaseListCellid";

@interface ZHMoreCaseViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger _pageNumber;
}

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray <ZHMoreCaseListModel *>*mListModels;

@end

@implementation ZHMoreCaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    NSString *url = [NSString stringWithFormat:@"%@/api/caseAnalysis/uto/getExpertHomePageMoreCaseAnalysis",kIP];
    
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
    
        NSLog(@"%@",response);
        NSArray <ZHMoreCaseListModel *>*models = [NSArray yy_modelArrayWithClass:[ZHMoreCaseListModel class] json:response[@"data"]];
        
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
    
    ZHMoreCaseListModel *model = self.mListModels[indexPath.row];
    
    ZHCaseListTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:CaseListCellid forIndexPath:indexPath];
    
    cell.moreCaseModel = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ZHCaseDetaiPageleViewController *caseDetailVc = [[ZHCaseDetaiPageleViewController alloc]init];
    caseDetailVc.urlId = self.mListModels[indexPath.row].caseId;
    caseDetailVc.time = self.mListModels[indexPath.row].readingTime;
    caseDetailVc.title = self.mListModels[indexPath.row].title;
    caseDetailVc.words = self.mListModels[indexPath.row].caseWords;
    
    [self.navigationController pushViewController:caseDetailVc animated:YES];


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
        [_tableView registerNib:[UINib nibWithNibName:@"ZHCaseListTableViewCell" bundle:nil] forCellReuseIdentifier:CaseListCellid];
        //
        
        
    }
    
    return _tableView;
}

@end
