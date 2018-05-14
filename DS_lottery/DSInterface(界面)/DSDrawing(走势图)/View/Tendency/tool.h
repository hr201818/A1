//
//  tool.h
//  Ticket
//
//  Created by pro on 2017/7/7.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "tool.h"
@interface tool : NSObject

+(NSString *)ChineseZodiac:(NSString *)time;//根据日期判断生肖
+(BOOL)isBlankString:(NSString *)string;//判断字符串是否为空
+(NSMutableArray *)rangeOfSubString:(NSString *)subStr inString:(NSString *)string;//检测字符串重复字符位置 subStr需要检测的字符  string被检测的原始字符串
+(BOOL)nsArrIsNull:(NSArray *)arr;//判断不可变数组是否为空
+(BOOL)arrIsNull:(NSMutableArray *)arr;//判断可变数组是否为空
+ (BOOL)dx_isNullOrNilWithObject:(id)object;//判断对象是否为空
+(void)Alert:(NSString *)massage success:(BOOL)success;
+(void)Alert:(NSString *)massage;
+(NSString *)time:(NSString *)timeStr;//时间戳转化时间带时分秒
+(NSString *)noTime:(NSString *)timeStr;//时间戳转化时间不带时分秒
+(UIViewController *)getCurrentViewController:(UIView *)view;//获取当前对象的试图控制器
+(BOOL)checkPassWord:(NSString *)passWords;//6-12位数字和字母混合密码验证
+(int)numbeLengthOfString:(NSString*)strtemp;//计算英文和数字的字符个数,不能包含中文
+(NSUInteger)unicodeLengthOfString: (NSString *) text;//计算中文的字符个数,不能包含英文和数字
+ (BOOL)isEnglishFirst:(NSString *)str;//是否字母开头
+(BOOL)isChinese:(NSString*)str;//判断是否是纯汉字
+(BOOL)includeChinese:(NSString*)str;//判断是否含有汉字
+(NSString *)translationArebicStr:(NSString *)chineseStr;
+(BOOL)JudgeTheillegalCharacter:(NSString *)content;//判断是否含有非法字符 yes 有      no没有
+(NSString *)encryptionCardNumber:(NSString *)cardNumber;//银行卡显示头尾个四个数字
+(NSString *)date;//当天时间
+(NSString *)During;//当天的月份
+(NSString *)lastDay;//昨天
+(NSString *)nextDay;//明天
+(NSString *)dayBeforeYesterday;//前天
+(NSString *)LastMonday;//上周一
+(NSString *)LastSunday;//上周日
+(NSString *)OnMonday;//本周一
+(NSString *)OnSunday;//本周日
+(CGSize)CommentSizeContent:(NSString*)Text Font:(UIFont *)font size:(CGSize)size;//计算字体宽度和高度
+(BOOL)parity:(NSInteger)number;//判断奇偶数 yes为偶数
+(NSString*)getTheCorrectNum:(NSString*)tempString;//去掉数字前面的0
+(NSString *)doubleFromStr:(NSString *)str;//金额取三位，四舍五入，把末尾0舍弃
//+(UIToolbar *)addToolbar;//键盘添加toolbar
+(void)textFieldDone;//收起键盘
+(NSString *)bankLogoName:(NSString *)bankName;//银行卡Logo
+(void)clearAllCache;//清除全部缓存
+(float)folderSizeAtPath:(NSString *)path;//根据路径计算缓存文件大小
+(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size;//修改image的size
/* 获取对象的所有属性 以及属性值 */
+(NSDictionary *)properties_aps:(id)ss;
/**
 * 根据彩种ID获取彩种名称
 * @param playGroupId 彩种ID
 * @return 彩种名称
 */
+(NSString *)getPlayGroupName:(NSInteger)playGroupId;

/**
 * 获取所有彩种ID
 * @return 彩种ID列表
 */
+(NSArray *)getAllSscPlayGroupid;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;//json字符串转字典
+(NSString *)convertToJsonData:(NSDictionary *)dict;//字典转json字符串
@end
