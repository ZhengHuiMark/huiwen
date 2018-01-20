//
//  ZHSetupViewController.m
//  will ask
//
//  Created by 郑晖 on 2018/1/2.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHSetupViewController.h"
#import "ZHSetupListTableViewCell.h"
#import "ZHSetupPushTableViewCell.h"
#import "ZHExitAccountTableViewCell.h"
#import "ZHLoginViewController.h"

static NSString *setUpPushCellid = @"setUpPushCellid";

static NSString *setupListCellid = @"setupListCellid";

static NSString *exitCellid = @"exitCellid";


@interface ZHSetupViewController ()<UITableViewDelegate,UITableViewDataSource, UINavigationControllerDelegate>

@property(nonatomic,strong)UITableView *tableView;


@end

@implementation ZHSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 4;
    }
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        ZHSetupPushTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:setUpPushCellid forIndexPath:indexPath];
        
        return cell;
    }
    
    if (indexPath.section == 1) {
        ZHSetupListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:setupListCellid forIndexPath:indexPath];
        cell.indexPath = indexPath;
        
        
        return cell;
    }
    
    if (indexPath.section == 2) {
        ZHExitAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:exitCellid forIndexPath:indexPath];
        
        cell.didClick = ^(){
            [[UserManager sharedManager]removeUserModel];
            NSString *className = @"ZHLoginViewController";
            [self pushToSetControllerWithIndexPath:indexPath className:className];
        };
        
        return cell;
    }
    
    return cell?cell:[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                            reuseIdentifier: @"Cell"];

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 20;
    }
    if (section == 1) {
        return 30;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
        [tableView deselectRowAtIndexPath: indexPath animated: YES];
    
    if (indexPath.section == 0) return;
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:{
                
            }
                break;
            case 1:{
                NSString *className = @"ZHContactViewController";
                [self pushToSetControllerWithIndexPath:indexPath className:className];
            }
                break;
            case 2:{
                
            }
                break;
            case 3:{
                
            }
                break;
                
            default:
                break;
        }
    }
    
    if (indexPath.section == 2) {
        
        
        
    }
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
        

        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHSetupListTableViewCell" bundle:nil] forCellReuseIdentifier:setupListCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHSetupPushTableViewCell" bundle:nil] forCellReuseIdentifier:setUpPushCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHExitAccountTableViewCell" bundle:nil] forCellReuseIdentifier:exitCellid];
        
    }
    
    return _tableView;
}

#pragma mark - 实现点击跳转到控制器
-(void)pushToSetControllerWithIndexPath:(NSIndexPath *)indexPath className:(NSString *)className{
    
    Class clz = NSClassFromString(className);
    UIViewController *controller = [[clz alloc]init];
    NSLog(@"%@",controller);
    [self.navigationController pushViewController:controller animated:YES];
    
    
    
}

@end
