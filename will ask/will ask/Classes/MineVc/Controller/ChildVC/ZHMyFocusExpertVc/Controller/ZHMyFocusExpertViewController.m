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

@interface ZHMyFocusExpertViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger _pageNumber;
}

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray <ZHMyFocusModel *>* listModels;



@end

@implementation ZHMyFocusExpertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我关注的专家";
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
    
    

    
}

- (void)loadData{
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:@(_pageNumber) forKey:@"pageNO"];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/ut/follow/getFollowExpertList",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
         
            NSLog(@"%@",error);
        }
        
        NSLog(@"%@",response);
        NSArray <ZHMyFocusModel *>* models = [NSArray yy_modelArrayWithClass:[ZHMyFocusModel class] json:response[@"data"]];
        
        if (_pageNumber == 1) {
            self.listModels = [NSMutableArray arrayWithArray:models];
        }else{
            [self.listModels addObjectsFromArray:models];
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
    
    cell.didClick = ^(){
      
        NSMutableDictionary *dic = [ZHNetworkTools parameters];
        [dic setObject:_listModels[indexPath.row].userId forKey:@"expertId"];
        
        NSString *url = [NSString stringWithFormat:@"%@/api/ut/follow/unfollow",kIP];
        
        [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
           
            if (error) {
                NSLog(@"%@",error);
            }
            
            NSLog(@"%@",response);
            [SVProgressHUD showInfoWithStatus:@"取消成功"];
            [SVProgressHUD dismissWithDelay:1.0];
            
            [self.tableView reloadData];
        }];
        
        
        
    };
    
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
