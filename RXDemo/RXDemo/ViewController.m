//
//  ViewController.m
//  RuiXueDemo
//
//  Created by 陈汉 on 2021/9/26.
//

#import "ViewController.h"
#import <RXSDK_Pure/RXSDK_Pure.h>
//#import <RXSDK/RXSDK.h>
//#import <RXSDK_OS/RXSDK_OS.h>
#import <objc/runtime.h>
#import "LoginModel.h"
#import <YYModel/YYModel.h>

@interface ViewController () <RXLoginDelegate>
@property (nonatomic, strong) NSString *antiFrom; // 防沉迷开始时间
@property (nonatomic, strong) NSString *antiTo;   // 防沉迷结束时间
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    int val = UIInterfaceOrientationLandscapeRight;
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    
//    [[RXService sharedSDK] initWithAppId:@"1002" channelId:@"weile" fromChannel:@"weile" sourceChannel:@"normal" cpid:@"1000049" baseUrl:@"http://channelapi.weiletest.com/"];
    
    // http://rxapi.weileapp.com
    // http://ruixue.weiletest.com
    
//    BOOL b = [[RXService sharedSDK] isWXAppInstalled];
    
    [RXService sharedSDK].loginDelegate = self;
//    [[RXService sharedSDK] loginWithExtDic:nil username:nil password:nil loginOpenId:nil loginType:LoginTypeApple];
//    [[RXService sharedSDK] loginReq_wWithWXAppid:@""];
}

- (void)setUI
{
    // 实名认证
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 130, 30)];
    [btn1 setTitle:@"实名认证" forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor redColor]];
    [btn1 addTarget:self action:@selector(btnAction1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    // 防沉迷
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(150, 100, 130, 30)];
    [btn2 setTitle:@"防沉迷" forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor redColor]];
    [btn2 addTarget:self action:@selector(btnAction2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    // 权限
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(10, 150, 130, 30)];
    [btn3 setTitle:@"权限" forState:UIControlStateNormal];
    [btn3 setBackgroundColor:[UIColor redColor]];
    [btn3 addTarget:self action:@selector(btnAction3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    // 切换屏幕方向
    UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(290, 100, 130, 30)];
    [btn4 setTitle:@"切换屏幕方向" forState:UIControlStateNormal];
    [btn4 setBackgroundColor:[UIColor redColor]];
    [btn4 addTarget:self action:@selector(btnAction4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    // 单条协议
    UIButton *btn5 = [[UIButton alloc] initWithFrame:CGRectMake(10, 200, 130, 30)];
    [btn5 setTitle:@"单条协议" forState:UIControlStateNormal];
    [btn5 setBackgroundColor:[UIColor redColor]];
    [btn5 addTarget:self action:@selector(btnAction5) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];
    
    // 获取法务信息
    UIButton *btn6 = [[UIButton alloc] initWithFrame:CGRectMake(10, 250, 130, 30)];
    [btn6 setTitle:@"获取法务信息" forState:UIControlStateNormal];
    [btn6 setBackgroundColor:[UIColor redColor]];
    [btn6 addTarget:self action:@selector(btnAction6) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn6];
    
    // 声明
    UIButton *btn7 = [[UIButton alloc] initWithFrame:CGRectMake(150, 200, 130, 30)];
    [btn7 setTitle:@"声明" forState:UIControlStateNormal];
    [btn7 setBackgroundColor:[UIColor redColor]];
    [btn7 addTarget:self action:@selector(btnAction7) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn7];
    
    // 登录
    UIButton *btn10 = [[UIButton alloc] initWithFrame:CGRectMake(150, 150, 130, 30)];
    [btn10 setTitle:@"登录" forState:UIControlStateNormal];
    [btn10 setBackgroundColor:[UIColor redColor]];
    [btn10 addTarget:self action:@selector(btnAction10) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn10];
    
    // 绑定手机
    UIButton *btn12 = [[UIButton alloc] initWithFrame:CGRectMake(150, 250, 130, 30)];
    [btn12 setTitle:@"绑定手机" forState:UIControlStateNormal];
    [btn12 setBackgroundColor:[UIColor redColor]];
    [btn12 addTarget:self action:@selector(btnAction12) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn12];
    
    // applepay
    UIButton *btn13 = [[UIButton alloc] initWithFrame:CGRectMake(10, 300, 130, 30)];
    [btn13 setTitle:@"applepay" forState:UIControlStateNormal];
    [btn13 setBackgroundColor:[UIColor redColor]];
    [btn13 addTarget:self action:@selector(btnAction13) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn13];
    
    // 修改用户信息
    UIButton *btn14 = [[UIButton alloc] initWithFrame:CGRectMake(150, 300, 130, 30)];
    [btn14 setTitle:@"修改用户信息" forState:UIControlStateNormal];
    [btn14 setBackgroundColor:[UIColor redColor]];
    [btn14 addTarget:self action:@selector(btnAction14) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn14];
    
    // 修改密码
    UIButton *btn15 = [[UIButton alloc] initWithFrame:CGRectMake(10, 350, 130, 30)];
    [btn15 setTitle:@"修改密码" forState:UIControlStateNormal];
    [btn15 setBackgroundColor:[UIColor redColor]];
    [btn15 addTarget:self action:@selector(btnAction15) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn15];
    
    // 获取验证码
    UIButton *btn16 = [[UIButton alloc] initWithFrame:CGRectMake(150, 350, 130, 30)];
    [btn16 setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn16 setBackgroundColor:[UIColor redColor]];
    [btn16 addTarget:self action:@selector(btnAction16) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn16];
    
    // 重置密码
    UIButton *btn17 = [[UIButton alloc] initWithFrame:CGRectMake(290, 150, 130, 30)];
    [btn17 setTitle:@"重置密码" forState:UIControlStateNormal];
    [btn17 setBackgroundColor:[UIColor redColor]];
    [btn17 addTarget:self action:@selector(btnAction17) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn17];
    
    // 微信登录
    UIButton *btn18 = [[UIButton alloc] initWithFrame:CGRectMake(290, 200, 130, 30)];
    [btn18 setTitle:@"微信登录" forState:UIControlStateNormal];
    [btn18 setBackgroundColor:[UIColor redColor]];
    [btn18 addTarget:self action:@selector(btnAction18) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn18];
    
    // 苹果登录
    UIButton *btn19 = [[UIButton alloc] initWithFrame:CGRectMake(290, 250, 130, 30)];
    [btn19 setTitle:@"苹果登录" forState:UIControlStateNormal];
    [btn19 setBackgroundColor:[UIColor redColor]];
    [btn19 addTarget:self action:@selector(btnAction19) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn19];
    
    // 一键登录
    UIButton *btn20 = [[UIButton alloc] initWithFrame:CGRectMake(290, 300, 130, 30)];
    [btn20 setTitle:@"一键登录" forState:UIControlStateNormal];
    [btn20 setBackgroundColor:[UIColor redColor]];
    [btn20 addTarget:self action:@selector(btnAction20) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn20];
    
    // 上报位置信息
    UIButton *btn21 = [[UIButton alloc] initWithFrame:CGRectMake(10, 400, 130, 30)];
    [btn21 setTitle:@"上报位置信息" forState:UIControlStateNormal];
    [btn21 setBackgroundColor:[UIColor redColor]];
    [btn21 addTarget:self action:@selector(btnAction21) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn21];
    
    // 查询附近人
    UIButton *btn22 = [[UIButton alloc] initWithFrame:CGRectMake(150, 400, 130, 30)];
    [btn22 setTitle:@"查询附近人" forState:UIControlStateNormal];
    [btn22 setBackgroundColor:[UIColor redColor]];
    [btn22 addTarget:self action:@selector(btnAction22) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn22];
    
    // 删除位置信息
    UIButton *btn23 = [[UIButton alloc] initWithFrame:CGRectMake(10, 450, 130, 30)];
    [btn23 setTitle:@"删除位置信息" forState:UIControlStateNormal];
    [btn23 setBackgroundColor:[UIColor redColor]];
    [btn23 addTarget:self action:@selector(btnAction23) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn23];
    
    // 微信分享
    UIButton *btn24 = [[UIButton alloc] initWithFrame:CGRectMake(150, 450, 130, 30)];
    [btn24 setTitle:@"微信分享" forState:UIControlStateNormal];
    [btn24 setBackgroundColor:[UIColor redColor]];
    [btn24 addTarget:self action:@selector(btnAction24) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn24];
    
    // 注销
    UIButton *btn25 = [[UIButton alloc] initWithFrame:CGRectMake(290, 450, 130, 30)];
    [btn25 setTitle:@"注销" forState:UIControlStateNormal];
    [btn25 setBackgroundColor:[UIColor redColor]];
    [btn25 addTarget:self action:@selector(btnAction25) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn25];
    
    // 获取通路配置
    UIButton *btn26 = [[UIButton alloc] initWithFrame:CGRectMake(10, 500, 130, 30)];
    [btn26 setTitle:@"获取通路配置" forState:UIControlStateNormal];
    [btn26 setBackgroundColor:[UIColor redColor]];
    [btn26 addTarget:self action:@selector(btnAction26) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn26];
    
    // webView测试
    UIButton *pushBtn = [[UIButton alloc] initWithFrame:CGRectMake(150, 650, 130, 30)];
    [pushBtn setTitle:@"webView" forState:UIControlStateNormal];
    [pushBtn setBackgroundColor:[UIColor redColor]];
    [pushBtn addTarget:self action:@selector(pushBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushBtn];
    
    // apidemo
    UIButton *apiBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 650, 130, 30)];
    [apiBtn setTitle:@"apiPush" forState:UIControlStateNormal];
    [apiBtn setBackgroundColor:[UIColor redColor]];
    [apiBtn addTarget:self action:@selector(apiBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:apiBtn];

}

- (void)apiBtnAction
{
//    [self.navigationController pushViewController:[RXApiVC new] animated:YES];
}

- (void)pushBtnAction
{
//    [self.navigationController pushViewController:[ViewController1 new] animated:YES];
}

- (void)btnAction26
{
    [[RXShareService sharedSDK] getSharePlatformsWithComplete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
        NSLog(@"");
    }];
}

- (void)btnAction25
{
    
}

- (void)btnAction24
{
//    [[RXShareService sharedSDK] getShareInfoWithFunc:@"lucky_turntable_double_free" transmitargs:@"" custom:@"" region:@"350203" shareScene:0 urlCustom:@{@"test": @"1"} complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
//        NSLog(@"");
//    }];
    
    [[RXShareService sharedSDK] getShareInfoWithFunc:@"youdao" platform:@"" region:@"350203" shareScene:0 transmits:nil complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
        NSLog(@"");
    }];
    
    NSDictionary *dic = @{
        @"wxid": @"wx595cc057ae448b00",
        @"shareScene": @(1),
        @"type": @"image",
        @"materialid": @(14),
        @"material": @"url",
        @"image": @"https://oss-anchor-v2.weile.com/share/link_contents/14.png",
        @"webpageUrl": @"http://dl2.jixiang61.cn/fish/jx/1213A/index.html",
        @"url": @"http://s.jixiangweb.com/jixiang/fish/general/index.html?identity=3zUJBR&rtag=20220127B",
        @"title": @"",
        @"description": @"",
        @"qrCodeX": @(50),
        @"qrCodeY": @(50),
        @"qrCodeW": @(100),
        @"qrCodeH": @(100),
        @"ext" : @{@"test" : @"22"},
//        @"protocol_ios": @"111"
    };
    
//    [[RXWXService sharedSDK] shareToWWithShareInfo:dic shareScene:0 complete:^(BOOL success) {
//        NSLog(@"分享结果:\n %@", success ? @"YES" : @"NO");
//        [[RXShareService sharedSDK] getshareReportWithParam:@{} complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
//        }];
//    }];
    
//    [[RXShareService sharedSDK] shareToWWithShareInfo:dic complete:^(BOOL success) {
//        NSLog(@"分享结果:\n %@", success ? @"YES" : @"NO");
//        [[RXShareService sharedSDK] getshareReportWithParam:@{} complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
//        }];
//    }];
    
//    [[RXShareService sharedSDK] SystemShareWithShareInfo:dic complete:^(BOOL success) {
//        NSLog(@"分享结果:\n %@", success ? @"YES" : @"NO");
//    }];
    
    
//    [[RXShareService sharedSDK] getShareLimitInfoWithFunc_tags:@[@"tag"] complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
//
//    }];
}

- (void)btnAction23
{
    [[RXContactService sharedSDK] deleteLocationWithTypes:@[@"boy"] complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
            
    }];
    
//    [[RXUpdateCheckService sharedSDK] checkUpdate_GameWithGame_id:111 region:@"地区码" client_version:@"1.0.0" type:@"js" game_version:1 game_check_version:1 complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
//
//    }];
}

- (void)btnAction22
{
    [[RXContactService sharedSDK] getRadiusAccount:1000 count:100 page:1 page_size:10 type:@"boy" complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
        
    }];
}

- (void)btnAction21
{
//    [[RXContactService sharedSDK] openLocationReportWithDuration:30 types:@[@"boy"]];
    [[RXContactService sharedSDK] getLocationInfo:^(RXLocationModel * _Nonnull location) {
        
    }];
    
//    [[RXContactService sharedSDK] addRelationWithTarget:@"" types:@{} target_remarks:@"" user_remarks:@"" complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
//
//    }];
    
//    [[RXContactService sharedSDK] deleteRelationWithTarget:@"" types:@{} complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
//
//    }];
    
//    [[RXContactService sharedSDK] updateRemarksWithTarget:@"" target_remarks:@"" type:@"" complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
//
//    }];
    
//    [[RXContactService sharedSDK] addFriendWithTarget:@"" target_remarks:@"" user_remarks:@"" complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
//
//    }];
    
//    [[RXContactService sharedSDK] deleteFriendWithTarget:@"" complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
//
//    }];
    
//    [[RXContactService sharedSDK] updateFriendRemarkWithTarget:@"" target_remarks:@"" complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
//
//    }];
    
//    [[RXContactService sharedSDK] getRankListWithRankId:@"" userId:@"" complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
//
//    }];
    
//    [[RXContactService sharedSDK] reportRankScoreWithRankId:@"" openId:@"" score:0 userId:0 complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
//
//    }];
}

- (void)btnAction20
{
    
}

- (void)btnAction19
{
    [[RXService sharedSDK] loginReq_apple];
    [[RXDestroyAccountService sharedSDK] destroyAccountWithIDCard:@"360402198611133850" realname:@"黄文杰" cpdata:@"{\"uid\":3356802,\"openid\":\"rxuL281WvMzwkoUBNZdSO9gn6_4VPp-o\",\"nick_name\":\"凉凉计时风\",\"sign\":\"7717F2948EC82F0A5DF03FCA24B33D7F\"}" complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {

    }];
}

- (void)btnAction18
{
//    [[RXService sharedSDK] loginReq_wWithWXAppid:@"wx242f30ff90bb6668"];
//    [[RXWXService sharedSDK] loginReq_wWithWXAppid:@"wx595cc057ae448b00"];
}

- (void)btnAction17
{
    // 先获取验证码
    [[RXApiService sharedSDK] resetPasswordWithUsername:@"18698646213" password:@"111111b" captchaCode:@"4599" complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
        NSLog(@"");
    }];
}

- (void)btnAction16
{
    [[RXApiService sharedSDK] getCaptchaCodeWithType:CaptchaType_email target:@"1173411140@qq.com" purpose:@"register" complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
        
    }];
}

- (void)btnAction15
{
    [[RXApiService sharedSDK] updatePasswordWithOldPwd:@"111111b" newPwd:@"111111a" complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
            
    }];
}

- (void)btnAction14
{
    [[RXApiService sharedSDK] updateUserInfoWithAvatarUrl:@"" nickname:@"test" sex:@"1" w_avatarurl:@"" complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
            
    }];
}

- (void)btnAction13
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setValue:@"1钻石" forKey:@"goodsName"];
//    [dict setValue:@"goods1" forKey:@"goodsTag"];
//    [dict setValue:[self getTime] forKey:@"tradeNo"];
//    [dict setValue:@"6" forKey:@"selectProductID"]; //商品ID
    [dict setValue:@"10000鱼币" forKey:@"goodsName"]; // 商品名称
    [dict setValue:@"830001008" forKey:@"goodsTag"]; // 商品标签
    [dict setValue:[self getTime] forKey:@"tradeNo"]; // 订单号
    [dict setValue:@"com.guiyangmj15.goods108" forKey:@"selectProductID"]; // 商品ID
    [dict setValue:@"apple" forKey:@"type"];
    [dict setValue:@"1" forKey:@"sandbox"]; // 0正式 1沙盒

    NSLog(@"%@",dict);
    
    [[RXPayService sharedSDK] requestWithDict:dict completeHandle:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
        if(!error){
            NSLog(@"下单成功");
        }else{
            NSLog(@"下单失败");
        }
    }];
    
//    [[Apiappzhifu sharedAppzhifu]requestWithDict:dict completeHandle:^(BOOL flag) {
//        if(flag){
//            NSLog(@"下单成功");
//        }else{
//            NSLog(@"下单失败");
//        }
//    }];
    
//    [[RXPayService sharedSDK] getProductInfoWithProductIdArr:@[@"6"] complete:^(NSArray<SKProduct *> *productInfoList) {
//        NSLog(@"");
//    }];
    
//    [[RXUpdateCheckService sharedSDK] checkUpdate_AppWithRegion:@"" client_version:@"" complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
//
//    }];
    
//    [[RXUpdateCheckService sharedSDK] checkUpdate_GameWithGame_id:1 game_version:1 game_check_version:@"1.0.0" complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
//
//    }];
    
//    [[RXUpdateCheckService sharedSDK] checkUpdate_GameWithGame_id:1 game_version:1 game_check_version:@"1.0.0" complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
//
//    }];
}

- (void)btnAction12
{
//    [[RXService sharedSDK] bindingPhoneWithComplete:^(NSDictionary * _Nonnull response, RXCommonRequestError * _Nonnull error) {
//
//    }];
    
//    [[RXApiService sharedSDK] bindingPhoneWithCaptchaCode:@"7238" password:nil phone:@"18698646213" complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
//
//    }];
//    [[RXApiService sharedSDK] reliveBindingPhoneWithCaptchaCode:@"0013" phone:@"18698646213" complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
//
//    }];
//    [[RXApiService sharedSDK] bindingEmailWithCaptchaCode:@"0545" password:nil email:@"894306571@qq.com" complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
//
//    }];
    [[RXApiService sharedSDK] reliveBindingEmailWithCaptchaCode:@"0322" email:nil complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
            
    }];
}

- (void)btnAction10
{
//    // 游客
//    RXUserInfoModel *user = [[RXUserInfoModel alloc] init];
//    user.userType = RXUserType_visitor;
//    // 苹果
//    RXUserInfoModel *user1 = [[RXUserInfoModel alloc] init];
//    user1.userType = RXUserType_apple;
//    // 微信
//    RXUserInfoModel *user2 = [[RXUserInfoModel alloc] init];
//    user2.userType = RXUserType_w;
//    user2.wxAppid = @"wx242f30ff90bb6668";
//    // 账号登录
//    RXUserInfoModel *user3 = [[RXUserInfoModel alloc] init];
//    user3.userType = RXUserType_account;
//    user3.userName = @"test";
//    user3.userPhone = @"testaccount10";
//    user3.userPassword = @"111111a";
//    user3.userIcon = @"https://xxx.png";
//    // 一键登录
//    RXUserInfoModel *user4 = [[RXUserInfoModel alloc] init];
//    user4.userType = RXUserType_auth;
//
//    NSMutableArray *arr = [NSMutableArray array];
//    [arr addObject:user];
//    [arr addObject:user1];
//    [arr addObject:user2];
//    [arr addObject:user3];
//    [arr addObject:user4];
//
//    [[RXUIKitService sharedSDK] setLoginViewWithAccounts:arr clickAddAccount:^{
//        // 注册/登录弹框
//        [[RXUIKitService sharedSDK] setAddAccountViewWithIsSelect:YES extDic:nil complete:^(BOOL success, NSString * _Nonnull username, NSString * _Nonnull password) {
//
//        }];
//    } loginType:^(LoginType loginType) {
//        // 业务端可根据不同登录方式传定制extDic
//        // 登录接口
//        NSString *username;
//        NSString *password;
//        switch (loginType) {
//            case LoginTypeAuth:
////                [[RXService sharedSDK] setAuthLoginViewWithPrivacy1:@"" privacy2:@""];
//                break;
//            case LoginTypeAccount:
//            {
////                NSDictionary *accountInfo = [[RXApiService sharedSDK] getAccountInfo];
////                username = accountInfo[@"username"];
////                password = accountInfo[@"password"];
//            }
//                break;
//            default:
//                break;
//        }
//        [[RXService sharedSDK] loginWithExtDic:nil username:username password:password loginOpenId:@"" loginType:loginType];
//    }];
    
    
    
    NSMutableDictionary *dic = @{@"logindata": @"vmV8YV1bqArlZM9vLFaBETedBzXY/3b3ZES8PSJqQSHmEZ76hM22doPMPnUKlYVV1xMFYIggjSA247cFEMWPAGKmM/6lALUWgZwfYnvkxE4l68kAnAB8SAUzayqyE7R+JCpShfm635QPJQlaw61gqLKx/7EQbV9AbmZf6UFFvd0=",
                          @"regtime": @"2022-02-11 18:04:11"}.mutableCopy;
    [[RXService sharedSDK] loginWithExtDic:dic username:@"testaccount22" password:@"111111a" loginOpenId:@"" loginType:LoginTypeVisitor];
//    return;
    
    // 游客
//    RXUserInfoModel *user = [[RXUserInfoModel alloc] init];
//    user.userType = RXUserType_visitor;
//    // 苹果
//    RXUserInfoModel *user1 = [[RXUserInfoModel alloc] init];
//    user1.userType = RXUserType_apple;
//    // 微信
//    RXUserInfoModel *user2 = [[RXUserInfoModel alloc] init];
//    user2.userType = RXUserType_w;
//    user2.wxAppid = @"wx242f30ff90bb6668";
//    // 账号登录
//    RXUserInfoModel *user3 = [[RXUserInfoModel alloc] init];
//    user3.userType = RXUserType_account;
//    user3.userName = @"test";
//    user3.userPhone = @"testaccount10";
//    user3.userPassword = @"111111a";
//    user3.userIcon = @"https://xxx.png";
//    // 一键登录
//    RXUserInfoModel *user4 = [[RXUserInfoModel alloc] init];
//    user4.userType = RXUserType_auth;
//
//    NSMutableArray *arr = [NSMutableArray array];
//    [arr addObject:user];
//    [arr addObject:user1];
//    [arr addObject:user2];
//    [arr addObject:user3];
//    [arr addObject:user4];
//
//
//    [[RXService sharedSDK] setLoginViewWithAccounts:arr clickAddAccount:^{
//        // 注册/登录弹框
//        [[RXService sharedSDK] setAddAccountViewWithIsSelect:YES extDic:nil complete:^(BOOL success, NSString * _Nonnull username, NSString * _Nonnull password) {
//
//        }];
//    } loginType:^(LoginType loginType) {
//        // 业务端可根据不同登录方式传定制extDic
//        // 登录接口
//        NSString *username;
//        NSString *password;
//        switch (loginType) {
//            case LoginTypeAuth:
//                [[RXService sharedSDK] setAuthLoginViewWithPrivacy1:@"" privacy2:@""];
//                break;
//            case LoginTypeAccount:
//            {
//                NSDictionary *accountInfo = [[RXApiService sharedSDK] getAccountInfo];
//                username = accountInfo[@"username"];
//                password = accountInfo[@"password"];
//            }
//                break;
//            default:
//                break;
//        }
//        [[RXService sharedSDK] loginWithExtDic:nil username:username password:password loginOpenId:@"" loginType:loginType];
//    }];
}

#pragma mark -- <登录回调>
- (void)rx_LoginCallBackWithResponse:(NSDictionary *)response error:(RXCommonRequestError *)error
{
    if (!error) {
//        [[RXPushService sharedSDK] registerDeviceToken:deviceToken complete:^(BOOL success, NSError * _Nonnull error) {
//
//        }];
        // 获取法务信息--防沉迷，权限，协议弹框等需要法务内容
//        NSDictionary *loginResponse = response;
//        [[RXService sharedSDK] getLegalInfo:^(NSDictionary * _Nonnull response, RXCommonRequestError * _Nonnull error) {
//            NSDictionary *antiDic = response[@"antiAddiction"];
//            NSDictionary *userLimitDic = antiDic[@"useLimit"];
//            NSLog(@"");
//            [[RXService sharedSDK] closeLoginView];
//            LoginModel *loginModel = [LoginModel yy_modelWithDictionary:loginResponse[@"data"]];
//            [[NSUserDefaults standardUserDefaults] setValue:loginModel.login_openid forKey:@"openid"];
//            BOOL isApprove = (loginModel.attr&1)==1; // 是否实名认证 NO为未实名
//            BOOL isBindingPhone = (loginModel.attr&2)==2; // 是否绑定手机 NO为未绑定
//            BOOL needAnti = (loginModel.flag&2)==2; // 是否需要开启防沉迷
//            if (!isApprove) {
//                // 实名认证
//                [[RXService sharedSDK] setApproveViewWithComplete:^(NSDictionary * _Nonnull backData, RXCommonRequestError * _Nonnull error) {
//                    // 实名后开启防沉迷
//                    NSInteger aas = [backData[@"data"][@"aas"] integerValue];
//                    NSInteger flag = [backData[@"data"][@"flag"] integerValue];
//                    BOOL needAnti_approve = (flag&2)==2; // 是否需要开启防沉迷
//                    if (needAnti_approve) {
//                        [self openAntiTimer:aas];
//                    }
//                }];
//            } else {
//                if (needAnti) {
//                    [self openAntiTimer:loginModel.aas];
//                }
//            }
//        }];

//        [[RXPushService sharedSDK] registerDeviceToken:[[NSUserDefaults standardUserDefaults] valueForKey:@"deciceToken"]];
//        [[RXPushService sharedSDK] bindingAlias:@"别名"];
//        [[RXPushService sharedSDK] reliveBinding];
//        [[RXPushService sharedSDK] addTags:@[@"tag1", @"tag2"]];
//        [[RXPushService sharedSDK] deleteTags:@[@"tag1"]];
//        [[RXPushService sharedSDK] reliveBindingPushDevice];
    } else {
    }
}

#pragma mark -- <开启防沉迷>
- (void)openAntiTimer:(NSInteger)aas
{
    NSTimer *antiTimer = [NSTimer scheduledTimerWithTimeInterval:aas target:self selector:@selector(antimerAction:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:antiTimer forMode:NSRunLoopCommonModes];
}

- (void)antimerAction:(NSTimer *)timer
{
    NSInteger antiTime = [self pleaseInsertStarTime:self.antiFrom andInsertEndTime:self.antiTo];
//    [[RXService sharedSDK] setAntiAdditionViewWithTitle:@"未成年人防沉迷登录限制提示" des:[NSString stringWithFormat:@"仅可在周五，周六，周日和法定节假日每日%@至%@向未成年人提供%ld小时网络游戏服务，目前已达到下线要求时间，请您退出游戏", self.antiFrom, self.antiTo, (long)antiTime] type:AntiBtnType_logout complete:^{
//
//    }];
    [timer invalidate];
    
}

#pragma mark -- <getter>
// 获取时间差
- (NSInteger)pleaseInsertStarTime:(NSString *)starTime andInsertEndTime:(NSString *)endTime{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"mm:ss"];//根据自己的需求定义格式
    NSDate* startDate = [formater dateFromString:starTime];
    NSDate* endDate = [formater dateFromString:endTime];
    NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:startDate];
    NSInteger time = (int)timeInterval / 60;
    return time;
}

- (void)btnAction1
{
    [[RXApiService sharedSDK] approveWithRealName:@"黄文杰" idCard:@"360402198611133850" complete:^(NSDictionary * _Nullable response, RXCommonRequestError * _Nullable error) {
                
    }];
#warning test -- 系统分享测试
//    UIActivityViewController *vc = [[UIActivityViewController alloc]initWithActivityItems:@[@"123",[NSURL URLWithString:@"https://www.baidu.com"]] applicationActivities:nil];
//    vc.view.frame = CGRectMake(0, 0, 300, 100);
//    vc.excludedActivityTypes = @[UIActivityTypePostToFacebook, UIActivityTypePostToTwitter, UIActivityTypePostToWeibo, UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop,UIActivityTypeOpenInIBooks];
//    [vc setValue:@(100) forKeyPath:@"_collectionView.frame.size.height"];
//    vc.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:vc animated:YES completion:nil];
//    for (UIView *v in [UIApplication sharedApplication].keyWindow.subviews) {
//        NSLog(@"%@", [v class]);
//        UILayoutContainerView *layout = (UILayoutContainerView *)v;
//    }1
    
//    [[RXService sharedSDK] setApproveViewWithComplete:^(NSDictionary * _Nonnull backData, RXCommonRequestError * _Nonnull error) {
//
//    }];
}

- (void)btnAction2
{
//    [[RXService sharedSDK] setAntiAdditionViewWithTitle:@"提示" des:@"未满18不能充值" type:AntiBtnType_default complete:^{
//
//    }];
}

- (void)btnAction3
{
    // @[@"phone", camera]
    // 取配置接口下的permission list key
//    [[RXService sharedSDK] setLimitViewWithKeys:@[@"phone", @"camera"] clickBlock:^(NSInteger status) {
//
//    }];
}

- (void)btnAction4
{
    BOOL rota = [[NSUserDefaults standardUserDefaults] boolForKey:@"rotation"];
    [[NSUserDefaults standardUserDefaults] setBool:!rota forKey:@"rotation"];
    exit(0);
}

- (void)btnAction5
{
//    [[RXService sharedSDK] setProtocolViewWithKey:@"00006" complete:^(BOOL isAgree) {
//
//    }];
}

- (void)btnAction6
{
    
    [[RXService sharedSDK] getLegalInfo:^(NSDictionary * _Nonnull response, RXCommonRequestError * _Nonnull error) {
        NSDictionary *antiDic = response[@"antiAddiction"];
        NSDictionary *userLimitDic = antiDic[@"useLimit"];
        self.antiFrom = userLimitDic[@"timeFrom"];
        self.antiTo = userLimitDic[@"timeTo"];
        // TODO: 先获取法务信息后调用登录
        
    }];
}

- (void)btnAction7
{
//    [[RXService sharedSDK] setPrivacyViewWithKey:@"00004"];
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

-(NSString *)getTime{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970]*1000; // *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a]; //转为字符型
    return timeString;
}

@end
