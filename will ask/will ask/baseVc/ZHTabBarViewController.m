//
//  ZHTabBarViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/8/22.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHTabBarViewController.h"
#import "ZHNavigationVC.h"
#import "HomeViewController.h"
#import "AskViewController.h"
#import "StudyViewController.h"
#import "MineViewController.h"

@interface ZHTabBarViewController ()

@end

@implementation ZHTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addController];
}



-(void)addController
{
    
    //添加四个nav控制器的子控制器
    UIViewController *HomeViewController = [self setControllerWith:@"HomeViewController" Title:@"首页" image:@"001"];
    HomeViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"h001"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIViewController *AskViewController =  [self setControllerWith:@"AskViewController" Title:@"提问" image:@"002"];
    AskViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"h0023x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIViewController *StudyViewController =  [self setControllerWith:@"StudyViewController" Title:@"关注" image:@"003"];
    StudyViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"h003"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIViewController *MineViewController =  [self setControllerWith:@"MineViewController" Title:@"我的" image:@"004"];
        MineViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"h004"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    
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
