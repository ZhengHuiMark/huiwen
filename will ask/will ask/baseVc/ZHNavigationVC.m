//
//  ZHNavigationVC.m
//  will ask
//
//  Created by 郑晖 on 2017/8/22.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHNavigationVC.h"

@interface ZHNavigationVC ()

@end


@implementation ZHNavigationVC


- (void)viewDidLoad {
    [super viewDidLoad];
    //     //取消导航栏的分割线
    //    [self.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationBar setShadowImage:[[UIImage alloc]init]];
    //取消导航栏的穿透效果，不取消，则头部视图的高度是从顶部算起
        self.navigationBar.translucent = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    //设置文字的颜色
//    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    
    [self.navigationBar setTintColor:[UIColor blackColor]];
    
    
//    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    //    [navigationBarAppearance setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"ffffff"]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setTintColor:[UIColor colorWithHexString:@"666666"]];//返回按钮的箭头颜色
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName: [UIFont systemFontOfSize:18.0],
                                     NSForegroundColorAttributeName: [UIColor colorWithHexString:@"3333333"],
                                     };
    //    [[UINavigationBar appearance] setShadowImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"3333333"]]];
    
    [self.navigationBar setTitleTextAttributes:textAttributes];
    [self.navigationBar.backItem.backBarButtonItem setTitle:@""];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin)
                                                         forBarMetrics:UIBarMetricsDefault];
    

  

}

//设置状态栏为白色
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 跳转其他控制器是掩藏tabBAr
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}



@end
