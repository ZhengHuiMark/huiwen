//
//  AskViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/8/22.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "AskViewController.h"
#import "ZHJumpTableViewCell.h"
#import "ZHLatestPriceTableViewCell.h"
#import "ZHFreeListTableViewCell.h"
#import "Macro.h"
#import "ZHNetworkTools.h"
#import "ZHAskQuestionTableViewController.h"
#import "ZHBtnModel.h"
#import "ZHBtn.h"
#import "ZHBtnContainer.h"
#import "ZHRewardCellTableViewCell.h"
#import "YYModel.h"
#import "ZHAskModel.h"
#import "ZHFreeQuestionViewController.h"
#import "ZHRewardViewController.h"
#import "MJRefresh.h"
#import "FreeDetailViewController.h"
#import "ZHRewardDetailViewController.h"
#import "ZHExpertViewController.h"

static NSString *JumpCellid = @"JumpCellid";

static NSString *LatesPriceCellid = @"LatesPriceCellid";

static NSString *FreeListTableViewCellid = @"FreeListTableViewCellid";



@interface AskViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, strong)ZHBtnModel *model;
@property (nonatomic, strong) NSMutableArray<ZHBtn *> *tagButtons;

@property (nonatomic, strong)NSMutableArray<ZHAskModel *>* Freemodels;


@property (nonatomic, strong) ZHBtnContainer *tagContainer;

@property(nonatomic,strong) UISearchBar *searchBar;

@end

@implementation AskViewController

+ (instancetype)sharedInstance
{
    static AskViewController *instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[AskViewController alloc] init];
    });
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
    
    
    
    [self LoadFreeAskData];
    
    
    
    [self loadData];

    
    [self configUI];

    _tagContainer =  [ZHBtnContainer new];
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mingzizijiqi:) name:@"postVc" object:nil];

//    [self.navigationController.navigationBar addSubview:self.searchBar];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    

}

- (void)mingzizijiqi:(NSNotification *)notification{
    
    
    if([notification.object isKindOfClass:[self class]]) {
        
        ZHRewardDetailViewController *rewardDVc = [[ZHRewardDetailViewController alloc]init];
        rewardDVc.uidStringz = notification.userInfo[@"rewardAskId"];
        
        [self.navigationController pushViewController:rewardDVc animated:YES];
    }
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)configUI{
    
 
    UIButton *editorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editorBtn addTarget:self action:@selector(toMessage) forControlEvents:UIControlEventTouchUpInside];
    [editorBtn setImage:[UIImage imageNamed:@"news3"] forState:UIControlStateNormal];
    [editorBtn sizeToFit];

    UIBarButtonItem *editBtnItem = [[UIBarButtonItem alloc] initWithCustomView:editorBtn];
    self.navigationItem.rightBarButtonItem = editBtnItem;

    
    self.tableView.delegate = self;

    [self.tableView registerNib:[UINib nibWithNibName:@"ZHJumpTableViewCell" bundle:nil] forCellReuseIdentifier:JumpCellid];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHLatestPriceTableViewCell" bundle:nil] forCellReuseIdentifier:LatesPriceCellid];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHFreeListTableViewCell" bundle:nil] forCellReuseIdentifier:FreeListTableViewCellid];
    
    self.tableView.rowHeight = 110;
    self.tableView.sectionHeaderHeight = 43;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    


}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    
    return [super initWithStyle:UITableViewStyleGrouped];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    
//    if (section == 1) {
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor whiteColor];
    
        UILabel *nameLa = [[UILabel alloc]init];
        
        nameLa.frame = CGRectMake(20, 10 ,[UIScreen mainScreen].bounds.size.width, 20);
        
        nameLa.text = @"最新悬赏榜";
        
        [headerView addSubview:nameLa];
        
        UIView * lineView = [[UIView alloc]init];
        lineView.frame = CGRectMake(0, 43, [UIScreen mainScreen].bounds.size.width, 1);
        lineView.backgroundColor = [UIColor grayColor];
        
        [headerView addSubview:lineView];
    
    if (section == 1) {
        nameLa.text = @"最新悬赏榜";
    }else if (section == 2) {
        nameLa.text = @"最新免费问";
    }else {
        return [UIView new];
    }
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    

//    if (section == 1) {
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor whiteColor];
    
    
    
    UIButton *button = [[UIButton alloc]init];
    
    button.frame = CGRectMake(0, 1, [UIScreen mainScreen].bounds.size.width, 44);
    [button setTitle:@"dadas" forState:UIControlStateNormal];
//    [button setBackgroundColor:[UIColor redColor]];
    
        [headerView addSubview:button];
        
        UIView * lineView = [[UIView alloc]init];
        lineView.frame = CGRectMake(0, 45, [UIScreen mainScreen].bounds.size.width, 5 );
        lineView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        
        [headerView addSubview:lineView];
    
        UIView * lineView1 = [[UIView alloc]init];
        lineView1.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1);
        lineView1.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    
        [headerView addSubview:lineView1];

    
        if (section == 1) {
            [button setTitle:@"查看全部悬赏榜 >" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(toReward) forControlEvents:UIControlEventTouchUpInside];

        }else if (section == 2) {
            [button setTitle:@"查看全部免费问 >" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(toFree) forControlEvents:UIControlEventTouchUpInside];


        }else {
            return [UIView new];
        }
        
        return headerView;

   

}

- (void)toReward{
    ZHRewardViewController *rewardVc = [[ZHRewardViewController alloc]init];
    
    [self.navigationController pushViewController:rewardVc animated:YES];

}
- (void)toFree{
    ZHFreeQuestionViewController *freeVc = [[ZHFreeQuestionViewController alloc]init];
    
    [self.navigationController pushViewController:freeVc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        ZHJumpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JumpCellid forIndexPath:indexPath];
        
        if (cell == nil) {
            
            cell = [[ZHJumpTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JumpCellid];

           
            cell.indexPath = indexPath;


        }
        cell.RewardBtnClick = ^(){
//            ZHAskQuestion TableViewController *AskVc = [[ZHAskQuestionTableViewController alloc]init];
            ZHRewardViewController *rewardVc = [[ZHRewardViewController alloc]init];
            
            [self.navigationController pushViewController:rewardVc animated:YES];
        };
        
        
        cell.FreeBtnClick = ^(){
            
            ZHFreeQuestionViewController *freeVc = [[ZHFreeQuestionViewController alloc]init];
            
            [self.navigationController pushViewController:freeVc animated:YES];
        };
        
        cell.AskExpertBtnClick = ^{
            ZHExpertViewController *expertListVc = [[ZHExpertViewController alloc]init];
            
            [self.navigationController pushViewController:expertListVc animated:YES];
            
        };
        
        
        return cell;
    
    }else if (indexPath.section == 1){
        
        ZHRewardCellTableViewCell *cell = [[ZHRewardCellTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                                                           reuseIdentifier: @"123"];
        if (!cell) {
            
            cell.tableView = tableView;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tagContainer = self.tagContainer;
        
        
        return cell;
        
    }
    
    
    ZHAskModel *model = _Freemodels[indexPath.row];

    ZHFreeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FreeListTableViewCellid forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ZHFreeListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FreeListTableViewCellid];
    }
    
    [cell setModel:model];
    
    return cell;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
  
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    if (section == 2) {
        return self.Freemodels.count;
    }
    
    return 1;
}

// cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 && indexPath.section == 0) {
        
        return 110;
    }else if (indexPath.section == 1){
        return 190 + self.tagContainer.cellHeight;
    }
    return 155;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        return 50;
    }
    
    if (section == 2) {
        return 50;
    }
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 10;
        case 1:
            return 50;
        case 2:
            return 50;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      [tableView deselectRowAtIndexPath: indexPath animated: YES];
    
    if (indexPath.section == 0) {
        return;
    }
    
    if (indexPath.section == 1) {
        return;
    }
    
    if (indexPath.section == 2) {
        FreeDetailViewController *freeDVc = [[FreeDetailViewController alloc]init];
        freeDVc.uidString = self.Freemodels[indexPath.row].freeAskId;
        
        [self.navigationController pushViewController:freeDVc animated:YES];
        
    }
    
    
}




- (void)loadData{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/rewardask/getRewardAskByLatest",kIP];
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        
        NSLog(@"response = %@",response);
        
        NSArray<ZHBtnModel *> *models = [NSArray yy_modelArrayWithClass:[ZHBtnModel class] json:response[@"data"]];
        NSMutableArray<ZHBtnModel *> *tagModels = [NSMutableArray array];
        
        NSInteger index=0;
        for (NSDictionary *dict in response[@"data"]) {
            [tagModels addObject: [ZHBtnModel tagModelWithDictionary: dict
                                                             atIndex: index]];
            index++;
        }
        self.tagContainer.BtnTagModels = [NSMutableArray arrayWithArray: tagModels];
        
        [self.tableView reloadData];
        
    }];
    
}


- (void)LoadFreeAskData {
    
    
    NSString *url = [NSString stringWithFormat:@"%@/api/freeask/getFreeAskByLatest",kIP];
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        
        NSLog(@"response = %@",response);
        
        NSArray<ZHAskModel *> *models = [NSArray yy_modelArrayWithClass:[ZHAskModel class] json:response[@"data"]];
        
        self.Freemodels = [NSMutableArray arrayWithArray:models];
     
        [self.tableView reloadData];
        
    }];

    
}

#pragma mark - Lazy load
- (NSMutableArray<ZHBtn *> *)tagButtons {
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}


- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame: CGRectMake(13, 0, [UIScreen mainScreen].bounds.size.width-60, 44)];
        
        _searchBar.delegate = self;
        
        _searchBar.placeholder = @"搜索案例,资讯,问答";
        
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        
        _searchBar.layer.cornerRadius = 3;
        _searchBar.layer.masksToBounds = YES;
        _searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
        
        
    }
    return _searchBar;
}

@end
