 //
//  HomeViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/8/22.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "HomeViewController.h"
#import "ZHLoginViewController.h"
#import "ZHMessageTableViewController.h"
#import "OssService.h"
#import "LBViewController+ImagePicker.h"
#import "ImageModel.h"
#import "ZHRewardDetailViewController.h"

#import "ZHBtn.h"
#import "ZHBtnModel.h"
#import "ZHBtnContainer.h"
#import "Macro.h"
#import "ZHNetworkTools.h"
#import "YYModel.h"
#import "MJRefresh.h"
#import "ZHRewardCellTableViewCell.h"
#import "ZHSpecialExpertTableViewCell.h"
#import "ZHJumpFourTableViewCell.h"
#import "ZHExpertTodayTableViewCell.h"
#import "ZHCaseBreakDownTableViewCell.h"
#import "ZHIntroductionTableViewCell.h"

#import "SDCycleScrollView.h"
#import "ZHBannerListModel.h"
#import "ZHHomeBigModel.h"
#import "ZHStudyModel.h"
#import "ZHCaseModel.h"
#import "ZHSubCaseModel.h"
#import "ImageTools.h"


static NSString *jumpCellid = @"jumpCellid";

static NSString *specialCellid = @"specialCellid";

static NSString *ExpertsCellid = @"ExpertsCellid";

static NSString *CaseBreakDownCellid = @"CaseBreakDownCellid";

static NSString *IntroductionCellid = @"IntroductionCellid";



#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height


@interface HomeViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSArray <ZHBannerListModel *> *_bannerModelArray;
    NSMutableArray *_bannerImageUrlMarry;
    
    NSArray <ZHStudyModel *> *_expertModelArray;
    
    NSArray <ZHCaseModel *> *_caseModelArray;
}
@property(nonatomic,strong)NSData *imageData;

@property(nonatomic,strong)ZHBtnContainer *tagContainer;

@property(nonatomic,strong)NSMutableArray <ZHBtn *> *tagButtons;

@property(nonatomic,strong)ZHBtnModel *model;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong) SDCycleScrollView *bannerView;

@property(nonatomic,strong) UISearchBar *searchBar;



@property(nonatomic,weak)UIView *headerView;

@end

@implementation HomeViewController

- (void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = NO;

}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationController.navigationBar.hidden = YES;
    
    
    _bannerImageUrlMarry = [NSMutableArray array];

    [self.view addSubview:self.tableView];
    [self configUI];

    
    _tagContainer =  [ZHBtnContainer new];
    
    
    [self loadDataz];

    
    UIView *view = [[UIView alloc] init];
    _headerView = view;
    view.frame = CGRectMake(0, 0, ScreenWidth, 64);
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    
    [view addSubview:self.searchBar];

    UIButton *editorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editorBtn addTarget:self action:@selector(toMessage) forControlEvents:UIControlEventTouchUpInside];
    [editorBtn setImage:[UIImage imageNamed:@"news"] forState:UIControlStateNormal];
    [editorBtn sizeToFit];

    editorBtn.frame = CGRectMake(CGRectGetMaxX(self.searchBar.frame) + 16, 30.5, 20, 17);
    [view addSubview:editorBtn];
 
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mingzizijiqi:) name:@"postVc" object:nil];
}


- (void)mingzizijiqi:(NSNotification *)user{
    
    ZHRewardDetailViewController *rewardDVc = [[ZHRewardDetailViewController alloc]init];
    rewardDVc.uidStringz = user.userInfo[@"rewardAskId"];
    
    [self.navigationController pushViewController:rewardDVc animated:YES];
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//// 测试用 跳转登录页
- (void)actionModal{
    
    ZHLoginViewController *loginVc = [[ZHLoginViewController alloc]init];
    
    [self.navigationController pushViewController:loginVc animated:YES];
    
    
    
}


- (void)configUI{
    

    UIButton *button  = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(actionModal) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    UIButton *button1  = [[UIButton alloc]initWithFrame:CGRectMake(200, 200, 100, 100)];
    
    button1.backgroundColor = [UIColor blueColor];
    [button1 addTarget:self action:@selector(touch123456) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button1];

}


- (void)loadDataz{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/homepage/uto/getAppHomePageInfo",kIP];
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
 
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
        _bannerModelArray = [NSArray yy_modelArrayWithClass:[ZHBannerListModel class] json:response[@"data"][@"bannerList"]];

        for (ZHBannerListModel *tempModel in _bannerModelArray) {
            [_bannerImageUrlMarry addObject: [NSString stringWithFormat:@"%@%@%@",bucketNameDwsoftLoad,OSS,tempModel.picture]];
        }

        NSLog(@"%@",response);
        NSMutableArray<ZHBtnModel *> *tagModels = [NSMutableArray array];
        
        NSInteger index=0;
        for (NSDictionary *dict in response[@"data"][@"rewardAskList"]) {
            [tagModels addObject: [ZHBtnModel tagModelWithDictionary: dict
                                                             atIndex: index]];
            index++;
        }
        self.tagContainer.BtnTagModels = [NSMutableArray arrayWithArray: tagModels];
        
        _expertModelArray = [NSArray yy_modelArrayWithClass:[ZHStudyModel class] json:response[@"data"][@"expertList"]];
        
        _caseModelArray = [NSArray yy_modelArrayWithClass:[ZHCaseModel class] json:response[@"data"][@"caseinfoList"]];
        
        
        [self.tableView reloadData];
    }];
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
        return;
    }
    
    if (indexPath.section > 2) {
        return;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if (section == 0) {
        
        self.bannerView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
        
        self.bannerView.imageURLStringsGroup = _bannerImageUrlMarry;
        
        return self.bannerView;
    }else {
        return [UIView new];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 180;
    }
    return 0.1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _caseModelArray.count + 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 1;
    }
    if (section == 2) {
        return _expertModelArray.count;
    }
    return _caseModelArray[section - 3].subCaseModels.count + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;

    if (indexPath.section == 0) {
        ZHJumpFourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:jumpCellid forIndexPath:indexPath];
        
        return cell;
    }

    if (indexPath.section == 1) {
        ZHRewardCellTableViewCell *cell = [[ZHRewardCellTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                                                           reuseIdentifier: @"123"];
        if (!cell) {
            
            cell.tableView = tableView;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tagContainer = self.tagContainer;
        
        return cell;
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        ZHSpecialExpertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:specialCellid forIndexPath:indexPath];
        
        cell.stuModel = _expertModelArray[indexPath.row];
        
        return cell;
    }else if (indexPath.section == 2 && indexPath.row != 0) {
        ZHExpertTodayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ExpertsCellid forIndexPath:indexPath];
        
        cell.model = _expertModelArray[indexPath.row];
        
        return cell;
    }
    
    if (indexPath.section > 2) {
        
        if (indexPath.row == 0) {
            self.caseModel = _caseModelArray[indexPath.section - 3];

            ZHCaseBreakDownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CaseBreakDownCellid forIndexPath:indexPath];
            
            if (cell == nil) {
                cell = [[ZHCaseBreakDownTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CaseBreakDownCellid];
                
            }
            cell.model = self.caseModel;
            
            return cell;
        }else {
            
            self.subCaseModel = _caseModelArray[indexPath.section - 3].subCaseModels[indexPath.row-1];
            
            ZHIntroductionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IntroductionCellid forIndexPath:indexPath];
            
            if (cell == nil) {
                cell = [[ZHIntroductionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IntroductionCellid];
            }
            
            cell.model = self.subCaseModel;
            
            return cell;
        }
        
    }
    

    return cell?cell:[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"Cell"];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 110;
    }
    
    if (indexPath.section == 1) {
        return self.tagContainer.cellHeight;
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        return 250;
    }
    if (indexPath.section == 2 && indexPath.row != 0) {
        return 159;
    }
    
    if (indexPath.section > 2 && indexPath.row == 0) {
        return 110;
    }

    return 310;
}

- (UITableView *)tableView {
    //
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -15, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        
        
        //    NSBundle *bundle = [NSBundle mainBundle];
        
//        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHJumpFourTableViewCell" bundle:nil] forCellReuseIdentifier:jumpCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHSpecialExpertTableViewCell" bundle:nil] forCellReuseIdentifier:specialCellid];
//
        [_tableView registerNib:[UINib nibWithNibName:@"ZHExpertTodayTableViewCell" bundle:nil] forCellReuseIdentifier:ExpertsCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHCaseBreakDownTableViewCell" bundle:nil] forCellReuseIdentifier:CaseBreakDownCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHIntroductionTableViewCell" bundle:nil] forCellReuseIdentifier:IntroductionCellid];
  
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    return _tableView;
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
        _searchBar = [[UISearchBar alloc] initWithFrame: CGRectMake(0, 17, [UIScreen mainScreen].bounds.size.width-60, 44)];
        
        _searchBar.delegate = self;
        
        _searchBar.placeholder = @"搜索案例,资讯,问答";
        
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        
        _searchBar.layer.cornerRadius = 3;
        _searchBar.layer.masksToBounds = YES;
        _searchBar.layer.borderColor = [UIColor whiteColor].CGColor;

        
    }
    return _searchBar;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offset = scrollView.contentOffset.y;
    UIColor *color = [UIColor whiteColor];
    
    if (offset > 50) {
        
        if (offset >= 100) {
            
            offset = 100;
        }
        CGFloat alpha = (offset - 50)/50;
        
        _headerView.backgroundColor = [color colorWithAlphaComponent:alpha];
        
    }else {
        
        _headerView.backgroundColor = [UIColor clearColor];
    }
    
    if (offset < -80) {
        
        _headerView.hidden = YES;
    }else {
        
        _headerView.hidden = NO;
    }
    
}


@end
