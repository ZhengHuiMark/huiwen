//
//  HomeViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/8/22.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "HomeViewController.h"
#import "ZHLoginViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor redColor];
    [self configUI];
}

- (void)configUI{
    
    UIButton *button  = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(actionModal) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
}

- (void)actionModal{
    
    ZHLoginViewController *loginVc = [[ZHLoginViewController alloc]init];
    
    [self.navigationController pushViewController:loginVc animated:YES];
    
}
@end
