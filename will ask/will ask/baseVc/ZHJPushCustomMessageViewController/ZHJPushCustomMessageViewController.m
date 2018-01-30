//
//  ZHJPushCustomMessageViewController.m
//  will ask
//
//  Created by 郑晖 on 2018/1/20.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHJPushCustomMessageViewController.h"
#import "MessageViewCell.h"
#import "JPushMessageModel.h"
#import "ZHCertifiedExpertsVC.h"
#import "ZHExpertServiceViewController.h"
#import "ZHRewardDetailViewController.h"
#import "ZHChooseTypeViewController.h"
#import "ZHMyConsultVc.h"
#import "ZHConsultingMeViewController.h"
#import "ZHToAnswerViewController.h"


static NSString *messageCellID = @"messageCellID";


@interface ZHJPushCustomMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UIView *bottomChooseView;

@property(nonatomic,strong) UIButton *choseButton;

@property(nonatomic,strong) UIButton *readButton;

@property(nonatomic,strong) UIButton *deleteButton;

@property(nonatomic,strong) UIButton *itemBut;

@end

@implementation ZHJPushCustomMessageViewController{
    
    NSMutableArray *_dataSoure;
    BOOL _isEditBoooL;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    _isEditBoooL = NO;
    [self setupMessageViewControllerUI];
    
    _dataSoure = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:kJPushMessage object:nil];
    
//        for (int i = 0; i < 15; i++) {
//            JPushMessageModel *model = [JPushMessageModel new];
//            model.time = @"2019-10-11 12:23:33";
//            model.objectId = [NSString stringWithFormat:@"%d",i];
//            model.linkType = @"43";
//            model.msgType = @"系统消息";
//            model.content = @"消息内容";
//            model.title = @"标题";
//            model.pushType = @"推送类型 固定值：1";
//            model.isMessageSelection = NO;
//            model.isHiddenChooseBtn = YES;
//            model.isRead = NO;
//            [_dataSoure addObject:model];
//        }
//    
//    
//    BOOL ret =  [NSKeyedArchiver archiveRootObject:_dataSoure toFile:kPersonInfoPath];
//    if (ret) {
//        NSLog(@"归档成功");
//    }else{
//        NSLog(@"归档失败");
//    }
//    
//    NSArray *arr =[NSKeyedUnarchiver unarchiveObjectWithFile:kPersonInfoPath];
//    _dataSoure = [NSMutableArray arrayWithArray:arr];
    [self loadData];
}

- (void)loadData {
    
    NSArray *arr =[NSKeyedUnarchiver unarchiveObjectWithFile:kPersonInfoPath];
    _dataSoure = [NSMutableArray arrayWithArray:arr];
    
    [self.tableView reloadData];
}

- (void)setupMessageViewControllerUI {
    
    UIBarButtonItem *barBut = [[UIBarButtonItem alloc]init];
    
    _itemBut = [[UIButton alloc]init];
    [_itemBut setTitle:@"编辑" forState:UIControlStateNormal];
    [_itemBut setTitle:@"取消" forState:UIControlStateSelected];
    [_itemBut setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_itemBut setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    _itemBut.titleLabel.font = [UIFont systemFontOfSize:13];
    [_itemBut sizeToFit];
    [_itemBut addTarget:self action:@selector(editorClickAction:) forControlEvents:UIControlEventTouchUpInside];
    barBut.customView = _itemBut;
    
    self.navigationItem.rightBarButtonItem = barBut;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomChooseView];
    [self.bottomChooseView addSubview:self.choseButton];
    [self.bottomChooseView addSubview:self.readButton];
    [self.bottomChooseView addSubview:self.deleteButton];
}

//MARK: UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSoure.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:messageCellID forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor yellowColor];
    cell.models = _dataSoure[indexPath.row];
    
    
    __weak __typeof(self) weakself= self;
    __block int idx = 0;
    cell.hookButtonClickBlock = ^{
        dispatch_async(dispatch_queue_create(0, 0), ^{
            // 子线程执行任务（比如获取较大数据）
            for (JPushMessageModel *model in _dataSoure) {
                
                if (model.isMessageSelection == YES) {
                    idx ++;
                    
                    if (idx == _dataSoure.count) {

                        dispatch_async(dispatch_get_main_queue(), ^{
                            weakself.choseButton.selected = YES;
                        });
                        
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            weakself.choseButton.selected = NO;
                        });
                    }
                }
            }
        });
    };
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_dataSoure removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
    
    BOOL ret =  [NSKeyedArchiver archiveRootObject:_dataSoure toFile:kPersonInfoPath];
    if (ret) {
        NSLog(@"commitEditingStyle-归档成功");
    }else{
        NSLog(@"commitEditingStyle-归档失败");
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_isEditBoooL == NO) {
        /*
         链接类型
         编码
         无链接
         0
         专家服务页
         11
         专家认证申请页
         12
         悬赏问详情页
         21
         悬赏问提问-选择分类页
         22
         专家服务-我的案例详解
         31
         我的咨询详情页
         41
         专家服务-咨询我的详情页
         42
         专家服务-咨询我的问题列表页
         43
         */
        
        switch ([[_dataSoure[indexPath.row] linkType] integerValue]) {
            case 0:
            {
                [SVProgressHUD showInfoWithStatus:@"系统消息无跳转页面"];
                [SVProgressHUD dismissWithDelay:1.0];
            }
                break;
            case 11:
            {
                //跳转专家服务页
                ZHExpertServiceViewController *expertServiceVc = [[ZHExpertServiceViewController alloc]init];
                //                expertServiceVc.uidStringz = userInfo[@"objectId"];
//                ZHTabBarViewController *tabVC = (ZHTabBarViewController *)self.window.rootViewController;
//                ZHNavigationVC *nav = tabVC.viewControllers[tabVC.selectedIndex];
                [self.navigationController pushViewController:expertServiceVc animated:YES];
            }
                break;
            case 12:
            {
                //专家认证页
                ZHCertifiedExpertsVC *expertVc = [[ZHCertifiedExpertsVC alloc]init];
                //                [self.inputViewController.navigationController pushViewController:expertVc animated:YES];
//                ZHTabBarViewController *tabVC = (ZHTabBarViewController *)self.window.rootViewController;
//                ZHNavigationVC *nav = tabVC.viewControllers[tabVC.selectedIndex];
                [self.navigationController pushViewController:expertVc animated:YES];
            }
                break;
            case 21:
            {
                //悬赏问详情
                ZHRewardDetailViewController *rewardDetail = [[ZHRewardDetailViewController alloc]init];
                rewardDetail.uidStringz = [_dataSoure[indexPath.row] objectId];
//                ZHTabBarViewController *tabVC = (ZHTabBarViewController *)self.window.rootViewController;
//                ZHNavigationVC *nav = tabVC.viewControllers[tabVC.selectedIndex];
                [self.navigationController pushViewController:rewardDetail animated:YES];
            }
                break;
            case 22:
            {
                // 悬赏问 - 选择分类页面
                ZHChooseTypeViewController *chooseTypeVc = [[ZHChooseTypeViewController alloc]init];
                chooseTypeVc.typeString = @"2";
//                ZHTabBarViewController *tabVC = (ZHTabBarViewController *)self.window.rootViewController;
//                ZHNavigationVC *nav = tabVC.viewControllers[tabVC.selectedIndex];
                [self.navigationController pushViewController:chooseTypeVc animated:YES];
            }
                break;
            case 31:
            {
                
                //                ZHRewardDetailViewController *rewardDetail = [[ZHRewardDetailViewController alloc]init];
                //                rewardDetail.uidStringz = userInfo[@"objectId"];
                //                ZHTabBarViewController *tabVC = (ZHTabBarViewController *)self.window.rootViewController;
                //                ZHNavigationVC *nav = tabVC.viewControllers[tabVC.selectedIndex];
                //                [nav pushViewController:rewardDetail animated:YES];
            }
                break;
            case 41:
            {
                //我的咨询详情页
                ZHMyConsultVc *myConsultVc = [[ZHMyConsultVc alloc]init];
                myConsultVc.consultId = [_dataSoure[indexPath.row] objectId];
//                ZHTabBarViewController *tabVC = (ZHTabBarViewController *)self.window.rootViewController;
//                ZHNavigationVC *nav = tabVC.viewControllers[tabVC.selectedIndex];
                [self.navigationController pushViewController:myConsultVc animated:YES];
            }
                break;
            case 42:
            {
                //咨询我的详情页
                ZHConsultingMeViewController *consultMeVc = [[ZHConsultingMeViewController alloc]init];
                consultMeVc.conslutId = [_dataSoure[indexPath.row] objectId];
//                ZHTabBarViewController *tabVC = (ZHTabBarViewController *)self.window.rootViewController;
//                ZHNavigationVC *nav = tabVC.viewControllers[tabVC.selectedIndex];
                [self.navigationController pushViewController:consultMeVc animated:YES];
            }
                break;
            case 43:
            {
                //专家服务 - 咨询我的 - 列表页
                ZHToAnswerViewController *toAnswerVc = [[ZHToAnswerViewController alloc]init];
                //                toAnswerVc.uidStringz = userInfo[@"objectId"];
//                ZHTabBarViewController *tabVC = (ZHTabBarViewController *)self.window.rootViewController;
//                ZHNavigationVC *nav = tabVC.viewControllers[tabVC.selectedIndex];
                [self.navigationController pushViewController:toAnswerVc animated:YES];
            }
                break;
                
            default:
                break;
        }
        
    }

    NSLog(@" linktype %@",[_dataSoure[indexPath.row] linkType]);
//    [_dataSoure[indexPath.row] objectId];
    
}


- (void)choseButtonClickAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    for (JPushMessageModel *model in _dataSoure) {
        model.isMessageSelection = sender.selected;
    }
    [self.tableView reloadData];
}

- (void)editorClickAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    self.choseButton.selected = !sender.selected;
    _isEditBoooL = sender.selected;
    
    if (sender.selected) {
        self.bottomChooseView.hidden = NO;
        self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50);
    }else {
        self.bottomChooseView.hidden = YES;
        self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
    
    for (JPushMessageModel *model in _dataSoure) {
        model.isHiddenChooseBtn = !sender.selected;
        model.isMessageSelection = NO;
    }
    
    [self.tableView reloadData];
}

- (void)readButtonClickAction {
    
    for (JPushMessageModel *model in _dataSoure) {
        if (model.isMessageSelection == YES) {
            model.isRead = YES;
            model.isMessageSelection = NO;
        }
    }
    [self editorClickAction:_itemBut];
    [self.tableView reloadData];
    
    BOOL ret =  [NSKeyedArchiver archiveRootObject:_dataSoure toFile:kPersonInfoPath];
    if (ret) {
        NSLog(@"delete-归档成功");
    }else{
        NSLog(@"delete-归档失败");
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kJPushMessage object:nil];
}

- (void)deleteButtonClickAction {
    NSMutableArray *temp = [NSMutableArray new];
    for (JPushMessageModel *model in _dataSoure) {
        if (model.isMessageSelection == YES) {
            [temp addObject:model];
        }
    }
    [self editorClickAction:_itemBut];
    [_dataSoure removeObjectsInArray:temp];
    [self.tableView reloadData];
    
    BOOL ret =  [NSKeyedArchiver archiveRootObject:_dataSoure toFile:kPersonInfoPath];
    if (ret) {
        NSLog(@"delete-归档成功");
    }else{
        NSLog(@"delete-归档失败");
    }
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 70;
        
        [_tableView registerClass:[MessageViewCell class] forCellReuseIdentifier:messageCellID];
    }
    return _tableView;
}

- (UIView *)bottomChooseView {
    
    if (!_bottomChooseView) {
        _bottomChooseView = [UIView new];
        _bottomChooseView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50-64, [UIScreen mainScreen].bounds.size.width, 50);
        _bottomChooseView.backgroundColor = [UIColor whiteColor];
        _bottomChooseView.hidden = YES;
    }
    return _bottomChooseView;
}

- (UIButton *)choseButton {
    if (!_choseButton) {
        _choseButton = [[UIButton alloc] initWithFrame:CGRectMake(19, 14.5, 80, 20)];
        [_choseButton setImage:[UIImage imageNamed:@"choice"] forState:UIControlStateNormal];
        [_choseButton setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
        [_choseButton setTitle:@"全选" forState:UIControlStateNormal];
        [_choseButton setTitleColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1] forState:UIControlStateNormal];
        [_choseButton setTitleColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1] forState:UIControlStateSelected];
        _choseButton.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        [_choseButton addTarget:self action:@selector(choseButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _choseButton;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-50-20, 16.5, 50, 15)];
        [_deleteButton setTitle:@"删除" forState: UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor colorWithRed:242.0/255.0 green:90.0/255.0 blue:41.0/255.0 alpha:1] forState:UIControlStateNormal];

        [_deleteButton addTarget:self action:@selector(deleteButtonClickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (UIButton *)readButton {
    if (!_readButton) {
        _readButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-107.5-100, 16.5, 100, 15)];
        [_readButton setTitle:@"设为已读" forState:UIControlStateNormal];
        [_readButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_readButton setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
        [_readButton addTarget:self action:@selector(readButtonClickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _readButton;
}

@end
