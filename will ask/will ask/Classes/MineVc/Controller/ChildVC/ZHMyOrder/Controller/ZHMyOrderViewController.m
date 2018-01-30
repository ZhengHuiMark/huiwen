

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

@property (nonatomic, strong) UIView *lineView;




@end

@implementation ZHMyOrderViewController {
    
    NSString *_loadDataStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _loadDataStr = @"";
    
    self.title = @"我的订单";
    
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
        [_allBtn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        
        [_btnMutableArray addObject:_allBtn];
 
        _lineView = [UIView new];
        _lineView.frame = (CGRect){CGRectGetMinX(_allBtn.frame) + 35 , CGRectGetMaxY(_allBtn.frame)-1, CGRectGetWidth(_allBtn.frame) / 2, 1};
        _lineView.hidden = YES;
        _lineView.tag = i;
        [_lineView setBackgroundColor: [UIColor redColor]];
        [HeaderView addSubview: _lineView];
        [_arrSepViews addObject: _lineView];
        [HeaderView addSubview:_allBtn];

        if (i == 0) {
            _allBtn.selected = YES;
            _lineView.hidden = NO;
        }
    }

}

- (void)btnActions:(UIButton *)sender{
    
    if (sender.selected) return;
    
    NSInteger tag = sender.tag;
    
//    ((UIButton *)[_btnMutableArray objectAtIndex:0]).selected=NO; //点击其他button之后这里设置为非选中状态，否则会出现2个红色的选中状态
//    [self.btnMutableArray makeObjectsPerformSelector: @selector(setSelected:) withObject: @(NO)];
    for (UIButton *btn in self.btnMutableArray) {
        btn.selected = NO;
    }

    
    for (_lineView in _arrSepViews) {
        
        if (_lineView.tag == sender.tag) {
            _lineView.hidden = NO;
        }else {
            _lineView.hidden = YES;
        }
    }
    
//    [[self.arrSepViews objectAtIndex: sender.tag] setHidden:@(NO)];

    sender.selected = YES;
    
//    [self.arrSepViews makeObjectsPerformSelector: @selector(setHidden:) withObject: @(YES)];
    [_tableView.mj_header removeFromSuperview];
    
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
//        [_tableView.mj_header removeFromSuperview];
        _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageNo = 1;
            
            
            [self requestFormNetWorkstatus:@"0" pageNo:_pageNo];
            
        }];
        _tableView.mj_header.automaticallyChangeAlpha = YES;
        _tableView.mj_footer.automaticallyHidden = YES;
        
//        [_tableView.mj_header beginRefreshing];
        
        
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _pageNo++;
            
            [self requestFormNetWorkstatus:@"0" pageNo:_pageNo];
            
            
        }];
        [_tableView.mj_header beginRefreshing];


    }
    
    if (tag == 2) {
        
//        [_tableView.mj_header removeFromSuperview];
        _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageNo = 1;
            
            
            [self requestFormNetWorkstatus:@"1" pageNo:_pageNo];
            
        }];
        _tableView.mj_header.automaticallyChangeAlpha = YES;
        _tableView.mj_footer.automaticallyHidden = YES;
    
//        [_tableView.mj_header beginRefreshing];

        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _pageNo++;
            
            [self requestFormNetWorkstatus:@"1" pageNo:_pageNo];
            
        }];
                    [_tableView.mj_header beginRefreshing];


    }
//    */
//    
//    switch (sender.tag) {
//        case 0:
//            [self requestFormNetWorkstatus:@"" pageNo:_pageNo];
//            [_tableView.mj_header beginRefreshing];
////            _loadDataStr = @"";
//            break;
//        case 1:
//            [self requestFormNetWorkstatus:@"0" pageNo:_pageNo];
//            [_tableView.mj_header beginRefreshing];
//            break;
//        case 2:
//            [self requestFormNetWorkstatus:@"1" pageNo:_pageNo];
//            [_tableView.mj_header beginRefreshing];
//            break;
//    }
    
}



#pragma mark - Lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame: CGRectMake(0,50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100)
                                                            style: UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.tableView.rowHeight = 222;
    
        
        
//        _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            _pageNo = 1;
//        
//            [self requestFormNetWorkstatus:_loadDataStr pageNo:_pageNo];
//        }];
//        
//        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            _pageNo++;
//            
//            [self requestFormNetWorkstatus:_loadDataStr pageNo:_pageNo];
//        }];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHMyorderTableViewCell" bundle:nil] forCellReuseIdentifier:myOrderCellid];
        
    }
    return _tableView;
}





@end
