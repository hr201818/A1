//
//  DSUserInfoData.h
//  DS_lottery
//
//  Created by pro on 2018/4/15.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSAppConfigModel.h"
/* 登录通知 */
#define LOGIN_NOTICATION  @"login"
/* 注销通知 */
#define SIGNOUT @"signOut"
/* 登录后将token和uid缓存到本地的文件名 */
#define DSUSER_INFO    @"user_info"

@interface DSUserInfoData : NSObject

+(DSUserInfoData *)initUserInfoData;

@property (copy, nonatomic) NSString * token;

@property (copy, nonatomic) NSString * userId;

/* 法律声明模型 */
@property (strong, nonatomic) DSAppConfigModel  * lawModel;

//注销成功
-(void)signOutSucceed;

//登录成功
-(void)loginSucceed;

@end
