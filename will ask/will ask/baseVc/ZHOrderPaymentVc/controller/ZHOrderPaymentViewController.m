//
//  ZHOrderPaymentViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/12/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHOrderPaymentViewController.h"
#import "ZHOrderPayContentTableViewCell.h"
#import "ZHPaymentOptionsTableViewCell.h"
#import "ZHOrderPayModel.h"

static NSString *payContentCellid = @"payContentCellid";
static NSString *paymentOptionsCellid = @"paymentOptionsCellid";

@interface ZHOrderPaymentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ZHOrderPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview: self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 ) {
        return 140;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        ZHOrderPayContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:payContentCellid forIndexPath:indexPath];
        
        
        cell.orderTitle.text = _payModel.goodsName;
        cell.orderState.text = _payModel.descriptions;
        cell.priceNumber.text = _payModel.amount;
        cell.creatTime.text = _payModel.createTime;
        
        return cell;
    }
    
    if (indexPath.section == 1) {
        ZHPaymentOptionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:paymentOptionsCellid forIndexPath:indexPath];
        cell.indexPath = indexPath;
        
        return cell;
    }

    
    return cell?cell:[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                            reuseIdentifier: @"Cell"];
}


- (UITableView *)tableView {
    //
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        _tableView.sectionHeaderHeight = 43;
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHOrderPayContentTableViewCell" bundle:nil] forCellReuseIdentifier:payContentCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHPaymentOptionsTableViewCell" bundle:nil] forCellReuseIdentifier:paymentOptionsCellid];
        //

    }
    
    return _tableView;
}



@end
