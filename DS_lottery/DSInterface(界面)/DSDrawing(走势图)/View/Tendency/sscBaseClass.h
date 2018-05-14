//
//  sscBaseClass.h
//  时时彩走势图
//
//  Created by pro on 2017/7/7.
//  Copyright © 2017年 pro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sscBaseClass : NSObject
/*
 NSMutableArray *_issueArr;//期号
 NSMutableArray *_resultsArr;//开奖结果
 NSMutableArray *_numberArr;//总次数
 NSMutableArray *_valuesArr;//平均遗漏值
 NSMutableArray *_maxValuesArr;//最大遗漏值
 NSMutableArray *_evenValueArr;//连出值
*/

+(void)requstWithSuccess:(NSDictionary *)dict numberLength:(NSMutableArray *)numberLength location:(NSInteger)location nper:(NSInteger)nper returnValue:(void (^)(NSMutableArray *issueArr,NSMutableArray *resultsArr,NSMutableArray *numberArr,NSMutableArray *valuesArr,NSMutableArray *maxValuesArr,NSMutableArray *evenValueArr))block;
@end
