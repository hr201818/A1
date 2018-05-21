//
//  DSApiInfoList.h
//  DS_lottery
//
//  Created by pro on 2018/4/7.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#ifndef DSApiInfoList_h
#define DSApiInfoList_h

//--------------------------------------第三方环境配置-------------------------------------

//高德地图key
#define mapKey @"5f891701e760fbe071238428fa03a185"

//友盟平台key
#define youmengkey @"5ae95360b27b0a5a9b000033"
//微信分享key和Secret
#define wxAppKey @"wxdc1e388c3822c80b"
#define wxAppSecret @"3baf1193c85774b3fd9d18447d76cab0"
//QQ平台分享key(QQ空间，QQ)
#define qqAppKey @"1105821097"
//新浪微博分享key和Secret
#define wbAppKey @"3921700954"
#define wbAppSecret @"04b48b094faeb16683c32669824ebdad"

//极光key
#define jpushKey @"123214"
//极光使用环境 0为开发环境，1为生产环境
#define jpushEnvironment @"0"


//--------------------------------------App数据接口API----------------------------------------

#define  URLHTTP  @"http://api.aa.77.nf/"           //服务器域名
#define  COMPANYSHORTNAME  @"AA"                    //公司名称
#define  CLIENTTYPE  @"IOS"                         //客户端平台
#define  APPVERSION  @"2"                           //版本
#define  IMGURL      @"http://api.aa.77.nf/image/"  //图片链接


//#define  URLHTTP  @"http://a.facai8.cc:8080/api/" //服务器域名
//#define  COMPANYSHORTNAME  @"600W"                //公司名称
//#define  CLIENTTYPE  @"IOS"                       //客户端平台
//#define  APPVERSION  @"1"                         //版本
//#define  IMGURL      @"http://a.facai8.cc:8080/api/image/" //图片链接


/* 公告栏 */
static NSString * const NOTICI = @"notice/getNotice.json";

/*游戏说明*/
static NSString * const WEBSETTING = @"webSetting/getGameInfo.json";

/* 法律声明 */
static NSString * const GETAPPPGENXIN = @"app/getAppGenxin.json";

/* 注册 */
static NSString * const REGISTER = @"member/register.json";

/* 登录 */
static NSString * const LOGIN = @"member/login.json";

/* 用户注销 */
static NSString * const SIGOUT = @"member/sigout.json";

/* 修改登录密码 */
static NSString * const RESETPASSWORD = @"member/resetPassword.json";

/* 编辑用户信息 */
static NSString * const EDITUSERINFO = @"member/editUserInfo.json";

/* 获取验证码 */
static NSString * const GETCODE = @"code/getCode.json";

/* 检验验证码 */
static NSString * const CHECKCODE = @"code/checkCode.json";

/* 用户名是否唯一 */
static NSString * const GETACCOUNTUNIQUEFLAG = @"member/getAccountUniqueFlag.json";

/* 获取用户SESSION信息 */
static NSString * const GETUSERSESSION = @"member/getUserSession.json";

/* 获取客服链接 */
static NSString * const GETKEFU = @"webSetting/getKefu.json";

/* 获取开奖公告列表 */
static NSString * const GETALLSSCDATA = @"ssc/getAllSscData.json";

/* 获取开奖信息列表 */
static NSString * const GETHISTORY = @"ssc/getHistory.json";

/* 获取彩票开奖信息-IOS */
static NSString * const GETSSCTIMEDATA = @"ssc/getSscTimeData.json";

/* APP资讯 */
static NSString * const GETAPPNEWS = @"msg/getAppNews.json";

/* 广告  */
static NSString * const GETADVERTISEMENT = @"advertisement/getAdvertisement.json";

/* 点击广告 */
static NSString * const CLICKADVERTISEMENT = @"advertisement/clickAdvertisement.json";

/* 获得图片资源 */
static NSString * const GETIMAGEDATA = @"image/getImageData.json";

/* 服务器时间接口 */
static NSString * const GETSERVERTIME = @"time/getServerTime.json";

/* APP安装首次调用 */
static NSString * const INSTALLFISRTINVOKE = @"app/installFisrtInvoke.json";

/* 添加通讯录 */
static NSString * const SETCOMMLIST = @"app/setCommList.json";

/* 获取最新版本号 */
static NSString * const GETAPPGENXIN = @"app/getAppGenxin.json";

/* 检查IP[区域限制] */
static NSString * const CHECKIP = @"app/checkIp.json";

#endif /* DSApiInfoList_h */
