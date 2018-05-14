//
//  LuckyTwentyEightBaseClass.h
//  Ticket
//
//  Created by pro on 2017/7/18.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LuckyTwentyEightBaseClass : NSObject
+(void)requstWithSuccess:(NSDictionary *)dict nper:(NSInteger)nper returnValue:(void (^)(NSMutableArray *issueArr,NSMutableArray *resultsArr,NSMutableArray *numberArr,NSMutableArray *valuesArr,NSMutableArray *maxValuesArr,NSMutableArray *evenValueArr, NSMutableArray *valueResultsArr, NSMutableArray *valueNumberArr, NSMutableArray *valueValuesArr, NSMutableArray *valueMaxValuesArr, NSMutableArray *valueEvenValueArr))block;
@end
