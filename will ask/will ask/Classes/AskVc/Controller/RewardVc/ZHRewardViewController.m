//
//  ZHRewardViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/11/2.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHRewardViewController.h"
#import "MLTagModelContainer.h"
#import "MLTagModel.h"
#import "MLSubTagModel.h"
#import "MLTagCell.h"
#import "ZHNetworkTools.h"
#import "Macro.h"
#import "ZHRewardListTableViewCell.h"
#import "ZHAskModel.h"
#import "YYModel.h"
#import "MLTagButton.h"
#import "FreeDetailViewController.h"
#import "ZHAskQuestionTableViewController.h"
#import "ZHRewardDetailViewController.h"

#import "ZHChooseTypeViewController.h"


static NSString *ZHRewardListTableViewCellid = @"ZHRewardListTableViewCellid";

@interface ZHRewardViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    NSString *_title;
    NSNumber *_pageNumber;
    
    
}

// 给提问选择分类界面所传的值
@property(nonatomic,strong) NSString *stringType;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MLTagModelContainer *tagContainer;


@property(nonatomic,strong)NSMutableArray<ZHAskModel *>* RewardModels;



@property(nonatomic,strong)MLTagButton *btn;

@property(nonatomic,strong)MLTagModel *model;

@property(nonatomic,strong)MLSubTagModel *subModel;

@property (nonatomic,strong)UISearchBar *searchBar;

@end



@implementation ZHRewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self LoadFreeAskData];
    
    [self setupUI];
    
    [self LoadData];
}


#pragma mark - Basic setup
- (void)setupUI {
    
    // Table view
    
    if (self.tableView.style == UITableViewStyleGrouped) {
        UIEdgeInsets contentInset = self.tableView.contentInset;
        contentInset.top =  +40;
        [self.tableView setContentInset:contentInset];
    }
    
    [self.view addSubview: self.tableView];
    
    
    UIView *PlaceHolderView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 44)];
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
    
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHRewardListTableViewCell" bundle:nil] forCellReuseIdentifier:ZHRewardListTableViewCellid];
}

#pragma mark - 跳转提问页
- (void)toAskQuestion {
    
    _stringType = @"2";
    
    ZHChooseTypeViewController *AskQuestionVc = [[ZHChooseTypeViewController alloc]init];
    
    AskQuestionVc.typeString = _stringType;
    
    [self.navigationController pushViewController:AskQuestionVc animated:YES];
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    UIView * view = nil;
    
    if (section == 1) {
        
        
            UIView *headerView = [[UIView alloc] init];
            headerView.backgroundColor = [UIColor whiteColor];
            //    headerView.frame = self.view.frame;
            //
            UILabel *nameLa = [[UILabel alloc]init];
            
            nameLa.frame = CGRectMake(20, 10 ,[UIScreen mainScreen].bounds.size.width, 20);
            
            nameLa.text = @"全部悬赏问";
            
            [headerView addSubview:nameLa];
            
            UIView * lineView = [[UIView alloc]init];
            lineView.frame = CGRectMake(0, 43, [UIScreen mainScreen].bounds.size.width, 1);
            lineView.backgroundColor = [UIColor grayColor];
            
            [headerView addSubview:lineView];
            
            return headerView;
        
    }

    return view;
    
    
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (indexPath.section == 0) {
//        
//        return;
//        
//    }
    
    
//    if (self.RewardModels[indexPath.row].uid) {
    
        ZHRewardDetailViewController *FDeetailVc = [[ZHRewardDetailViewController alloc]init];
        
        FDeetailVc.uidStringz = self.RewardModels[indexPath.row].rewardAskId ;
        
        [self.navigationController pushViewController:FDeetailVc animated:YES];
        
//    }
    
    
}


#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        
        return  50;
    }
    
    return 0.1;
    
}

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
    return self.RewardModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.tagContainer.cellHeight;
    }
    
    
    ZHRewardListTableViewCell *cell = (ZHRewardListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:ZHRewardListTableViewCellid];
    
    CGSize size = CGSizeMake(cell.bounds.size.width, 300);
    CGRect rectSize = [cell.content.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:nil context:nil];
    
    return 204 + rectSize.size.height;
    
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
                        
                        _pageNumber = @(1);
                        
                        
                        
                        NSString *url = [NSString stringWithFormat:@"%@/api/rewardask/getRewardAskList",kIP];
                        
                        NSMutableDictionary *dic = [ZHNetworkTools parameters];
                        [dic setObject:tagModel.code forKey:@"typeCode"];
                        [dic setObject:_pageNumber forKey:@"pageNo"];
                        
                        [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                            if (error) {
                                NSLog(@"%@",error);
                            }
                            
                            NSLog(@"response = %@",response);
                            
                            
                            NSArray<ZHAskModel *> *models = [NSArray yy_modelArrayWithClass:[ZHAskModel class] json:response[@"data"]];
                            
                            self.RewardModels = [NSMutableArray arrayWithArray:models];
                            
                            
                            [self.tableView reloadData];
                            
                        }];
                        
                        
                        
                    } else {
                        _title = @"未选中标签";
                        
                    }
                } else if ([tagModel isKindOfClass: [MLTagModel class]]) {
                    if (tagModel.isSelected) {
                        _title = @"未选中标签";
                        
                        _pageNumber = @(1);
                        
                        
                        
                        NSString *url = [NSString stringWithFormat:@"%@/api/rewardask/getRewardAskList",kIP];
                        
                        NSMutableDictionary *dic = [ZHNetworkTools parameters];
                        [dic setObject:tagModel.code forKey:@"typeCode"];
                        [dic setObject:_pageNumber forKey:@"pageNo"];
                        
                        [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                            if (error) {
                                NSLog(@"%@",error);
                            }
                            
                            NSLog(@"response = %@",response);
                            
                            
                            NSArray<ZHAskModel *> *models = [NSArray yy_modelArrayWithClass:[ZHAskModel class] json:response[@"data"]];
                            
                            self.RewardModels = [NSMutableArray arrayWithArray:models];
                            
                            
                            [self.tableView reloadData];
                            
                        }];
                        
                        
                    }
                }
            };
        }
        cell.tagContainer = self.tagContainer;
        
//        cell.userInteractionEnabled = NO;
        return cell;
    }
    
    
    
    ZHAskModel *model = _RewardModels[indexPath.row];
    
    ZHRewardListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZHRewardListTableViewCellid forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ZHRewardListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ZHRewardListTableViewCellid];
    }
    
    [cell setModel:model];
    
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
        self.tableView.sectionHeaderHeight = 43;
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

//#pragma mark - Test methods
//- (void)testData {
//
//    _title = @"未选中标签";
//    NSArray<NSDictionary *> *JSONArray = [self JSONArray];
//    NSMutableArray<MLTagModel *> *tagModels = [NSMutableArray array];
//
//    NSInteger index=0;
//    for (NSDictionary *dict in JSONArray) {
//        [tagModels addObject: [MLTagModel tagModelWithDictionary: dict
//                                                         atIndex: index]];
//        index++;
//    }
//    self.tagContainer.tagModels = [NSArray arrayWithArray: tagModels];
//}

- (void)LoadFreeAskData {
    
    
    NSString *url = [NSString stringWithFormat:@"%@/api/commoncategory/getCategories",kIP];
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject: @"2"
            forKey: @"type"];
    
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        
        //        NSLog(@"response = %@",response);
        
        _title = @"未选中标签";
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



- (void)LoadData {
    
    
    NSString *url = [NSString stringWithFormat:@"%@/api/rewardask/getRewardAskList",kIP];
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject: @"2"
            forKey: @"type"];
    
    
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        
        //        NSLog(@"response = %@",response);
        
        NSArray<ZHAskModel *> *models = [NSArray yy_modelArrayWithClass:[ZHAskModel class] json:response[@"data"]];
        
        self.RewardModels = [NSMutableArray arrayWithArray:models];
        
        [self.tableView reloadData];
        
    }];
    
    
}


- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame: CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width-40, 44)];
        
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
