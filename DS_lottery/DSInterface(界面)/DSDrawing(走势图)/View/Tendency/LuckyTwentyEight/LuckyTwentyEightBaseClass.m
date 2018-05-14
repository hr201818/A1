//
//  LuckyTwentyEightBaseClass.m
//  Ticket
//
//  Created by pro on 2017/7/18.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "LuckyTwentyEightBaseClass.h"
#import "tool.h"
@implementation LuckyTwentyEightBaseClass
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

        [_resultsArr addObject:[json[@"openCode"] componentsSeparatedByString:@","]];

    }


    [_issueArr addObject:@"出现总次数"];
    [_issueArr addObject:@"平均遗漏值"];
    [_issueArr addObject:@"最大遗漏值"];
    [_issueArr addObject:@"最大连出值"];

    for (NSInteger i =0; i <  10; i++) {
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

            if ([aa containsObject:[NSString stringWithFormat:@"%ld",i]]==YES) {

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

            if ([aa containsObject:[NSString stringWithFormat:@"%ld",i]]==YES) {
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
    //和值分布

     NSMutableArray *valueResultsArr = [NSMutableArray new];
     NSMutableArray *valueNumberArr = [NSMutableArray new];
     NSMutableArray *valueValuesArr = [NSMutableArray new];
     NSMutableArray *valueMaxValuesArr = [NSMutableArray new];
     NSMutableArray *valueEvenValueArr = [NSMutableArray new];

    for (NSArray *aa in _resultsArr) {
        NSInteger i = 0;
        for (NSString *nu in aa) {
            i=[nu integerValue]+i;
        }
        [valueResultsArr addObject:@(i)];
    }
    for (NSInteger i = 1; i <28; i++) {
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



            if ([valueResultsArr containsObject:[NSString stringWithFormat:@"%ld",i]]==YES) {

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


            if ([valueResultsArr containsObject:[NSString stringWithFormat:@"%ld",i]]==YES) {
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
