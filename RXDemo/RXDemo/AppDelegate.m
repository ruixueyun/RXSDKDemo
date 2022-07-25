//
//  AppDelegate.m
//  RXDemo
//
//  Created by 陈汉 on 2022/7/25.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <RXSDK_Pure/RXSDK_Pure.h>
#import <objc/runtime.h>
#import <UserNotifications/UserNotifications.h>
//#import <RXSDK_OS/RXSDK_OS.h>
//#import <RXWXSDK/RXWXSDK.h>

@interface AppDelegate ()

@property (nonatomic, assign) BOOL allowRotation;//是否允许转向

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    
    ViewController *rootVC = [[ViewController alloc] init];

    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:rootVC];
    self.window.rootViewController = naVC;
    [self.window makeKeyAndVisible];
    
    _allowRotation = [[NSUserDefaults standardUserDefaults] boolForKey:@"rotation"];
    
    [[RXService sharedSDK] initWithProductId:@"1002"
                                   channelId:@"100"
                                        cpid:@"1000049"
                                 baseUrlList:@[@"https://ruixue.weiletest.com/"]];
//    [[RXWXService sharedSDK] configUniversallink:@"https://open.adaptablenb.com/jxfish/"];
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    //处理接收到的推送通知
    if (@available(iOS 10.0,*)) {
        completionHandler(UIBackgroundFetchResultNoData);
    }else {
        completionHandler(UIBackgroundFetchResultNewData);
    }
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window{
    if (_allowRotation == YES) { //仅允许屏幕向左旋转
        return UIInterfaceOrientationMaskLandscapeLeft;
    }else{ //仅允许竖屏
        return (UIInterfaceOrientationMaskPortrait);
    }
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
//    if([[RXWXService sharedSDK] handleOpenUrl:url]){
//        return YES;
//    }
//    if ([[RXFacebookService sharedSDK] FBApplication:app openURL:url options:options]) {
//        return YES;
//    }
//    if ([[RXGooleService sharedSDK] GOpenURL:url]) {
//        return YES;
//    }
     
    return YES;
}

#pragma mark - 注册APNS
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    if (![deviceToken isKindOfClass:[NSData class]]) return;
    NSString *pushToken=@"";
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 13.0) {
        const unsigned *tokenBytes = [deviceToken bytes];
        pushToken = [NSString stringWithFormat:@"%08x %08x %08x %08x %08x %08x %08x %08x",
                     ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                     ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                     ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    }
    else{
        pushToken = [NSString stringWithFormat:@"%@", deviceToken];
        if (pushToken != nil && pushToken.length> 3) {
            pushToken = [pushToken substringFromIndex:1];
            pushToken = [pushToken substringToIndex:pushToken.length -1];
        }
    }
    NSLog(@"deviceToken= %@", pushToken);
    [[NSUserDefaults standardUserDefaults] setValue:pushToken forKey:@"deciceToken"];
//    [[RXPushService sharedSDK] registerDeviceToken:deviceToken openId:@"openId" complete:^(BOOL success, NSError * _Nonnull error) {
//
//    }];
}

- (void)RXUserNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    NSLog(@"");
}

- (void)RXUserNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
    NSLog(@"");
}

/** appdelegate */
- (id<UIApplicationDelegate>)applicationDelegate {
    return [UIApplication sharedApplication].delegate;
}

/** 返回当前控制器 */
- (UIViewController *)currentViewController {
    
    UIViewController *rootViewController = [self applicationDelegate].window.rootViewController;
    return [self currentViewControllerFrom:rootViewController];
}

/** 返回当前的导航控制器 */
- (UINavigationController *)currentNavigationViewController {
    
    UIViewController *currentViewController = [self currentViewController];
    return currentViewController.navigationController;
}

/** 通过递归拿到当前控制器 */
- (UIViewController *)currentViewControllerFrom:(UIViewController*)viewController {
    
    // 如果传入的控制器是导航控制器,则返回最后一个
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController *navigationController = (UINavigationController *)viewController;
        return [self currentViewControllerFrom:navigationController.viewControllers.lastObject];
    }
    // 如果传入的控制器是tabBar控制器,则返回选中的那个
    else if([viewController isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController *tabBarController = (UITabBarController *)viewController;
        return [self currentViewControllerFrom:tabBarController.selectedViewController];
    }
    // 如果传入的控制器发生了modal,则就可以拿到modal的那个控制器
    else if(viewController.presentedViewController != nil) {
        return [self currentViewControllerFrom:viewController.presentedViewController];
    }
    else {
        return viewController;
    }
}

@end
