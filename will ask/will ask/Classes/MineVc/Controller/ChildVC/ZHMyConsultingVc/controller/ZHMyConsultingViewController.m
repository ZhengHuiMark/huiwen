//
//  ZHMyConsultingViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/12/11.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMyConsultingViewController.h"
#import "ZHMyConsultingListTableViewCell.h"
#import "MJRefresh.h"
#import "Macro.h"
#import "YYModel.h"
#import "ZHNetworkTools.h"
#import "ZHMyConsultModel.h"

#import "ZHMyConsultDetailViewController.h"

static NSString *conultListCellid = @"conultListCellid";

@interface ZHMyConsultingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _pageNo;
}

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UISegmentedControl *segmentedControl;

@property(nonatomic,strong)NSMutableArray <ZHMyConsultModel *> *listModels;


@end

@implementation ZHMyConsultingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self.view addSubview:self.tableView];

    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageNo = 1;
        
        
        [self requestFormNetWorkanswered:@"true" pageNo:_pageNo];
        
    }];
    _tableView.mj_header.automaticallyChangeAlpha = YES;
    _tableView.mj_footer.automaticallyHidden = YES;
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageNo++;
        
        [self requestFormNetWorkanswered:@"true" pageNo:_pageNo];
        
    }];
    [_tableView.mj_header beginRefreshing];
    
}

- (void)setupUI{
    UIView *backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 60)];
    
    backGroundView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:backGroundView];
    
    
    // 初始化，添加分段名，会自动布局
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"已回答", @"待回答"]];
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
        NSLog(@"正在销售");
        
        _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageNo = 1;
            
            
            [self requestFormNetWorkanswered:@"true" pageNo:_pageNo];
            
        }];
        _tableView.mj_header.automaticallyChangeAlpha = YES;
        _tableView.mj_footer.automaticallyHidden = YES;
        
        [_tableView.mj_header beginRefreshing];
        
        
    } else if (sender.selectedSegmentIndex == 1){
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageNo = 1;
            
            
            [self requestFormNetWorkanswered:@"false" pageNo:_pageNo];
            
        }];
        _tableView.mj_header.automaticallyChangeAlpha = YES;
        _tableView.mj_footer.automaticallyHidden = YES;
        
        [_tableView.mj_header beginRefreshing];
        
        NSLog(@"已下架");
    }
}


- (void)requestFormNetWorkanswered:(NSString *)answered pageNo:(NSInteger)pageNo{
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:answered forKey:@"answered"];
    [dic setObject:@(pageNo) forKey:@"pageNo"];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/ut/consult/getMyConsultList",kIP];
    
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        NSLog(@" response = %@",response);
        
        NSArray<ZHMyConsultModel *>*models = [NSArray yy_modelArrayWithClass:[ZHMyConsultModel class] json:response[@"data"]];
        
        //  3.2 判断是刷新 还是 加载更多
        if (_pageNo == 1) { // 刷新
            self.listModels = [NSMutableArray arrayWithArray:models];
        } else { // 加载更多
            
            [self.listModels addObjectsFromArray: models];
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




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _listModels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZHMyConsultModel *model = _listModels[indexPath.row];
    
    ZHMyConsultingListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:conultListCellid forIndexPath:indexPath];
    
    cell.listModel = model;
    
    return cell;
}


- (UITableView *)tableView {
    //
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 130, self.view.frame.size.width, self.view.frame.size.height - 130) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        _tableView.rowHeight = 180;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //    NSBundle *bundle = [NSBundle mainBundle];
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHMyConsultingListTableViewCell" bundle:nil] forCellReuseIdentifier:conultListCellid];
        
    }
    
    return _tableView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    ZHMyConsultDetailViewController *detailvc = [[ZHMyConsultDetailViewController alloc]init];
    
    [self.navigationController pushViewController:detailvc animated:YES];
    
}


- (NSMutableArray<ZHMyConsultModel *> *)listModels {
    
    if (!_listModels) {
        _listModels = [NSMutableArray array];
    }
    
    return _listModels;
}



@end
