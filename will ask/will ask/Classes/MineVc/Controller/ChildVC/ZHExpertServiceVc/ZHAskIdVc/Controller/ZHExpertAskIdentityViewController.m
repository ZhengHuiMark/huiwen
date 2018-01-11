//
//  ZHExpertAskIdentityViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/12/26.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHExpertAskIdentityViewController.h"
#import "ZHSetUpIdentityTableViewCell.h"
#import "ZHTitleLabelTableViewCell.h"
#import "ZHNormalUserTableViewCell.h"
#import "UserModel.h"
#import "UserManager.h"
#import "ZHAskIdModel.h"

static NSString *setUpCellid = @"setUpCellid";
static NSString *titleLabelCellid = @"titleLabelCellid";
static NSString *normalUserCellid = @"normalUserCellid";


@interface ZHExpertAskIdentityViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>{
    NSMutableDictionary *_tempDict;

}

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ZHExpertAskIdentityViewController


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
        NSMutableDictionary *dic = [ZHNetworkTools parameters];
        [dic addEntriesFromDictionary:_tempDict];
    
        NSString *url = [NSString stringWithFormat:@"%@/api/ut/expert/saveQuestionerIdentity",kIP];
        
        [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
            if (error) {
                NSLog(@"%@",error);
            }
            
            NSLog(@"%@",response);
        }];
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveName:) name:@"textName" object:nil];
    _tempDict = [NSMutableDictionary dictionary];
    
}


- (void)loadData{
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/ut/expert/getQuestionerIdentity",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        if (error) {
            NSLog(@"%@",response);
        }
        
        NSLog(@"response = %@",response);
        _model = [ZHAskIdModel yy_modelWithJSON:response];
        
        [self.tableView reloadData];
       
        
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        
        ZHSetUpIdentityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:setUpCellid forIndexPath:indexPath];
        cell.model = _model;
        return cell;
        
    }
   
    if (indexPath.section == 1) {
        ZHTitleLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:titleLabelCellid forIndexPath:indexPath];
        
        
        
        return cell;
    }
    
    if (indexPath.section == 2) {
        UserModel *model = [UserManager sharedManager].userModel;
        ZHNormalUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalUserCellid forIndexPath:indexPath];
        cell.model = model;
        
        
        return cell;
    }
    
    return cell?cell:[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                            reuseIdentifier: @"Cell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) return 50;
    if (indexPath.section == 1) return 154.5;
    
    return 130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) return 0;
    if (section == 1) return 0;
    
    
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath: indexPath animated: YES];

    if (indexPath.section == 0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@""
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"普通用户",@"专家用户",nil];
        
        
        actionSheet.actionSheetStyle = UIBarStyleDefault;
        [actionSheet showInView:self.view];

    }

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex != 2) {
        _model.data = [actionSheet buttonTitleAtIndex: buttonIndex];
        
        [_tempDict setValue:@(buttonIndex+1) forKey:@"identity"];
    
    }
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}


- (UITableView *)tableView {
    //
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        _tableView.sectionHeaderHeight = 50;
        _tableView.tableFooterView = [UIView new];
        
        //        _tableView.rowHeight = 299;
        
        //    NSBundle *bundle = [NSBundle mainBundle];
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHSetUpIdentityTableViewCell" bundle:nil] forCellReuseIdentifier:setUpCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHTitleLabelTableViewCell" bundle:nil] forCellReuseIdentifier:titleLabelCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHNormalUserTableViewCell" bundle:nil] forCellReuseIdentifier:normalUserCellid];
    }
    
    return _tableView;
}

//- (ZHAskIdModel *)model {
//    
//    if (!_model) {
//        _model = [ZHAskIdModel new];
//    }
//    return _model;
//}


- (void)saveName:(NSNotification *)user {
    
    NSLog(@"user %@",user.userInfo);
    [_tempDict addEntriesFromDictionary:user.userInfo];
    NSLog(@"tempDictionary %@",_tempDict);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
