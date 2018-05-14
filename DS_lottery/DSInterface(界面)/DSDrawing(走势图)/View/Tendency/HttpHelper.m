//
//  HttpHelper.m
//  Ticket
//
//  Created by zhaoxiafei on 2017/6/19.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "HttpHelper.h"
#import "AFNetworking.h"
#import "Header.h"
#import <sys/utsname.h>
//#import "LoginViewController.h"
#import "AppDelegate.h"
@implementation HttpHelper
+(HttpHelper *)shareHelper
{
    static HttpHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[HttpHelper alloc]init];
 
    });
    return helper;
}

+ (AFHTTPSessionManager *)shareHttpManager
{
    static AFHTTPSessionManager *manager = nil;
    if (!manager) {
        manager = [AFHTTPSessionManager manager];
        
    }
    return manager;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(NSString *)token
{
    if (!_token) {
        self.token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        
    }
    return _token;
}
-(NSString *)user_id
{
    if (!_user_id) {
        self.user_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"];
    }
    return _user_id;
}


-(NSMutableDictionary *)zodiacDic
{
    if (!_zodiacDic) {
        self.zodiacDic = [NSMutableDictionary dictionary];
        NSString *shifenStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"ShiFen"];
        if (shifenStr.length > 0) {
            [_zodiacDic addEntriesFromDictionary:[NSJSONSerialization JSONObjectWithData:[shifenStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil]];
        }
    }
    return _zodiacDic;
}
-(NSDictionary *)orderZodiacDic
{
    if (!_orderZodiacDic) {
        self.orderZodiacDic  = @{@"鼠":@"1",@"牛":@"2",@"虎":@"3",@"兔":@"4",@"龙":@"5",@"蛇":@"6",@"马":@"7",@"羊":@"8",@"猴":@"9",@"鸡":@"10",@"狗":@"11",@"猪":@"12"};
    }
    return _orderZodiacDic;
}


-(NSMutableArray *)redArray
{
    if (!_redArray) {
        self.redArray = [NSMutableArray arrayWithObjects:@(1),@(2), @(7), @(8), @(12), @(13), @(18), @(19), @(23), @(24), @(29), @(30), @(34), @(35), @(40), @(45), @(46), nil];
    }
    return _redArray;
}
-(NSMutableArray *)blueArray
{
    if (!_blueArray) {
        self.blueArray = [NSMutableArray arrayWithObjects:@3,@4,@9,@10,@14,@15,@20,@25,@26,@31,@36,@37,@41,@42,@47,@48, nil];
    }
    return _blueArray;
}
-(NSMutableArray *)greenArray
{
    if (!_greenArray) {
        _greenArray = [NSMutableArray arrayWithObjects:@5,@6,@11,@16,@17,@21,@22,@27,@28,@32,@33,@38,@39,@43,@44,@49,nil];
    }
    return _greenArray;
}
//-(NSMutableDictionary *)numColorDic
//{
////    if (!_numColorDic) {
////        _numColorDic = [NSMutableDictionary dictionary];
////        [_numColorDic setObject:[UIColor RGBColor:240 g:198 b:45] forKey:@"1"];
////        [_numColorDic setObject:[UIColor RGBColor:27 g:134 b:250] forKey:@"2"];
////        [_numColorDic setObject:[UIColor RGBColor:253 g:128 b:132] forKey:@"3"];
////        [_numColorDic setObject:[UIColor RGBColor:253 g:118 b:35] forKey:@"4"];
////        [_numColorDic setObject:[UIColor RGBColor:47 g:226 b:228] forKey:@"5"];
////        [_numColorDic setObject:[UIColor RGBColor:110 g:92 b:251] forKey:@"6"];
////        [_numColorDic setObject:[UIColor RGBColor:208 g:208 b:208] forKey:@"7"];
////        [_numColorDic setObject:[UIColor RGBColor:230 g:50 b:58] forKey:@"8"];
////        [_numColorDic setObject:[UIColor RGBColor:196 g:102 b:44] forKey:@"9"];
////        [_numColorDic setObject:[UIColor RGBColor:31 g:189 b:33] forKey:@"10"];
////    }
////    return _numColorDic;
//}
- (NSMutableDictionary *)danshuangDic
{
    if (!_danshuangDic) {
        _danshuangDic = [NSMutableDictionary dictionary];
        [_danshuangDic setObject:@"1,7,13,19,23,29,35,45" forKey:@"红单"];
        [_danshuangDic setObject:@"2,8,12,18,24,30,34,40,46" forKey:@"红双"];
        [_danshuangDic setObject:@"29,30,34,35,40,45,46" forKey:@"红大"];
        [_danshuangDic setObject:@"1,2,7,8,12,13,18,19,23,24" forKey:@"红小"];
        [_danshuangDic setObject:@"1,7,12,18,23,29,30,34,45" forKey:@"红合单"];
        [_danshuangDic setObject:@"2,8,13,19,24,35,40,46" forKey:@"红合双"];
        [_danshuangDic setObject:@"5,11,17,21,27,33,39,43,49" forKey:@"绿单"];
        [_danshuangDic setObject:@"6,16,22,28,32,38,44" forKey:@"绿双"];
        [_danshuangDic setObject:@"27,28,32,33,38,39,43,44" forKey:@"绿大"];
        [_danshuangDic setObject:@"5,6,11,16,17,21,22" forKey:@"绿小"];
        [_danshuangDic setObject:@"5,16,21,27,32,38,43,49" forKey:@"绿合单"];
        [_danshuangDic setObject:@"6,11,17,22,28,33,39,44" forKey:@"绿合双"];
        [_danshuangDic setObject:@"3,9,15,25,31,37,41,47" forKey:@"蓝单"];
        [_danshuangDic setObject:@"4,10,14,20,26,36,42,48" forKey:@"蓝双"];
        [_danshuangDic setObject:@"25,26,31,36,37,41,42,47,48" forKey:@"蓝大"];
        [_danshuangDic setObject:@"3,4,9,10,14,15,20" forKey:@"蓝小"];
        [_danshuangDic setObject:@"3,9,10,14,25,36,41,47" forKey:@"蓝合单"];
        [_danshuangDic setObject:@"4,15,20,26,31,37,42,48" forKey:@"蓝合双"];
    }
    return _danshuangDic;
}



+ (NSString *)getDateStringWithTimeStamp:(NSString *)timeStamp
{
    NSTimeInterval time=[timeStamp doubleValue]/1000.0;
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];

    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    return currentDateStr;
}
//时间戳转NSString
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString fomart:(NSString *)fm
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:fm];
    //    yyyy-MM-dd HH:mm
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

//+ (void)show
//{
//    [MBProgressHUD showMessage:@"请稍后"];
//}
//+ (void)hide
//{
//    [MBProgressHUD hideHUD];
//}
//+ (UIImage *)getFitImageWithImage:(UIImage *)oldImage targetSize:(CGSize)targetSize
//{
//    CGSize size = oldImage.size;
//    CGFloat rate = MIN(size.width / targetSize.width, size.height / targetSize.height);
//    CGRect rect = CGRectMake((size.width - rate * targetSize.width) / 2.0, (size.height - rate * targetSize.height) / 2.0, rate * targetSize.width, rate * targetSize.height);
//    CGImageRef cgimage = CGImageCreateWithImageInRect(oldImage.CGImage, rect);
//    UIImage *image = [UIImage imageWithCGImage:cgimage];
//    CGImageRelease(cgimage);
//    return image;
//}
//
//+ (void)startGetNetWorkWithURL:(NSString *)url successBlk:(void (^)(id))successBlk failedBlk:(void (^)(id))failedBlk
//{
//    AFHTTPSessionManager *manager = HttpManager;
//    //    manager.requestSerializer.timeoutInterval = 40;
//    manager.requestSerializer.timeoutInterval = 10;
//    //申明请求的数据是json类型
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-type"];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager GET:[NSString stringWithFormat:@"%@%@",ServerURL,url] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        successBlk(responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [MBProgressHUD hideHUD];
//        failedBlk(error);
//    }];
//}
//+ (void)startPostNetWorkWithURL:(NSString *)url params:(NSDictionary *)params successBlk:(void (^)(id))successBlk failedBlk:(void (^)(NSError * errorInfo))failedBlk
//{
//    NSMutableDictionary *params1 = [params mutableCopy];
//    if (!params1) {
//        params1 = [NSMutableDictionary dictionary];
//    }
//    [params1 setObject:kClientType forKey:@"clientType"];
//    [params1 setObject:kCompanyShortName forKey:@"companyShortName"];
//    [params1 setObject:kVersion forKey:@"appVersion"];
//
//    //    [MBProgressHUD showMessage:@"请稍后"];
//    AFHTTPSessionManager *manager = HttpManager;
//    manager.requestSerializer.timeoutInterval = 10;
//    //申明请求的数据是json类型
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-type"];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//
////    NSLog(@"%@---%@",[NSString stringWithFormat:@"%@%@",ServerURL,url],params);
//    [manager POST:[NSString stringWithFormat:@"%@%@",ServerURL,url] parameters:params1 progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        successBlk(responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        //       [MBProgressHUD hideHUD];
//        failedBlk(error);
//        //        NSLog(@"%@",error);
//    }];
//}
//
//-(void)setOrLine:(BOOL)orLine {
//    _orLine = orLine;
//    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//
//    if (_orLine == YES) {
//        [appDelegate.timer setFireDate:[NSDate date]];
//    }else if (_orLine == NO&&appDelegate.timer!= nil){
//        [appDelegate.timer setFireDate:[NSDate distantFuture]];
//    }
//}
//
////
//+ (LotteryInfoModel *)readLocationHisLotteryData:(NSString *)caizhongId
//{
//    NSString *key = [NSString stringWithFormat:@"playgroupId%@",caizhongId];
//    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
//
//    LotteryInfoModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    return model;
//}
//+ (void)saveHisLotteryData:(LotteryInfoModel *)model
//{
//    NSString *key = [NSString stringWithFormat:@"playgroupId%@",model.playGroupId];
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    [user setObject:data forKey:key];
//    [user synchronize];
//}
//// 保存/读取-赔率记录
//+ (NSMutableArray<OfficialPeiLvModel*> *)readLocationPeilvData:(NSString *)wanfaId
//{
//    NSString *key = [NSString stringWithFormat:@"peilvDataWithWanfaid%@",wanfaId];
//    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
//    NSMutableArray *peilvdata = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    return peilvdata;
//}
//+ (void)savePeilvData:(NSMutableArray<OfficialPeiLvModel*> *)peilvData wanfaid:(NSString *)wanfaid
//{
//    if (peilvData.count<=0) {
//        return;
//    }
//    NSString *key = [NSString stringWithFormat:@"peilvDataWithWanfaid%@",wanfaid];
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:peilvData];
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    [user setObject:data forKey:key];
//    [user synchronize];
//}
//+ (NSMutableArray<OfficialPeiLvModel*> *)readOriginalPeilvData:(NSString *)wanfaId
//{
//    NSString *key = [NSString stringWithFormat:@"originalpeilvDataWithWanfaid%@",wanfaId];
//    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
//
//    NSMutableArray *peilvdata = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    return peilvdata;
//}
//+ (void)saveOriginalPeilvData:(NSMutableArray<OfficialPeiLvModel*> *)peilvData wanfaid:(NSString *)wanfaid
//{
//    if (peilvData.count<=0) {
//        return;
//    }
//    NSString *key = [NSString stringWithFormat:@"originalpeilvDataWithWanfaid%@",wanfaid];
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:peilvData];
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    [user setObject:data forKey:key];
//    [user synchronize];
//}
+ (NSArray *)readCachePromotionListData
{
    NSString *key = @"PromotionListData";
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    NSMutableArray *listdata = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return listdata;
}
+ (void)savePromotionListData:(NSArray *)arr
{
    if (arr.count<=0) {
        return;
    }
    NSString *key = @"PromotionListData";
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:data forKey:key];
    [user synchronize];
}

+ (void)firstInstall
{
    NSString *flag = [[NSUserDefaults standardUserDefaults] objectForKey:@"firstInstall"];
    if (!flag) {
        
        [HttpHelper startPostNetWorkWithURL:@"app/installFisrtInvoke.json" params:nil successBlk:^(id responseObject) {
            
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            if ([dataDic[@"result"] integerValue]==1) {
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"firstInstall"];
            }
  
        } failedBlk:^(NSError * errorInfo) {
            
        }];
    }
}

+ (void)removeNSUserDefault
{
//    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
//    
//    NSDictionary* dict = [defs dictionaryRepresentation];
//
//    for(id key in dict) {
//        
//        if ([key isEqualToString:kLastAccountKey]) {
//            
//        }else if ([key isEqualToString:@"firstCouponBoard_iPhone"]){
//            
//        }else if ([key rangeOfString:@"peilvDataWithWanfaid"].location !=NSNotFound) {
//        
//        }else if ([key rangeOfString:@"playgroupId"].location != NSNotFound) {
//        
//        }
//        else{
//            [defs removeObjectForKey:key];
//        }
//    }
//    [defs synchronize];
}

//+(NSMutableArray *)calculateCountWithSelectedCount:(NSMutableArray *)array baseNum:(NSInteger)baseNum
//{
//    int n = (int)[array count];
//    
//    if (baseNum > n)
//    {
//        return nil;
//    }
//    NSMutableArray *allChooseArray = [NSMutableArray array];
//    NSMutableArray *retArray = [array copy];
//    for(int i=0;i < n;i++)
//    {
//        if (i < baseNum)
//        {
//            [array replaceObjectAtIndex:i withObject:@"1"];
//        }
//        else
//        {
//            [array replaceObjectAtIndex:i withObject:@"0"];
//        }
//    }
//    NSMutableArray *firstArray = [[NSMutableArray alloc] init];
//    for(int i=0; i<n; i++)
//    {
//        if ([[array objectAtIndex:i] intValue] == 1)
//        {
//            [firstArray addObject:[retArray objectAtIndex:i]];
//        }
//    }
//    [allChooseArray addObject:firstArray];
//    int count = 0;
//    for(int i = 0; i < n-1; i++)
//    {
//        if ([[array objectAtIndex:i] intValue] == 1 && [[array objectAtIndex:(i + 1)] intValue] == 0)
//        {
//            [array replaceObjectAtIndex:i withObject:@"0"];
//            [array replaceObjectAtIndex:(i + 1) withObject:@"1"];
//            for (int k = 0; k < i; k++)
//            {
//                if ([[array objectAtIndex:k] intValue] == 1)
//                {
//                    count ++;
//                }
//            }
//            if (count > 0)
//            {
//                for (int k = 0; k < i; k++)
//                {
//                    if (k < count)
//                    {
//                        // k = 1, (1,1,0,1,0)
//                        [array replaceObjectAtIndex:k withObject:@"1"];
//                    }
//                    else
//                    {
//                        [array replaceObjectAtIndex:k withObject:@"0"];
//                    }
//                }
//            }
//            NSMutableArray *middleArray = [[NSMutableArray alloc] init];
//            for (int k = 0; k < n; k++)
//            {
//                if ([[array objectAtIndex:k] intValue] == 1)
//                {
//                    [middleArray addObject:[retArray objectAtIndex:k]];
//                }
//            }
//            [allChooseArray addObject:middleArray];
//            i = -1;
//            count = 0;
//        }
//    }
//    return allChooseArray;
//}

// 状态条的高度
- (CGFloat) statusBarHeight
{
    if (@available(iOS 11.0, *)) {
        // iphoneX
        if (ScreenH==812) {
            return 44;
        }else {
            return 20;
        }
    }
    return 20;
}
// 导航条高度
- (CGFloat)NavigationBarHeight
{
    return 44;
}
// 画面中视图的起始位置
- (CGFloat)viewTopOffset
{
    return [self statusBarHeight]+[self NavigationBarHeight];
}

- (CGFloat)sysTabBarHeight
{
    if (@available(iOS 11.0, *)) {
        // iphoneX
        if (ScreenH==812) {
            return 83;
        }
    }
    return 49;
}
- (CGFloat)safeAreaBottom
{
    if (@available(iOS 11.0, *)) {
        // iphoneX
        if (ScreenH==812) {
            return 34;
        }
    }
    return 0;
    
}


- (UIColor *)getTrendTextColor:(NSUInteger)i arrCount:(NSUInteger)count
{
    UIColor *color = labelTextClor;
    if (i == count-4) {
        color = COLOR(100, 177, 249);
    }else if (i == count-3) {
        color = COLOR(75, 211, 233);
    }else if (i == count-2) {
        color = COLOR(252, 84, 87);
    }else if (i == count-1) {
        color = COLOR(151, 82, 50);
    }
    return color;
}


- (BOOL)isEnablePlayGroupId:(NSString *)playGroupId
{
    BOOL result = NO;
    
    for (int i = 0; i < Helper.caizhongConfigArr.count; i ++) {
        NSDictionary *dic = Helper.caizhongConfigArr[i];
        if ([dic[@"id"] integerValue]==[playGroupId integerValue] && [dic[@"enable"] integerValue]==1) {
            result = YES;
            break;
        }
    }
    
    return result;
}


@end
