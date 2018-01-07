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


@interface HomeViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
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

@property (nonatomic, strong) SDCycleScrollView *bannerView;



@property(nonatomic,weak)UIView *headerView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationController.navigationBar.hidden = YES;
    
//    self.view.backgroundColor = [UIColor yellowColor];
    
    _bannerImageUrlMarry = [NSMutableArray array];

    [self.view addSubview:self.tableView];
    [self configUI];

//    [self loadData];
    
    _tagContainer =  [ZHBtnContainer new];
    
    
    [self loadDataz];

    
    UIView *view = [[UIView alloc] init];
    _headerView = view;
    view.frame = CGRectMake(0, 0, ScreenWidth, 64);
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = [UIImage imageNamed:@"ask"];
    imageV.bounds = CGRectMake(0, 0, 36, 36);
    imageV.center = CGPointMake(28, 42);
    [view addSubview:imageV];

    
}



//// 测试用 跳转登录页
- (void)actionModal{
    
    ZHLoginViewController *loginVc = [[ZHLoginViewController alloc]init];
    
    [self.navigationController pushViewController:loginVc animated:YES];
    
    
    
}


- (void)configUI{
    
    



//    UIButton *editorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [editorBtn addTarget:self action:@selector(toMessage) forControlEvents:UIControlEventTouchUpInside];
//    [editorBtn setImage:[UIImage imageNamed:@"news"] forState:UIControlStateNormal];
//    [editorBtn sizeToFit];
//    UIBarButtonItem *editBtnItem = [[UIBarButtonItem alloc] initWithCustomView:editorBtn];
//    self.navigationItem.rightBarButtonItem = editBtnItem;
    
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


//- (void)loadData{
//    
//    NSString *url = [NSString stringWithFormat:@"%@/api/rewardask/getRewardAskByLatest",kIP];
//    
//    NSMutableDictionary *dic = [ZHNetworkTools parameters];
//    
//    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
//        if (error) {
//            NSLog(@"%@",error);
//        }
//        
//        NSLog(@"response = %@",response);
//        
//        NSArray<ZHBtnModel *> *models = [NSArray yy_modelArrayWithClass:[ZHBtnModel class] json:response[@"data"]];
//        NSMutableArray<ZHBtnModel *> *tagModels = [NSMutableArray array];
//        
//        NSInteger index=0;
//        for (NSDictionary *dict in response[@"data"]) {
//            [tagModels addObject: [ZHBtnModel tagModelWithDictionary: dict
//                                                             atIndex: index]];
//            index++;
//        }
//        self.tagContainer.BtnTagModels = [NSMutableArray arrayWithArray: tagModels];
//        
//        [self.tableView reloadData];
//        
//    }];
//    
//}

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
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
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



@end
