//
//  ZHTableView.m
//  Test Home Page
//
//  Created by  Liguoan on 13/02/2017.
//  Copyright © 2017 LinkBike. All rights reserved.
//

#import "ZHFoucsTableView.h"
#import "ZHNetworkTools.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"


#import "ZHRewardListTableViewCell.h"
#import "ZHFreeListTableViewCell.h"
#import "ZHExpertTodayTableViewCell.h"
#import "ZHCaseListTableViewCell.h"
#import "Macro.h"

#import "ZHAskModel.h"
#import "ZHStudyModel.h"
#import "ZHCaseListsModel.h"


@interface ZHFoucsTableView () <UITableViewDelegate, UITableViewDataSource> {
    NSString *_baseUrl;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;



@property (nonatomic ,strong)NSMutableArray<ZHModel *> *dataSouse;

@end

static NSString *CaseListCellid = @"CaseListCellid";

static NSString *ExpertsCellid = @"ExpertsCellid";

static NSString *FreeListTableViewCellid = @"FreeListTableViewCellid";

static NSString *ZHRewardListTableViewCellid = @"ZHRewardListTableViewCellid";

@implementation ZHFoucsTableView
#pragma mark - Constructor
+ (instancetype)tableViewWithDropMenu:(NSArray <NSArray <id <ZHDropMenuProtocol>>*>*)dropMenuData frame:(CGRect)frame inView:(UIView *)superView {
    
    ZHFoucsTableView *tableView = [[[NSBundle mainBundle] loadNibNamed: NSStringFromClass([self class])
                                                            owner: nil
                                                          options: nil] firstObject];
    tableView.frame = frame;
    [superView addSubview: tableView];
//    tableView.dropMenuData = dropMenuData;
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

    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHRewardListTableViewCell.h" bundle:nil] forCellReuseIdentifier:ZHRewardListTableViewCellid];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHFreeListTableViewCell.h" bundle:nil] forCellReuseIdentifier:FreeListTableViewCellid];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHExpertTodayTableViewCell.h" bundle:nil] forCellReuseIdentifier:ExpertsCellid];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHCaseListTableViewCell.h" bundle:nil] forCellReuseIdentifier:CaseListCellid];


    
    self.tableView.estimatedRowHeight = 260 ; //44为任意值
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // 下拉刷新
    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    _tableView.mj_header.automaticallyChangeAlpha = YES;
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
//    ZHModel *model = _dataSouse[indexPath.row];

    
    return 250;
    
}

#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSouse.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
//    ZHModel *model = self.dataSouse[indexPath.row];
//   
//    
//    
//    switch (model.cellType) {
//        case CellTypeReward:
//            cell = [tableView dequeueReusableCellWithIdentifier:rewardCellID forIndexPath:indexPath];
//            [(ZHRewardTableViewCell *)cell setZh_model:model];
//            break;
//        case CellTypeInvitation:
//            cell = [tableView dequeueReusableCellWithIdentifier:InvitationCellId forIndexPath:indexPath];
//            [(ZHExpertsInvitationTableViewCell *)cell setExpertsModel:model];
//        case CellTypePeep:
//            cell = [tableView dequeueReusableCellWithIdentifier:PeepCellID forIndexPath:indexPath];
//            [(ZHPeepTableViewCell *)cell setZh_model:model];
//        case CellTypeZHGraphic:
//            cell = [tableView dequeueReusableCellWithIdentifier:contentCellID forIndexPath:indexPath];
//            [(ZHGraphicTableViewCell *)cell setZh_model:model];
//        case CellTypeText:
//            cell = [tableView dequeueReusableCellWithIdentifier:textCellID forIndexPath:indexPath];
//            [(ZHTextTableViewCell *)cell setZh_model:model];
//        
//        default: {
//        
//        }
//            break;
//    }
    
    return cell;
}

//#pragma mark - UITableView Delegate
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath: indexPath animated: YES];
//    
//    self.FocusCellSelectPush(_dataSouse[indexPath.row]);
//}

- (void)loadData {
    
 
    [SVProgressHUD show];
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl: _baseUrl andParams:nil andCallBlock:^(id response, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];

        // 2. 判断错误
        if (error) {
            NSLog(@"网络请求异常: %@", error);
            return;
        }
        
        // 3. 解析数据模型
        //  3.1 从 JSON 中解析数据
//        NSArray<ZHModel *> *models = [NSArray yy_modelArrayWithClass:[ZHModel class] json:response[@"data"]];
        
        //  3.2 刷新数据源
//        _dataSouse = [NSMutableArray arrayWithArray: models];
        
        // 4. 刷新TableView
        [self.tableView reloadData];
        
        
    }];
}

@end
