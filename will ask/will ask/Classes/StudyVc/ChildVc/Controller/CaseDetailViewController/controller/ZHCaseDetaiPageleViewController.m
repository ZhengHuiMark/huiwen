//
//  ZHCaseDetaileViewController.m
//  will ask
//
//  Created by 郑晖 on 2018/1/17.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHCaseDetaiPageleViewController.h"
#import "ZHCaseDetailModel.h"
#import "ZHCaseDetailTableViewCell.h"

static NSString *caseDetailCellid = @"caseDetailCellid";

@interface ZHCaseDetaiPageleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ZHCaseDetaiPageleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    [self loadData];
}

- (void)setupUI{
    
}


- (void)loadData{
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:_urlId forKey:@"caseId"];
    NSString *url = [NSString stringWithFormat:@"%@/api/caseInfo/uto/getContent",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
        _model = [ZHCaseDetailModel yy_modelWithJSON:response[@"data"]];
        NSLog(@"%@",response);
        
        [self.tableView reloadData];
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *wenzi = _model.content;
    CGFloat marin = 17.5;
    CGFloat labelWidth = [UIScreen mainScreen].bounds.size.width - marin * 2;
    CGFloat labelHeight = [wenzi boundingRectWithSize: CGSizeMake(labelWidth,MAXFLOAT)
                                              options: NSStringDrawingUsesLineFragmentOrigin
                                           attributes: @{NSFontAttributeName : [UIFont systemFontOfSize: 17]}
                                              context: nil].size.height;
    
    
    
    return 142 + [ZHCaseDetailTableViewCell getSpaceLabelHeight:_model.content withFont:[UIFont systemFontOfSize:17] withWidth:labelWidth];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZHCaseDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:caseDetailCellid forIndexPath:indexPath];
    
    cell.model = _model;
    cell.title.text = self.title;
    
    
    return cell;
    
}


- (UITableView *)tableView {

    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - SafeAreaTopHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        
        //    NSBundle *bundle = [NSBundle mainBundle];
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHCaseDetailTableViewCell" bundle:nil] forCellReuseIdentifier:caseDetailCellid];
        
        
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    
    return _tableView;
}



@end
