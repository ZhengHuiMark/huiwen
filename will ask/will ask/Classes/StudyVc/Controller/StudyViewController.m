    //
//  StudyViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/8/22.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "StudyViewController.h"
#import "ZHExpertTodayTableViewCell.h"
#import "ZHCaseBreakDownTableViewCell.h"
#import "ZHIntroductionTableViewCell.h"
#import "ZHNetworkTools.h"
#import "Macro.h"
#import "ZHStudyModel.h"
#import "YYModel.h"
#import "ZHSubCaseModel.h"
#import "ZHCaseModel.h"
#import "ZHTypeTableViewCell.h"
#import "ZHExpertViewController.h"
#import "ZHFindCaseViewController.h"
#import "SDCycleScrollView.h"
#import "ZHStudyBannerModel.h"
#import "ImageTools.h"
#import "ZHExpertUserInfoHomePageViewController.h"

static NSString *ExpertsCellid = @"ExpertsCellid";

static NSString *CaseBreakDownCellid = @"CaseBreakDownCellid";

static NSString *IntroductionCellid = @"IntroductionCellid";

static NSString *typeCellid = @"typeCellid";

@interface StudyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray <ZHStudyModel *> *TodayExpetsModel;

@property(nonatomic,strong)NSArray <ZHCaseModel *> *caseModels;

@property(nonatomic,strong)NSArray <ZHSubCaseModel *> *subCaseModelsz;

@property(nonatomic,strong)NSMutableArray <ZHSubCaseModel *> *subCaseModelszzz;

@property(nonatomic,strong)NSMutableArray <ZHCaseModel *> *caseModelsss;

@property (nonatomic, strong) SDCycleScrollView *bannerView;



@end

@implementation StudyViewController {
    
    NSArray <ZHStudyBannerModel *>*_bannerModelArray;
    NSMutableArray *_bannerImageUrlMarray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bannerImageUrlMarray = [NSMutableArray array];
    
//    [self.view addSubview:self.tableView];
    
    [self loadData];
    
    [self loadCaseData];
    
    [self loadBannerData];
    
    [self.view addSubview:self.tableView];
}

- (void)loadData{
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/learning/column/getTodaysExpert",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
//        NSLog(@"response = %@",response);
        _TodayExpetsModel = [NSArray yy_modelArrayWithClass:[ZHStudyModel class] json:response[@"data"]];
        
        
        [self.tableView reloadData];
    }];
    
}


- (void)loadCaseData{
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/learning/column/uto/getHomePageCaseInfo",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
//        NSLog(@"response = %@",response);

        
        _caseModels = [NSArray yy_modelArrayWithClass:[ZHCaseModel class]  json:response[@"data"]];
        _caseModelsss = [NSMutableArray arrayWithArray:_caseModels];

        [self.tableView reloadData];

    }];

    
}

- (void)loadBannerData{
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/learning/column/getBannerList",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        
        _bannerModelArray = [NSArray yy_modelArrayWithClass:[ZHStudyBannerModel class] json:response[@"data"]];
        for (ZHStudyBannerModel *tempModel in _bannerModelArray) {
            [_bannerImageUrlMarray addObject: [NSString stringWithFormat:@"%@%@%@",bucketNameDwsoftLoad,OSS,tempModel.picture]];
        }
    }];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if (section == 0) {
        
        self.bannerView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
        
        self.bannerView.imageURLStringsGroup = _bannerImageUrlMarray;
        
        return self.bannerView;
    }else {
        return [UIView new];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 0 ) {
        return 100;
    }
    
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return iOS11Later;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
//    NSLog(@"_caseModels.count = %lu",_caseModels.count+2);
    return _caseModels.count+2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return _TodayExpetsModel.count;
    }
    
    return _caseModels[section-2].subCaseModels.count + 1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        ZHTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:typeCellid forIndexPath:indexPath];
        
        if (cell == nil) {
            cell = [[ZHTypeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:typeCellid];
        }
        
        
//         找专家
        cell.didClick = ^(){
          
            ZHExpertViewController *ExpertVc = [[ZHExpertViewController alloc]init];
            
            [self.navigationController pushViewController:ExpertVc animated:YES];
        };
//         查案例
        cell.CaseDidClick = ^() {
            ZHFindCaseViewController *FindCaseVc = [[ZHFindCaseViewController alloc]init];
            
            [self.navigationController pushViewController:FindCaseVc animated:YES];
        };
        
        return cell;
        
    }
    
    if (indexPath.section == 1) {
    
    _todayExpertModel = _TodayExpetsModel[indexPath.row];

    ZHExpertTodayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ExpertsCellid ];
    if (cell == nil) {
        cell = [[ZHExpertTodayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ExpertsCellid];
    }
    cell.model = _todayExpertModel;

        return cell;

    }
    
    if (indexPath.section > 1) {
        
        
        if (indexPath.row == 0) {
            
            self.caseModel = _caseModelsss[indexPath.section-2];
            ZHCaseBreakDownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CaseBreakDownCellid forIndexPath:indexPath];
            
            if (cell == nil) {
                cell = [[ZHCaseBreakDownTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CaseBreakDownCellid];
                
            }
            cell.model = self.caseModel;
            
            return cell;
        }else {
            
            self.subCaseModel = _caseModelsss[indexPath.section-2].subCaseModels[indexPath.row-1];

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
        return 80;
    }
    
    if (indexPath.section == 1) {
        return 160;
    }
    
    if (indexPath.section > 1 && indexPath.row == 0) {
        return 110;
    }
    
    return 310;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath: indexPath animated: YES];

    if (indexPath.section == 0)return;
    
    
    if (indexPath.section == 1) {
        
        ZHExpertUserInfoHomePageViewController  *expertVc = [[ZHExpertUserInfoHomePageViewController alloc]init];
        
        expertVc.expertID = _TodayExpetsModel[indexPath.row].expertId;
        
        [self.navigationController pushViewController:expertVc animated:YES];
        
    }
    
    if (indexPath.section == 2)return;
    
    
}

- (UITableView *)tableView {
    //
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - SafeAreaTopHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        
        //    NSBundle *bundle = [NSBundle mainBundle];
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHExpertTodayTableViewCell" bundle:nil] forCellReuseIdentifier:ExpertsCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHCaseBreakDownTableViewCell" bundle:nil] forCellReuseIdentifier:CaseBreakDownCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHIntroductionTableViewCell" bundle:nil] forCellReuseIdentifier:IntroductionCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHTypeTableViewCell" bundle:nil] forCellReuseIdentifier:typeCellid];
        
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    
    return _tableView;
}





@end
