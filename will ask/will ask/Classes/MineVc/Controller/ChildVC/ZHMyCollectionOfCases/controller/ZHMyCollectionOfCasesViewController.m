//
//  ZHMyCollectionOfCasesViewController.m
//  will ask
//
//  Created by 郑晖 on 2018/1/25.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHMyCollectionOfCasesViewController.h"
#import "MLTagCell.h"
#import "MLSubTagModel.h"
#import "MLTagModel.h"
#import "MLTagModelContainer.h"
#import "MLTagButton.h"
#import "ZHCaseListsModel.h"
#import "ZHCaseListTableViewCell.h"
#import "ZHCaseDetaiPageleViewController.h"
#import "ZHMyCollectionCaseListTableViewCell.h"

static NSString *ZHMyCollectionCaseListCellid = @"ZHMyCollectionCaseListCellid";


@interface ZHMyCollectionOfCasesViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    NSInteger _pageNumber;
    
}

@property (nonatomic, strong) MLTagModelContainer *tagContainer;


@property(nonatomic,strong)MLTagButton *btn;


@property(nonatomic,strong)NSMutableArray <ZHCaseListsModel *>* CaseListModels;


@property(nonatomic,strong)MLTagModel *model;

@property(nonatomic,strong)MLSubTagModel *subModel;

@property (nonatomic,strong)UISearchBar *searchBar;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong)NSString *HeaderTitle;


@end

@implementation ZHMyCollectionOfCasesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageNumber = 1;
        
        [self LoadData];
        
    }];
    _tableView.mj_header.automaticallyChangeAlpha = YES;
    _tableView.mj_footer.automaticallyHidden = YES;
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageNumber++;
        [self LoadData];
    }];
    [_tableView.mj_header beginRefreshing];
    
    [self LoadFreeAskData];
    self.title = @"我收藏的案例";

}

- (void)setupUI{
    
    
    // Table view
    
    if (self.tableView.style == UITableViewStyleGrouped) {
        UIEdgeInsets contentInset = self.tableView.contentInset;
        contentInset.top =  +40;
        [self.tableView setContentInset:contentInset];
    }
    
    [self.view addSubview: self.tableView];
    
    
//    UIView *PlaceHolderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
//    PlaceHolderView.backgroundColor = [UIColor whiteColor];
//    
//    [self.view addSubview:PlaceHolderView];
//    [PlaceHolderView addSubview:self.searchBar];

    
    //重新创建一个barButtonItem
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    //设置backBarButtonItem即可
    self.navigationItem.backBarButtonItem = backItem;
    
    [[UINavigationBar appearance]setTintColor:[UIColor grayColor]];
    
    
    
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return .1;
    }
    
    return 20;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    
    return _CaseListModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.tagContainer.cellHeight;
    }

    return 234;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        return;
    }
    
    ZHCaseDetaiPageleViewController *caseDetailVc = [[ZHCaseDetaiPageleViewController alloc]init];
    caseDetailVc.urlId = _CaseListModels[indexPath.row].caseId;
    caseDetailVc.time = _CaseListModels[indexPath.row].readingTime;
    caseDetailVc.title = _CaseListModels[indexPath.row].title;
    caseDetailVc.words = _CaseListModels[indexPath.row].words;
    
    [self.navigationController pushViewController:caseDetailVc animated:YES];
    
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
              
                        
                        NSString *url = [NSString stringWithFormat:@"%@/api/caseInfo/ut/getMyFavoriteCaseInfoPageList",kIP];
                        
                        NSMutableDictionary *dic = [ZHNetworkTools parameters];
                        [dic setObject:tagModel.code forKey:@"typeCode"];
                        [dic setObject:@(_pageNumber) forKey:@"pageNo"];
                        
                        [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                            if (error) {
                                NSLog(@"%@",error);
                                //                                [self.tableView.mj_header endRefreshing];
                                //                                [self.tableView.mj_footer endRefreshing];
                                
                            }
                            
                            NSLog(@"response = %@",response);
                            
                            
                            NSArray<ZHCaseListsModel *> *models = [NSArray yy_modelArrayWithClass:[ZHCaseListsModel class] json:response[@"data"]];
                            
                            
                            self.CaseListModels = [NSMutableArray arrayWithArray:models];
                            
                            
                            [self.tableView reloadData];
                            [_tableView.mj_header beginRefreshing];

                            
                            
                            
                        }];
                        
                        
                        
                    } else {
                        //                        _title = @"未选中标签";
                        
                    }
                } else if ([tagModel isKindOfClass: [MLTagModel class]]) {
                    if (tagModel.isSelected) {
                        //                        _title = @"未选中标签";
                        
                        //                        _pageNumber = 1;
                        _HeaderTitle = tagModel.title;
                        
                        
                        NSString *url = [NSString stringWithFormat:@"%@/api/caseInfo/ut/getMyFavoriteCaseInfoPageList",kIP];
                        
                        NSMutableDictionary *dic = [ZHNetworkTools parameters];
                        [dic setObject:tagModel.code forKey:@"typeCode"];
                        [dic setObject:@(_pageNumber) forKey:@"pageNo"];
                        
                        [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                            if (error) {
                                NSLog(@"%@",error);
                            }
                            
                            NSLog(@"response = %@",response);
                            
                            
                            NSArray<ZHCaseListsModel *> *models = [NSArray yy_modelArrayWithClass:[ZHCaseListsModel class] json:response[@"data"]];
                            
                            self.CaseListModels = [NSMutableArray arrayWithArray:models];
                            
                            
                            [self.tableView reloadData];
                            [_tableView.mj_header beginRefreshing];

                            
                        }];
                        
                        
                    }
                }
            };
        }
        cell.tagContainer = self.tagContainer;
        return cell;
    }
    
    _caseModel = _CaseListModels[indexPath.row];
    
    ZHMyCollectionCaseListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZHMyCollectionCaseListCellid forIndexPath:indexPath];
    cell.model = self.caseModel;
    
    cell.continueDidClick = ^{
        
        ZHCaseDetaiPageleViewController *caseDetailVc = [[ZHCaseDetaiPageleViewController alloc]init];
        caseDetailVc.urlId = _CaseListModels[indexPath.row].caseId;
        caseDetailVc.time = _CaseListModels[indexPath.row].readingTime;
        caseDetailVc.title = _CaseListModels[indexPath.row].title;
        caseDetailVc.words = _CaseListModels[indexPath.row].words;
        
        [self.navigationController pushViewController:caseDetailVc animated:YES];
        
    };
    
    cell.cancelDidClick = ^{
        
        NSMutableDictionary *dic = [ZHNetworkTools parameters];
        [dic setObject:_CaseListModels[indexPath.row].caseId forKey:@"caseId"];
        
        NSString *url = [NSString stringWithFormat:@"%@/api/caseInfo/ut/unfavorite",kIP];
        [SVProgressHUD show];

        [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
            [SVProgressHUD dismiss];
            if (error) {
                NSLog(@"%@",error);
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                
                return ;
            }
            
            if ([response[@"success"] integerValue] == 1) {
                [SVProgressHUD showSuccessWithStatus:@"已取消收藏"];
                [SVProgressHUD dismissWithDelay:1.5f];
                
                [self.tableView reloadData];
                [_tableView.mj_header beginRefreshing];

            }
            
            
        }];
        
    };
    
    return cell;
    
    
}


- (void)LoadFreeAskData {
    
    
    NSString *url = [NSString stringWithFormat:@"%@/api/commoncategory/getCategories",kIP];
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject: @"3"
            forKey: @"type"];
    
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        
        NSLog(@"response = %@",response);
        
        //        _title = @"未选中标签";
        NSArray<NSDictionary *> *JSONArray = response[@"data"];
        NSMutableArray<MLTagModel *> *tagModels = [NSMutableArray array];
        
        NSInteger index=0;
        NSArray *imgs = @[@"accounting", @"tax", @"audit", @"assessment", @"software"];
        for (NSDictionary *dict in JSONArray) {
            MLTagModel *aModel = [MLTagModel tagModelWithDictionary: dict
                                                            atIndex: index];
            aModel.imgName = imgs[index];
            [tagModels addObject: aModel];
            
            index++;
        }
        self.tagContainer.tagModels = [NSArray arrayWithArray: tagModels];
        
        [self.tableView reloadData];
        
    }];
    
    
}


- (void)LoadData {
    
    
    NSString *url = [NSString stringWithFormat:@"%@/api/caseInfo/ut/getMyFavoriteCaseInfoPageList",kIP];
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    
    [dic setObject:@(_pageNumber) forKey:@"pageNo"];
    
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        
        NSLog(@"response = %@",response);
        
        NSArray<ZHCaseListsModel *> *models = [NSArray yy_modelArrayWithClass:[ZHCaseListsModel class] json:response[@"data"]];
        
        //  3.2 判断是刷新 还是 加载更多
        if (_pageNumber == 1) { // 刷新
            self.CaseListModels = [NSMutableArray arrayWithArray:models];
        } else { // 加载更多
            
            [self.CaseListModels addObjectsFromArray: models];
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




#pragma mark - Lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];

        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.tableView.rowHeight = 155;
        //        self.tableView.sectionHeaderHeight = 43;
        //        NSLog(@"self.tableview.height = %f",self.tableView.sectionHeaderHeight);
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHMyCollectionCaseListTableViewCell" bundle:nil] forCellReuseIdentifier:ZHMyCollectionCaseListCellid];
    }
    return _tableView;
}


- (MLTagModelContainer *)tagContainer {
    if (!_tagContainer) {
        _tagContainer = [MLTagModelContainer new];
    }
    return _tagContainer;
}


@end
