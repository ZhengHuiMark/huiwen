//
//  MineViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/8/22.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "MineViewController.h"
#import "ZHHeaderTableViewCell.h"
#import "ZHMoneyTableViewCell.h"
#import "ZHExpertsTableViewCell.h"
#import "ZHMineTableViewCell.h"
#import "MineModel.h"
#import "UserManager.h"
#import "UserModel.h"


@interface MineViewController ()

@end
//头部cell
static NSString *HeaderCellid = @"HeaderCellid";
//收入cell
static NSString *MoneyCellid = @"MoneyCellid";
//专家cell
static NSString *ExpertsCellid = @"ExpertsCellid";
//列表cell
static NSString *MineListCellid = @"MineListCellid";

@implementation MineViewController
{
    NSMutableArray<MineModel *> *_arrList;

}

-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.hidden = YES;

}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.view addSubview: [UIView new]];
    
    if (self.tableView.style == UITableViewStylePlain) {
        UIEdgeInsets contentInset = self.tableView.contentInset;
        contentInset.top = -22;
        [self.tableView setContentInset:contentInset];
    }
    // Do any additional setup after loading the view.
//    self.navigationController.navigationBar.translucent = YES;
//    UIColor *color = [UIColor clearColor];
//    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.clipsToBounds = YES;
//    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    [self loadData];
    
    [self configUI];
    
}


- (void)configUI{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:HeaderCellid];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHMoneyTableViewCell" bundle:nil] forCellReuseIdentifier:MoneyCellid];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHExpertsTableViewCell" bundle:nil] forCellReuseIdentifier:ExpertsCellid];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHMineTableViewCell" bundle:nil] forCellReuseIdentifier:MineListCellid];

    self.tableView.rowHeight = 50;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 190;
//}

// cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 && indexPath.section == 0) {
        
            return 200;
    }
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    //    if ([UserManager sharedManager].userModel.autograph) {
    //        return 3;
    //    }else{
    return 4;
    //    }
}


// 点击跳转控制器
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        
            NSString *className = @"ZHPersonalInformationVc";
            
            [self pushToSetControllerWithIndexPath:indexPath className:className];
        
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:{
                
                
                NSString *className = @"PersonalInformation";
                [self pushToSetControllerWithIndexPath:indexPath className:className];
                
                break;
            }
                //            case 1:
                //            {
                //                NSString *className = @"PrivateMessageViewController";
                //                [self pushToSetControllerWithIndexPath:indexPath className:className];
                //                break;
                //
                //            }
                //            case 1:
                //            {
                //                NSString *className = @"AlertsViewController";
                //                [self pushToSetControllerWithIndexPath:indexPath className:className];
                //                break;
                //
                //            }
                //            case 1:
                //            {
                //                NSString *className = @"MyAccountViewController";
                //                [self pushToSetControllerWithIndexPath:indexPath className:className];
                //                break;
                //
                //            }
            case 1:
            {
     
                break;
                
            }
            case 2:
            {
                
                NSString *className = @"ZHUserFeedbackViewController";
                [self pushToSetControllerWithIndexPath:indexPath className:className];
                
                break;
                
            }
            case 3:
            {
                
          
                break;
                
            }
            case 4:
            {
                
           
                break;
                
            }
                
                
                
                
            default:
                break;
        }
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //HeaderCell
        ZHHeaderTableViewCell *HeadCell = [tableView dequeueReusableCellWithIdentifier:HeaderCellid forIndexPath:indexPath];    // 不写这句直接崩掉，找不到循环引用的cell
        if (HeadCell == nil) {
            HeadCell = [[ZHHeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderCellid];
        }
        HeadCell.placeholderView.backgroundColor = [UIColor orangeColor];
        [HeadCell.touXiangBtn setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
        HeadCell.userIDLabel.text = @"12344567";
        
        return HeadCell;
    }else if (indexPath.section == 1){
        ZHMoneyTableViewCell *mCell = [tableView dequeueReusableCellWithIdentifier:MoneyCellid forIndexPath:indexPath];
        if (mCell == nil) {
            mCell = [[ZHMoneyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoneyCellid];
        }
        return mCell;
    }else if (indexPath.section == 2){
    ZHExpertsTableViewCell *eCell = [tableView dequeueReusableCellWithIdentifier:ExpertsCellid forIndexPath:indexPath];
    if (eCell == nil) {
        eCell = [[ZHExpertsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ExpertsCellid];
    }
    return eCell;
    }
    
    
    ZHMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MineListCellid forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    MineModel *model = [[MineModel alloc]init];
    
    model = _arrList[indexPath.row];
    
    cell.model = model;
    
    
    return cell;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 1;
//    }else if (section == 3){
//        return 5;
//    }
//    return 3;
    }
    return 8;
 
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0.1;
        case 1:
            return 10;
        case 2:
            return 10;
    }
    return 0;
}



- (void)loadData{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Mine.plist" withExtension:nil];
    
    NSArray *arr = [NSArray arrayWithContentsOfURL:url];
    
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        MineModel *model = [[MineModel alloc]initMineModelWithDict:obj];
        [arrM addObject:model];
        
    }];
    
    _arrList = arrM.copy;
    
}


#pragma mark - 实现点击跳转到控制器
-(void)pushToSetControllerWithIndexPath:(NSIndexPath *)indexPath className:(NSString *)className{
    
    Class clz = NSClassFromString(className);
    UIViewController *controller = [[clz alloc]init];
    NSLog(@"%@",controller);
    [self.navigationController pushViewController:controller animated:YES];
    
    
    
}
@end
