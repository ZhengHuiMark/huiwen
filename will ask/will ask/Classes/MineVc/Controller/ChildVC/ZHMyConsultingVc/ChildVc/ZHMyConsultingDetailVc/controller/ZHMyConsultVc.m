//
//  ZHMyConsultVc.m
//  will ask
//
//  Created by 郑晖 on 2017/12/18.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMyConsultVc.h"
#import "ZHMyConsultingDetailTableViewCell.h"
#import "ZHMyConsultingAnswerVoiceTableViewCell.h"
#import "ZHMyConsultingVoiceTableViewCell.h"
#import "ZHExpertAnswerTableViewCell.h"
#import "ZHMyChaseAskTableViewCell.h"
#import "ZHExpertChaseTableViewCell.h"
#import "ZHAllMyDetailModel.h"
#import "ZHNetworkTools.h"
#import "Macro.h"
#import "YYModel.h"

static NSString *contentCellid = @"contentCellid";
static NSString *expertAnswerCellid = @"expertAnswerCellid";
static NSString *myChaseCellid = @"myChaseCellid";
static NSString *expertChaseCellid = @"expertChaseCellid";
static NSString *answerVoiceCellid = @"answerVoiceCellid";
static NSString *voiceCellid = @"voiceCellid";

@interface ZHMyConsultVc ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray <ZHAllMyDetailModel *>*detailModels;

@end

@implementation ZHMyConsultVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];

    [self.view addSubview:self.tableView];

    
}



- (void)loadData{
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:self.consultId forKey:@"consultId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/ut/consult/getMyConsultDetails",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
        NSLog(@"response = %@",response);
        

        _model = [ZHAllMyDetailModel yy_modelWithJSON:response[@"data"]];
        
        
        
//        _detailModels = [NSMutableArray arrayWithArray:models];
//        _detailModels = [NSMutableArray arrayWithObject:model];
        
        [self.tableView reloadData];
    }];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    
    if (section == 1 && self.model.answerTime) {
        return 1;
    }
    if (section == 2 && self.model.addQuestionTime) {
        return 1;
    }
    
    if (section == 3 && self.model.addAnswerTime) {
        return 1;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        ZHMyConsultingDetailTableViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:contentCellid forIndexPath:indexPath];
        contentCell.detailModel = _model;
    
        return contentCell;
    }
    
    if (indexPath.section == 1 && self.model.answerTime) {
        
        if (self.model.answerVoice) {
            ZHMyConsultingAnswerVoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:answerVoiceCellid forIndexPath:indexPath];
            
            return cell;
            
        }
        ZHExpertAnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:expertAnswerCellid forIndexPath:indexPath];
        cell.detailModel = _model;
        
        return cell;
    }
    
    if (indexPath.section == 2 && self.model.addQuestionTime) {
        ZHMyChaseAskTableViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:myChaseCellid forIndexPath:indexPath];
        contentCell.detailModel = _model;
        
        return contentCell;
    }
    
    if (indexPath.section == 3 && self.model.addAnswerTime) {
        
        if (self.model.addAnswerVoice) {
            ZHMyConsultingVoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:voiceCellid forIndexPath:indexPath];
            
            return cell;
        }
        ZHExpertChaseTableViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:expertChaseCellid forIndexPath:indexPath];
        contentCell.detailModel = _model;
        
        return contentCell;
    }

    return cell?cell:[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                            reuseIdentifier: @"Cell"];

}


- (UITableView *)tableView {
    //
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        
        //    NSBundle *bundle = [NSBundle mainBundle];
        _tableView.rowHeight = 300;
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHMyConsultingDetailTableViewCell" bundle:nil] forCellReuseIdentifier:contentCellid];
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHExpertAnswerTableViewCell" bundle:nil] forCellReuseIdentifier:expertAnswerCellid];
        [_tableView registerNib:[UINib nibWithNibName:@"ZHMyChaseAskTableViewCell" bundle:nil] forCellReuseIdentifier:myChaseCellid];
        [_tableView registerNib:[UINib nibWithNibName:@"ZHExpertChaseTableViewCell" bundle:nil] forCellReuseIdentifier:expertChaseCellid];
        [_tableView registerNib:[UINib nibWithNibName:@"ZHMyConsultingAnswerVoiceTableViewCell" bundle:nil] forCellReuseIdentifier:answerVoiceCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHMyConsultingVoiceTableViewCell" bundle:nil] forCellReuseIdentifier:voiceCellid];
    }
//    //#import "ZHMyConsultingDetailTableViewCell.h"
//#import "ZHMyConsultingAnswerVoiceTableViewCell.h"
//#import "ZHMyConsultingVoiceTableViewCell.h"
    return _tableView;
}



- (NSMutableArray<ZHAllMyDetailModel *> *)detailModels {
    
    if (!_detailModels) {
        _detailModels = [NSMutableArray array];
    }
    
    return _detailModels;
}


@end
