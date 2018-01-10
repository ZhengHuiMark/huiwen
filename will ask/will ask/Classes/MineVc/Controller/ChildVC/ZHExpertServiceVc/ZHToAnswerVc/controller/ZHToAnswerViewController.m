//
//  ZHToAnswerViewController.m
//  will ask
//
//  Created by 郑晖 on 2018/1/10.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHToAnswerViewController.h"
#import "ZHToAnswerTableViewCell.h"
#import "ZHHaveToAnswerTableViewCell.h"
#import "ZHNetworkTools.h"
#import "MJRefresh.h"
#import "Macro.h"
#import "YYModel.h"
#import "ZHToAnsModel.h"

static NSString *toAnswerCellid = @"toAnswerCellid";
static NSString *haveToAnswerCellid = @"haveToAnswerCellid";

@interface ZHToAnswerViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
        NSInteger _pageNo;
        NSURLSessionDataTask *_leftTask;
        NSURLSessionDataTask *_rightTask;
}

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UISegmentedControl *segmentedControl;

@property (nonatomic,strong)NSMutableArray *leftArray;
@property (nonatomic,strong)NSMutableArray *rigthArray;

@property(nonatomic,assign)NSInteger tag;

@property(nonatomic,strong)UITableView *leftTableView;

@property(nonatomic,strong)UITableView *rightTableView;

@end

@implementation ZHToAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tag = 0;
    [self initTableView];
    [self setupUI];
    
    self.leftTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageNo = 1;
        
        
        [self requestFormNetWorkanswered:@"false" pageNo:_pageNo];
        
    }];
    self.leftTableView.mj_header.automaticallyChangeAlpha = YES;
    self.leftTableView.mj_footer.automaticallyHidden = YES;
    
    self.leftTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageNo++;
        
        [self requestFormNetWorkanswered:@"false" pageNo:_pageNo];
        
    }];
    [self.leftTableView.mj_header beginRefreshing];
    
    self.rightTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageNo = 1;
        //        [self LoadFreeAskDatas];
        [self requestFormNetWorkanswered:@"true" pageNo:_pageNo];
    }];
    self.rightTableView.mj_header.automaticallyChangeAlpha = YES;
    self.rightTableView.mj_footer.automaticallyHidden = YES;
    self.rightTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageNo++;
        [self requestFormNetWorkanswered:@"true" pageNo:_pageNo];
        
    }];

    
    
    
}

- (void)setupUI{
    
    
    UIView *backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, 60)];
    
    backGroundView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:backGroundView];
    
    
    // 初始化，添加分段名，会自动布局
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"待回答", @"已回答"]];
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
        
       
        [self.leftTableView.mj_header beginRefreshing];
        
        self.tag = 0;
    }else if (sender.selectedSegmentIndex == 1){
        self.rightTableView.hidden = NO;
        
        self.leftTableView.hidden = YES;
        [self.rightTableView.mj_header beginRefreshing];
        self.tag = 1;
        
        
//                [self.rightTableView reloadData];
    }
    
}

- (void)requestFormNetWorkanswered:(NSString *)answered pageNo:(NSInteger)pageNo{
    [_leftTask cancel];
    [_rightTask cancel];
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:answered forKey:@"answered"];
    [dic setObject:@(pageNo) forKey:@"pageNo"];

    NSString *url = [NSString stringWithFormat:@"%@/api/ut/consult/getConsultMyList",kIP];

    NSURLSessionDataTask *task = [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            [self.leftTableView.mj_header endRefreshing];
            [self.rightTableView.mj_header endRefreshing];
            
        } else {
            
            NSLog(@"response = %@",response);
            NSArray <ZHToAnsModel *> *models = [NSArray yy_modelArrayWithClass:[ZHToAnsModel class] json:response[@"data"]];
            
            if (_leftTask) {
                //  3.2 判断是刷新 还是 加载更多
                if (_pageNo == 1) { // 刷新
                    _leftArray = [NSMutableArray arrayWithArray:models];
                } else { // 加载更多
                    
                    [_leftArray addObjectsFromArray: models];
                }
                
                
                [self.leftTableView reloadData];
                
                
                if (!models || !models.count) {
                    [self.leftTableView.mj_footer endRefreshingWithNoMoreData];
                    [self.rightTableView.mj_footer endRefreshingWithNoMoreData];
                } else {
                    [self.leftTableView.mj_footer resetNoMoreData];
                    [self.rightTableView.mj_footer resetNoMoreData];
                }
                [self.leftTableView.mj_header endRefreshing];
                [self.rightTableView.mj_header endRefreshing];
            }
            
            if (_pageNo == 1) { // 刷新
                _rigthArray = [NSMutableArray arrayWithArray:models];
            } else { // 加载更多
                
                [_rigthArray addObjectsFromArray: models];
            }
            
            
            [self.rightTableView reloadData];
            
            
            if (!models || !models.count) {
                [self.leftTableView.mj_footer endRefreshingWithNoMoreData];
                [self.rightTableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [self.leftTableView.mj_footer resetNoMoreData];
                [self.rightTableView.mj_footer resetNoMoreData];
            }
            [self.leftTableView.mj_header endRefreshing];
            [self.rightTableView.mj_header endRefreshing];
          
        }
        
        
        
        
    }];
    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        _leftTask = task;
    } else if (self.segmentedControl.selectedSegmentIndex == 1) {
        _rightTask = task;
    }

    
}

// 17710875374
- (void)initTableView {
    
    [self.view addSubview: [UIView new]];
    
    self.leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,  64, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height - 70 - 64) style:UITableViewStylePlain];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.estimatedRowHeight = 44.0f;
    self.leftTableView.rowHeight = UITableViewAutomaticDimension;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    [self.leftTableView registerNib:[UINib nibWithNibName:@"ZHToAnswerTableViewCell" bundle:nil] forCellReuseIdentifier:toAnswerCellid];
    
    [self.view addSubview:self.leftTableView];
    
    self.rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,  64, [UIScreen mainScreen].bounds.size.width,self.view.frame.size.height - 70 - 64) style:UITableViewStylePlain];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.estimatedRowHeight = 44.0f;
    self.rightTableView.rowHeight = UITableViewAutomaticDimension;
    self.rightTableView.contentInset = self.leftTableView.contentInset;
    //    self.rightTableView.backgroundColor = [UIColor redColor];
    self.rightTableView.showsVerticalScrollIndicator = NO;
        [self.rightTableView registerNib:[UINib nibWithNibName:@"ZHHaveToAnswerTableViewCell" bundle:nil] forCellReuseIdentifier:haveToAnswerCellid];

    
    [self.view addSubview:self.rightTableView];
    
    if (self.tag == 0) {
        self.rightTableView.hidden = YES;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.leftTableView) {
        
        return self.leftArray.count;
    }
    
    return self.rigthArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTableView) {
        ZHToAnsModel *model = _leftArray[indexPath.row];
        ZHToAnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:toAnswerCellid forIndexPath:indexPath];
        
        cell.model = model;
        
        return cell;
        
    }else if (tableView == self.rightTableView){
        
        ZHToAnsModel *model = _rigthArray[indexPath.row];
        ZHHaveToAnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:haveToAnswerCellid forIndexPath:indexPath];
        
        cell.model = model;

        
        return cell;
    }
    
    
    return nil;
    
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
