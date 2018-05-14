//
//  DSAdvertSingleData.h
//  DS_lottery
//
//  Created by pro on 2018/4/20.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSHomeBannerListModel.h"

//倒计时通知
#define TIMERLOTTERY @"timerLottery"
//刷新首页信息
#define HOMEUPDATE @"homeUpdate"
@interface DSAdvertSingleData : NSObject

@property (strong, nonatomic) DSHomeBannerListModel * model;

//**************彩种倒计时时间*************
@property (assign, nonatomic) NSInteger  id_1;
@property (assign, nonatomic) NSInteger  id_2;
@property (assign, nonatomic) NSInteger  id_4;
@property (assign, nonatomic) NSInteger  id_5;
@property (assign, nonatomic) NSInteger  id_8;
@property (assign, nonatomic) NSInteger  id_10;
@property (assign, nonatomic) NSInteger  id_11;
@property (assign, nonatomic) NSInteger  id_12;
@property (assign, nonatomic) NSInteger  id_19;
@property (assign, nonatomic) NSInteger  id_20;
//获取倒计时
-(void)beginTimer;

+(DSAdvertSingleData *)initAdvertData;

/* 请求广告数据 */
-(void)requestDataSucceed:(void(^)(DSHomeBannerListModel * result))adSucceed Failure:(void(^)())adFailure;
/* 根据广告ID返回对应的模型 */
-(DSHomeBannerModel * )searchAdvertLocationID:(NSString *)locationid;
@end
