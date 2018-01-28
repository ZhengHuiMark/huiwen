//
//  ZHFreeQuestionViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/10/18.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHFreeQuestionViewController.h"
#import "MLTagModelContainer.h"
#import "MLTagModel.h"
#import "MLSubTagModel.h"
#import "MLTagCell.h"
#import "ZHNetworkTools.h"
#import "Macro.h"
#import "ZHFreeListTableViewCell.h"
#import "ZHAskModel.h"
#import "YYModel.h"
#import "MLTagButton.h"
#import "FreeDetailViewController.h"
#import "MJRefresh.h"
#import "ZHChooseTypeViewController.h"
#import "ZHUserHomePageViewController.h"
#import "ZHExpertUserInfoHomePageViewController.h"



static NSString *FreeListTableViewCellid = @"FreeListTableViewCellid";




@interface ZHFreeQuestionViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    NSString *_title;
    NSInteger _pageNumber;


}

// 给提问选择分类界面所传的值
@property(nonatomic,strong) NSString *stringType;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MLTagModelContainer *tagContainer;


@property(nonatomic,strong)NSMutableArray<ZHAskModel *>* Freemodels;



@property(nonatomic,strong)MLTagButton *btn;

@property(nonatomic,strong)MLTagModel *model;

@property(nonatomic,strong)MLSubTagModel *subModel;

@property (nonatomic,strong)UISearchBar *searchBar;




@end

@implementation ZHFreeQuestionViewController

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

//    [self LoadData];


}




#pragma mark - Basic setup
- (void)setupUI {
    
    // Table view
    self.title = @"免费问";
    
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
    
    UIButton *editorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editorBtn addTarget:self action:@selector(toAskQuestion) forControlEvents:UIControlEventTouchUpInside];
    [editorBtn setTitle:@"提问" forState:UIControlStateNormal];
//    editorBtn.titleLabel.text = @"提问";
    [editorBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [editorBtn sizeToFit];
    UIBarButtonItem *editBtnItem = [[UIBarButtonItem alloc] initWithCustomView:editorBtn];
    self.navigationItem.rightBarButtonItem = editBtnItem;
    
    
    //重新创建一个barButtonItem
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    //设置backBarButtonItem即可
    self.navigationItem.backBarButtonItem = backItem;
    
   [[UINavigationBar appearance]setTintColor:[UIColor grayColor]];
    

    

    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin)
                                                         forBarMetrics:UIBarMetricsDefault];
    

    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHFreeListTableViewCell" bundle:nil] forCellReuseIdentifier:FreeListTableViewCellid];
}



- (void)toAskQuestion {
    
    _stringType = @"1";
    
    ZHChooseTypeViewController *AskQuestionVc = [[ZHChooseTypeViewController alloc]init];
    
    AskQuestionVc.typeString = _stringType;
    
    [self.navigationController pushViewController:AskQuestionVc animated:YES];
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    UIView * view = nil;
    
    if (section == 1) {
        
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor redColor];
        
//        UILabel *label
        
        

        return headerView;
        
        
    }
    
    
    
    return view;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 50;
    }
    return 0.1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0) {
        return;
    }
    
    if (self.Freemodels[indexPath.row].freeAskId) {
        
        FreeDetailViewController *FDeetailVc = [[FreeDetailViewController alloc]init];

        FDeetailVc.uidString = self.Freemodels[indexPath.row].freeAskId ;
        
        [self.navigationController pushViewController:FDeetailVc animated:YES];
        
    }
    
    
}


#pragma mark - UITableViewDataSource
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 100;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.Freemodels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.tagContainer.cellHeight;
    }
    
//    if (indexPath.section == 1) {
        ZHFreeListTableViewCell *cell = (ZHFreeListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:FreeListTableViewCellid];
        
        CGSize size = CGSizeMake(cell.bounds.size.width, 300);
        CGRect rectSize = [cell.contentLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:nil context:nil];
        
        return 155 + rectSize.size.height;
//    }
//    return 155;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
                        _title = tagModel.title;
//                        _pageNumber = @(1);
                        
//                            _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//                                _pageNumber = 1;
//                            }];
                        
                        
                        NSString *url = [NSString stringWithFormat:@"%@/api/freeask/getFreeAskList",kIP];
                        
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
                         
                            
                            NSArray<ZHAskModel *> *models = [NSArray yy_modelArrayWithClass:[ZHAskModel class] json:response[@"data"]];
                            
                            
                            self.Freemodels = [NSMutableArray arrayWithArray:models];
                            
                            
                            [self.tableView reloadData];
                            
                            [_tableView.mj_header beginRefreshing];

                            
                            
                        }];
                        
                        
                        
                    } else {
                        _title = @"未选中标签";

                    }
                } else if ([tagModel isKindOfClass: [MLTagModel class]]) {
                    if (tagModel.isSelected) {
                        _title = @"未选中标签";

                        _pageNumber = 1;
                        
                        
                        
                        NSString *url = [NSString stringWithFormat:@"%@/api/freeask/getFreeAskList",kIP];
                        
                        NSMutableDictionary *dic = [ZHNetworkTools parameters];
                        [dic setObject:tagModel.code forKey:@"typeCode"];
                        [dic setObject:@(_pageNumber) forKey:@"pageNo"];
                        
                        [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                            if (error) {
                                NSLog(@"%@",error);
                            }
                            
                            NSLog(@"response = %@",response);
                            
                            
                            NSArray<ZHAskModel *> *models = [NSArray yy_modelArrayWithClass:[ZHAskModel class] json:response[@"data"]];
                            
                            self.Freemodels = [NSMutableArray arrayWithArray:models];
                            
                            
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
    

    
    ZHAskModel *model = _Freemodels[indexPath.row];
    
    ZHFreeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FreeListTableViewCellid forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ZHFreeListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FreeListTableViewCellid];
    }

    [cell setModel:model];
    
    cell.didClick = ^{
        
        if (model.certifiedNames) {
            ZHExpertUserInfoHomePageViewController *expertVc = [[ZHExpertUserInfoHomePageViewController alloc]init];
            expertVc.expertID = model.userId;
            [self.navigationController pushViewController:expertVc animated:YES];
        }else{
            ZHUserHomePageViewController *userVc = [[ZHUserHomePageViewController alloc]init];
            userVc.userId = model.userId;
            [self.navigationController pushViewController:userVc animated:YES];

        }
        
        
    };
    
    return cell;
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
        
        
    }
    return _tableView;
}

- (MLTagModelContainer *)tagContainer {
    if (!_tagContainer) {
        _tagContainer = [MLTagModelContainer new];
    }
    return _tagContainer;
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
        
        
        _title = @"未选中标签";
        NSArray<NSDictionary *> *JSONArray = response[@"data"];
        NSMutableArray<MLTagModel *> *tagModels = [NSMutableArray array];
        
        NSInteger index=0;
        NSArray *imgs = @[@"accounting", @"tax", @"audit", @"assessment", @"software"];

        for (NSDictionary *dict in JSONArray) {
//            [tagModels addObject: [MLTagModel tagModelWithDictionary: dict
//                                                             atIndex: index]];
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
   
  
    NSString *url = [NSString stringWithFormat:@"%@/api/freeask/getFreeAskList",kIP];
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:@(_pageNumber) forKey:@"pageNo"];
    
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        
//        NSLog(@"response = %@",response);
        
        NSArray<ZHAskModel *> *models = [NSArray yy_modelArrayWithClass:[ZHAskModel class] json:response[@"data"]];
        
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
