//
//  ZHTableView.m
//  Test Home Page
//
//  Created by  Liguoan on 13/02/2017.
//  Copyright © 2017 LinkBike. All rights reserved.
//

#import "ZHFoucsTableView.h"
#import "ZHNetworkTools.h"
#import "YYModel.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "ZHRewardListTableViewCell.h"
#import "ZHFreeListTableViewCell.h"
#import "ZHExpertTodayTableViewCell.h"
#import "ZHCaseListTableViewCell.h"
#import "ZHAllModel.h"

static NSString *FreeListTableViewCellid = @"FreeListTableViewCellid";
static NSString *ExpertsCellid = @"ExpertsCellid";
static NSString *CaseListCellid = @"CaseListCellid";
static NSString *ZHRewardListTableViewCellid = @"ZHRewardListTableViewCellid";
@interface ZHFoucsTableView () <UITableViewDelegate, UITableViewDataSource> {
    NSString *_baseUrl;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *dropMenuBackground;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dropMenuHeight;

@property (nonatomic ,strong)NSMutableArray<ZHAllModel *> *dataSouse;

@end



@implementation ZHFoucsTableView
#pragma mark - Constructor
+ (instancetype)tableViewWithDropMenu:(NSArray <NSArray <id <ZHDropMenuProtocol>>*>*)dropMenuData frame:(CGRect)frame inView:(UIView *)superView {
    
    ZHFoucsTableView *tableView = [[[NSBundle mainBundle] loadNibNamed: NSStringFromClass([self class])
                                                            owner: nil
                                                          options: nil] firstObject];
    tableView.frame = frame;
    [superView addSubview: tableView];
    tableView.dropMenuData = dropMenuData;
    return tableView;
}

#pragma mark - Override methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadData) name:@"loginSuccess" object:nil];
    
    // Setup table view
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView registerNib:[UINib nibWithNibName:@"ZHRewardListTableViewCell" bundle:nil] forCellReuseIdentifier:ZHRewardListTableViewCellid];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHFreeListTableViewCell" bundle:nil] forCellReuseIdentifier:FreeListTableViewCellid];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHExpertTodayTableViewCell" bundle:nil] forCellReuseIdentifier:ExpertsCellid];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHCaseListTableViewCell" bundle:nil] forCellReuseIdentifier:CaseListCellid];

//
//    
    self.tableView.estimatedRowHeight = 260 ; //44为任意值
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // 下拉刷新
    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    _tableView.mj_header.automaticallyChangeAlpha = YES;
}

#pragma mark - Override Setter/Getter Methods
-(void)setDropMenuData:(NSArray<NSArray<id<ZHDropMenuProtocol>> *> *)dropMenuData {
    _dropMenuData = dropMenuData;
    
    if (!_dropMenuData || !_dropMenuData.count) {
        self.dropMenuHeight.constant = 0;
        [self layoutIfNeeded];
    }
}

#define kUrls @[ \
    @"http://192.168.0.21:7000/api/search/searchByRewardAsk", \
    @"http://192.168.0.21:7000/api/search/searchByFreeAsk", \
    @"http://192.168.0.21:7000/api/search/searchByExpert", \
    @"http://192.168.0.21:7000/api/search/searchByCaseInfo", \
]

- (void)setRequestType:(NSInteger)requestType {
    _requestType = requestType;
    
    _baseUrl = kUrls[requestType];
    
    // 测试代码
    [self loadData];

}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 270.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 200;
    
}

#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSouse.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;

    ZHAllModel *model = _dataSouse[indexPath.row];
    
    if (model.rewardAskId) {
        ZHRewardListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZHRewardListTableViewCellid forIndexPath:indexPath];
        
        return cell;
    }
    
    if (model.freeAskId) {
        ZHFreeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FreeListTableViewCellid forIndexPath:indexPath];
        
        return cell;
    }
    
    if (model.expertId) {
        ZHExpertTodayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ExpertsCellid forIndexPath:indexPath];
        
        return cell;
    }
    
    if (model.caseId) {
        ZHExpertTodayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CaseListCellid forIndexPath:indexPath];
        
        return cell;
    }
    
    
    
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    
    self.FocusCellSelectPush(_dataSouse[indexPath.row]);
}

- (void)loadData {
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:@"什么" forKey:@"content"];
    [dic setObject:@(1) forKey:@"pageNo"];
 
    [SVProgressHUD show];
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl: _baseUrl andParams:dic andCallBlock:^(id response, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];

        // 2. 判断错误
        if (error) {
            NSLog(@"网络请求异常: %@", error);
            return;
        }
        NSLog(@"%@",response);
        // 3. 解析数据模型
//          3.1 从 JSON 中解析数据
        NSArray<ZHAllModel *> *models = [NSArray yy_modelArrayWithClass:[ZHAllModel class] json:response[@"data"]];
        
        //  3.2 刷新数据源
        _dataSouse = [NSMutableArray arrayWithArray: models];
        
        // 4. 刷新TableView
        [self.tableView reloadData];
        
        
    }];
}

@end
