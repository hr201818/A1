//
//  DSNetWorkManager.m
//  DS_lottery
//
//  Created by pro on 2018/4/7.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSNetWorkManager.h"

@implementation DSNetWorkManager
static  DSNetWorkManager * network;

+(DSNetWorkManager *)initAFNetWork
{
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        network = [[DSNetWorkManager alloc] init];

    });
    return network;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manager = [AFHTTPSessionManager manager];
        AFJSONResponseSerializer *responseSerializer = [[AFJSONResponseSerializer alloc] init];
        responseSerializer.removesKeysWithNullValues = YES;
    }
    return self;
}
@end
