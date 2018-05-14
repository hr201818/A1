//
//  DSAdvertSingleData.m
//  DS_lottery
//
//  Created by pro on 2018/4/20.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSAdvertSingleData.h"

@interface DSAdvertSingleData()

@property (strong, nonatomic) NSTimer * timer;

@end
@implementation DSAdvertSingleData

static  DSAdvertSingleData * advert;

+(DSAdvertSingleData *)initAdvertData{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        advert = [[DSAdvertSingleData alloc] init];
    });
    return advert;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
 
    }
    return self;
}

/* 请求广告数据 */
-(void)requestDataSucceed:(void(^)(DSHomeBannerListModel * result))adSucceed Failure:(void(^)())adFailure{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:COMPANYSHORTNAME forKey:@"companyShortName"];
    [dic setValue:CLIENTTYPE forKey:@"clientType"];
    [dic setValue:APPVERSION forKey:@"appVersion"];
    __weak typeof (self)weakSelf = self;
    [DSNetWorkRequest postConectWithS:GETADVERTISEMENT Parameter:dic Succeed:^(id result) {
        __strong typeof (weakSelf)strongSelf = weakSelf;
        if (SSUCCESS(result)) {
            strongSelf.model = [DSHomeBannerListModel yy_modelWithJSON:result];
            adSucceed(strongSelf.model);
        }
    } Failure:^(NSError *failure) {
        adFailure();
    }];
}

-(DSHomeBannerModel * )searchAdvertLocationID:(NSString *)locationid{
    if (self.model.advertList.count) {
        for (DSHomeBannerModel * model in self.model.advertList) {
            if ([model.locationId isEqualToString:locationid]) {
                return model;
            }
        }
        return nil;
    }else{
        return nil;
    }
}

//第一次请求彩种
-(void)requestLotteryTimerPlayGroupId:(NSString *)playGroupId{
    __weak typeof (self)weakSelf = self;
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:CLIENTTYPE forKey:@"clientType"];
    [dic setValue:APPVERSION forKey:@"appVersion"];
    [dic setValue:COMPANYSHORTNAME forKey:@"companyShortName"];
    [dic setObject:playGroupId forKey:@"playGroupId"];
    [DSNetWorkRequest postConectWithS:GETSSCTIMEDATA Parameter:dic Succeed:^(id result) {
        __strong typeof (weakSelf)strongSelf = weakSelf;
        if (SSUCCESS(result)) {
            if([[result objectForKey:@"leftTime"] integerValue] > 0){
                NSString * leftTimer = [result objectForKey:@"leftTime"];
                switch ([[result objectForKey:@"playGroupId"]integerValue]) {
                    case 1:  self.id_1 = [leftTimer integerValue];  break;
                    case 2:  self.id_2 = [leftTimer integerValue];  break;
                    case 4:  self.id_4 = [leftTimer integerValue];  break;
                    case 5:  self.id_5 = [leftTimer integerValue];  break;
                    case 8:  self.id_8 = [leftTimer integerValue];  break;
                    case 10:  self.id_10 = [leftTimer integerValue];  break;
                    case 11:  self.id_11 = [leftTimer integerValue];  break;
                    case 12:  self.id_12 = [leftTimer integerValue];  break;
                    case 19:  self.id_19 = [leftTimer integerValue];  break;
                    case 20:  self.id_20 = [leftTimer integerValue]; break;
                    default:
                        break;
                }
            }else{
               [strongSelf performSelector:@selector(requestLotteryTimerPlayGroupId:) withObject:playGroupId afterDelay:10];
            }
        }else{
           [strongSelf performSelector:@selector(requestLotteryTimerPlayGroupId:) withObject:playGroupId afterDelay:10];
        }
    } Failure:^(NSError *failure) {
         __strong typeof (weakSelf)strongSelf = weakSelf;
       [strongSelf performSelector:@selector(requestLotteryTimerPlayGroupId:) withObject:playGroupId afterDelay:10];
    }];
}

//请求倒计时
-(void)beginTimer{
    //清除之前的信息，刷新用的
    [self.timer invalidate];
    NSArray * playGroupIdArr = [NSArray arrayWithObjects:@"1",@"2",@"4",@"5",@"10",@"11",@"12",@"19",@"20",@"8", nil];
    for (int i = 0; i<playGroupIdArr.count; i++) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(requestLotteryTimerPlayGroupId:) object:playGroupIdArr[i]];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(towRequestLotteryTimerPlayGroupId:) object:playGroupIdArr[i]];
    }
    self.id_1 = 0;self.id_2 = 0;self.id_4 = 0;self.id_5 = 0;self.id_8 = 0;self.id_10 = 0;self.id_11 = 0;self.id_12 = 0;self.id_19 = 0;self.id_20 = 0;
    NSArray * array = [NSArray arrayWithObjects:@"1",@"2",@"19",@"20",@"4",@"5",@"8",@"12",@"10",@"11",nil];
    for (NSString * _id in array) {
        [self requestLotteryTimerPlayGroupId:_id];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)handleTimer{
    if (self.id_1 > 0) {
        self.id_1--;
        if(self.id_1 == 0){
            [self towRequestLotteryTimerPlayGroupId:@"1"];
        }
    }
    if (self.id_2 > 0) {
        self.id_2--;
        if(self.id_2 == 0){
            [self towRequestLotteryTimerPlayGroupId:@"2"];
        }
    }
    if (self.id_4 > 0) {
        self.id_4--;
        if(self.id_4 == 0){
            [self towRequestLotteryTimerPlayGroupId:@"4"];
        }
    }
    if (self.id_5 > 0) {
        self.id_5--;
        if(self.id_5 == 0){
            [self towRequestLotteryTimerPlayGroupId:@"5"];
        }
    }
    if (self.id_8 > 0) {
        self.id_8--;
        if(self.id_8 == 0){
            [self towRequestLotteryTimerPlayGroupId:@"8"];
        }
    }
    if (self.id_10 > 0) {
        self.id_10--;
        if(self.id_10 == 0){
            [self towRequestLotteryTimerPlayGroupId:@"10"];
        }
    }
    if (self.id_11 > 0) {
        self.id_11--;
        if(self.id_11 == 0){
            [self towRequestLotteryTimerPlayGroupId:@"11"];
        }
    }
    if (self.id_12 > 0) {
        self.id_12--;
        if(self.id_12 == 0){
            [self towRequestLotteryTimerPlayGroupId:@"12"];
        }
    }
    if (self.id_19 > 0) {
        self.id_19--;
        if(self.id_19 == 0){
            [self towRequestLotteryTimerPlayGroupId:@"19"];
        }
    }
    if (self.id_20 > 0) {
        self.id_20--;
        if(self.id_20 == 0){
            [self towRequestLotteryTimerPlayGroupId:@"20"];
        }
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:TIMERLOTTERY object:nil];
}

//每次更新都走这个方法，通知首页进行数据请求刷新
-(void)towRequestLotteryTimerPlayGroupId:(NSString *)playGroupId{
    __weak typeof (self)weakSelf = self;
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:CLIENTTYPE forKey:@"clientType"];
    [dic setValue:APPVERSION forKey:@"appVersion"];
    [dic setValue:COMPANYSHORTNAME forKey:@"companyShortName"];
    [dic setObject:playGroupId forKey:@"playGroupId"];
    [DSNetWorkRequest postConectWithS:GETSSCTIMEDATA Parameter:dic Succeed:^(id result) {
        __strong typeof (weakSelf)strongSelf = weakSelf;
        if (SSUCCESS(result)) {
            if([[result objectForKey:@"leftTime"] integerValue] > 0){
                NSString * leftTimer = [result objectForKey:@"leftTime"];
                switch ([[result objectForKey:@"playGroupId"]integerValue]) {
                    case 1:  self.id_1 = [leftTimer integerValue];  break;
                    case 2:  self.id_2 = [leftTimer integerValue];  break;
                    case 4:  self.id_4 = [leftTimer integerValue];  break;
                    case 5:  self.id_5 = [leftTimer integerValue];  break;
                    case 8:  self.id_8 = [leftTimer integerValue];  break;
                    case 10:  self.id_10 = [leftTimer integerValue];  break;
                    case 11:  self.id_11 = [leftTimer integerValue];  break;
                    case 12:  self.id_12 = [leftTimer integerValue];  break;
                    case 19:  self.id_19 = [leftTimer integerValue];  break;
                    case 20:  self.id_20 = [leftTimer integerValue]; break;
                    default:
                        break;
                }
                //通知首页刷新数据
                 [[NSNotificationCenter defaultCenter]postNotificationName:HOMEUPDATE object:nil];
            }else{
                [strongSelf performSelector:@selector(towRequestLotteryTimerPlayGroupId:) withObject:playGroupId afterDelay:10];
            }
        }else{
            [strongSelf performSelector:@selector(towRequestLotteryTimerPlayGroupId:) withObject:playGroupId afterDelay:10];
        }
    } Failure:^(NSError *failure) {
        __strong typeof (weakSelf)strongSelf = weakSelf;
        [strongSelf performSelector:@selector(towRequestLotteryTimerPlayGroupId:) withObject:playGroupId afterDelay:10];
    }];
}



@end
