//
//  ZHMyRewardAskViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/12/7.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMyRewardAskViewController.h"
#import "MLTagModelContainer.h"
#import "MLTagModel.h"
#import "MLSubTagModel.h"
#import "MLTagCell.h"
#import "Macro.h"
#import "ZHNetworkTools.h"
#import "YYModel.h"
#import "MLTagButton.h"
#import "MJRefresh.h"
#import "ZHMyRewardListTableViewCell.h"
#import "ZHMyRewardRightListTableViewCell.h"

static NSString *MyRewardListCellid = @"MyRewardListCellid";

static NSString *MyRewardRightListCellid = @"MyRewardRightListCellid";


@interface ZHMyRewardAskViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) MLTagModelContainer *tagContainer;


@property(nonatomic,strong)MLTagButton *btn;

@property(nonatomic,strong)MLTagModel *model;

@property(nonatomic,strong)MLSubTagModel *subModel;

@property(nonatomic,strong)UISegmentedControl *segmentedControl;

@property(nonatomic,strong)UITableView *leftTableView;

@property(nonatomic,strong)UITableView *rightTableView;

@property(nonatomic,assign)NSInteger tag;

@property (nonatomic,strong)NSMutableArray *leftArray;
@property (nonatomic,strong)NSMutableArray *rigthArray;

@end

@implementation ZHMyRewardAskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tag = 0;

    [self setupUI];
    [self initTableView];

}


- (void)initTableView {
    
    _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 130, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height - 130) style:UITableViewStylePlain];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.estimatedRowHeight = 44.0f;
    _leftTableView.rowHeight = UITableViewAutomaticDimension;
    _leftTableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_leftTableView];
    
    _rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 130, [UIScreen mainScreen].bounds.size.width,self.view.frame.size.height - 130) style:UITableViewStylePlain];
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.estimatedRowHeight = 44.0f;
    _rightTableView.rowHeight = UITableViewAutomaticDimension;
    _rightTableView.backgroundColor = [UIColor redColor];
    _rightTableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_rightTableView];
    if (self.tag == 0) {
        _rightTableView.hidden = YES;
    }
}


- (void)setupUI{
    
    
    UIView *backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 60)];
    
    backGroundView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:backGroundView];
    
    
    // 初始化，添加分段名，会自动布局
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"已有答案", @"悬赏中"]];
    self.segmentedControl.frame = CGRectMake(17,13,[UIScreen mainScreen].bounds.size.width - 35,35);
    
    self.segmentedControl.tintColor = [UIColor colorWithRed:242/255.0 green:90/255.0 blue:41/255.0  alpha:1];
    
    // 设置初始选中项
    self.segmentedControl.selectedSegmentIndex = 0;
    
    // 设置点击后恢复原样，默认为NO，点击后一直保持选中状态
    self.segmentedControl.momentary = NO;
    
    
    [self.segmentedControl addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventValueChanged];// 添加响应方法
    
    [backGroundView addSubview:self.segmentedControl];

}


- (void)selectItem:(UISegmentedControl *)sender {

    if (sender.selectedSegmentIndex == 0) {
        _leftTableView.hidden = NO;
        _rightTableView.hidden = YES;
        
        self.tag = 0;
        [_leftTableView reloadData];
    }else if (sender.selectedSegmentIndex == 1){
        _rightTableView.hidden = NO;
        _leftTableView.hidden = YES;
        
        self.tag = 1;
        [_rightTableView reloadData];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.tag == 0) {
        return self.leftArray.count;
    }return self.rigthArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.tag == 0) {
        ZHMyRewardListTableViewCell *cell = [[ZHMyRewardListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyRewardListCellid];
        
        return cell;
    }
    else if (self.tag == 1) {
        ZHMyRewardRightListTableViewCell *cell = [[ZHMyRewardRightListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyRewardRightListCellid];
        return cell;
    }
    return nil;
    
}

- (NSMutableArray *)leftArray {
    if (!_leftArray) {
        _leftArray = [NSMutableArray array];
    }
    return _leftArray;
}

- (NSMutableArray *)rigthArray {
    if (!_leftArray) {
        _leftArray = [NSMutableArray array];
    }
    return _leftArray;
}

@end
