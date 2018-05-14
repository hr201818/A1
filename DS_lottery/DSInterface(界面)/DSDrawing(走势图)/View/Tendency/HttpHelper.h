//
//  HttpHelper.h
//  Ticket
//
//  Created by zhaoxiafei on 2017/6/19.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>
//#import "SscOfficialPlayView.h"
//#import "AFNetworking.h"
//#import "OfficialPeiLvModel.h"

#define Helper [HttpHelper shareHelper]
#define HttpManager [HttpHelper shareHttpManager]

#define kViewTop [Helper viewTopOffset]
#define kBottomSafeArea [Helper safeAreaBottom]

@interface HttpHelper : NSObject

@property(nonatomic,strong)ALAssetsLibrary *liberary;
@property(nonatomic,strong)NSString *account;
@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)NSString *user_id;

@property (copy,nonatomic) void(^loginOutBackcall)(void);
@property (copy,nonatomic) void(^reloadLotteryNaviTitle)(NSString *title);

// 官方投注成功 回调到官方控制器刷新余额
@property (copy,nonatomic) void(^officialBetSuccessBlock)(void);

@property (strong,nonatomic) NSArray    *caizhongConfigArr;

- (CGFloat)viewTopOffset;
- (CGFloat)sysTabBarHeight;
- (CGFloat)safeAreaBottom;
- (CGFloat) statusBarHeight;

/**
 canBet
 0为圈子
 1为开奖结果
 */

@property(nonatomic,strong)NSString *canBet;
///headIsOpen 首页上的导航条  0为关闭,   1位显示
@property(nonatomic,strong)NSString *headIsOpen;
///memberIsOpen 0会员中心关闭,点击我的,进入个人资料   ,1会员中心开启,先试试偶有
@property(nonatomic,strong)NSString *memberIsOpen;
///needWithdrawPasswd 1会员中心展示“取款”
@property (nonatomic,strong) NSString   *needWithdrawPasswd;
//公司名称
@property(nonatomic,strong)NSString *enterpriseName;
///存储初次加载时返回的数据
@property(nonatomic,strong)NSDictionary *dataDic;

@property(nonatomic,assign)BOOL orLine;

// 在线客服的url
@property (strong,nonatomic) NSString   *kefuUrl;

///红色array
@property(nonatomic,strong)NSMutableArray *redArray;
///绿色array
@property(nonatomic,strong)NSMutableArray *blueArray;
///蓝色array
@property(nonatomic,strong)NSMutableArray *greenArray;
///数字-生肖对应
@property(nonatomic,strong)NSMutableDictionary *zodiacDic;
///数字-背景色额
@property(nonatomic,strong)NSMutableDictionary *numColorDic;

@property(nonatomic,strong)NSMutableDictionary *danshuangDic;

@property(nonatomic,strong)NSDictionary *orderZodiacDic;



//@property (nonatomic,assign)BOOL  networkStatus;//网络状态

@property (nonatomic,assign)BOOL  isDrawPassword;//记录是否弹出过取款密码提示框

@property (assign,nonatomic) BOOL   isShowCaijin; // 晋级奖金
@property (assign,nonatomic) BOOL   isShowYysq; // 月月送钱
@property (assign,nonatomic) BOOL   isShowDaily; // 每日加奖
@property (assign,nonatomic) BOOL   isShowQhb; // 抢红包
@property (strong,nonatomic) NSString   *appEmbedApiAddress; // 活动链接地址

@property (strong,nonatomic) NSString   *bankZzYhbl; // 银行卡充值优惠比例

@property (assign,nonatomic) BOOL   isForce;
@property (strong,nonatomic) NSString   *updateUrl;
//@property (assign,nonatomic) BOOL   isShenheZhong;
@property (assign,nonatomic) BOOL   isLimitArea;
@property (strong,nonatomic) NSString   *closeLiuhe;
@property (strong,nonatomic) NSString   *clauseContent;

//时间戳转NSString
+(NSString *)timeWithTimeIntervalString:(NSString *)timeString fomart:(NSString *)fm;
+(void)show;
+(void)hide;

+(UIImage *)getFitImageWithImage:(UIImage *)oldImage targetSize:(CGSize)targetSize;

+(HttpHelper *)shareHelper;
//+ (AFHTTPSessionManager *)shareHttpManager;

+(void)startGetNetWorkWithURL:(NSString *)url successBlk:(void(^)(id responseObject))successBlk failedBlk:(void(^)(id errorInfo))failedBlk;
+(void)startPostNetWorkWithURL:(NSString *)url params:(NSDictionary *)params successBlk:(void(^)(id responseObject))successBlk failedBlk:(void(^)(NSError * errorInfo))failedBlk;
+(NSString *)getDateStringWithTimeStamp:(NSString *)timeStamp;

// 第一次安装上传数据
+ (void)firstInstall;

//+(NSMutableArray *)calculateCountWithSelectedCount:(NSMutableArray *)array baseNum:(NSInteger)baseNum;


// 保存/读取-历史开奖记录
//+ (LotteryInfoModel *)readLocationHisLotteryData:(NSString *)caizhongId;
//+ (void)saveHisLotteryData:(LotteryInfoModel *)model;
// 保存/读取-赔率记录
//+ (NSMutableArray<OfficialPeiLvModel*> *)readLocationPeilvData:(NSString *)wanfaId;
//+ (void)savePeilvData:(NSMutableArray<OfficialPeiLvModel*> *)peilvData wanfaid:(NSString *)wanfaid;
//+ (NSMutableArray<OfficialPeiLvModel*> *)readOriginalPeilvData:(NSString *)wanfaId;
//+ (void)saveOriginalPeilvData:(NSMutableArray<OfficialPeiLvModel*> *)peilvData wanfaid:(NSString *)wanfaid;
//+ (NSArray *)readCachePromotionListData;
//+ (void)savePromotionListData:(NSArray *)arr;


+ (void)removeNSUserDefault;


// 判断彩种是否开启
- (BOOL)isEnablePlayGroupId:(NSString *)playGroupId;


- (UIColor *)getTrendTextColor:(NSUInteger)i arrCount:(NSUInteger)count;

@end
