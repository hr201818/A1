//
//  lhcBaseClass.h
//  Ticket
//
//  Created by pro on 2017/7/19.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lhcBaseClass : NSObject
+(void)requstWithSuccess:(NSDictionary *)dict nper:(NSInteger)nper returnValue:(void (^)(NSMutableArray *issueArr,NSMutableArray *resultsArr,NSMutableArray *totalArr,NSMutableArray *temaArr))block;
@end
