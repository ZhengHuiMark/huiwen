//
//  SetViewController.m
//  hui
//
//  Created by yangxudong on 2017/12/28.
//  Copyright © 2017年 yangxudong. All rights reserved.
//

#import "ZHCertifiedExpertsVC.h"
#import "ZHCertifiedNormalCell.h"
#import "ZHCertificateCell.h"
#import "ZHExpertCategoryCell.h"
#import "ZHCertifiedExpertsHeaderView.h"
#import <AVFoundation/AVFoundation.h>
#import "CertifiedExpertsModel.h"
#import "BRPickerView.h"
#import "expert.h"
#import "UIColor+Extension.h"
#import "ZHGoodAtBusinessVC.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define WEAKSELF __weak __typeof(self)weakSelf = self;
#define STRONGSELF __strong __typeof(weakSelf)strongSelf = weakSelf;

static NSString *ZHCertifiedNormalCellID = @"ZHCertifiedNormalCellID";
static NSString *ZHCertificateCellID = @"ZHCertificateCellID";
static NSString *ZHExpertCategoryCellID = @"ZHExpertCategoryCellID";

@interface ZHCertifiedExpertsVC ()<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZHCertifiedExpertsHeaderView *headerView;
@property (nonatomic, strong) NSArray *secondGroupArr;
@property (nonatomic, strong) NSArray *cateArr;
@property (nonatomic, strong) NSMutableArray *thridGroupMArr;
@property (nonatomic, strong) expert *expertModel;
@property (nonatomic, strong) UIButton *savePersonInfomationBtn; /// 保存个人信息
@property (nonatomic, strong) UIView *saveBackView;

@end

@implementation ZHCertifiedExpertsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专家信息";
    self.expertModel = [[expert alloc] init];
    self.expertModel.sex = 100;
    self.thridGroupMArr = [NSMutableArray new];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatSaveBackView];
    self.secondGroupArr = @[@"*真实姓名:",@"*专家昵称:",@"*性别:",@"*所在地:",@"*出生日期:",@"*企业名称:",@"*职务:",@"*擅长业务:",@"*个人简介:"];
    [self loadData];
}

#pragma mark - 获取专家类型
- (void)loadData {
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    NSString *url = [NSString stringWithFormat:@"%@/api/expert/getCertificationTypes",kIP];
    [[ZHNetworkTools sharedTools] requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        NSLog(@"%@",response);
        self.cateArr = [NSArray yy_modelArrayWithClass:[CertifiedExpertsModel class] json:response[@"data"]];
        [self.view addSubview:self.tableView];
    }];
}

#pragma mark - 上传个人信息
- (void)putData {
    NSMutableDictionary *mdic = [ZHNetworkTools parameters];
    self.expertModel.intro = @"你好晖哥";
    BOOL isCorrent = [[ZHNetworkTools sharedTools] chectInfomationIsCorrect:self.expertModel];
    if (!isCorrent) {
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@/api/ut/expert/apply",kIP];
    NSDictionary *dic = [self jsonValueDecoded:[[self.expertModel yy_modelToJSONString] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@",dic);
    [[ZHNetworkTools sharedTools] requestWithType:POST andUrl:url andParams:mdic andCallBlock:^(id response, NSError *error) {
        
    }];
}

- (id)jsonValueDecoded:(NSData *)data {
    NSError *error = nil;
    id value = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error) {
        NSLog(@"jsonValueDecoded error:%@", error);
    }
    return value;
}

#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.secondGroupArr.count;
    } else if (section == 1) {
        return 1;
    } else {
        return self.thridGroupMArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ZHCertifiedNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:ZHCertifiedNormalCellID];
        if (!cell) {
            cell = [[ZHCertifiedNormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ZHCertifiedNormalCellID];
        }
        cell.expertModel = self.expertModel;
        cell.titleStr = self.secondGroupArr[indexPath.row];
        cell.index = indexPath;
        return cell;
    } else if (indexPath.section == 1) {
        ZHCertificateCell *cell = [tableView dequeueReusableCellWithIdentifier:ZHCertificateCellID];
        if (!cell) {
            cell = [[ZHCertificateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ZHCertificateCellID categoryArr:self.cateArr];
        }
        cell.expert = self.expertModel;
        WEAKSELF
        cell.SelectedExpertCategoryBlcok = ^(CertifiedExpertsModel *model,BOOL isSed) {
            STRONGSELF
            NSIndexPath *path;
            if (isSed) {
                path = [NSIndexPath indexPathForRow:strongSelf.thridGroupMArr.count inSection:indexPath.section+1];
                [strongSelf.thridGroupMArr insertObject:model atIndex:strongSelf.thridGroupMArr.count];
                [strongSelf.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
                [strongSelf.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            } else {
                [strongSelf.thridGroupMArr removeObject:model];
                path = [NSIndexPath indexPathForRow:strongSelf.thridGroupMArr.count inSection:indexPath.section+1];
                [strongSelf.tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
            }
        };
        
        return cell;
    } else {
        ZHExpertCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ZHExpertCategoryCellID];
        if (!cell) {
            cell = [[ZHExpertCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ZHExpertCategoryCellID];
        }
        cell.expert = self.expertModel;
        cell.model = self.thridGroupMArr[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ZHCertifiedNormalCell *cell = (ZHCertifiedNormalCell *)[tableView cellForRowAtIndexPath:indexPath];
        if (indexPath.row == 3) {
            [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@10, @0, @3] isAutoSelect:YES resultBlock:^(NSArray *selectAddressArr) {
                [self updateCellText:[selectAddressArr componentsJoinedByString:@"-"] cell:cell];
                self.expertModel.locus = cell.editEndTitle;
            }];
        } else if (indexPath.row == 4) {
            [BRDatePickerView showDatePickerWithTitle:@"出生年月" dateType:UIDatePickerModeDate defaultSelValue:@"" minDateStr:@"" maxDateStr:@"" isAutoSelect:YES resultBlock:^(NSString *selectValue) {
                [self updateCellText:selectValue cell:cell];
                self.expertModel.birthdate = selectValue;
            }];
        } else if (indexPath.row == 2) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *manAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [self updateCellText:action.title cell:cell];
                self.expertModel.sex = 0;
            }];
            UIAlertAction *wowenAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [self updateCellText:action.title cell:cell];
                self.expertModel.sex = 1;
            }];
            [alert addAction:manAction];
            [alert addAction:wowenAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        } else if (indexPath.row == 7) {
            ZHGoodAtBusinessVC *vc = [[ZHGoodAtBusinessVC alloc] init];
            WEAKSELF
            vc.SaveSedBusiessBlock = ^(NSString *busiessStr) {
                weakSelf.expertModel.business = busiessStr;
                cell.editEndTitle = @"已填";
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 50;
    } else if (indexPath.section == 1) {
        return 280;
    } else {
        return 200;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    } else {
        return 10.0;    
    }
}

#pragma mark - Private Method
- (void)updateCellText:(NSString *)title cell:(ZHCertifiedNormalCell *)cell {
    cell.editEndTitle = title;
    [self.tableView reloadData];
}

#pragma mark - UI
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight-64-80) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (ZHCertifiedExpertsHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[ZHCertifiedExpertsHeaderView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 150)];
    }
    return _headerView;
}

- (void)creatSaveBackView {
    _saveBackView = [[UIView alloc] init];
    [self.view addSubview:_saveBackView];
    [_saveBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.height.mas_equalTo(80);
    }];
    _savePersonInfomationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _savePersonInfomationBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _savePersonInfomationBtn.backgroundColor = [UIColor orangeColor];
    [_savePersonInfomationBtn setTitle:@"提交认证" forState:UIControlStateNormal];
    [_savePersonInfomationBtn setCornerRadius:5];
    [_savePersonInfomationBtn addTarget:self action:@selector(putData) forControlEvents:UIControlEventTouchUpInside];
    [_savePersonInfomationBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [_saveBackView addSubview:_savePersonInfomationBtn];
    [_savePersonInfomationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(50);
        make.centerY.mas_equalTo(_saveBackView);
    }];
}

@end
