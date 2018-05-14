//
//  tool.m
//  Ticket
//
//  Created by pro on 2017/7/7.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "tool.h"

#import "Header.h"

@implementation tool


+(NSString *)ChineseZodiac:(NSString *)time{
    NSArray *array=@[@"鼠_4",@"牛_5",@"虎_6",@"兔_7",@"龙_8",@"蛇_9",@"马_10",@"羊_11",@"猴_0",@"鸡_1",@"狗_2",@"猪_3"];
    for (int i=0; i<array.count; i++) {
        if ([[array[i] componentsSeparatedByString:@"_"][1] isEqualToString:[NSString stringWithFormat:@"%ld",[time integerValue]%12]]) {
//            NSLog(@"属%@-->>>%@",[array[i] componentsSeparatedByString:@"_"][0],[NSString stringWithFormat:@"%ld",[time integerValue]%12]);
            return [array[i] componentsSeparatedByString:@"_"][0];
        }
    }
    return nil;
}

+(BOOL)isBlankString:(NSString *)string{

    if (string == nil) {
        return YES;
    }else if (string == NULL) {
        return YES;
    }else if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }else if ([string isEqualToString:@"(null)"]) {
        return YES;
    }else if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }else{
        return NO;
    }
}
+(NSMutableArray *)rangeOfSubString:(NSString *)subStr inString:(NSString *)string {

    NSMutableArray *rangeArray = [NSMutableArray array];

    NSString *string1 = [string stringByAppendingString:subStr];

    NSString *temp;

    for (int i = 0; i < string.length; i ++) {

        temp = [string1 substringWithRange:NSMakeRange(i, subStr.length)];

        if ([temp isEqualToString:subStr]) {

            NSRange range = {i,subStr.length};

            [rangeArray addObject:NSStringFromRange(range)];
        }
    }

    return rangeArray;
}

+(BOOL)nsArrIsNull:(NSArray *)arr{
    if ([arr isKindOfClass:[NSNull class]]||arr.count == 0) {
        return NO;
    }else{
        return YES;
    }
}
+(BOOL)arrIsNull:(NSMutableArray *)arr{
    if ([arr isKindOfClass:[NSNull class]]||arr.count == 0) {
        return NO;
    }else{
        return YES;
    }
}

+ (BOOL)dx_isNullOrNilWithObject:(id)object{
    if (object == nil || [object isEqual:[NSNull null]]) {
        return YES;
    } else if ([object isKindOfClass:[NSString class]]) {
        if ([object isEqualToString:@""]) {
            return YES;
        } else {
            return NO;
        }
    } else if ([object isKindOfClass:[NSNumber class]]) {
        if ([object isEqualToNumber:@0]) {
            return YES;
        } else {
            return NO;
        }
    }

    return NO;
}
+(UIViewController *)getCurrentViewController:(UIView *)view{
    UIResponder *next = [view nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}
//+(void)Alert:(NSString *)massage success:(BOOL)success{
//
//    if (success) {
//        [MBProgressHUD showSuccess:massage withTime:2.0];
//    }else {
//        [MBProgressHUD showError:massage withTime:2.0];
//    }
//}
+(void)Alert:(NSString *)massage{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:massage delegate:nil  cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    [self performSelector:@selector(alertDimiss:) withObject:alert afterDelay:2.5];

}
+(void) alertDimiss:(UIAlertView *)alert {
    if(alert)     {
        [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
    }
}
+(NSString *)time:(NSString *)timeStr{

    NSTimeInterval time=[timeStr doubleValue]/1000.0;
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];

    return currentDateStr;
}
+(NSString *)noTime:(NSString *)timeStr{
    NSTimeInterval time=[timeStr doubleValue]/1000.0;
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];

    return currentDateStr;
}
+(NSUInteger)unicodeLengthOfString: (NSString *) text {
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    NSUInteger unicodeLength = asciiLength / 2;
    if(asciiLength % 2) {
        unicodeLength++;
    }
    return unicodeLength;
}
+(int)numbeLengthOfString:(NSString*)strtemp{

    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUTF8StringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUTF8StringEncoding] ;i++) {
        if (*p) {
            if(*p == '\xe4' || *p == '\xe5' || *p == '\xe6' || *p == '\xe7' || *p == '\xe8' || *p == '\xe9')
            {
                strlength--;
            }
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

+(BOOL)checkPassWord:(NSString *)passWords
{
    //6-12位数字和字母组成
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$";

    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:passWords]) {
        return YES ;
    }else
        return NO;
}
+ (BOOL)isEnglishFirst:(NSString *)str {
    NSString *regular = @"^[A-Za-z].+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];

    if ([predicate evaluateWithObject:str] == YES){
        return YES;
    }else{
        return NO;
    }
}
+(BOOL)JudgeTheillegalCharacter:(NSString *)content{
    //提示 标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:content]) {
        return YES;
    }
    return NO;
}
+(BOOL)isChinese:(NSString*)str
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:str];
}

+(BOOL)includeChinese:(NSString*)str
{
    for(int i=0; i< [str length];i++)
    {
        int a =[str characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}
//汉字转数字
+(NSString *)translationArebicStr:(NSString *)chineseStr{
    NSString *str = chineseStr;

    NSArray *arabic_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"10"];
    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零", @"十"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:arabic_numerals forKeys:chinese_numerals];

    NSMutableArray *sums = [NSMutableArray array];

    for (int i = 0; i < str.length; i ++) {
        NSString *substr = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *sum = substr;
        if([chinese_numerals containsObject:substr]){

            if([substr isEqualToString:@"十"] && i < str.length){
                NSString *nextStr = [str substringWithRange:NSMakeRange(i+1, 1)];
                if([chinese_numerals containsObject:nextStr]){
                    continue;
                }
            }
            sum = [dictionary objectForKey:substr];
        }

        [sums addObject:sum];
    }

    NSString *sumStr = [sums  componentsJoinedByString:@""];
    return sumStr;
}
+(NSString *)encryptionCardNumber:(NSString *)cardNumber{
    // 银行卡号
    NSString *originalString = cardNumber;

    // 转换成可变字符串
    NSMutableString *stringM = [NSMutableString stringWithFormat:@"%@",originalString];

    NSRange range = {4,stringM.length -4};

    [stringM deleteCharactersInRange:range];//根据范围删除子字符串

//    NSLog(@"留下前面需要的字符串%@",stringM);

    [stringM appendString:@"********"];//个数根据银行卡号长度规则而定

//    NSLog(@"拼接隐藏个数%@",stringM);

    NSMutableString *endString = [NSMutableString stringWithFormat:@"%@",originalString];

    NSRange endRange = {0,endString.length-4};

    [endString deleteCharactersInRange:endRange];

//    NSLog(@"留下末尾需要的字符串%@",endString);

    [stringM appendString:endString];

//    NSLog(@"拼接后最终效果%@",stringM);
    return stringM;
}
+(NSString *)date{
    NSDate * date = [NSDate date];//当前时间
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSString *currentDateStr =   [dateFormatter stringFromDate:firstDayOfWeek];
    return currentDateStr;
}

+(NSString *)During{
    NSDate *firstDay = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&firstDay interval:nil forDate:[NSDate date]];
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:firstDay];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr =   [dateFormatter stringFromDate:firstDayOfWeek];

    return currentDateStr;
}
+(NSString *)lastDay{
    NSDate * date = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:[NSDate date]];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSString *currentDateStr =   [dateFormatter stringFromDate:firstDayOfWeek];
    return currentDateStr;
}
+(NSString *)dayBeforeYesterday{
    NSDate * date = [NSDate dateWithTimeInterval:(-24*60*60)*2 sinceDate:[NSDate date]];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSString *currentDateStr =   [dateFormatter stringFromDate:firstDayOfWeek];
    return currentDateStr;

}
+(NSString *)nextDay{

    NSDate *nextDay = [NSDate dateWithTimeInterval:24*60*60 sinceDate:[NSDate date]];//后一天
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:nextDay];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSString *currentDateStr =   [dateFormatter stringFromDate:firstDayOfWeek];

    return currentDateStr;

}
+(NSString *)LastMonday{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitDay
                                         fromDate:now];

    // 得到星期几
    // 1(星期天) 2(星期二) 3(星期三) 4(星期四) 5(星期五) 6(星期六) 7(星期天)
    NSInteger weekDay = [comp weekday];
    // 得到几号
    NSInteger day = [comp day];

    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff;//,lastDiff;
    if (weekDay == 1) {
        firstDiff = 7;
//        lastDiff = 0;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay-6;
//        lastDiff = 1 - weekDay;
    }

    // 在当前日期(去掉了时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];

    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    return [formater stringFromDate:firstDayOfWeek];
}
+(NSString *)LastSunday{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitDay
                                         fromDate:now];

    // 得到星期几
    // 1(星期天) 2(星期二) 3(星期三) 4(星期四) 5(星期五) 6(星期六) 7(星期天)
    NSInteger weekDay = [comp weekday];
    // 得到几号
    NSInteger day = [comp day];

    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = 7;
        lastDiff = 0;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay-6;
        lastDiff = 2 - weekDay;
    }

    // 在当前日期(去掉了时分秒)基础上加上差的天数
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];

    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    return [formater stringFromDate:lastDayOfWeek];
}
+(NSString *)OnMonday{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitDay
                                         fromDate:now];

    // 得到星期几
    // 1(星期天) 2(星期一) 3(星期二) 4(星期三) 5(星期四) 6(星期五) 7(星期六)
    NSInteger weekDay = [comp weekday];
    // 得到几号
    NSInteger day = [comp day];

    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = 1;
        lastDiff = 0;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay+1;
        lastDiff = 8 - weekDay;
    }


    // 在当前日期(去掉了时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];

    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    return [formater stringFromDate:firstDayOfWeek];
}
+(NSString *)OnSunday{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitDay
                                         fromDate:now];

    // 得到星期几
    // 1(星期天) 2(星期一) 3(星期二) 4(星期三) 5(星期四) 6(星期五) 7(星期六)
    NSInteger weekDay = [comp weekday];
    // 得到几号
    NSInteger day = [comp day];

    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = 1;
        lastDiff = 0;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay+1;
        lastDiff = 9 - weekDay;
    }

    // 在当前日期(去掉了时分秒)基础上加上差的天数

    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];

    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    return [formater stringFromDate:lastDayOfWeek];
}
+(CGSize)CommentSizeContent:(NSString*)Text Font:(UIFont *)font size:(CGSize)size
{
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize sizes = [Text boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine| NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;

    return sizes;
}
//去掉数字前面的0
+(NSString*) getTheCorrectNum:(NSString*)tempString
{
    while ([tempString hasPrefix:@"0"])
    {
        tempString = [tempString substringFromIndex:1];
    }

    return tempString;
}
+(BOOL)parity:(NSInteger)number{
   return  number%2 == 0 ? YES:NO;
}

+(NSString *)doubleFromStr:(NSString *)str{
    if ([str isKindOfClass:[NSNull class]]) {
        return @"";
    }
    double d            = [str doubleValue];
    NSString *dStr      = [NSString stringWithFormat:@"%f", d];
    NSDecimalNumber *dn = [NSDecimalNumber decimalNumberWithString:dStr];
   return  [dn stringValue];
}
+(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    //    UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage *scaleImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImage;
}
+(void)textFieldDone{

    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
//+(void)clearAllCache{
//
//    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
//    NSDictionary* dict = [defs dictionaryRepresentation];
//
//    for (NSString *key in [dict allKeys]) {
//
//        if ([key isEqualToString:@"account"]) {
//
//        }else if ([key isEqualToString:@"token"]){
//
//        }else if ([key isEqualToString:@"user_id"]){
//
//        }else if ([key isEqualToString:@"getUserSession"]){
//
//        }else if ([key isEqualToString:kLastAccountKey]){
//
//        }else{
//            [defs removeObjectForKey:key];
//        }
//    }
//    [defs synchronize];
//
//    [self clearCache:[NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()]];
//    [self clearCache:[NSString stringWithFormat:@"%@/Library",NSHomeDirectory()]];
//    [self clearCache:[NSString stringWithFormat:@"%@/tmp",NSHomeDirectory()]];
//    [self clearPreferencesCache:[NSString stringWithFormat:@"%@/Library/Preferences",NSHomeDirectory()]];
//
//    //清除webView的缓存
//    [[NSURLCache sharedURLCache] removeAllCachedResponses];
//
//    //清除cookies
//    NSHTTPCookie *cookie;
//    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (cookie in [storage cookies]) {
//        [storage deleteCookie:cookie];
//    }
//}
//+(void)clearPreferencesCache:(NSString *)path{
//    NSFileManager *fileManager=[NSFileManager defaultManager];
//    if ([fileManager fileExistsAtPath:path]) {
//        NSArray *childerFiles=[fileManager subpathsAtPath:path];
//        for (NSString *fileName in childerFiles) {
//            //如有需要，加入条件，过滤掉不想删除的文件
//            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
//            if (![absolutePath isEqualToString:[NSString stringWithFormat:@"%@/Library/Preferences/com.600w.project.plist",NSHomeDirectory()]]) {
//                [fileManager removeItemAtPath:absolutePath error:nil];
//            }
//        }
//    }
//}
////根据路径清除缓存
//+(void)clearCache:(NSString *)path{
//
//    NSFileManager *fileManager=[NSFileManager defaultManager];
//    if ([fileManager fileExistsAtPath:path]) {
//        NSArray *childerFiles=[fileManager subpathsAtPath:path];
//        for (NSString *fileName in childerFiles) {
//            //如有需要，加入条件，过滤掉不想删除的文件
//            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
//            if ([absolutePath rangeOfString:@"Preferences"].location !=NSNotFound) {
//            }else{
//                [fileManager removeItemAtPath:absolutePath error:nil];
//            }
//
//        }
//    }
//
//
//}
////计算缓存文件夹大小
//+(float)folderSizeAtPath:(NSString *)path{
//    NSFileManager *fileManager=[NSFileManager defaultManager];
//    float folderSize = 0.0;
//    if ([fileManager fileExistsAtPath:path]) {
//        NSArray *childerFiles=[fileManager subpathsAtPath:path];
//        for (NSString *fileName in childerFiles) {
//            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
//            folderSize +=[self fileSizeAtPath:absolutePath];
//        }
//        //SDWebImage框架自身计算缓存的实现
////        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
//        return folderSize;
//    }
//    return 0;
//}
////计算单个文件夹大小
//+(float)fileSizeAtPath:(NSString *)path{
//    NSFileManager *fileManager=[NSFileManager defaultManager];
//    if([fileManager fileExistsAtPath:path]){ long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
//        return size/1024.0/1024.0;
//    }
//    return 0;
//}
//+ (NSString *)bankLogoName:(NSString *)bankName{
//    NSString *logoName = @"其他.png";
//    if([bankName rangeOfString:@"交通银行"].location !=NSNotFound)    {
//       logoName = @"交通银行.png";
//    }else if ([bankName rangeOfString:@"招商银行"].location !=NSNotFound){
//        logoName = @"招商银行.png";
//    }else if ([bankName rangeOfString:@"建设银行"].location !=NSNotFound){
//        logoName = @"建设银行.png";
//    }else if ([bankName rangeOfString:@"工商银行"].location !=NSNotFound){
//        logoName = @"工商银行.png";
//    }else if ([bankName rangeOfString:@"农业银行"].location !=NSNotFound){
//        logoName = @"农业银行.png";
//    }else if ([bankName rangeOfString:@"民生银行"].location !=NSNotFound){
//        logoName = @"民生银行.png";
//    }else if ([bankName rangeOfString:@"兴业银行"].location !=NSNotFound){
//        logoName = @"兴业银行.png";
//    }else if ([bankName rangeOfString:@"浦发银行"].location !=NSNotFound){
//        logoName = @"浦发.png";
//    }else if ([bankName rangeOfString:@"光大银行"].location !=NSNotFound){
//        logoName = @"光大.png";
//    }else if ([bankName rangeOfString:@"深圳发展"].location !=NSNotFound){
//        logoName = @"深圳发展.png";
//    }else if ([bankName rangeOfString:@"上海银行"].location !=NSNotFound){
//        logoName = @"上海.png";
//    }else if ([bankName rangeOfString:@"邮政储蓄"].location !=NSNotFound){
//        logoName = @"邮政.png";
//    }else if ([bankName rangeOfString:@"华夏银行"].location !=NSNotFound){
//        logoName = @"华夏.png";
//    }else if ([bankName rangeOfString:@"广发银行"].location !=NSNotFound){
//        logoName = @"广发.png";
//    }else if ([bankName rangeOfString:@"中信银行"].location !=NSNotFound){
//        logoName = @"中信.png";
//    }else if ([bankName rangeOfString:@"平安银行"].location !=NSNotFound){
//        logoName = @"平安.png";
//    }else if ([bankName rangeOfString:@"北京银行"].location !=NSNotFound){
//        logoName = @"北京.png";
//    }else if ([bankName rangeOfString:@"宁波银行"].location !=NSNotFound){
//        logoName = @"宁波.png";
//    }else if ([bankName isEqualToString:@"中国银行"]){
//        logoName = @"中国银行.png";
//    }
//
//    return logoName;
//}
//
//+(NSString *)getPlayGroupName:(NSInteger)playGroupId {
//    NSDictionary *sscPlayGroupIdAndName = @{@(PLAYGROUPID_CQ): @"重庆时时彩",
//                                            @(PLAYGROUPID_TJ): @"天津时时彩",
//                                            @(PLAYGROUPID_XJ): @"新疆时时彩",
//                                            @(PLAYGROUPID_TCPL3): @"体彩排列3",
//                                            @(PLAYGROUPID_FC3D): @"福彩3D",
//                                            @(PLAYGROUPID_LHC): @"香港六合彩",
//                                            @(PLAYGROUPID_XY28): @"北京28",
//                                            @(PLAYGROUPID_BJKL8): @"北京快乐8",
//                                            @(PLAYGROUPID_BJPK10): @"北京PK10",
//                                            @(PLAYGROUPID_CQXYNC): @"重庆幸运农场",
//                                            @(PLAYGROUPID_GDKLSF): @"广东快乐十分",
//                                            @(PLAYGROUPID_SSQ): @"双色球",
//                                            @(PLAYGROUPID_AJSFC): @"三分时时彩",
//                                            @(PLAYGROUPID_XYFT): @"幸运飞艇",
//                                            @(PLAYGROUPID_FFSSC): @"分分时时彩",
//                                            @(PLAYGROUPID_LFSSC): @"两分时时彩",
//                                            @(PLAYGROUPID_WFSSC): @"五分时时彩",
//                                            @(PLAYGROUPID_K3_JIANGSU): @"江苏快3",
//                                            @(PLAYGROUPID_K3_HUBEI): @"湖北快3",
//                                            @(PLAYGROUPID_K3_ANHUI): @"安徽快3",
//                                            @(PLAYGROUPID_K3_JILIN): @"吉林快3",
//                                            @(PLAYGROUPID_JSLHC): @"10分六合彩",
//                                            @(PLAYGROUPID_JSPK10): @"极速PK10"};
//    return sscPlayGroupIdAndName[@(playGroupId)];
//}
//
//+(NSArray *)getAllSscPlayGroupid
//{
//    return @[
//             @(PLAYGROUPID_CQ),
//             @(PLAYGROUPID_TJ),
//             @(PLAYGROUPID_XJ),
//             @(PLAYGROUPID_TCPL3),
//             @(PLAYGROUPID_FC3D),
//             @(PLAYGROUPID_LHC),
//             @(PLAYGROUPID_XY28),
//             @(PLAYGROUPID_BJKL8),
//             @(PLAYGROUPID_BJPK10),
//             @(PLAYGROUPID_CQXYNC),
//             @(PLAYGROUPID_GDKLSF),
//             @(PLAYGROUPID_SSQ),
//             @(PLAYGROUPID_AJSFC),
//             @(PLAYGROUPID_XYFT),
//             @(PLAYGROUPID_FFSSC),
//             @(PLAYGROUPID_LFSSC),
//             @(PLAYGROUPID_WFSSC),
//             @(PLAYGROUPID_K3_JIANGSU),
//             @(PLAYGROUPID_K3_HUBEI),
//             @(PLAYGROUPID_K3_ANHUI),
//             @(PLAYGROUPID_K3_JILIN),
//             @(PLAYGROUPID_JSLHC),
//             @(PLAYGROUPID_JSPK10),
//             ];
//}
///* 获取对象的所有属性 以及属性值 */
//+(NSDictionary *)properties_aps:(id)ss
//{
//    NSMutableDictionary *props = [NSMutableDictionary dictionary];
//    unsigned int outCount, i;
//    objc_property_t *properties = class_copyPropertyList([ss class], &outCount);
//    for (i = 0; i<outCount; i++)
//    {
//        objc_property_t property = properties[i];
//        const char* char_f =property_getName(property);
//        NSString *propertyName = [NSString stringWithUTF8String:char_f];
//        id propertyValue = [ss valueForKey:(NSString *)propertyName];
//        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
//    }
//    free(properties);
//    return props;
//}   
//+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
//{
//    if (jsonString == nil) {
//        return nil;
//    }
//
//    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *err;
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                        options:NSJSONReadingMutableContainers
//                                                          error:&err];
//    if(err)
//    {
//        NSLog(@"json解析失败：%@",err);
//        return nil;
//    }
//    return dic;
//}
//+(NSString *)convertToJsonData:(NSDictionary *)dict
//{
//
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
//
//    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
//
////    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
////
////    NSRange range = {0,jsonString.length};
////
////    //去掉字符串中的空格
////
////    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
////
////    NSRange range2 = {0,mutStr.length};
////
////    //    //去掉字符串中的换行符
////    //
////        [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
//
//    return jsonString;
//    
//}

@end
