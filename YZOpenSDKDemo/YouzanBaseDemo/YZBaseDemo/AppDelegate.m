//
//  AppDelegate.m
//  youzanIOSDemo
//
//  Copyright (c) 2012-2015 © youzan.com. All rights reserved.
//

#import "AppDelegate.h"
#import <Unsuggest/UnsuggestMethod.h>
#import <YZBaseSDK/YZBaseSDK.h>
#import <Unsuggest/UnsuggestMethod.h>
#import "UserModel.h"

static NSString *const SCHEME = @"yzbasedemo";/**< demo 的 scheme */

@interface AppDelegate () <YZSDKDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 初始化sdk
    YZConfig *conf = [[YZConfig alloc] initWithClientId:CLIENT_ID];
    conf.enableLog = NO; // 关闭 sdk 的 log 输出
    conf.scheme = SCHEME; // 配置 scheme 以便微信支付完成后跳转
    [YZSDK.shared initializeSDKWithConfig:conf];
    YZSDK.shared.delegate = self; // 必须设置代理方法，保证 SDK 在需要 token 的时候可以正常运行
    
    // 查看 sdk 的版本
    NSLog(@"%@", YZSDK.shared.version);

    return YES;
}

- (void)yzsdk:(YZSDK *)sdk
needInitToken:(void (^)(NSString * _Nullable))callback
{
    // 调用有赞云的初始化Token接口并返回 token. 见：https://www.youzanyun.com/docs/guide/3400/3466
    // 注意，下面的代码只是做为演示，请不要使用 UnsuggestMethod。
    [UnsuggestMethod loginWithOpenUid:[UserModel sharedManage].userId
                      completionBlock:^(NSDictionary *info) {
                          callback(info[@"access_token"]);
                      }];
}

@end

