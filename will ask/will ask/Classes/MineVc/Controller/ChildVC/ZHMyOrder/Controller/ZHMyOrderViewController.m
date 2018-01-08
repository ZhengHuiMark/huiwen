

//
//  ZHMyOrderViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/12/5.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMyOrderViewController.h"
#import "ZHMyorderTableViewCell.h"
#import "ZHMyOrderModel.h"
#import "ZHNetworkTools.h"
#import "Macro.h"
#import "YYModel.h"
#import "MJRefresh.h"
#import "ZHOrderPaymentViewController.h"

#import "ZHOrderDetailViewController.h"


static NSString *myOrderCellid = @"myOrderCellid";

@interface ZHMyOrderViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger _pageNo;
}
@property(nonatomic,strong)UIButton *tempBtn;

@property(nonatomic,strong)UIButton *allBtn;

@property(nonatomic,strong)NSMutableArray<UIButton *> *btnMutableArray;
@property (nonatomic, strong)NSMutableArray<UIView*> *arrSepViews;

@property(nonatomic,strong)NSMutableArray * orderModels;

@property(nonatomic,strong)UITableView *tableView;




@end

@implementation ZHMyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:245 green:245 blue:245 alpha:1];
    
    
    [self setupUI];
    
    [self.view addSubview:self.tableView];
    
    
    
    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageNo = 1;
        
        
        [self requestFormNetWorkstatus:@"" pageNo:_pageNo];
    }];
    
    _tableView.mj_header.automaticallyChangeAlpha = YES;
    _tableView.mj_footer.automaticallyHidden = YES;
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageNo++;
        
        [self requestFormNetWorkstatus:@"" pageNo:_pageNo];
        
    }];
    [_tableView.mj_header beginRefreshing];

    
}

- (void)requestFormNetWorkstatus:(NSString *)status pageNo:(NSInteger)pageNo{
    
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:status forKey:@"status"];
    [dic setObject:@(pageNo) forKey:@"pageNo"];
    
    
    NSString *url = [NSString stringWithFormat:@"%@/api/ut/order/getMyOrderList",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
        NSLog(@"%@",response);
        NSArray <ZHMyOrderModel *> * models = [NSArray yy_modelArrayWithClass:[ZHMyOrderModel class] json:response[@"data"]];
        
        //        self.orderModels = [NSMutableArray arrayWithArray:models];
        //  3.2 判断是刷新 还是 加载更多
        if (_pageNo == 1) { // 刷新
            self.orderModels = [NSMutableArray arrayWithArray:models];
        } else { // 加载更多
            
            [self.orderModels addObjectsFromArray: models];
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
    
    return _orderModels.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
    ZHMyorderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myOrderCellid];
    
    if (cell == nil) {
        
        cell = [[ZHMyorderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myOrderCellid];
    }
    
    
    ZHMyOrderModel *model = _orderModels[indexPath.row];
    
    cell.orderModel = model;
    
    cell.didClick = ^(){
      
        ZHOrderPaymentViewController *orderPaymentVc = [[ZHOrderPaymentViewController alloc]init];
        orderPaymentVc.payModel = _orderModels[indexPath.row];
        [self.navigationController pushViewController:orderPaymentVc animated:YES];
        
    };
//
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];

    ZHOrderDetailViewController *orderDetailVc = [[ZHOrderDetailViewController alloc]init];
    orderDetailVc.payModel = _orderModels[indexPath.row];
    [self.navigationController pushViewController:orderDetailVc animated:YES];
}


- (void)setupUI{
    
    UIView *HeaderView = [[UIView  alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    
    HeaderView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:HeaderView];
    
    
    
    _btnMutableArray = [[NSMutableArray alloc]init]; //将button放到数组里面
    _arrSepViews = [[NSMutableArray alloc] init];

    NSArray * array = [NSArray arrayWithObjects:@"全部",@"待支付",@"已完成", nil];
    
    for (NSInteger i = 0; i < 3; i++) {
        
        _allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _allBtn.frame = CGRectMake(self.view.frame.size.width /3 *i, 0, self.view.frame.size.width/3, 50);
        _allBtn.tag = i;
        _allBtn.backgroundColor = [UIColor colorWithWhite:100*i alpha:0];
        [_allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_allBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
      
        
        [_allBtn addTarget:self action:@selector(btnActions:) forControlEvents:UIControlEventTouchUpInside];
        [HeaderView addSubview:_allBtn];
        [_allBtn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        
        [_btnMutableArray addObject:_allBtn];
 
        UIView *view = [UIView new];
        view.frame = (CGRect){CGRectGetMinX(_allBtn.frame), CGRectGetMaxY(_allBtn.frame)-1, CGRectGetWidth(_allBtn.frame), 1};
        view.hidden = YES;
        [view setBackgroundColor: [UIColor redColor]];
        [HeaderView addSubview: view];
        [_arrSepViews addObject: view];
        
        if (!i) {
            _allBtn.selected = YES;
            view.hidden = NO;
        }
    }
    
//    ((UIButton *)[_btnMutableArray objectAtIndex:0]).selected = YES;  // 关键是这里，设置 数组的第一个button为选中状态

    
//    _tempBtn = nil;

    
    
}



- (void)btnActions:(UIButton *)sender{
    
    if (sender.selected) return;
    
    NSInteger tag = sender.tag;
    
//    ((UIButton *)[_btnMutableArray objectAtIndex:0]).selected=NO; //点击其他button之后这里设置为非选中状态，否则会出现2个红色的选中状态
//    [self.btnMutableArray makeObjectsPerformSelector: @selector(setSelected:) withObject: @(NO)];
    for (UIButton *btn in self.btnMutableArray) {
        btn.selected = NO;
    }

    [self.arrSepViews makeObjectsPerformSelector: @selector(setHidden:) withObject: @(YES)];
    sender.selected = YES;
    [[self.arrSepViews objectAtIndex: sender.tag] setHidden: NO];
    
    if (tag == 0) {
        
        _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageNo = 1;
            
            
            [self requestFormNetWorkstatus:@"" pageNo:_pageNo];
            
        }];
        _tableView.mj_header.automaticallyChangeAlpha = YES;
        _tableView.mj_footer.automaticallyHidden = YES;
        
        [_tableView.mj_header beginRefreshing];
        

    }
    
    if (tag == 1) {
        
        _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageNo = 1;
            
            
            [self requestFormNetWorkstatus:@"0" pageNo:_pageNo];
            
        }];
        _tableView.mj_header.automaticallyChangeAlpha = YES;
        _tableView.mj_footer.automaticallyHidden = YES;
        
        [_tableView.mj_header beginRefreshing];
        
        
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _pageNo++;
            
            [self requestFormNetWorkstatus:@"0" pageNo:_pageNo];
            
        }];
        [_tableView.mj_header beginRefreshing];

    }
    
    if (tag == 2) {
        
        _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageNo = 1;
            
            
            [self requestFormNetWorkstatus:@"1" pageNo:_pageNo];
            
        }];
        _tableView.mj_header.automaticallyChangeAlpha = YES;
        _tableView.mj_footer.automaticallyHidden = YES;
        
        [_tableView.mj_header beginRefreshing];

        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _pageNo++;
            
            [self requestFormNetWorkstatus:@"2" pageNo:_pageNo];
            
        }];
        [_tableView.mj_header beginRefreshing];
        

    }
    

    
}



#pragma mark - Lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 114)
                                                            style: UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.tableView.rowHeight = 222;
        //        self.tableView.sectionHeaderHeight = 43;
        //        NSLog(@"self.tableview.height = %f",self.tableView.sectionHeaderHeight);
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHMyorderTableViewCell" bundle:nil] forCellReuseIdentifier:myOrderCellid];
    }
    return _tableView;
}





@end
