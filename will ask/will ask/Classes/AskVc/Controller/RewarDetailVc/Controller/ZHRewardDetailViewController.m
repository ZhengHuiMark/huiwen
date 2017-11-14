//
//  ZHRewardDetailViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/11/7.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHRewardDetailViewController.h"
#import "ZHRewardDetailTableViewCell.h"
#import "ZHRewardAnswerTableViewCell.h"
#import "ZHRewardAnswerVoiceTableViewCell.h"
#import "Macro.h"
#import "ZHNetworkTools.h"
#import "ZHFreeAnswerModel.h"
#import "ZHFreeDetailModel.h"
#import "YYModel.h"


static NSString *RewardDetailCellid = @"RewardDetailCellid";

static NSString *RewardContentCellid = @"RewardContentCellid";

static NSString *RewardVoiceCellid = @"RewardVoiceCellid";

@interface ZHRewardDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;


@end

@implementation ZHRewardDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [self loadData];
    
    
    [self.view addSubview:self.tableView];
    
}

- (void)loadData {
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:_uidStringz forKey:@"rewardAskId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/rewardask/uto/getRewardAskDetail",kIP];
    
    NSLog(@"url = %@",url);
    
    NSLog(@"231231 = %@",dic);
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
        NSLog(@"response = %@",response);
        
        _detailModel = [ZHFreeDetailModel yy_modelWithJSON:response[@"data"]];
        
        
        _detailModel.anserModels = [NSArray yy_modelArrayWithClass:[ZHFreeAnswerModel class] json:response[@"data"][@"answers"]];
        
        
        [self.tableView reloadData];
        
    }];
    
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    
    return self.detailModel.anserModels.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    
    if (indexPath.section == 0) {
        ZHRewardDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RewardDetailCellid forIndexPath:indexPath];
        
        cell.detailModel = _detailModel;
        
        return cell;
    }
    
    if (self.detailModel.anserModels[indexPath.row].content) {
        ZHRewardAnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RewardContentCellid forIndexPath:indexPath];
        
//        cell.detailModel = self.detailModel;
//        cell.answerModel = self.detailModel.anserModels[indexPath.row];
        //
        //        cell.answerVoiceModel = self.detailModel.anserModels[indexPath.row];
        
        return cell;
        
    }else{
        //   (self.detailModel.anserModels[indexPath.row].voice)
        ZHRewardAnswerVoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RewardVoiceCellid forIndexPath:indexPath];
        
//        
//        cell.detailModel = self.detailModel;
//        
//        cell.answerVoiceModel = self.detailModel.anserModels[indexPath.row];
        
        return cell;
        
    }
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 ) {
        return 300;
    }
    
    
    return  300;
    
}






- (UITableView *)tableView {
    //
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        
        //    NSBundle *bundle = [NSBundle mainBundle];
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHRewardDetailTableViewCell" bundle:nil] forCellReuseIdentifier:RewardDetailCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHRewardAnswerTableViewCell" bundle:nil] forCellReuseIdentifier:RewardContentCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHRewardAnswerVoiceTableViewCell" bundle:nil] forCellReuseIdentifier:RewardVoiceCellid];
    }
    
    return _tableView;
}




@end
