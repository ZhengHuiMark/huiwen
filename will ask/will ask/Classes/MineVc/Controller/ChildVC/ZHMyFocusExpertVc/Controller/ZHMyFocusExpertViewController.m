//
//  ZHMyFocusExpertViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/12/18.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMyFocusExpertViewController.h"
#import "ZHMyFocusModel.h"
#import "ZHMyFocusListTableViewCell.h"
#import "ZHNetworkTools.h"
#import "Macro.h"
#import "YYModel.h"
#import "MJRefresh.h"

static NSString *myFocusCellid = @"myFocusCellid";

@interface ZHMyFocusExpertViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray <ZHMyFocusModel *>* listModels;

@end

@implementation ZHMyFocusExpertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];
    
    [self.view addSubview:self.tableView];
}

- (void)loadData{
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/ut/follow/getFollowExpertList",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
         
            NSLog(@"%@",error);
        }
        
        NSLog(@"%@",response);
        NSArray <ZHMyFocusModel *>* models = [NSArray yy_modelArrayWithClass:[ZHMyFocusModel class] json:response[@"data"]];
        
        self.listModels = [NSMutableArray arrayWithArray:models];

        [self.tableView reloadData];
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listModels.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZHMyFocusModel *model = _listModels[indexPath.row];
    
    ZHMyFocusListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myFocusCellid forIndexPath:indexPath];
   
    cell.model = model;
    
    
    return cell;
    
    
}

- (UITableView *)tableView {
    //
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        _tableView.rowHeight = 115;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //    NSBundle *bundle = [NSBundle mainBundle];
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHMyFocusListTableViewCell" bundle:nil] forCellReuseIdentifier:myFocusCellid];

        
    }
    
    return _tableView;
}



- (NSMutableArray<ZHMyFocusModel *> *)listModels {
    
    if (!_listModels) {
        _listModels = [NSMutableArray array];
    }
    
    return _listModels;
}


@end
