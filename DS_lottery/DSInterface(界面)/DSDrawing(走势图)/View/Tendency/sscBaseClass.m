//
//  sscBaseClass.m
//  时时彩走势图
//
//  Created by pro on 2017/7/7.
//  Copyright © 2017年 pro. All rights reserved.
//

#import "sscBaseClass.h"
//#import "requestModels.h"

@implementation sscBaseClass
+(void)requstWithSuccess:(NSDictionary *)dict numberLength:(NSMutableArray *)numberLength location:(NSInteger)location nper:(NSInteger)nper returnValue:(void (^)(NSMutableArray *issueArr,NSMutableArray *resultsArr,NSMutableArray *numberArr,NSMutableArray *valuesArr,NSMutableArray *maxValuesArr,NSMutableArray *evenValueArr))block{

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
        NSLog(@"%@",json);
        [_issueArr addObject:json[@"number"]];
        [_resultsArr addObject:[json[@"openCode"] componentsSeparatedByString:@","][location]];
    }


    for (NSInteger i =[numberLength[0] integerValue]; i <  numberLength.count+1; i++) {
        //出现总次数
        int zongcishu = 0;

        for (NSString *value in _resultsArr) {
            if (i==[value integerValue]) {
                zongcishu++;
            }
        }
        [_numberArr addObject:@{@(i):@(zongcishu)}];

        //平均遗漏值    （总期数-出现总次数）/ 遗漏段数
        int pingjunyilou = 0; BOOL shiling = NO;//遍历时遇到开奖结果相等置为YES

        for (int j=0; j < _resultsArr.count; j++) {

            if (i==[_resultsArr[j] integerValue]) {
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
        [_valuesArr addObject:@{@(i):@((nper-zongcishu)/(pingjunyilou==0?1:pingjunyilou))}];
        //最大遗漏值
        NSMutableArray *zdylArr =[NSMutableArray new]; NSInteger zuidayilou=0;
        //最大连出值
        NSMutableArray *zdlcArr =[NSMutableArray new]; NSInteger zuilianchu=0;
        for (int j=0; j < _resultsArr.count; j++) {

            if (i==[_resultsArr[j] integerValue]) {
                zuilianchu++;
                zuidayilou=0;

            }else{
                zuilianchu = 0;
                zuidayilou++;//

            }

            [zdylArr addObject:@(zuidayilou)];
            [zdlcArr addObject:@(zuilianchu)];
        }

        [_maxValuesArr addObject:@{@(i):[zdylArr valueForKeyPath:@"@max.floatValue"]}];
        [_evenValueArr addObject:@{@(i):[zdlcArr valueForKeyPath:@"@max.floatValue"]}];
    }


    if (block) {
        block(_issueArr,
              _resultsArr,
              _numberArr,
              _valuesArr,
              _maxValuesArr,
              _evenValueArr);
    }
    
    
    
}

@end
