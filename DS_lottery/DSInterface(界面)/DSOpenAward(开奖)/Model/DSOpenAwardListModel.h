//
//  DSOpenAwardListModel.h
//  DS_lottery
//
//  Created by pro on 2018/4/20.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DSOpenAwardModel;
@interface DSOpenAwardListModel : NSObject

@property (strong, nonatomic) NSMutableArray * resultList;

@end

@interface DSOpenAwardModel : NSObject

@property (copy, nonatomic) NSString * number;

@property (copy, nonatomic) NSString * openCode;

@property (copy, nonatomic) NSString * openTime;

@property (copy, nonatomic) NSString * playGroupId;

@property (copy, nonatomic) NSString * playGroupName;

@property (assign, nonatomic) NSInteger  leftTimer;

@end
