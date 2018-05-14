//
//  Header.h
//  Ticket
//
//  Created by zhaoxiafei on 2017/6/19.
//  Copyright © 2017年 xigu. All rights reserved.
//

#ifndef Header_h
#define Header_h
//#import "AFNetworking.h"
//#import "MBProgressHUD+MJ.h"
//#import "HttpHelper.h"
//#import "MBProgressHUD.h"
//#import "SDAutoLayout.h"
//#import "requestModels.h"
#import "UIColor+Hex.h"
#import "tool.h"
#import "HttpHelper.h"
#import "UIFont+adapt.h"
#import "UIViewExt.h"
#import "SDAutoLayout.h"
//#import "SDWebImageManager.h"
//#import "SDImageCache.h"
//#import "UIImageView+WebCache.h"
//#import "UIImageView+HighlightedWebCache.h"
//#import "MJRefresh.h"
//#import "YYCache.h"
//#import "MJExtension.h"
//#import "HttpRequest.h"
//#import "RecordUserLastMode.h"
//#import "ALFPSStatus.h"


#define kMargin adaptWidth(12)
#define kRatio ScreenW/375.0

#define SysTabBarHeight [Helper sysTabBarHeight]
#define SysStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define sscWidth ([[UIScreen mainScreen] bounds].size.width/13)
#define syxwWidth ([[UIScreen mainScreen] bounds].size.width/14)
#define listWidth ([[UIScreen mainScreen] bounds].size.width/8)

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define keyWindows [[UIApplication sharedApplication].delegate window] 
#define HEIGHT (self.navigationController.navigationBar.bounds.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height)

#define COLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define COLOR_ALPHA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define adaptHeight(height) (float)height*(ScreenH/667)
#define adaptWidth(width) (float)width*(ScreenW/375)

#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);

#define UIColor(a,b,c,d) [UIColor colorWithRed:a / 255.0 green:b / 255.0 blue:c / 255.0 alpha:d]
#define UIColorFromHex(s)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >> 8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]
#define Font(A) [UIFont zkd_systemFontOfSize:A]
#define DefaultFont Font(13)

//#define mWidth  (float)(([UIScreen mainScreen].bounds.size.width-100)/9)
#define lhWidth  (float)(([UIScreen mainScreen].bounds.size.width-80)/7)
#define lhWidthTow  (float)(([UIScreen mainScreen].bounds.size.width-100)/4)
#define lhWidthThree  (float)(([UIScreen mainScreen].bounds.size.width-100)/5)
#define cellHeight (float) ([tool CommentSizeContent:@"99" Font:[UIFont zkd_systemFontOfSize:14] size:CGSizeMake(MAXFLOAT, MAXFLOAT)].height+40)

#define backgColor [UIColor cp_backgroundColor]
#define navColor [UIColor cp_themeColor]
#define lineColor  UIColorFromHex(0xe3e3e3)
#define labelTextClor UIColorFromHex(0x5f646e)


//#define CZNameDic @{@"1":@"重庆时时彩",@"2":@"天津时时彩",@"3":@"新疆时时彩",@"4":@"体彩排列3",@"5":@"福彩3D",@"6":@"六合彩",@"7":@"北京28",@"8":@"北京快乐8",@"9":@"北京PK10",@"10":@"重庆幸运农场",@"11":@"广东快乐十分",@"13":@"三分时时彩",@"14":@"幸运飞艇",@"15":@"分分时时彩",@"16":@"两分时时彩",@"17":@"五分时时彩",@"20":@"江苏快3",@"21":@"安徽快3",@"22":@"吉林快3",@"23":@"极速PK10"}


#define HomeDic @{@"1":@"icon1",@"2":@"icon2",@"3":@"icon3",@"4":@"icon4",@"5":@"icon5",@"6":@"icon6",@"7":@"icon7",@"8":@"icon8",@"9":@"icon9",@"10":@"icon10",@"11":@"icon11",@"12":@"icon12",@"13":@"icon13",@"14":@"icon14",@"15":@"icon15",@"16":@"icon16",@"17":@"icon17",@"18":@"icon18",@"19":@"icon19",@"20":@"icon20",@"21":@"icon21",@"22":@"icon22",@"23":@"icon23",@"24":@"icon24"}



//#define kDesCZDic @{@"1":@"最火的高频率快彩",@"2":@"每十分钟一期",@"3":@"每十分钟一期",@"4":@"每天08:30",@"5":@"每天08:30",@"6":@"全网最高48.8倍",@"7":@"PC蛋蛋 5分1期",@"8":@"每五分钟一期",@"9":@"超人气易中奖赛车",@"10":@"重庆版快乐十分",@"11":@"每十分钟一期",@"12":@"",@"13":@"24小时在线玩",@"14":@"PK10夜场版",@"15":@"开奖最快的时时彩",@"16":@"2分1期 24小时不停",@"17":@"",@"18":@"",@"19":@"高赔率 易中奖",@"20":@"一天80期 返奖超高",@"21":@"",@"22":@"",@"23":@"极速赛车 分分开奖"}

#define kDesCZDic @{@"6":@"全网最高48.8倍"}

#define kERZIDING @"二字定位"
#define KSANZIDING @"三字定位"
#define kYIZIDING @"一字定位"
#define kYIZIZUHE @"一字组合"
#define kERZIZUHE @"二字组合"
#define kZUXUANSAN @"组选三"
#define kZUXUANLIU @"组选六"
#define kKUADU @"跨度"
#define kLONGHU @"龙虎"
#define kDINGWEI @"定位"
#define kGUANYAHE @"冠亚和"
#define kXUANWU @"选5"
#define kXUANSI @"选4"
#define kXUANSAN @"选3"
#define kXUANER @"选2"
#define kXUANYI @"选1"
#define kQITA @"其他"
#define kZUHE @"组合"
#define kHESHU @"和数"
#define kHEZHI @"和值"
#define kSHUANGMIAN @"双面"


// 玩法
typedef NS_ENUM(NSInteger, LotteryPlayId) {
    //重庆时时彩
    CQ_shuagnmian = 216,
    CQ_yiziding = 218,
    CQ_erziding = 219,
    CQ_sanziding = 220,
    CQ_yizizuhe = 221,
    CQ_erzizuhe = 222,
    CQ_zuxuansan = 224,
    CQ_zuxuanliu = 225,
    CQ_kuadu = 226,
    CQ_longhu = 227,
    
    
    //天津时时彩
    TJ_shuagnmian = 228,
    TJ_yiziding = 230,
    TJ_erziding = 231,
    TJ_sanziding = 232,
    TJ_yizizuhe = 233,
    TJ_erzizuhe = 234,
    TJ_zuxuansan = 236,
    TJ_zuxuanliu = 237,
    TJ_kuadu = 238,
    TJ_longhu = 239,
    
    
    //新疆时时彩
    XJ_shuagnmian = 240,
    XJ_yiziding = 242,
    XJ_erziding = 243,
    XJ_sanziding = 244,
    XJ_yizizuhe = 245,
    XJ_erzizuhe = 246,
    XJ_zuxuansan = 248,
    XJ_zuxuanliu = 249,
    XJ_kuadu = 250,
    XJ_longhu = 251,
    
    
    //三分时时彩
    SF_shuagnmian = 332,
    SF_yiziding = 333,
    SF_erziding = 340,
    SF_sanziding = 334,
    SF_yizizuhe = 339,
    SF_erzizuhe = 331,
    SF_zuxuansan = 341,
    SF_zuxuanliu = 335,
    SF_kuadu = 342,
    SF_longhu = 336,
    
    //分分时时彩
    FF_shuagnmian = 389,
    FF_yiziding = 383,
    FF_erziding = 388,
    FF_sanziding = 381,
    FF_yizizuhe = 387,
    FF_erzizuhe = 384,
    FF_zuxuansan = 386,
    FF_zuxuanliu = 379,
    FF_kuadu = 385,
    FF_longhu = 390,
    FF_shuzipan = 380,
    
    
    //广东快乐十分
    GD_ball1 = 278,
    GD_ball2 = 279,
    GD_ball3 = 280,
    GD_ball4 = 281,
    GD_ball5 = 282,
    GD_ball6 = 283,
    GD_ball7 = 284,
    GD_ball8 = 285,
    
    //重庆幸运农场
    CQ_ball1 = 295,
    CQ_ball2 = 296,
    CQ_ball3 = 297,
    CQ_ball4 = 298,
    CQ_ball5 = 299,
    CQ_ball6 = 300,
    CQ_ball7 = 301,
    CQ_ball8 = 302,
    
    //幸运28
    XY28_ball1 = 293,
    
    //福彩3D
    FC3D_dingwei = 252,
    FC3D_zuhe = 253,
    FC3D_heshu = 254,
    FC3D_zuxuansan = 255,
    FC3D_zuxuanliu = 256,
    FC3D_kuadu = 257,
    
    
    //体彩排列3
    TC_dingwei = 287,
    TC_zuhe = 288,
    TC_heshu = 289,
    TC_zuxuansan = 290,
    TC_zuxuanliu = 291,
    TC_kuadu = 292,
    
};

// 彩种ID
#define PLAYGROUPID_CQ 1  // 重庆
#define PLAYGROUPID_TJ 2  // 天津
#define PLAYGROUPID_XJ 3  // 新疆
#define PLAYGROUPID_TCPL3 4 // 体彩排列3
#define PLAYGROUPID_FC3D 5 // 福彩3D
#define PLAYGROUPID_LHC 6 // 六合彩
#define PLAYGROUPID_XY28 7 // 幸运28
#define PLAYGROUPID_BJKL8 8 // 北京快乐8
#define PLAYGROUPID_BJPK10 9 // 北京PK10
#define PLAYGROUPID_CQXYNC 10 // 重庆幸运场
#define PLAYGROUPID_GDKLSF 11 // 广东快乐十分
#define PLAYGROUPID_SSQ 12 // 双色球
#define PLAYGROUPID_AJSFC 13 // 埃及三分彩
#define PLAYGROUPID_XYFT 14 // 幸运飞艇
#define PLAYGROUPID_FFSSC 15 // 分分
#define PLAYGROUPID_LFSSC 16 // 两分
#define PLAYGROUPID_WFSSC 17 // 五分
#define PLAYGROUPID_K3_JIANGSU 18 // 江苏快3
#define PLAYGROUPID_K3_HUBEI 19 // 湖北快3
#define PLAYGROUPID_K3_ANHUI 20 // 安徽快3
#define PLAYGROUPID_K3_JILIN 21 // 吉林快3
#define PLAYGROUPID_JSLHC 22 // 急速六合彩
#define PLAYGROUPID_JSPK10 23 // 急速PK10
#define PLAYGROUPID_11xuan5_GD 24 // 广东11选5

#endif /* Header_h */
