//
//  DSNetWorkRequest.m
//  DS_lottery
//
//  Created by pro on 2018/4/7.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSNetWorkRequest.h"
#import "DSNetWorkManager.h"



@implementation DSNetWorkRequest
/**
 *  监听网络变化
 *  back 回调网络状态
 */
+ (void)reach:(void(^)(AFNetworkReachabilityStatus status))back {
    /**
     AFNetworkReachabilityStatusUnknown          = -1,   // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,    // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,    // WWAN
     AFNetworkReachabilityStatusReachableViaWiFi = 2,    // wifi
     */
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        back(status);
        [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    }];
}

#pragma mark - GET请求
+ (void)getConectWithS:(NSString *)s Parameter:(NSDictionary *)parameter Succeed:(void(^)(id result))succeed Failure:(void(^)(NSError * failure))failure
{
    DSNetWorkRequest * netWork = [[self alloc]init];
    [DSNetWorkManager initAFNetWork].manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",nil];
    [DSNetWorkManager initAFNetWork].manager.requestSerializer.timeoutInterval = 15;
    NSLog(@"请求网址为%@",[netWork requestDic:parameter S:s]);
    [[DSNetWorkManager initAFNetWork].manager GET:[netWork requestDic:parameter S:s] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         succeed(responseObject);
         NSLog(@"网址%@请求回来的数据%@",[netWork requestDic:parameter S:s],responseObject);
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
          NSLog(@"网址%@请求发生错误,错误信息为%@",[netWork requestDic:parameter S:s],error);
         failure(error);
     }];
}

#pragma mark - POST请求
+ (void)postConectWithS:(NSString *)s Parameter:(NSDictionary *)parameter Succeed:(void(^)(id result))succeed Failure:(void(^)(NSError * failure))failure
{

    DSNetWorkRequest * netWork = [[self alloc]init];
    //设置接收的数据类型
    [DSNetWorkManager initAFNetWork].manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    [DSNetWorkManager initAFNetWork].manager.requestSerializer.timeoutInterval = 15;
    [[DSNetWorkManager initAFNetWork].manager POST:[netWork requestDic:nil S:s]parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress)
     {

     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         succeed(responseObject);
         NSLog(@"网址%@请求回来的数据%@",[netWork requestDic:parameter S:s],responseObject);
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网址%@请求发生错误,错误信息为%@",[netWork requestDic:parameter S:s],error);
         failure(error);
     }];
}


//网址拼接,获取的网址,统一的前缀
-(NSString *)requestDic:(NSDictionary *)dic S:(NSString *)s
{
    NSString *value = @"";
    for (NSString *key in [dic allKeys])
    {
        if ([value length] == 0)
        {
            value = [NSString stringWithFormat:@"%@=%@",key,[dic objectForKey:key]];
        }
        else
        {
            value = [NSString stringWithFormat:@"%@&%@=%@",value,key,[dic objectForKey:key]];
        }
    }
    if (dic != nil) {
        return [NSString stringWithFormat:@"%@%@?%@",URLHTTP,s,value];
    }
    return  [NSString stringWithFormat:@"%@%@?",URLHTTP,s];
}
@end
