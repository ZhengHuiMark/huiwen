//
//  ZHTabBarViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/8/22.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHTabBarViewController.h"
#import "ZHNavigationVC.h"

@interface ZHTabBarViewController ()

@end

@implementation ZHTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



-(void)addController
{
    
    //添加五个nav控制器的子控制器
    UIViewController *HomeViewController = [self setControllerWith:@"HomeViewController" Title:@"首页" image:@"home-"];
    HomeViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIViewController *AskViewController =  [self setControllerWith:@"QAViewController" Title:@"提问" image:@""];
    AskViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIViewController *StudyViewController =  [self setControllerWith:@"FocusViewController" Title:@"关注" image:@"follow"];
    StudyViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"follow-"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIViewController *MineViewController =  [self setControllerWith:@"MineViewController" Title:@"我的" image:@"我的2"];
        MineViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"我的1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    
    //将nav控制器传给tabbar控制器
    //    self.viewControllers = @[HomeViewController,QAViewController,FocusViewController,MineViewController];
    self.viewControllers = @[HomeViewController,AskViewController,StudyViewController,MineViewController];
}


//多态
-(UIViewController *)setControllerWith:(NSString *)className  Title:(NSString *)title image:(NSString *)imageName
{
    Class clz = NSClassFromString(className);
    UIViewController *controller = [[clz alloc]init];
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:[ NSString stringWithFormat:@"%@_Sel",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ZHNavigationVC *navController = [[ZHNavigationVC alloc]initWithRootViewController:controller];
    
    return navController;
    
}



@end
