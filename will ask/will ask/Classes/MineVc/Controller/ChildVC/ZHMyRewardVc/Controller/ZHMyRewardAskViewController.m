//
//  ZHMyRewardAskViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/12/7.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMyRewardAskViewController.h"
#import "MLTagModelContainer.h"
#import "MLTagModel.h"
#import "MLSubTagModel.h"
#import "MLTagCell.h"
#import "Macro.h"
#import "ZHNetworkTools.h"
#import "YYModel.h"
#import "MLTagButton.h"
#import "MJRefresh.h"
#import "ZHMyRewardListTableViewCell.h"
#import "ZHMyRewardRightListTableViewCell.h"
#import "ZHMyRewardListModel.h"

static NSString *MyRewardListCellid = @"MyRewardListCellid";

static NSString *MyRewardRightListCellid = @"MyRewardRightListCellid";


@interface ZHMyRewardAskViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger _pageNo;
//    NSString *answered;

}

@property (nonatomic, strong) MLTagModelContainer *tagContainer;


@property(nonatomic,strong)MLTagButton *btn;

@property(nonatomic,strong)MLTagModel *model;

@property(nonatomic,strong)MLSubTagModel *subModel;

@property(nonatomic,strong)UISegmentedControl *segmentedControl;

@property(nonatomic,strong)UITableView *leftTableView;

@property(nonatomic,strong)UITableView *rightTableView;

@property(nonatomic,assign)NSInteger tag;

@property (nonatomic,strong)NSMutableArray *leftArray;
@property (nonatomic,strong)NSMutableArray *rigthArray;

@end

@implementation ZHMyRewardAskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tag = 0;
    [self initTableView];

    [self setupUI];
    [self LoadFreeAskData];
    
    self.leftTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageNo = 1;
        
        
        [self requestFormNetWorkanswered:@"true" pageNo:_pageNo typeCode:@""];
        
    }];
    self.leftTableView.mj_header.automaticallyChangeAlpha = YES;
    self.leftTableView.mj_footer.automaticallyHidden = YES;
    
    self.leftTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageNo++;
        
        [self requestFormNetWorkanswered:@"true" pageNo:_pageNo typeCode:@""];
        
    }];
    [self.leftTableView.mj_header beginRefreshing];

}

- (void)requestFormNetWorkanswered:(NSString *)answered pageNo:(NSInteger)pageNo typeCode:(NSString *)typeCode{
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:answered forKey:@"answered"];
    [dic setObject:@(pageNo) forKey:@"pageNo"];
    [dic setObject:typeCode forKey:@"typeCode"];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/rewardask/ut/getMyRewardAskList",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
        NSLog(@"response = %@",response);
        NSArray <ZHMyRewardListModel *> *models = [NSArray yy_modelArrayWithClass:[ZHMyRewardListModel class] json:response[@"data"]];
        
        //  3.2 判断是刷新 还是 加载更多
        if (_pageNo == 1) { // 刷新
            _leftArray = [NSMutableArray arrayWithArray:models];
        } else { // 加载更多
            
            [_leftArray addObjectsFromArray: models];
        }
        
        
        [self.leftTableView reloadData];
        
        
        if (!models || !models.count) {
            [self.leftTableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.leftTableView.mj_footer resetNoMoreData];
        }
        [self.leftTableView.mj_header endRefreshing];
        

        
        
    }];
    
}


- (void)initTableView {
    
    self.leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 130, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height - 130) style:UITableViewStylePlain];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.estimatedRowHeight = 44.0f;
    self.leftTableView.rowHeight = UITableViewAutomaticDimension;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    [self.leftTableView registerNib:[UINib nibWithNibName:@"ZHMyRewardListTableViewCell" bundle:nil] forCellReuseIdentifier:MyRewardListCellid];
    
    [self.view addSubview:self.leftTableView];
    
    self.rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 130, [UIScreen mainScreen].bounds.size.width,self.view.frame.size.height - 130) style:UITableViewStylePlain];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.estimatedRowHeight = 44.0f;
    self.rightTableView.rowHeight = UITableViewAutomaticDimension;
    self.rightTableView.backgroundColor = [UIColor redColor];
    self.rightTableView.showsVerticalScrollIndicator = NO;
    
    [self.rightTableView registerNib:[UINib nibWithNibName:@"ZHMyRewardRightListTableViewCell" bundle:nil] forCellReuseIdentifier:MyRewardRightListCellid];
    
    [self.view addSubview:self.rightTableView];
    
    if (self.tag == 0) {
        self.rightTableView.hidden = YES;
    }
}


- (void)setupUI{
    
    
    UIView *backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 60)];
    
    backGroundView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:backGroundView];
    
    
    // 初始化，添加分段名，会自动布局
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"已有答案", @"悬赏中"]];
    self.segmentedControl.frame = CGRectMake(17,13,[UIScreen mainScreen].bounds.size.width - 35,35);
    
    self.segmentedControl.tintColor = [UIColor colorWithRed:242/255.0 green:90/255.0 blue:41/255.0  alpha:1];
    
    // 设置初始选中项
    self.segmentedControl.selectedSegmentIndex = 0;
    
    // 设置点击后恢复原样，默认为NO，点击后一直保持选中状态
    self.segmentedControl.momentary = NO;
    
    
    [self.segmentedControl addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventValueChanged];// 添加响应方法
    
    [backGroundView addSubview:self.segmentedControl];

}


- (void)selectItem:(UISegmentedControl *)sender {

    if (sender.selectedSegmentIndex == 0) {
        self.leftTableView.hidden = NO;
        self.rightTableView.hidden = YES;
        
        [self requestFormNetWorkanswered:@"ture" pageNo:1 typeCode:@""];
        
        self.tag = 0;
        [self.leftTableView reloadData];
    }else if (sender.selectedSegmentIndex == 1){
        self.rightTableView.hidden = NO;
        
        self.leftTableView.hidden = YES;
        
        [self LoadFreeAskDatas];
        
        self.rightTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageNo = 1;
            
            
            [self requestFormNetWorkanswered:@"false" pageNo:_pageNo typeCode:@""];
            
        }];
        self.rightTableView.mj_header.automaticallyChangeAlpha = YES;
        self.rightTableView.mj_footer.automaticallyHidden = YES;
        
        self.rightTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _pageNo++;
            
            [self requestFormNetWorkanswered:@"false" pageNo:_pageNo typeCode:@""];
            
        }];
        [self.rightTableView.mj_header beginRefreshing];

        
        self.tag = 1;
        [self.rightTableView reloadData];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.tag == 0) {
        if (indexPath.section == 0) {
            return self.tagContainer.cellHeight;
        }
        return 211;
    }
    
    if (self.tag == 1) {
        if (indexPath.section == 0) {
            return self.tagContainer.cellHeight;
        }
    }
    return 212;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.tag == 0) {
        if (section == 0) {
            return 1;
        }
        return self.leftArray.count;
    }
    
    if (self.tag == 1) {
        if (section == 0) {
            return 1;
        }
    }
    return self.rigthArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.tag == 0) {
        
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
                            //                        _pageNumber = @(1);
                            
                            //                            _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                            //                                _pageNumber = 1;
                            //                            }];
                            
                            
                            NSString *url = [NSString stringWithFormat:@"%@/api/rewardask/ut/getMyRewardAskList",kIP];
                            
                           NSString * answered = @"ture";
                            
                            NSMutableDictionary *dic = [ZHNetworkTools parameters];
                            [dic setObject:tagModel.code forKey:@"typeCode"];
                            [dic setObject:@(_pageNo) forKey:@"pageNo"];
                            [dic setObject:answered forKey:@"answered"];
                            
                            [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                                if (error) {
                                    NSLog(@"%@",error);
                                    [self.leftTableView.mj_header endRefreshing];
                                    [self.leftTableView.mj_footer endRefreshing];
                                    
                                }
                                
                                NSLog(@"response = %@",response);
                                
                                
                                NSArray<ZHMyRewardListModel *> *models = [NSArray yy_modelArrayWithClass:[ZHMyRewardListModel class] json:response[@"data"]];
                                
                                
                                self.leftArray = [NSMutableArray arrayWithArray:models];
                                
                                
                                [self.leftTableView reloadData];
                                
                                
                                
                                
                            }];
                            
                            
                            
                        } else {
                            //                    _title = @"未选中标签";
                            
                        }
                    } else if ([tagModel isKindOfClass: [MLTagModel class]]) {
                        if (tagModel.isSelected) {
                            //                    _title = @"未选中标签";
                            
                            _pageNo = 1;
                            
                            
                            
                            NSString *url = [NSString stringWithFormat:@"%@/api/rewardask/ut/getMyRewardAskList",kIP];
                            
                            NSMutableDictionary *dic = [ZHNetworkTools parameters];
                            [dic setObject:tagModel.code forKey:@"typeCode"];
                            [dic setObject:@(_pageNo) forKey:@"pageNo"];
                            
                            [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                                if (error) {
                                    NSLog(@"%@",error);
                                }
//                                
                                NSLog(@"response = %@",response);
                                
                                
                                NSArray<ZHMyRewardListModel *> *models = [NSArray yy_modelArrayWithClass:[ZHMyRewardListModel class] json:response[@"data"]];
                                
                                _leftArray = [NSMutableArray arrayWithArray:models];
                                
                                
                                [self.leftTableView reloadData];
//
                            }];
                            
                            
                        }
                    }
                };
            }
            cell.tagContainer = self.tagContainer;
            return cell;
        }

        ZHMyRewardListModel *model = _leftArray[indexPath.row];
        
        ZHMyRewardListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyRewardListCellid forIndexPath:indexPath];

    

        cell.listModel = model;
        
        return cell;
    }else if (self.tag == 1) {
        
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
                            //                        _pageNumber = @(1);
                            
                            //                            _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                            //                                _pageNumber = 1;
                            //                            }];
                            
                            
                            NSString *url = [NSString stringWithFormat:@"%@/api/rewardask/ut/getMyRewardAskList",kIP];
                            
                            NSString * answered = @"ture";
                            
                            NSMutableDictionary *dic = [ZHNetworkTools parameters];
                            [dic setObject:tagModel.code forKey:@"typeCode"];
                            [dic setObject:@(_pageNo) forKey:@"pageNo"];
                            [dic setObject:answered forKey:@"answered"];
                            
                            [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                                if (error) {
                                    NSLog(@"%@",error);
                                    [self.rightTableView.mj_header endRefreshing];
                                    [self.rightTableView.mj_footer endRefreshing];
                                    
                                }
                                
                                NSLog(@"response = %@",response);
                                
                                
                             NSArray<ZHMyRewardListModel *> *models = [NSArray yy_modelArrayWithClass:[ZHMyRewardListModel class] json:response[@"data"]];
                                
                                
                                      self.rigthArray = [NSMutableArray arrayWithArray:models];
                                
                                
                                             [self.rightTableView reloadData];
                                
                                
                                
                                
                            }];
                            
                            
                            
                        } else {
                            //                    _title = @"未选中标签";
                            
                        }
                    } else if ([tagModel isKindOfClass: [MLTagModel class]]) {
                        if (tagModel.isSelected) {
                            //                    _title = @"未选中标签";
                            
                            _pageNo = 1;
                            
                            
                            
                            NSString *url = [NSString stringWithFormat:@"%@/api/rewardask/ut/getMyRewardAskList",kIP];
                            
                            NSMutableDictionary *dic = [ZHNetworkTools parameters];
                            [dic setObject:tagModel.code forKey:@"typeCode"];
                            [dic setObject:@(_pageNo) forKey:@"pageNo"];
                            
                            [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                                if (error) {
                                    NSLog(@"%@",error);
                                }
                                //
                                NSLog(@"response = %@",response);
                                
                                
                                NSArray<ZHMyRewardListModel *> *models = [NSArray yy_modelArrayWithClass:[ZHMyRewardListModel class] json:response[@"data"]];
                                
                                _rigthArray = [NSMutableArray arrayWithArray:models];
                                
                                
                                [self.rightTableView reloadData];
                                //
                            }];
                            
                            
                        }
                    }
                };
            }
            cell.tagContainer = self.tagContainer;
            return cell;
        }

        
        
        ZHMyRewardListModel *model = _rigthArray[indexPath.row];

        
        ZHMyRewardRightListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyRewardRightListCellid forIndexPath:indexPath];

        if (cell == nil) {
            cell = [[ZHMyRewardRightListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyRewardRightListCellid];
        }
        cell.listModel = model;
        
        
        return cell;
    }
    return nil;
    
}

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
        
        [self.leftTableView reloadData];
        
    }];
    
    
}


- (void)LoadFreeAskDatas {
    
    
    NSString *url = [NSString stringWithFormat:@"%@/api/commoncategory/getCategories",kIP];
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject: @"2"
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
        
        [self.rightTableView reloadData];
        
    }];
    
    
}



- (MLTagModelContainer *)tagContainer {
    if (!_tagContainer) {
        _tagContainer = [MLTagModelContainer new];
    }
    return _tagContainer;
}

- (NSMutableArray *)leftArray {
    if (!_leftArray) {
        _leftArray = [NSMutableArray array];
    }
    return _leftArray;
}

- (NSMutableArray *)rigthArray {
    if (!_leftArray) {
        _leftArray = [NSMutableArray array];
    }
    return _leftArray;
}

@end
