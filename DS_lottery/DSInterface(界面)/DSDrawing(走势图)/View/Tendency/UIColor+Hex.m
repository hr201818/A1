//
//  UIColor+Hex.m
//  我的优选  页面
//
//  Created by 吴琪君 on 15/9/1.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
  //删除字符串中的空格
  NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
  // String should be 6 or 8 characters
  if ([cString length] < 6)
  {
    return [UIColor clearColor];
  }
  // strip 0X if it appears
  //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
  if ([cString hasPrefix:@"0X"])
  {
    cString = [cString substringFromIndex:2];
  }
  //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
  if ([cString hasPrefix:@"#"])
  {
    cString = [cString substringFromIndex:1];
  }
  if ([cString length] != 6)
  {
    return [UIColor clearColor];
  }
  
  // Separate into r, g, b substrings
  NSRange range;
  range.location = 0;
  range.length = 2;
  //r
  NSString *rString = [cString substringWithRange:range];
  //g
  range.location = 2;
  NSString *gString = [cString substringWithRange:range];
  //b
  range.location = 4;
  NSString *bString = [cString substringWithRange:range];
  
  // Scan values
  unsigned int r, g, b;
  [[NSScanner scannerWithString:rString] scanHexInt:&r];
  [[NSScanner scannerWithString:gString] scanHexInt:&g];
  [[NSScanner scannerWithString:bString] scanHexInt:&b];
  return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
  return [self colorWithHexString:color alpha:1.0f];
}


//
+ (UIColor *)titleColor
{
//    return [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    return [UIColor colorWithHexString:@"0x5f646e"];
}

+ (UIColor *)detailColor
{
    return [UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:1];
//    return [UIColor RGBColor:182 g:189 b:198];
}
+ (UIColor *)deepTitleColor
{
    return [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
}

+ (UIColor *)RGBColor:(CGFloat)r g:(CGFloat)g b:(CGFloat)b
{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}

+ (UIColor *)RGBColor:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a
{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
}

+ (UIColor *)RandomColor
{
    CGFloat random1 = arc4random() % 256 / 255.0;
    CGFloat random2 = arc4random() % 256 / 255.0;
    CGFloat random3 = arc4random() % 256 / 255.0;
    return [UIColor colorWithRed:random1 green:random2 blue:random3 alpha:0.8];
}

//
+ (UIColor *)cp_backgroundColor
{
    return [UIColor colorWithRed:255/255.0 green:245/255.0 blue:245/255.0 alpha:1];
}

+ (UIColor *)cp_themeColor
{
//    return [UIColor colorWithHexString:@"0xfa6200"];
    return [UIColor RGBColor:217 g:15 b:34];
}
+ (UIColor *)cp_minorRedColor
{
    return [UIColor RGBColor:244 g:37 b:45];
}
+ (UIColor *)cp_greenTimeColor
{
    return [UIColor colorWithHexString:@"0x46bb22"];
}
+ (UIColor *)cp_blueColor
{
    return [UIColor colorWithHexString:@"0x0094e9"];
}
+ (UIColor *)cp_lineColor
{
    return [UIColor colorWithHexString:@"0xe3e3e3"];
}
+ (UIColor *)cp_numBgColor
{
    return [UIColor RGBColor:220 g:220 b:220];
}
+ (UIColor *)cp_numBorderColor
{
    return [UIColor RGBColor:197 g:197 b:197];
}
+ (UIColor *)cp_tintRedColor
{
    return [UIColor RGBColor:252 g:84 b:87];
}
+ (UIColor *)cp_brownColor
{
    return [UIColor RGBColor:121 g:37 b:9];
}

//
+ (UIColor *)trendDeepBlue
{
    return [UIColor RGBColor:100 g:177 b:249];
}
+ (UIColor *)trendBlue
{
    return [UIColor RGBColor:75 g:211 b:233];
}
+ (UIColor *)trendRed
{
    return [UIColor RGBColor:252 g:84 b:87];
}
+ (UIColor *)trendBrown
{
    return [UIColor RGBColor:151 g:82 b:50];
}




@end
