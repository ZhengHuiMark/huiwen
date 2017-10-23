//
//  ValidationViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/9/29.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ValidationViewController.h"
#import "ZHHeaderAvatarTableViewCell.h"
#import "ZHExpertsEditTableViewCell.h"
#import "ZHIdCardTableViewCell.h"
#import "ZHExpertChooseTableViewCell.h"
#import "ZHValidationCertificateCell.h"
#import "ValidationViewControllerHeader.h"

@interface ValidationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic , strong)UITableView *tableView;
@end

@implementation ValidationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 62, 20)] ;
    titleLabel.text  = @"个人信息";
    //    titleLabel.backgroundColor  = [UIColor blueColor]   ;
    
    titleLabel.textColor = [UIColor blackColor] ;
    
    titleLabel.font= [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;

    self.view.backgroundColor = [UIColor blueColor];

    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = backBtn;
    
    
    [self setupTableView];
}

#pragma mark - Basic 
- (void)setupTableView{
    
    [self.view addSubview:self.tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    
    switch (indexPath.section) {
        case kValidationViewControllerSection_Avatar: {
            cell = [self obtainAvatarCellWithTableView: tableView atIndexPath: indexPath];
        }
            break;
            
        case kValidationViewControllerSection_UserInfo: {
            cell = [self obtainEditCellWithTableView: tableView
                                             atIndexPath: indexPath];
        }
            break;
            
        case kValidationViewControllerSection_Identity: {
            switch (indexPath.row) {
                case kValidationViewControllerRow_Identity: {
                    cell = [self obtainIdentifierCellWithTableView:tableView
                                                      atIndexPath: indexPath];
                }
                    break;
                    
        case kValidationViewControllerSectionCertificateType:{
                    switch (indexPath.row) {
                        case kValidationViewControllerRow_CertificateType:
                            cell = [self obtainExpertChooseCellWithTableView:tableView atIndexPath:indexPath];
                            break;
                    }
                }
                default:
                    break;
            }
        }
            break;
    }
    
    return cell?cell:[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                            reuseIdentifier: @"Cell"];
}



- (ZHHeaderAvatarTableViewCell *)obtainAvatarCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    
    ZHHeaderAvatarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: NSStringFromClass([ZHHeaderAvatarTableViewCell class])
                                                                  forIndexPath: indexPath];
    
    return  cell;
    
}

- (ZHExpertsEditTableViewCell *)obtainEditCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    
    ZHExpertsEditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: NSStringFromClass([ZHExpertsEditTableViewCell class])
                                                                  forIndexPath: indexPath];
    
    return  cell;
    
}

- (ZHIdCardTableViewCell *)obtainIdentifierCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    
    ZHIdCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: NSStringFromClass([ZHIdCardTableViewCell class])
                                                                       forIndexPath: indexPath];
    
    return  cell;
    
}

- (ZHExpertChooseTableViewCell *)obtainExpertChooseCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    
    ZHExpertChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: NSStringFromClass([ZHExpertChooseTableViewCell class])
                                                                       forIndexPath: indexPath];
    
    return  cell;
    
}

- (ZHValidationCertificateCell *)obtainValidationCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    
    ZHValidationCertificateCell *cell = [tableView dequeueReusableCellWithIdentifier: NSStringFromClass([ZHValidationCertificateCell class])
                                                                       forIndexPath: indexPath];
    
    return  cell;
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return kValidationViewControllerSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case kValidationViewControllerSection_Avatar:{
            return kValidationViewControllerSectionRowCountInSectionUserAvatar;
        }
            break;
        case kValidationViewControllerSection_UserInfo:{
            return kValidationViewControllerSectionRowCountInSectionUserInfo;
        }
            break;
        case kValidationViewControllerSection_Identity:{
            return kValidationViewControllerSectionRowCountInSectionIdentity;
        }
            break;
        case kValidationViewControllerSectionCertificateType:{
            return kValidationViewControllerSectionRowCountInSectionCertificateType;
        }
            break;
            
//        case kValidationViewControllerSection_Certificate:{
//            return kValidationViewControllerSectionRowCountInSectionCertificate;
//        }
//            break;
        
        default:
            break;
    }
    return 0;
}

#pragma mark - Lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        
        
        NSBundle *bundle = [NSBundle mainBundle];
       
        [_tableView registerNib: [UINib nibWithNibName: NSStringFromClass([ZHHeaderAvatarTableViewCell class]) bundle: bundle]
         forCellReuseIdentifier: NSStringFromClass([ZHHeaderAvatarTableViewCell class])];
      
        [_tableView registerNib: [UINib nibWithNibName: NSStringFromClass([ZHExpertsEditTableViewCell class]) bundle: bundle]
         forCellReuseIdentifier: NSStringFromClass([ZHExpertsEditTableViewCell class])];
        
        [_tableView registerNib: [UINib nibWithNibName: NSStringFromClass([ZHIdCardTableViewCell class]) bundle: bundle]
         forCellReuseIdentifier: NSStringFromClass([ZHIdCardTableViewCell class])];
     
        [_tableView registerNib: [UINib nibWithNibName: NSStringFromClass([ZHExpertChooseTableViewCell class]) bundle: bundle]
         forCellReuseIdentifier: NSStringFromClass([ZHExpertChooseTableViewCell class])];
       
        [_tableView registerNib: [UINib nibWithNibName: NSStringFromClass([ZHValidationCertificateCell class]) bundle: bundle]
         forCellReuseIdentifier: NSStringFromClass([ZHValidationCertificateCell class])];
        


    }
    
    return _tableView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case kValidationViewControllerSection_Avatar: {
            return kValidationViewControllerRowHeight_Avatar;
        }
            break;
            
        case kValidationViewControllerSection_UserInfo: {
            return kValidationViewControllerRowHeight_UserInfo;
        }
            break;
        case kValidationViewControllerSection_Identity:{
            return kValidationViewControllerRowHeight_Identity;
        }
            
        case kValidationViewControllerSectionCertificateType: {
        
                    return kValidationViewControllerRowHeight_CertificateType;
                }
              
            break;
        }
    
    
            return 0;
    }

@end
