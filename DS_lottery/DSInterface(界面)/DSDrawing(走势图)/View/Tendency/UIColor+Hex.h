//
//  UIColor+Hex.h
//  我的优选  页面
//
//  Created by 吴琪君 on 15/9/1.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (UIColor *)titleColor;
+ (UIColor *)detailColor;

+ (UIColor *)RGBColor:(CGFloat)r g:(CGFloat)g b:(CGFloat)b;

+ (UIColor *)RGBColor:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a;

+ (UIColor *)RandomColor;


/*---需求---*/
+ (UIColor *)deepTitleColor;
+ (UIColor *)cp_backgroundColor;    // 背景色
+ (UIColor *)cp_themeColor;
+ (UIColor *)cp_minorRedColor;
+ (UIColor *)cp_greenTimeColor;
+ (UIColor *)cp_blueColor;
+ (UIColor *)cp_lineColor;
+ (UIColor *)cp_numBgColor;
+ (UIColor *)cp_tintRedColor;
+ (UIColor *)cp_brownColor;

+ (UIColor *)trendDeepBlue;
+ (UIColor *)trendBlue;
+ (UIColor *)trendRed;
+ (UIColor *)trendBrown;


@end
