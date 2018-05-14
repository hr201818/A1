//
//  SSQBaseClass.m
//  Ticket
//
//  Created by pro on 2017/11/6.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "SSQBaseClass.h"
#import "tool.h"
@implementation SSQBaseClass
+(void)requstWithSuccess:(NSDictionary *)dict nper:(NSInteger)nper returnValue:(void (^)(NSMutableArray *issueArr,NSMutableArray *resultsArr,NSMutableArray *numberArr,NSMutableArray *valuesArr,NSMutableArray *maxValuesArr,NSMutableArray *evenValueArr, NSMutableArray *valueResultsArr, NSMutableArray *valueNumberArr, NSMutableArray *valueValuesArr, NSMutableArray *valueMaxValuesArr, NSMutableArray *valueEvenValueArr))block{
    NSMutableArray *_issueArr =[NSMutableArray new];
    NSMutableArray *_resultsArr =[NSMutableArray new];
    NSMutableArray *_numberArr =[NSMutableArray new];
    NSMutableArray *_valuesArr =[NSMutableArray new];
    NSMutableArray *_maxValuesArr =[NSMutableArray new];
    NSMutableArray *_evenValueArr =[NSMutableArray new];

    NSArray *arr = dict[@"sscHistoryList"];
    if (nper>=arr.count) {
        nper = arr.count;
    }
    for (NSDictionary *json in [arr subarrayWithRange:NSMakeRange(0, nper)]) {
        [_issueArr addObject:json[@"number"]];
        NSArray *a = [json[@"openCode"] componentsSeparatedByString:@","];
        [_resultsArr addObject:[a subarrayWithRange:NSMakeRange(0, a.count-1)]];

    }

    [_issueArr addObject:@"出现总次数"];
    [_issueArr addObject:@"平均遗漏值"];
    [_issueArr addObject:@"最大遗漏值"];
    [_issueArr addObject:@"最大连出值"];

    for (NSInteger i =1; i <  34; i++) {
        //出现总次数
        int zongcishu = 0;
        for (NSArray *a in _resultsArr) {
            for (NSString *value in a) {
                if (i==[value integerValue]) {
                    zongcishu++;
                }
            }

        }

        [_numberArr addObject:@(zongcishu)];

        //平均遗漏值    （总期数-出现总次数）/ 遗漏段数
        int pingjunyilou = 0; BOOL shiling = NO;//遍历时遇到开奖结果相等置为YES

        for (int j=0; j < _resultsArr.count; j++) {

            NSArray *aa =_resultsArr [j];

            if ([aa containsObject:[NSString stringWithFormat:@"%02ld",i]]==YES) {

                if (j!=0&&shiling==NO) {
                    pingjunyilou++;
                }
                shiling = YES;
            }else{
                shiling = NO;
                if (j==_resultsArr.count-1&&shiling==NO) {
                    pingjunyilou++;
                }
            }
        }

        [_valuesArr addObject:@((nper-zongcishu)/( pingjunyilou==0 ? 1:pingjunyilou))];
        //        //最大遗漏值
        NSMutableArray *zdylArr =[NSMutableArray new]; NSInteger zuidayilou=0;
        //最大连出值
        NSMutableArray *zdlcArr =[NSMutableArray new]; NSInteger zuilianchu=0;
        for (int j=0; j < _resultsArr.count; j++) {
            NSArray *aa =_resultsArr [j];

            if ([aa containsObject:[NSString stringWithFormat:@"%02ld",i]]==YES) {
                zuilianchu++;
                zuidayilou=0;

            }else{
                zuilianchu = 0;
                zuidayilou++;//

            }

            [zdylArr addObject:@(zuidayilou)];
            [zdlcArr addObject:@(zuilianchu)];
        }

        [_maxValuesArr addObject:[zdylArr valueForKeyPath:@"@max.floatValue"]];
        [_evenValueArr addObject:[zdlcArr valueForKeyPath:@"@max.floatValue"]];
    }

    //蓝球
    NSMutableArray *valueResultsArr = [NSMutableArray new];
    NSMutableArray *valueNumberArr = [NSMutableArray new];
    NSMutableArray *valueValuesArr = [NSMutableArray new];
    NSMutableArray *valueMaxValuesArr = [NSMutableArray new];
    NSMutableArray *valueEvenValueArr = [NSMutableArray new];

    NSMutableArray *aaa = [NSMutableArray new];
    for (NSDictionary *json in [arr subarrayWithRange:NSMakeRange(0, nper)]) {
        NSArray *a = [json[@"openCode"] componentsSeparatedByString:@","];
        [aaa addObject:[a subarrayWithRange:NSMakeRange(a.count-1, 1)]];

    }
    for (NSArray *aa in aaa) {
        for (NSString *vv in aa) {
            [valueResultsArr addObject:vv];
        }
    }

    for (NSInteger i = 1; i <17; i++) {
        //出现总次数
        int zongcishu = 0;

        for (NSString *value in valueResultsArr) {
            if (i==[value integerValue]) {
                zongcishu++;
            }
        }
        [valueNumberArr addObject:@(zongcishu)];

        //平均遗漏值    （总期数-出现总次数）/ 遗漏段数
        int pingjunyilou = 0; BOOL shiling = NO;//遍历时遇到开奖结果相等置为YES

        for (int j=0; j < valueResultsArr.count; j++) {

            if (i==[valueResultsArr[j] integerValue]) {

                if (j!=0&&shiling==NO) {
                    pingjunyilou++;
                }
                shiling = YES;
            }else{
                shiling = NO;
                if (j==valueResultsArr.count-1&&shiling==NO) {
                    pingjunyilou++;
                }
            }
        }

        [valueValuesArr addObject:@((nper-zongcishu)/(pingjunyilou==0?1:pingjunyilou))];
        //        //最大遗漏值
        NSMutableArray *zdylArr =[NSMutableArray new]; NSInteger zuidayilou=0;
        //最大连出值
        NSMutableArray *zdlcArr =[NSMutableArray new]; NSInteger zuilianchu=0;
        for (int j=0; j < valueResultsArr.count; j++) {


            if (i==[valueResultsArr[j] integerValue]) {
                zuilianchu++;
                zuidayilou=0;

            }else{
                zuilianchu = 0;
                zuidayilou++;//

            }

            [zdylArr addObject:@(zuidayilou)];
            [zdlcArr addObject:@(zuilianchu)];
        }

        [valueMaxValuesArr addObject:[zdylArr valueForKeyPath:@"@max.floatValue"]];
        [valueEvenValueArr addObject:[zdlcArr valueForKeyPath:@"@max.floatValue"]];

    }

    if (block) {
        block(_issueArr,
              _resultsArr,
              _numberArr,
              _valuesArr,
              _maxValuesArr,
              _evenValueArr,
              valueResultsArr,
              valueNumberArr,
              valueValuesArr,
              valueMaxValuesArr,
              valueEvenValueArr);
    }

}
@end
