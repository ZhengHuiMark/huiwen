//
//  FreeDetailViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/10/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "FreeDetailViewController.h"
#import "ZHFreeDetailTableViewCell.h"
#import "ZHAnswerVoiceTableViewCell.h"
#import "Macro.h"
#import "ZHNetworkTools.h"
#import "YYModel.h"
#import "ZHFreeDetailModel.h"
#import "ZHFreeAnswerModel.h"
#import "ZHAnswerTableViewCell.h"

static NSString *FreeDetailCellid = @"FreeDetailCellid";

static NSString *AnswerVoiceCellid = @"AnswerVoiceCellid";

static NSString *AnswerContentCellid = @"AnswerContentCellid";

@interface FreeDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property (nonatomic, strong) UIButton *answerButton;

@end

@implementation FreeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

    [self loadData];
    
    
    [self.view addSubview:self.tableView];

}

- (void)loadData {
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:_uidString forKey:@"freeAskId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/freeask/getFreeAskDetail",kIP];
    
//    NSLog(@"url = %@",url);
//    
//    NSLog(@"231231 = %@",dic);
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
//        NSLog(@"response = %@",response);
        
        _detailModel = [ZHFreeDetailModel yy_modelWithJSON:response[@"data"]];
        
        
       _detailModel.anserModels = [NSArray yy_modelArrayWithClass:[ZHFreeAnswerModel class] json:response[@"data"][@"answers"]];
        

        [self.tableView reloadData];
        
    }];
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view= nil;
    if (section == 1) {
        UIView *footerView = [UIView new];
        footerView.clipsToBounds = YES;
        footerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
        
        _answerButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 20, 40)];
        [_answerButton setTitle:@"立即抢答" forState:UIControlStateNormal];
        _answerButton.layer.masksToBounds = YES;
        _answerButton.layer.cornerRadius = 10;
        [_answerButton setBackgroundColor:[UIColor colorWithRed:195/255.0 green:226/255.0 blue:237/255.0 alpha:1]];
        [_answerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        // 立即抢答按钮点击事件
//        [_answerButton addTarget:self action:@selector(answerTheQuestion) forControlEvents:UIControlEventTouchUpInside];
        
        [footerView addSubview:_answerButton];
        
        
            UILabel *noteLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_answerButton.frame) - 60,CGRectGetMaxY(_answerButton.frame) + 10, [UIScreen mainScreen].bounds.size.width - 300, 15)];
            noteLabel.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
//        noteLabel.backgroundColor = [UIColor redColor];
            noteLabel.text = @"抢答规则";
            noteLabel.numberOfLines = 0;
            noteLabel.font = [UIFont systemFontOfSize:13];
            
            [footerView addSubview:noteLabel];
            
        //
        return footerView;
    }
   

    return view;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    if (section == 0) {
        return 0.1;
    }
    
    return 80;
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
        ZHFreeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FreeDetailCellid forIndexPath:indexPath];
        
        cell.model = _detailModel;
        
        return cell;
    }
    
    if (self.detailModel.anserModels[indexPath.row].content) {
        ZHAnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AnswerContentCellid forIndexPath:indexPath];
        
        cell.detailModel = self.detailModel;
        cell.answerModel = self.detailModel.anserModels[indexPath.row];
//
//        cell.answerVoiceModel = self.detailModel.anserModels[indexPath.row];
       
        return cell;
        
    }else{
//   (self.detailModel.anserModels[indexPath.row].voice)
    ZHAnswerVoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AnswerVoiceCellid forIndexPath:indexPath];
    
    
    cell.detailModel = self.detailModel;
    
    cell.answerVoiceModel = self.detailModel.anserModels[indexPath.row];
        
        return cell;
    
    }
    
    return cell;
    
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    
//    
//    return 80;
//}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 ) {


        
        NSString *wenzi = self.detailModel.content;
        CGFloat marin = 17.5;
        CGFloat labelWidth = [UIScreen mainScreen].bounds.size.width - marin * 2;
        CGFloat labelHeight = [wenzi boundingRectWithSize: CGSizeMake(labelWidth, 300)
                                                  options: NSStringDrawingUsesLineFragmentOrigin
                                               attributes: @{NSFontAttributeName : [UIFont systemFontOfSize: 14]}
                                                  context: nil].size.height;
        
        return 219 + labelHeight;
    
    }
    
    if (self.detailModel.anserModels[indexPath.row].content) {
        
        NSString *wenzi = self.detailModel.anserModels[indexPath.row].content;
        CGFloat marin = 17.5;
        CGFloat labelWidth = [UIScreen mainScreen].bounds.size.width - marin * 2;

        CGFloat labelHeight = [wenzi boundingRectWithSize: CGSizeMake(labelWidth, 300)
                                                  options: NSStringDrawingUsesLineFragmentOrigin
                                               attributes: @{NSFontAttributeName : [UIFont systemFontOfSize: 14]}
                                                  context: nil].size.height;
        
        
        return 219 + labelHeight;
    }
    
    
    
    return  290;
    
}






- (UITableView *)tableView {
//
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        
        //    NSBundle *bundle = [NSBundle mainBundle];
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHFreeDetailTableViewCell" bundle:nil] forCellReuseIdentifier:FreeDetailCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHAnswerVoiceTableViewCell" bundle:nil] forCellReuseIdentifier:AnswerVoiceCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHAnswerTableViewCell" bundle:nil] forCellReuseIdentifier:AnswerContentCellid];
    }
    
    return _tableView;
}





@end
