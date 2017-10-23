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

static NSString *FreeListTableViewCellid = @"FreeListTableViewCellid";


@interface ZHFreeQuestionViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSString *_title;
    NSNumber *_pageNumber;


}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MLTagModelContainer *tagContainer;


@property(nonatomic,strong)NSMutableArray<ZHAskModel *>* Freemodels;

@property(nonatomic,strong)MLTagButton *btn;

@property(nonatomic,strong)MLTagModel *model;

@property(nonatomic,strong)MLSubTagModel *subModel;




@end

@implementation ZHFreeQuestionViewController

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
    
    [self.view addSubview: self.tableView];
    

    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHFreeListTableViewCell" bundle:nil] forCellReuseIdentifier:FreeListTableViewCellid];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    UIView * view = nil;
    
    if (section == 1) {
        
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor redColor];
//            headerView.frame = self.view.frame;
        //
//        UILabel *nameLa = [[UILabel alloc]init];
//        
////        nameLa.frame = CGRectMake(20, 10 ,[UIScreen mainScreen].bounds.size.width, 20);
//        
//        nameLa.text = @"123";
//        
//        [headerView addSubview:nameLa];
        
//        UIView * lineView = [[UIView alloc]init];
//        lineView.frame = CGRectMake(0, 43, [UIScreen mainScreen].bounds.size.width, 1);
//        lineView.backgroundColor = [UIColor grayColor];
//        
//        [headerView addSubview:lineView];
        
        return headerView;
        
        
    }
    
    
    
    return view;
    
    
}



#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
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
    return self.Freemodels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.tagContainer.cellHeight;
    }
    return 155;
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
                        
                        
                        
                        NSString *url = [NSString stringWithFormat:@"%@/api/freeask/getFreeAskList",kIP];
                        
                        NSMutableDictionary *dic = [ZHNetworkTools parameters];
                        [dic setObject:tagModel.code forKey:@"typeCode"];
                        [dic setObject:_pageNumber forKey:@"pageNo"];
                        
                        [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                            if (error) {
                                NSLog(@"%@",error);
                            }
                            
                            NSLog(@"response = %@",response);
                         
                            
                            NSArray<ZHAskModel *> *models = [NSArray yy_modelArrayWithClass:[ZHAskModel class] json:response[@"data"]];
                            
                            self.Freemodels = [NSMutableArray arrayWithArray:models];
                            
                            
                            [self.tableView reloadData];
                            
                        }];
                        
                        
                        
                    } else {
                        _title = @"未选中标签";

                    }
                } else if ([tagModel isKindOfClass: [MLTagModel class]]) {
                    if (tagModel.isSelected) {
                        _title = @"未选中标签";

                        _pageNumber = @(1);
                        
                        
                        
                        NSString *url = [NSString stringWithFormat:@"%@/api/freeask/getFreeAskList",kIP];
                        
                        NSMutableDictionary *dic = [ZHNetworkTools parameters];
                        [dic setObject:tagModel.code forKey:@"typeCode"];
                        [dic setObject:_pageNumber forKey:@"pageNo"];
                        
                        [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                            if (error) {
                                NSLog(@"%@",error);
                            }
                            
                            NSLog(@"response = %@",response);
                            
                            
                            NSArray<ZHAskModel *> *models = [NSArray yy_modelArrayWithClass:[ZHAskModel class] json:response[@"data"]];
                            
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
    
//    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier: @"1"];
//    if (!aCell) {
//        aCell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle
//                                       reuseIdentifier: @"1"];
//    }
//    aCell.textLabel.text = _title;
    
    ZHAskModel *model = _Freemodels[indexPath.row];
    
    ZHFreeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FreeListTableViewCellid forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ZHFreeListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FreeListTableViewCellid];
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
    [dic setObject: @"1"
             forKey: @"type"];
    
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        
        NSLog(@"response = %@",response);
        
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
   
  
    NSString *url = [NSString stringWithFormat:@"%@/api/freeask/getFreeAskList",kIP];
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject: @"1"
            forKey: @"type"];
    
    
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        
        NSLog(@"response = %@",response);
        
        NSArray<ZHAskModel *> *models = [NSArray yy_modelArrayWithClass:[ZHAskModel class] json:response[@"data"]];
        
        self.Freemodels = [NSMutableArray arrayWithArray:models];
        
        [self.tableView reloadData];
        
    }];
    
    
}


@end
