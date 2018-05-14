//
//  DSChartModal.h
//  ALLTIMELOTTERY
//
//  Created by wangzhijie on 2018/4/16.
//  Copyright © 2018年  . All rights reserved.
//

#import "DSBaseModal.h"
#import "DSChartListModal.h"
@interface DSChartModal : DSBaseModal
@property(nonatomic,assign) NSNumber * result;
@property(nonatomic, strong)  NSArray <DSChartListModal > * sscHistoryList;
@end
