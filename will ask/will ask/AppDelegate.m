//
//  AppDelegate.m
//  will ask
//
//  Created by 郑晖 on 2017/8/9.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "AppDelegate.h"
#import "ZHNavigationVC.h"
#import "ZHTabBarViewController.h"
#import "IQKeyboardManager.h"
#import "OssService.h"
#import "ZHNetworkTools.h"
#import "Macro.h"
#import "JPushMessageModel.h"
#import "ZHCertifiedExpertsVC.h"
#import "ZHTabBarViewController.h"
#import "AskViewController.h"


#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>


//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

#import "WXApiManager.h"

#import <AlipaySDK/AlipaySDK.h>
#import "KSGuaidViewManager.h"



@interface AppDelegate ()<JPUSHRegisterDelegate,WXApiDelegate>



@end

@implementation AppDelegate{
    NSMutableArray *_dataSoureMArray;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _dataSoureMArray = [NSMutableArray array];
    // Override point for customization after application launch.
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:@"1cf52d9cbc7c4"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            //                            @(SSDKPlatformTypeMail),
                            //                            @(SSDKPlatformTypeSMS),
                            //                            @(SSDKPlatformTypeCopy),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            //                            @(SSDKPlatformTypeRenren),
                            //                            @(SSDKPlatformTypeGooglePlus)
                            ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
                 
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wxc264c5d4f565c692"
                                       appSecret:@"db5c2c9660c35df6859bbd86d81e9b83"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"101390845"
                                      appKey:@"dbf1116f5cbb580975f2d2c7140ba117"
                                    authType:SSDKAuthTypeBoth];
                 break;
                 
             default:
                 break;
         }
         
     }];
    //注册微信支付
    [WXApi registerApp:@"wxc264c5d4f565c692"];
    
    NSInteger code = 1;
    [JPUSHService getAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
        NSLog(@"!@#@!#!#1234567889");
    } seq:code];
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:@"c6c150e320ab64b3307067c7"
                          channel:@"AppStore"
                 apsForProduction:NO
            advertisingIdentifier:nil];
    
    /** 极光自定义消息通知 */
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
    
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    
    manager.enable = YES;
    
    manager.shouldResignOnTouchOutside = YES;
    
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    
    manager.enableAutoToolbar = NO;
    
    
   
    
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    

    ZHTabBarViewController *tabBarVC = [[ZHTabBarViewController alloc]init];
 
    tabBarVC.selectedIndex = 1;
    _window.rootViewController = tabBarVC;
    
    [_window makeKeyAndVisible];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    
    KSGuaidManager.images = @[[UIImage imageNamed:@"bj"],
                              [UIImage imageNamed:@"bj"],
                              [UIImage imageNamed:@"bj"],
                              [UIImage imageNamed:@"bj"]];
    
    KSGuaidManager.dismissButtonImage = [UIImage imageNamed:@"会问"];
    KSGuaidManager.dismissButtonCenter = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height - 80);
    [KSGuaidManager begin];

    return YES;
}

#pragma mark - 极光自定义消息回调
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的Extras附加字段，key是自己定义的
    NSString *title = [userInfo valueForKey:@"title"];
    
    
    NSLog(@"自定义message:%@",userInfo);
    
    NSLog(@"content = %@",content);
    NSLog(@"title = %@",title);
    
    NSLog(@"推%@",extras);
    
    NSLog(@"推%@",customizeField1);
    
    
    NSArray *arr =[NSKeyedUnarchiver unarchiveObjectWithFile:kPersonInfoPath];
    _dataSoureMArray = [NSMutableArray arrayWithArray:arr];
    
    
    JPushMessageModel *model = [JPushMessageModel new];
    model.time = extras[@"time"];
    model.objectId = extras[@"objectId"];
    model.linkType = extras[@"linkType"];
    model.msgType = extras[@"msgType"];
    model.content = userInfo[@"content"];
    model.title = userInfo[@"title"];
    model.pushType = extras[@"pushType"];
    model.isMessageSelection = NO;
    model.isHiddenChooseBtn = YES;
    model.isRead = NO;
    [_dataSoureMArray insertObject:model atIndex:0];

    
    BOOL ret =  [NSKeyedArchiver archiveRootObject:_dataSoureMArray toFile:kPersonInfoPath];
    if (ret) {
        NSLog(@"归档成功");
    }else{
        NSLog(@"归档失败");
    }

//    [JPUSHService addTags:(NSSet<NSString *> *) completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
//        code
//    } seq:(NSInteger)];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kJPushMessage object:nil];
}



#pragma mark - 极光推送回调
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    
    
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
        
        NSDictionary *aps = [userInfo valueForKey:@"aps"];
        
        NSString *content = [aps valueForKey:@"alert"];//推送显示的内容
        
        int badge = [[aps valueForKey:@"badge"] intValue];//badge数量
        
        NSString *sound = [aps valueForKey:@"sound"];//播放的声音
        
        //取得Extras字段内容(额外的附加信息)
        
        
  
        NSString *customizeField1 = [userInfo valueForKey:@"Extras"];//服务端中Extras字段，key是自己定义的
        
        NSLog(@"自定义message:%@",userInfo);
        
        
        NSLog(@"推%@",content);
        
//        NSLog(@"推%@",extras);
        
        NSLog(@"推%@ = %@",customizeField1,userInfo[@"linkType"]);
       
        
        switch ([userInfo[@"linkType"] integerValue]) {
            case 11:
                
                break;
            case 12:
            {
                ZHCertifiedExpertsVC *expertVc = [[ZHCertifiedExpertsVC alloc]init];
//                [self.inputViewController.navigationController pushViewController:expertVc animated:YES];
                ZHTabBarViewController *tabVC = (ZHTabBarViewController *)self.window.rootViewController;
                ZHNavigationVC *nav = tabVC.viewControllers[tabVC.selectedIndex];
                [nav pushViewController:expertVc animated:YES];
            }
                
                break;
    
            default:
                break;
        }
        
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@" 推送消息 = %@",userInfo);
    completionHandler(UIBackgroundFetchResultNewData);
}


// iOS9.0及9.0以后调用此方法
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    // 在此方法中做如下判断，因为还有可能有其他的支付，如支付宝就是@"safepay"
    if ([url.host isEqualToString:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}


//微信SDK自带的方法，处理从微信客户端完成操作后返回程序之后的回调方法,显示支付结果的
-(void)onResp:(BaseResp*)resp
{
    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
                payResoult = @"支付结果：成功！";
                break;
            case -1:
                payResoult = @"支付结果：失败！";
                break;
            case -2:
                payResoult = @"用户已经退出支付！";
                break;
            default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@, resp.errCode,resp.errStr"];
                break;
        }
    }
    
}



// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
