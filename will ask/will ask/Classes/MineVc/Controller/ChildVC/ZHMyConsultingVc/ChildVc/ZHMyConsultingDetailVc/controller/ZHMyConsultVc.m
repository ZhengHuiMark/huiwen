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
#import "ZHMyConsultDetailViewController.h"


static NSString *contentCellid = @"contentCellid";
static NSString *expertAnswerCellid = @"expertAnswerCellid";
static NSString *myChaseCellid = @"myChaseCellid";
static NSString *expertChaseCellid = @"expertChaseCellid";
static NSString *answerVoiceCellid = @"answerVoiceCellid";
static NSString *voiceCellid = @"voiceCellid";

@interface ZHMyConsultVc ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray <ZHAllMyDetailModel *>*detailModels;

@property(nonatomic,strong)UIView *backView;

@property(nonatomic,strong)UIButton *addAskBtn;

@end

@implementation ZHMyConsultVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    [self loadData];

    [self.view addSubview:self.tableView];

    
}

- (void)setupUI{
    
    _backView = [UIView new];
    _backView.frame = CGRectMake(0,CGRectGetMaxY(self.view.frame)-49, ScreenHeight, 49);
    _backView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:self.backView];
    
    _addAskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addAskBtn.frame = CGRectMake(0, 1, ScreenWidth, 49);
    _addAskBtn.backgroundColor = [UIColor whiteColor];
    [_addAskBtn setTitle:@"追问" forState:UIControlStateNormal];
    [_addAskBtn addTarget:self action:@selector(addAsk) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.addAskBtn];

}

- (void)removeUI{
    [self.backView removeFromSuperview];
    [self.addAskBtn removeFromSuperview];
}
#pragma mark - 追问
- (void)addAsk{
    
    ZHMyConsultDetailViewController *myConsultVc = [[ZHMyConsultDetailViewController alloc]init];
    myConsultVc.consultId = self.consultId;
    
    [self.navigationController pushViewController:myConsultVc animated:YES];

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
        
        
        if (_model.allowAppend == YES) {
            [self setupUI];
        }else{
            [self removeUI];
        }
        
        [self.tableView reloadData];
    }];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        NSString *wenzi = self.model.question;
        CGFloat marin = 17.5;
        CGFloat labelWidth = [UIScreen mainScreen].bounds.size.width - marin * 2;
        CGFloat labelHeight = [wenzi boundingRectWithSize: CGSizeMake(labelWidth, 300)
                                                  options: NSStringDrawingUsesLineFragmentOrigin
                                               attributes: @{NSFontAttributeName : [UIFont systemFontOfSize: 14]}
                                                  context: nil].size.height;
        
        return 230 + labelHeight;
    }
    if (indexPath.section == 1) {
        NSString *wenzi = self.model.answerContent;
        CGFloat marin = 17.5;
        CGFloat labelWidth = [UIScreen mainScreen].bounds.size.width - marin * 2;
        CGFloat labelHeight = [wenzi boundingRectWithSize: CGSizeMake(labelWidth, 300)
                                                  options: NSStringDrawingUsesLineFragmentOrigin
                                               attributes: @{NSFontAttributeName : [UIFont systemFontOfSize: 14]}
                                                  context: nil].size.height;
        
        return 230 + labelHeight;
    }
    if (indexPath.section == 2) {
        NSString *wenzi = self.model.addQuestion;
        CGFloat marin = 17.5;
        CGFloat labelWidth = [UIScreen mainScreen].bounds.size.width - marin * 2;
        CGFloat labelHeight = [wenzi boundingRectWithSize: CGSizeMake(labelWidth, 300)
                                                  options: NSStringDrawingUsesLineFragmentOrigin
                                               attributes: @{NSFontAttributeName : [UIFont systemFontOfSize: 14]}
                                                  context: nil].size.height;
        
        return 230 + labelHeight;
    }
    if (indexPath.section == 3) {
        NSString *wenzi = self.model.addAnswerContent;
        CGFloat marin = 17.5;
        CGFloat labelWidth = [UIScreen mainScreen].bounds.size.width - marin * 2;
        CGFloat labelHeight = [wenzi boundingRectWithSize: CGSizeMake(labelWidth, 300)
                                                  options: NSStringDrawingUsesLineFragmentOrigin
                                               attributes: @{NSFontAttributeName : [UIFont systemFontOfSize: 14]}
                                                  context: nil].size.height;
        
        return 230 + labelHeight;
    }
    
    return 250;
    
    
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
            
            cell.model = _model;
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
            
            cell.voiceModel = _model;
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
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
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
