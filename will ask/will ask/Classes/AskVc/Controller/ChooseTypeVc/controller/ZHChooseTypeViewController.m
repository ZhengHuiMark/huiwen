
//
//  ZHChooseTypeViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/11/13.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHChooseTypeViewController.h"
#import "ZHChooseTypeBtnModel.h"
#import "ZHChooseTypeBtn.h"
#import "ZHChooseTypeBtnContainer.h"
#import "ZHChooseTypeTableViewCell.h"
#import "ZHChooseTypeSubTagModel.h"
#import "ZHNetworkTools.h"
#import "Macro.h"

#import "ZHAskQuestionTableViewController.h"


static NSInteger kIsSubTag = 1;


@interface ZHChooseTypeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZHChooseTypeBtnContainer *tagContainer;

// 小分类
@property (nonatomic, copy) NSString *SubTypeTitle;
// 大分类
@property (nonatomic,copy) UILabel *typeTitle;
// 小分类code
@property (nonatomic,copy) NSString *subTypeCode;

@property (nonatomic, strong) UIButton *editorBtn;


@property (nonatomic,copy) NSString *text1;
@end

@implementation ZHChooseTypeViewController

#pragma mark - Life cycles
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Test data
//    [self testData];
    [self LoadFreeAskData];
    
    // Setup UI
    [self setupUI];
}

#pragma mark - Basic setup
- (void)setupUI {
    
    // Table view
    [self.view addSubview: self.tableView];
    self.title = @"选择提问分类";
    
    _editorBtn = [UIButton buttonWithType:UIButtonTypeCustom];


    [_editorBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_editorBtn setTitle:@"下一步" forState:UIControlStateSelected];
    [_editorBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_editorBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_editorBtn addTarget:self action:@selector(toAskDetailVc:) forControlEvents:UIControlEventTouchUpInside];

    [_editorBtn sizeToFit];
    UIBarButtonItem *editBtnItem = [[UIBarButtonItem alloc] initWithCustomView:_editorBtn];
    self.navigationItem.rightBarButtonItem = editBtnItem;

}


- (void)toAskDetailVc:(UIButton *)sender{

    
    if (!sender.selected) {
        [SVProgressHUD showInfoWithStatus:@"请选择分类"];
        [SVProgressHUD dismissWithDelay:1.0];
    }else{
    ZHAskQuestionTableViewController *askVc = [[ZHAskQuestionTableViewController alloc]init];
    
    askVc.titleTypeLabel = _text1;
    
    askVc.titleSubTypeLabel = self.SubTypeTitle;
    
    askVc.AskType = _typeString;
    
    askVc.CodeSubType = _subTypeCode;
    
    [self.navigationController pushViewController:askVc animated:YES];
    }
}

- (void)LoadFreeAskData {
    
    
    NSString *url = [NSString stringWithFormat:@"%@/api/commoncategory/getCategories",kIP];
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject: _typeString
            forKey: @"type"];
    
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        
                NSLog(@"response = %@",response);
        
//        _title = @"未选中标签";
        NSArray<NSDictionary *> *JSONArray = response[@"data"];
        NSMutableArray<ZHChooseTypeBtnModel *> *tagModels = [NSMutableArray array];
        
        NSInteger index=0;
        for (NSDictionary *dict in JSONArray) {
            [tagModels addObject: [ZHChooseTypeBtnModel tagModelWithDictionary: dict
                                                             atIndex: index]];
            index++;
        }
        self.tagContainer.tagModels = [NSArray arrayWithArray: tagModels];
        
        [self.tableView reloadData];
        
    }];
    
    
}


#pragma mark - UITableViewDataSource
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [UIView new];

    UIView *lineView= [UIView new];
    lineView.frame = CGRectMake(17,12,3, 20);
    lineView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:90/255.0 blue:41/255.0 alpha:1];
    [header addSubview:lineView];
    
    _typeTitle = [UILabel new];
//    _typeTitle.frame = (CGRect){CGPointZero, {200, 44}};
    _typeTitle.frame = CGRectMake(CGRectGetMaxX(lineView.frame) + 10, 0, 200, 44);
    _typeTitle.text = self.tagContainer.tagModels[section].title;
    [header addSubview: _typeTitle];

    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (kIsSubTag) {
        return self.tagContainer.tagModels.count;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (kIsSubTag) {
        return 1;
    }
    
    if (section == 0) {
        return 1;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (kIsSubTag) {
        return CGRectGetMaxY([self.tagContainer.tagModels[indexPath.section].subTags lastObject].frame);
        
    }
    if (indexPath.section == 0) {
        return self.tagContainer.cellHeight;
    }
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (kIsSubTag) {
        
        ZHChooseTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ZHRewardCellTableViewCell"];
        if (!cell) {
            cell = [[ZHChooseTypeTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                                    reuseIdentifier: @"ZHRewardCellTableViewCell"];
            
            cell.tableView = tableView;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
            cell.cellClick = ^(ZHChooseTypeTableViewCell *cell, ZHChooseTypeBtn *tagButton, ZHChooseTypeBtnModel *tagModel){
                
                if (tagModel.selected) {
//                          _title = tagModel.title;
//                    NSLog(@"%@",[NSString stringWithFormat:@"%@", tagModel.title]);
                    _SubTypeTitle = tagModel.title;
                    
                    _subTypeCode = tagModel.code;
                    
                    _text1 = self.tagContainer.tagModels[indexPath.section].title;
                    
                    _editorBtn.selected = YES;
                
                }
                
            };
        }
        
        cell.tagModel = self.tagContainer.tagModels[indexPath.section];
        
        
        
        return cell;
    }
    
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier: @"1"];
    if (!aCell) {
        aCell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle
                                       reuseIdentifier: @"1"];
    }
    //    aCell.textLabel.text = _title;
    return aCell;
}

#pragma mark - Lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame: self.view.bounds
                                                  style: UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];

        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

- (ZHChooseTypeBtnContainer *)tagContainer {
    if (!_tagContainer) {
        _tagContainer = [ZHChooseTypeBtnContainer new];
    }
    return _tagContainer;
}

#pragma mark - Test methods
- (void)testData {
    
    //    _title = @"未选中标签";
    NSArray<NSDictionary *> *JSONArray = [self JSONArray];
    NSMutableArray<ZHChooseTypeBtnModel *> *tagModels = [NSMutableArray array];
    
    NSInteger index=0;
    for (NSDictionary *dict in JSONArray) {
        [tagModels addObject: [ZHChooseTypeBtnModel tagModelWithDictionary: dict
                                                                   atIndex: index]];
        index++;
    }
    self.tagContainer.tagModels = [NSArray arrayWithArray: tagModels];
}

- (NSArray<NSDictionary *> *)JSONArray {
    
    return @[
             @{
                 @"code" : @"1",
                 @"name" : @"会计",
                 @"subCategories" : @[
                         @{
                             @"code" : @"1",
                             @"name" : @"会计子类1"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"会计子类2"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"会计子类3"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"会计子类4"
                             }
                         ]
                 },
             @{
                 @"code" : @"1",
                 @"name" : @"税务",
                 @"subCategories" : @[
                         @{
                             @"code" : @"1",
                             @"name" : @"税务子类1"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"税务子类2"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"税务子类3"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"税务子类4"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"税务子类5"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"税务子类6"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"税务子类7"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"税务子类8"
                             }
                         ]
                 },
             @{
                 @"code" : @"1",
                 @"name" : @"审计",
                 @"subCategories" : @[
                         @{
                             @"code" : @"1",
                             @"name" : @"审计子类1"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"审计子类2"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"审计子类3"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"审计子类4"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"审计子类5"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"审计子类6"
                             }
                         ]
                 },
             @{
                 @"code" : @"1",
                 @"name" : @"评估",
                 @"subCategories" : @[
                         @{
                             @"code" : @"1",
                             @"name" : @"评估子类1"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"评估子类2"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"评估子类3"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"评估子类4"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"评估子类5"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"评估子类6"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"评估子类7"
                             }
                         ]
                 },
             @{
                 @"code" : @"1",
                 @"name" : @"软件",
                 @"subCategories" : @[
                         @{
                             @"code" : @"1",
                             @"name" : @"软件子类1"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"软件子类2"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"软件子类3"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"软件子类4"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"软件子类5"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"软件子类6"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"软件子类7"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"软件子类8"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"软件子类9"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"软件子类0"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"软件子类x"
                             },
                         @{
                             @"code" : @"1",
                             @"name" : @"软件子类y"
                             }
                         ]
                 },
             ];
}


@end
