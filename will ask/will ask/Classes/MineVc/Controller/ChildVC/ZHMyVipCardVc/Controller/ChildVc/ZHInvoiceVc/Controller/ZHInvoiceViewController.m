//
//  ZHInvoiceViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/12/14.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHInvoiceViewController.h"
#import "ZHInvoiceTableViewCell.h"
#import "ZHInvoiceMailTableViewCell.h"
#import "Invoice.h"

static NSString *invoceCellid = @"invoceCellid";

static NSString *invoceMailCellid = @"invoceMailCellid";

@interface ZHInvoiceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ZHInvoiceViewController {
    
    NSArray *_tempArray;
    NSArray *_tempMailArray;
    NSMutableDictionary *_tempDict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview: self.tableView];
    
    _tempDict = [NSMutableDictionary dictionary];
    _tempArray = @[@"invoiceTitle",@"dutyParagraph",@"companyAddress",@"phone",@"depositBank",@"bankAccount"];
    _tempMailArray = @[@"recipient",@"recipientMobile",@"recipientAddress",@"postcode"];

    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 62, 20)] ;
    
    titleLabel.text  = @"发票信息";
    //    titleLabel.backgroundColor  = [UIColor blueColor]   ;
    
    titleLabel.textColor = [UIColor blackColor];
    
    titleLabel.font= [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;

    
    UIButton *editorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editorBtn addTarget:self action:@selector(toAskQuestion) forControlEvents:UIControlEventTouchUpInside];
    [editorBtn setTitle:@"保存" forState:UIControlStateNormal];
    //    editorBtn.titleLabel.text = @"提问";
    [editorBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [editorBtn sizeToFit];
    UIBarButtonItem *editBtnItem = [[UIBarButtonItem alloc] initWithCustomView:editorBtn];
    self.navigationItem.rightBarButtonItem = editBtnItem;
    
    
    //重新创建一个barButtonItem
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    //设置backBarButtonItem即可
    self.navigationItem.backBarButtonItem = backItem;
    
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    

    
//    [[UINavigationBar appearance]setTintColor:[UIColor grayColor]];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin)
                                                         forBarMetrics:UIBarMetricsDefault];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return kInvoiceViewControllerSectionRowCountInSection;
    }
    
    return kInvoiceViewControllerSectionRowCountInSectionInvoice;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    UIView * view = nil;
    
    if (section == 1) {
        
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];

        UILabel *nameLa = [[UILabel alloc]init];
        nameLa.frame = CGRectMake(20, 10 ,[UIScreen mainScreen].bounds.size.width, 20);
        nameLa.text = @"发票邮寄信息:";
        nameLa.font = [UIFont systemFontOfSize:15];
        [headerView addSubview:nameLa];
    
        return headerView;
    }
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        ZHInvoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:invoceCellid forIndexPath:indexPath];
        cell.indexPath = indexPath;

        cell.textFieldClickBlock = ^(NSString *tempStr) {
          
            [_tempDict setValue:tempStr forKey: _tempArray[indexPath.row]];
        };
        
        return cell;
    }
    
    ZHInvoiceMailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:invoceMailCellid forIndexPath:indexPath];
    cell.indexPath = indexPath;
    
    cell.textFieldClickBlock = ^(NSString *tempStr) {
    
        [_tempDict setValue:tempStr forKey: _tempMailArray[indexPath.row]];
    };
    
    return cell;
}

- (void)toAskQuestion {
    
    if ([_tempDict allKeys].count >= 10) {
        
        NSMutableDictionary *dic = [ZHNetworkTools parameters];
        [dic addEntriesFromDictionary:_tempDict];
        
        NSString *url = [NSString stringWithFormat:@"%@/api/invoiceInfo/ut/save",kIP];
        
        [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
           
            if (error) {
                NSLog(@"%@",error);
            }
            
            if ([response[@"errcode"] integerValue] == 60000) {
                [SVProgressHUD showInfoWithStatus:response[@"message"]];
            }
            
            if ([response[@"success"] integerValue] == 1) {
                
                [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
          
        }];
        
    }else {
        [SVProgressHUD showInfoWithStatus:@"请确认信息"];
    }
}






- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        _tableView.sectionHeaderHeight = 43;

        [_tableView registerNib:[UINib nibWithNibName:@"ZHInvoiceTableViewCell" bundle:nil] forCellReuseIdentifier:invoceCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHInvoiceMailTableViewCell" bundle:nil] forCellReuseIdentifier:invoceMailCellid];
    }
    return _tableView;
}

@end
