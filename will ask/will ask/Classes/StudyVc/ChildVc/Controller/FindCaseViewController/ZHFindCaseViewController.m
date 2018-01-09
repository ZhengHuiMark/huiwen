 //
//  ZHFindCaseViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/11/24.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHFindCaseViewController.h"
#import "MLTagCell.h"
#import "MLSubTagModel.h"
#import "MLTagModel.h"
#import "MLTagModelContainer.h"
#import "ZHNetworkTools.h"
#import "Macro.h"
#import "MLTagButton.h"
#import "YYModel.h"
#import "ZHCaseListsModel.h"
#import "MJRefresh.h"
#import "ZHCaseListTableViewCell.h"
#import "ZHCaseDetailViewController.h"

static NSString *CaseListCellid = @"CaseListCellid";

@interface ZHFindCaseViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
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

@implementation ZHFindCaseViewController

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

    
}

- (void)setupUI{
    
    
    // Table view
    
    if (self.tableView.style == UITableViewStyleGrouped) {
        UIEdgeInsets contentInset = self.tableView.contentInset;
        contentInset.top =  +40;
        [self.tableView setContentInset:contentInset];
    }
    
    [self.view addSubview: self.tableView];
    
    
    UIView *PlaceHolderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    PlaceHolderView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:PlaceHolderView];
    [PlaceHolderView addSubview:self.searchBar];
    
//    UIButton *editorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [editorBtn addTarget:self action:@selector(toAskQuestion) forControlEvents:UIControlEventTouchUpInside];
//    [editorBtn setTitle:@"提问" forState:UIControlStateNormal];
//    //    editorBtn.titleLabel.text = @"提问";
//    [editorBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [editorBtn sizeToFit];
//    UIBarButtonItem *editBtnItem = [[UIBarButtonItem alloc] initWithCustomView:editorBtn];
//    self.navigationItem.rightBarButtonItem = editBtnItem;
    
    
    //重新创建一个barButtonItem
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    //设置backBarButtonItem即可
    self.navigationItem.backBarButtonItem = backItem;
    
    [[UINavigationBar appearance]setTintColor:[UIColor grayColor]];
    
    
    
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    
    
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

//        if (indexPath.section == 1) {
////    ZHFreeListTableViewCell *cell = (ZHFreeListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:FreeListTableViewCellid];
////    
////    CGSize size = CGSizeMake(cell.bounds.size.width, 300);
////    CGRect rectSize = [cell.contentLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:nil context:nil];
//    
//    return 155 + rectSize.size.height;
//    //    }
        return 200;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0) {
        return;
    }
    
    if (self.CaseListModels[indexPath.row].caseId) {
//        
        ZHCaseDetailViewController *detailCaseVc = [[ZHCaseDetailViewController alloc]init];
        
        detailCaseVc.model = self.CaseListModels[indexPath.row];
        
        [self.navigationController pushViewController:detailCaseVc animated:YES];
        
    }
    
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
//                        _title = tagModel.title;
//                                                _pageNumber = @(1);
                        
//                                                    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//                                                        _pageNumber = 1;
//                                                    }];
                        
                        
                        NSString *url = [NSString stringWithFormat:@"%@/api/learning/column/getCaseInfoList",kIP];
                        
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
                            
                        
                            
                            
                        }];
                        
                        
                        
                    } else {
//                        _title = @"未选中标签";
                        
                    }
                } else if ([tagModel isKindOfClass: [MLTagModel class]]) {
                    if (tagModel.isSelected) {
//                        _title = @"未选中标签";
                        
//                        _pageNumber = 1;
                        _HeaderTitle = tagModel.title;
                        
                        
                        NSString *url = [NSString stringWithFormat:@"%@/api/learning/column/getCaseInfoList",kIP];

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
                            
                        }];
                        
                        
                    }
                }
            };
        }
        cell.tagContainer = self.tagContainer;
        return cell;
    }
    
    _caseModel = _CaseListModels[indexPath.row];
    
    ZHCaseListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CaseListCellid forIndexPath:indexPath];

    
    cell.model = self.caseModel;
    
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
    
    
    NSString *url = [NSString stringWithFormat:@"%@/api/learning/column/getCaseInfoList",kIP];
    
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
        _tableView = [[UITableView alloc] initWithFrame: self.view.bounds
                                                  style: UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.tableView.rowHeight = 155;
        //        self.tableView.sectionHeaderHeight = 43;
        //        NSLog(@"self.tableview.height = %f",self.tableView.sectionHeaderHeight);
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHCaseListTableViewCell" bundle:nil] forCellReuseIdentifier:CaseListCellid];
    }
    return _tableView;
}


- (MLTagModelContainer *)tagContainer {
    if (!_tagContainer) {
        _tagContainer = [MLTagModelContainer new];
    }
    return _tagContainer;
}


- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame: CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width-40, 44)];
        
        _searchBar.delegate = self;
        
        _searchBar.placeholder = @"搜索案例,资讯,问答";
        
        _searchBar.searchBarStyle =UISearchBarStyleMinimal;
        
        _searchBar.layer.cornerRadius = 3;
        _searchBar.layer.masksToBounds = YES;
        _searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
        
    }
    return _searchBar;
}

@end
