//
//  ZHExpertServiceViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/12/25.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHExpertServiceViewController.h"
#import "ZHExpertServiceListTableViewCell.h"
#import "ZHExpertServiceListModel.h"
#import "ZHNetworkTools.h"
#import "Macro.h"
#import "YYModel.h"
#import "ZHExpertServicePriceTableViewCell.h"
#import "ZHExpertAskIdentityViewController.h"
#import "ZHToAnswerViewController.h"

static NSString *expertServicePriceCellid = @"expertServicePriceCellid";
static NSString *expertServiceCellid = @"expertServiceCellid";

@interface ZHExpertServiceViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)ZHExpertServicePriceTableViewCell *priceCell;

@end

@implementation ZHExpertServiceViewController

- (void)viewWillDisappear:(BOOL)animated {
    
    if (!self.priceCell.priceTextFiled.text) {
        NSMutableDictionary *dic = [ZHNetworkTools parameters];
        [dic setObject:self.priceCell.priceTextFiled.text forKey:@"consultPrice"];
        
        NSString *url = [NSString stringWithFormat:@"%@/api/ut/expert/setConsultPrice",kIP];
        
        [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
            if (error) {
                NSLog(@"%@",error);
            }
            
            NSLog(@"%@",response);
        }];
    }
   
    
}



- (void)viewWillAppear:(BOOL)animated{
    [self loadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
}


- (void)loadData{
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    NSString *url = [NSString stringWithFormat:@"%@/api/ut/expert/getExpertServicesStatistics",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
        NSLog(@"%@",response);
        
        _expertServiceModel = [ZHExpertServiceListModel yy_modelWithJSON:response[@"data"]];
        
        [self.tableView reloadData];
        
    }];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (section == 0) {
        return 1;
    }
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    
    
    if (indexPath.section == 0) {
        ZHExpertServicePriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:expertServicePriceCellid forIndexPath:indexPath];
     
        self.priceCell = cell;
        
        cell.priceModel = _expertServiceModel;
        
        return cell;
    }
    
    if (indexPath.section == 1) {
            ZHExpertServiceListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:expertServiceCellid forIndexPath:indexPath];
        cell.indexPath = indexPath;
        cell.expertServiceModel = _expertServiceModel;
        
        return cell;
        
    }

    
    
    
    
    return cell?cell:[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                            reuseIdentifier: @"Cell"];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) return;
    
    if (indexPath.section == 1) {

        switch (indexPath.row) {
            case 0:{
                
                NSString *className = @"ZHToAnswerViewController";
                [self pushToSetControllerWithIndexPath:indexPath className:className];
                
                break;
   
            }
            case 1:{
//                
                NSString *className = @"ZHMyRewardAnswerFirstViewController";
                [self pushToSetControllerWithIndexPath:indexPath className:className];
                
                break;
                
            }
            case 2:{
                
                NSString *className = @"ZHFocusMeUserViewController";
                [self pushToSetControllerWithIndexPath:indexPath className:className];
//
                break;
                
            }
            case 3:{
                
//                NSString *className = @"ValidationViewController";
//                [self pushToSetControllerWithIndexPath:indexPath className:className];
                
                break;
                
            }
            case 4:{
                
//                NSString *className = @"ValidationViewController";
//                [self pushToSetControllerWithIndexPath:indexPath className:className];
                
                break;
                
            }
            case 5:{
                
                NSString *className = @"ZHExpertAskIdentityViewController";
                [self pushToSetControllerWithIndexPath:indexPath className:className];
                
                break;
                
            }
            break;
            
        default:
            break;
        }
        
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

        //        _tableView.rowHeight = 299;
        
        //    NSBundle *bundle = [NSBundle mainBundle];
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHExpertServicePriceTableViewCell" bundle:nil] forCellReuseIdentifier:expertServicePriceCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHExpertServiceListTableViewCell" bundle:nil] forCellReuseIdentifier:expertServiceCellid];
    
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
