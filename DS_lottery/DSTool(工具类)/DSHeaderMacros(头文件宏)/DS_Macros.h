//
//  DS_Macros.h
//  DS_lottery
//
//  Created by pro on 2018/4/7.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#ifndef DS_Macros_h
#define DS_Macros_h
#define IOS8_WINDTH  Vertical_WIDTH / 375.0
#define IOS8_HEIGHT  Vertical_HEIGHT / 667.0

#ifdef DEBUG

#define NSLog( s, ... ) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(s), ##__VA_ARGS__] UTF8String] );

#else

#define NSLog( s, ... )

#endif
//tabbar底部的高度
#define  Tabbarbottom_HEIGHT    (IS_IPHONEX ? 34.f : 0.f)

//tabbar的高度
#define Tabbar_HEIGHT         (IS_IPHONEX ? (49.f+34.f) : 49.f)

//状态栏高度
#define  Statusbar_HEIGHT      (IS_IPHONEX ? 44.f : 20.f)

#define  navgation_top (IS_IPHONEX ? 20.f : 0.f)

//导航栏高度
#define  Navgationbar_HEIGHT   (IS_IPHONEX ? 88.f : 64.f)

//判断是否是PhoneX
#define IS_IPHONEX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

/* 比例系数 */
#define IOS_SiZESCALE(m) m * IOS8_WINDTH

/**
 *  获取竖屏下物理屏幕尺寸
 */
#define Vertical_HEIGHT ([UIScreen mainScreen].bounds.size.height > [UIScreen mainScreen].bounds.size.width ? [UIScreen mainScreen].bounds.size.height:[UIScreen mainScreen].bounds.size.width)

#define Vertical_WIDTH ([UIScreen mainScreen].bounds.size.width < [UIScreen mainScreen].bounds.size.height ? [UIScreen mainScreen].bounds.size.width:[UIScreen mainScreen].bounds.size.height)

/**
 *  获取横竖屏下物理屏幕尺寸
 */
#define PhoneScreen_WIDTH  [UIScreen mainScreen].bounds.size.width

#define PhoneScreen_HEIGHT [UIScreen mainScreen].bounds.size.height

/**
 *应用程序尺寸（去掉状态栏）
 */
#define APPLICATION_SIZE ([UIScreen mainScreen ].applicationFrame.size)


/**
 *获取系统版本
 */
#define OSVERSION_NUMBERIOS [[[UIDevice currentDevice] systemVersion]doubleValue]


/**
 *  字体倍数
 */
#define fontsize  (1 + (IOS8_WINDTH - 1) * 0.6)

/**
 *  判断是否是Ipad
 */
#define IPAD_IS (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/**
 *  隐藏键盘
 *
 *  @return nil
 */
#define HidenKeybory {[[[UIApplication sharedApplication] keyWindow] endEditing:YES];}

/**
 *  获取appdelegate
 */
#define APPDelegate [UIApplication sharedApplication]

/**
 *  获取windows
 */
#define KeyWindows [[UIApplication sharedApplication].delegate window]

/**
 *  NSUserDefaults
 */
#define kUserDefaults [NSUserDefaults standardUserDefaults]


/**
 *  请求成功
 */
#define SSUCCESS(a) [[a objectForKey:@"result"]integerValue] == 1

/**
 * 获取提示信息
 */
#define RESULT_INFO [result objectForKey:@"info"]

/**
 网络数据字段
 */
#define RESULT_CODE [result[@"code"] integerValue]
#define RESULT_DATA result[@"data"]
#define RESULT_FAIL @"请检查网络"

/**
 *  请求失败
 */
#define ERROR_MSG(m) [[m objectForKey:@"meta"]objectForKey:@"message"]


/**
 *  颜色
 */
#define COLOR(r,g,b) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1]
#define COLOR_Alpha(r,g,b,a) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//展位图颜色
#define backColor COLOR(235,235,235)

//线颜色
#define COLORLine COLOR(235,235,235)

//字体颜色
#define COLORFont83 COLOR(83,83,83)

#define COLORFont68 COLOR(68,68,68)

#define COLORFont53 COLOR(53,53,53)

#define COLORFont151 COLOR(151,151,151)

#define COLORFont121 COLOR(121,121,121)
//系统蓝色
#define COLORFontblu COLOR(0,136,254)

#define COLORFontred COLOR(248,9,30)
/**
 * 主风格颜色
 */
#define COLOR_HOME COLOR_Alpha(228, 87, 34,1)
/**
 *  默认字体大小
 */
#define DEFAULT_CELL_TITLE_SIZE 16.0f
/**
 *  默认字体颜色
 */
#define DEFAULT_CELL_TITLE_COLOR ([UIColor blackColor])

#define FONT(s) [UIFont systemFontOfSize:s]

#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;
//AppDelegate对象
#define AppDelegateInstance [[UIApplication sharedApplication] delegate]

// weakSelf
#define weakifySelf  \
__weak __typeof(&*self)weakSelf = self;

// strongSelf
#define strongifySelf \
__strong __typeof(&*weakSelf)self = weakSelf;

#endif /* DS_Macros_h */
