//
//  UserManager.m
//  will ask
//
//  Created by 郑晖 on 2017/9/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "UserManager.h"
#import "ZHNavigationVC.h"

@implementation UserManager

#pragma mark - Shared Singleton

static UserManager *_instance = nil;
+ (instancetype)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone: NULL] init];
    });
    return _instance;
}

+(id) allocWithZone:(struct _NSZone *)zone {
    return [self sharedManager] ;
}

-(id) copyWithZone:(struct _NSZone *)zone {
    return [[self class] sharedManager] ;
}


- (void)saveUserModel {
    
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject: self.userModel];
    [[NSUserDefaults standardUserDefaults] setObject: data forKey: @"userModel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//
- (void)removeUserModel {
    //
    self.userModel = nil;
    //
    //
    //    [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey: @"userModel"]; // 测试代码
    [[NSUserDefaults standardUserDefaults] setObject: nil forKey: @"userModel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Public methods
+ (BOOL)isLogin:(ZHLoginCompletion)completion {
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName: @"loginSuccess"
                                                        object: nil];
    if ([UserManager sharedManager].userModel) return YES;
    
    ZHLoginViewController *tabBarVC = [[ZHLoginViewController alloc]initWithNibName:[NSString stringWithFormat:@"ZHLoginInViewController"] bundle:[NSBundle mainBundle]];
    tabBarVC.loginCompletion = completion;
    ZHNavigationVC *nav = [[ZHNavigationVC alloc] initWithRootViewController:tabBarVC];
    [nav.navigationBar setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController: nav
//                                                                                 animated: YES completion: nil];
    [[UIApplication sharedApplication].keyWindow.rootViewController popoverPresentationController];
    
    
    return NO;
}

#pragma mark - Override Setter/Getter Methods
- (UserModel *)userModel {
    
    if (_userModel) return _userModel;
    
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey: @"userModel"];
    if (!obj) return nil;
    
    _userModel = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"UserModel"]];
    
    //    BOOL islogin = [[[NSUserDefaults standardUserDefaults] objectForKey: @"userModel"] boolValue];
    //    if (islogin) {
    //        return [UserModel new];
    //    }
    
    return _userModel;
}

@end
