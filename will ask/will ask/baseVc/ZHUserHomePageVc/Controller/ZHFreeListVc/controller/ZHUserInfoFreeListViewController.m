//
//  ZHUserInfoFreeListViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/12/25.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHUserInfoFreeListViewController.h"
#import "ZHMoreFreeListTableViewCell.h"
#import "ZHMoerFreeListModel.h"
#import "ZHNetworkTools.h"
#import "Macro.h"
#import "YYModel.h"
#import "FreeDetailViewController.h"

static NSString *moreFreeListCellid = @"moreFreeListCellid";
@interface ZHUserInfoFreeListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray <ZHMoerFreeListModel *>*mListModels;



@end

@implementation ZHUserInfoFreeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self loadData];
    [self.view addSubview:self.tableView];
    

}

- (void)loadData {
    ///api/freeask/getUserHomePageMoreFreeAsk
    NSString *userId = @"110341478336696320";

NSMutableDictionary *dic = [ZHNetworkTools parameters];
[dic setObject:userId forKey:@"userId"];
NSString *url = [NSString stringWithFormat:@"%@/api/freeask/getUserHomePageMoreFreeAsk",kIP];


[[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
    
    if (error) {
        NSLog(@"%@",error);
    }
    
    NSArray <ZHMoerFreeListModel *>*models = [NSArray yy_modelArrayWithClass:[ZHMoerFreeListModel class] json:response[@"data"]];
    
    _mListModels = [NSMutableArray arrayWithArray:models];
    
    [self.tableView reloadData];
    
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _mListModels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZHMoerFreeListModel *model = _mListModels[indexPath.row];
    
    ZHMoreFreeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moreFreeListCellid forIndexPath:indexPath];
    
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    FreeDetailViewController *freeDetailVc = [[FreeDetailViewController alloc]init];
    freeDetailVc.uidString = self.mListModels[indexPath.row].freeAskId;
    
    [self.navigationController pushViewController:freeDetailVc animated:YES];
    
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
        [_tableView registerNib:[UINib nibWithNibName:@"ZHMoreFreeListTableViewCell" bundle:nil] forCellReuseIdentifier:moreFreeListCellid];
        //
        
        
    }
    
    return _tableView;
}



@end
