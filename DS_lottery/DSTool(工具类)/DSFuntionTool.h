//
//  DSFuntionTool.h
//  DS_lottery
//
//  Created by pro on 2018/4/8.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@interface DSFuntionTool : NSObject

/**
 * 导航栏返回按钮
 */
+(UIButton*)leftNavBackTarget:(id)target Item:(SEL)item;


/**
 计算文本应有宽度
 @param content     文本内容
 @param attributes  例如传 @{NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
 @param height      文本默认高度
 */
+ (CGFloat)calculateWidthWithContent:(NSString *)content attributes:(NSDictionary *)attributes height:(CGFloat)height;

/**
 * 获取当前时间戳
 **/
+(NSString *)currentTimeStr;

/* 时间戳返回日期
 * timestamp 时间戳字符串
 * formatter 格式yyyy-MM-dd HH:mm:ss
 */
+(NSString *)timestampTo:(NSString *)timestamp formatter:(NSString *)formatter;


/* 获取IP地址 */
+(NSString *)getIPAddress:(BOOL)preferIPv4;


/* 手机号码判断 */
+(BOOL) isValidateMobile:(NSString*)mobile;

/* 判断字符串是否为空包括空格换行 */
+ (BOOL)isBlankString:(NSString *)string;

/* 获取缓存 */
+(float)readCacheSize;

/* 清除缓存 */
+ (void)clearFile;

+(void)openUrl:(NSString *)url;
@end
