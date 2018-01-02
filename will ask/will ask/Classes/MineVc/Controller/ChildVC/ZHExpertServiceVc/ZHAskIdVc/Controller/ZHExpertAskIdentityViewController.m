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

static NSString *setUpCellid = @"setUpCellid";
static NSString *titleLabelCellid = @"titleLabelCellid";
static NSString *normalUserCellid = @"normalUserCellid";


@interface ZHExpertAskIdentityViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ZHExpertAskIdentityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
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
        
        return cell;
    }
   
    if (indexPath.section == 1) {
        ZHTitleLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:titleLabelCellid forIndexPath:indexPath];
        
        return cell;
    }
    
    if (indexPath.section == 2) {
        ZHNormalUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalUserCellid forIndexPath:indexPath];
        
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


@end
