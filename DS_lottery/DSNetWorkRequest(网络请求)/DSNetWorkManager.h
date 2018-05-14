//
//  DSNetWorkManager.h
//  DS_lottery
//
//  Created by pro on 2018/4/7.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSNetWorkManager : NSObject

+(DSNetWorkManager *)initAFNetWork;

@property (strong, nonatomic)  AFHTTPSessionManager * manager;
@end
