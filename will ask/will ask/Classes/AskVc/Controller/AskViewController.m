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


static NSString *JumpCellid = @"JumpCellid";

static NSString *LatesPriceCellid = @"LatesPriceCellid";

static NSString *FreeListTableViewCellid = @"FreeListTableViewCellid";



@interface AskViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)ZHBtnModel *model;
@property (nonatomic, strong) NSMutableArray<ZHBtn *> *tagButtons;

@property(nonatomic,strong)NSMutableArray<ZHAskModel *>* Freemodels;


@property (nonatomic, strong) ZHBtnContainer *tagContainer;



@end

@implementation AskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
    
    [self LoadFreeAskData];
    
    
    
    [self loadData];

    
    [self configUI];

    _tagContainer =  [ZHBtnContainer new];
    




    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    

}


- (void)configUI{
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 62, 20)] ;
    
    titleLabel.text  = @"提问";
    //    titleLabel.backgroundColor  = [UIColor blueColor]   ;
    
    titleLabel.textColor = [UIColor blackColor];
    
    titleLabel.font= [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    

    self.tableView.delegate = self;

    [self.tableView registerNib:[UINib nibWithNibName:@"ZHJumpTableViewCell" bundle:nil] forCellReuseIdentifier:JumpCellid];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHLatestPriceTableViewCell" bundle:nil] forCellReuseIdentifier:LatesPriceCellid];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHFreeListTableViewCell" bundle:nil] forCellReuseIdentifier:FreeListTableViewCellid];
    
    self.tableView.rowHeight = 110;
    self.tableView.sectionHeaderHeight = 43;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    


}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    UIView * view = nil;
    
    if (section == 2) {
        
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor whiteColor];
        //    headerView.frame = self.view.frame;
        //
        UILabel *nameLa = [[UILabel alloc]init];
        
            nameLa.frame = CGRectMake(20, 10 ,[UIScreen mainScreen].bounds.size.width, 20);
        
            nameLa.text = @"最新悬赏问";
        
        [headerView addSubview:nameLa];
        
        UIView * lineView = [[UIView alloc]init];
        lineView.frame = CGRectMake(0, 43, [UIScreen mainScreen].bounds.size.width, 1);
        lineView.backgroundColor = [UIColor grayColor];
        
        [headerView addSubview:lineView];
        
        return headerView;


    }
   

    
    return view;

    
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
            return 20;
        case 2:
            return 20;
    }
    return 0;
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


@end
