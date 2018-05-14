//
//  DSUserInfoData.m
//  DS_lottery
//
//  Created by pro on 2018/4/15.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSUserInfoData.h"

@implementation DSUserInfoData

static  DSUserInfoData * userInfo;

+(DSUserInfoData *)initUserInfoData{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [[DSUserInfoData alloc] init];
    });
    return userInfo;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSMutableDictionary * dic = [SaveCachesFile loadDataList:DSUSER_INFO];
        if (dic) {
            _token = [dic objectForKey:@"token"];
            _userId = [dic objectForKey:@"userId"];
        }else{
            _token = nil;
            _userId = nil;
        }
        _lawModel = nil;
        [self requestLaw];
    }
    return self;
}

//注销
-(void)signOutSucceed{
    [DSUserInfoData initUserInfoData].token = nil;
    [DSUserInfoData initUserInfoData].userId = nil;
    [SaveCachesFile removeFile:DSUSER_INFO];
    //发送通知，登录成功
    [[NSNotificationCenter defaultCenter]postNotificationName:SIGNOUT object:nil];
}

//登录成功
-(void)loginSucceed{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[DSUserInfoData initUserInfoData].token forKey:@"token"];
    [dic setValue:[DSUserInfoData initUserInfoData].userId forKey:@"userId"];
    [SaveCachesFile saveDataList:dic fileName:DSUSER_INFO];
    //发送通知，登录成功
    [[NSNotificationCenter defaultCenter]postNotificationName:LOGIN_NOTICATION object:nil];
}

#pragma mark - 网络请求
/* 获取法律声明开关接口 */
-(void)requestLaw{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:CLIENTTYPE forKey:@"clientType"];
    [dic setValue:APPVERSION forKey:@"appVersion"];
    [dic setValue:COMPANYSHORTNAME forKey:@"companyShortName"];
    __weak typeof (self)weakSelf = self;
    [DSNetWorkRequest postConectWithS:GETAPPPGENXIN Parameter:dic Succeed:^(id result) {
        __strong typeof (weakSelf)strongSelf = weakSelf;
        if (SSUCCESS(result)) {
            strongSelf.lawModel = [DSAppConfigModel yy_modelWithJSON:result];
        }
    } Failure:^(NSError *failure) {

    }];
}
@end
