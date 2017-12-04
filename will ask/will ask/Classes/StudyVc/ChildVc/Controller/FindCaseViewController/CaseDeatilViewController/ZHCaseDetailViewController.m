//
//  ZHCaseDetailViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/11/30.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHCaseDetailViewController.h"
#import "ZHCaseListTableViewCell.h"
#import "ZHCaseDetailTableViewCell.h"
#import "ZHCaseListsModel.h"
#import "ZHSubCaseModel.h"
#import "Macro.h"
#import "ZHNetworkTools.h"
#import "YYModel.h"
#import "ZHCaseDetailsModel.h"

static NSString *CaseListCellid = @"CaseListCellid";

static NSString *ZHCaseDetailCellid = @"ZHCaseDetailCellid";



@interface ZHCaseDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray <ZHCaseListsModel *>* CaseListModels;


@property(nonatomic,strong)NSArray <ZHCaseDetailsModel *> *DetailModels;



@end

@implementation ZHCaseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController setTitle:@"专家详解版案例"];
    
    [self LoadData];
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    
    return _DetailModels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        ZHCaseListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CaseListCellid forIndexPath:indexPath];
        
        
        cell.model = self.model;
        cell.ExpertBtn.hidden = YES;
        
        return cell;

    }
    
    
    _detailModel = _DetailModels[indexPath.row];
    
    ZHCaseDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZHCaseDetailCellid forIndexPath:indexPath];
    
    cell.DetailModel = _detailModel;
  
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        return 200;
    }
    
    return 300;
}


- (void)LoadData{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/learning/column/uto/getCaseAnalysisList",kIP];
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:self.model.caseId forKey:@"caseId"];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
        NSLog(@"response = %@",response);
        
       _DetailModels = [NSArray yy_modelArrayWithClass:[ZHCaseDetailsModel class] json:response[@"data"]];
        
        
        [self.tableView reloadData];
        
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
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHCaseDetailTableViewCell" bundle:nil] forCellReuseIdentifier:ZHCaseDetailCellid];

    }
    return _tableView;
}




@end
