//
//  ZHMyFreeAskViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/12/7.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMyFreeAskViewController.h"
#import "MLTagModelContainer.h"
#import "MLTagModel.h"
#import "MLSubTagModel.h"
#import "MLTagCell.h"
#import "Macro.h"
#import "ZHNetworkTools.h"
#import "YYModel.h"
#import "MLTagButton.h"
#import "MJRefresh.h"
#import "ZHMyFreeAskModel.h"
#import "ZHMyFreeAskTableViewCell.h"

static NSString *MyFreeAskCellid = @"MyFreeAskCellid";

@interface ZHMyFreeAskViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger _pageNumber;

}

@property (nonatomic, strong) MLTagModelContainer *tagContainer;

@property (nonatomic, strong) UITableView *tableView;

@property(nonatomic,strong)MLTagButton *btn;

@property(nonatomic,strong)MLTagModel *model;

@property(nonatomic,strong)MLSubTagModel *subModel;

@property(nonatomic,strong)NSMutableArray<ZHMyFreeAskModel *>* Freemodels;


@end

@implementation ZHMyFreeAskViewController

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
    
    [self LoadFreeAskData];
    
    [self setupUI];
    
}

- (void)setupUI{
    
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 62, 20)] ;
    
    titleLabel.text  = @"我的免费问";
    //    titleLabel.backgroundColor  = [UIColor blueColor]   ;
    
    titleLabel.textColor = [UIColor blackColor];
    
    titleLabel.font= [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    return self.Freemodels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return  self.tagContainer.cellHeight;
        
    }
    
    return 200;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {

    MLTagCell *cell = [tableView dequeueReusableCellWithIdentifier: @"123"];
    if (!cell) {
        cell = [[MLTagCell alloc] initWithStyle: UITableViewCellStyleDefault
                                reuseIdentifier: @"123"];
        cell.tableView = tableView;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.cellClick = ^(MLTagCell *cell, MLTagButton *tagButton, MLTagModel *tagModel) {
            if ([tagModel isKindOfClass: [MLSubTagModel class
                                          ]]) {
                if (tagModel.isSelected) {
//                    _title = tagModel.title;
                                            _pageNumber = 1;
                    
                    //                            _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                    //                                _pageNumber = 1;
                    //                            }];
                    
                    
                    NSString *url = [NSString stringWithFormat:@"%@/api/freeask/ut/getMyFreeAskList",kIP];
                    
                    NSMutableDictionary *dic = [ZHNetworkTools parameters];
                    [dic setObject:tagModel.code forKey:@"typeCode"];
                    [dic setObject:@(_pageNumber) forKey:@"pageNo"];
                    
                    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                        if (error) {
                            NSLog(@"%@",error);
                            [self.tableView.mj_header endRefreshing];
                            [self.tableView.mj_footer endRefreshing];
                            
                        }
                        
                        NSLog(@"response = %@",response);
                        
                        
                        NSArray<ZHMyFreeAskModel *> *models = [NSArray yy_modelArrayWithClass:[ZHMyFreeAskModel class] json:response[@"data"]];
                        
                        
                        self.Freemodels = [NSMutableArray arrayWithArray:models];
                        
                        
                        [self.tableView reloadData];
                        
                        
                        
                        
                    }];
                    
                    
                    
                } else {
//                    _title = @"未选中标签";
                    
                }
            } else if ([tagModel isKindOfClass: [MLTagModel class]]) {
                if (tagModel.isSelected) {
//                    _title = @"未选中标签";
                    
                    _pageNumber = 1;
                    
                    
                    
                    NSString *url = [NSString stringWithFormat:@"%@/api/freeask/ut/getMyFreeAskList",kIP];
                    
                    NSMutableDictionary *dic = [ZHNetworkTools parameters];
                    [dic setObject:tagModel.code forKey:@"typeCode"];
                    [dic setObject:@(_pageNumber) forKey:@"pageNo"];
                    
                    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                        if (error) {
                            NSLog(@"%@",error);
                        }
                        
                        NSLog(@"response = %@",response);
                        
                        
                        NSArray<ZHMyFreeAskModel *> *models = [NSArray yy_modelArrayWithClass:[ZHMyFreeAskModel class] json:response[@"data"]];
                        
                        self.Freemodels = [NSMutableArray arrayWithArray:models];
                        
                        
                        [self.tableView reloadData];
                        
                    }];
                    
                    
                }
            }
        };
    }
    cell.tagContainer = self.tagContainer;
    return cell;
}

    
    ZHMyFreeAskModel *model = _Freemodels[indexPath.row];
    
    ZHMyFreeAskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyFreeAskCellid forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ZHMyFreeAskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyFreeAskCellid];
    }
    
    
    cell.model = model;
    
    return cell;
    
    
}

- (void)LoadFreeAskData {
    
    
    NSString *url = [NSString stringWithFormat:@"%@/api/commoncategory/getCategories",kIP];
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject: @"1"
            forKey: @"type"];
    
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        
        //        NSLog(@"response = %@",response);
        
//        _title = @"未选中标签";
        NSArray<NSDictionary *> *JSONArray = response[@"data"];
        NSMutableArray<MLTagModel *> *tagModels = [NSMutableArray array];
        
        NSInteger index=0;
        for (NSDictionary *dict in JSONArray) {
            [tagModels addObject: [MLTagModel tagModelWithDictionary: dict
                                                             atIndex: index]];
            index++;
        }
        self.tagContainer.tagModels = [NSArray arrayWithArray: tagModels];
        
        [self.tableView reloadData];
        
    }];
    
    
}

- (void)loadData {
    
    
    NSString *url = [NSString stringWithFormat:@"%@/api/freeask/ut/getMyFreeAskList",kIP];
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
//    [dic setObject:tagModel.code forKey:@"typeCode"];
    [dic setObject:@(_pageNumber) forKey:@"pageNo"];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        
        NSLog(@"response = %@",response);
        
        
        NSArray<ZHMyFreeAskModel *> *models = [NSArray yy_modelArrayWithClass:[ZHMyFreeAskModel class] json:response[@"data"]];
        
        
        //  3.2 判断是刷新 还是 加载更多
        if (_pageNumber == 1) { // 刷新
            self.Freemodels = [NSMutableArray arrayWithArray:models];
        } else { // 加载更多
            
            [self.Freemodels addObjectsFromArray: models];
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


- (MLTagModelContainer *)tagContainer {
    if (!_tagContainer) {
        _tagContainer = [MLTagModelContainer new];
    }
    return _tagContainer;
}

#pragma mark - Lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame: self.view.bounds
                                                  style: UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.tableView.rowHeight = 155;
        //        self.tableView.sectionHeaderHeight = 43;
        //        NSLog(@"self.tableview.height = %f",self.tableView.sectionHeaderHeight);
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHMyFreeAskTableViewCell" bundle:nil] forCellReuseIdentifier:MyFreeAskCellid];
        
    }
    return _tableView;
}

@end
