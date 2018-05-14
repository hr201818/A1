//
//  DSAppConfigModel.h
//  DS_lottery
//
//  Created by pro on 2018/4/25.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSAppConfigModel : NSObject
@property (copy, nonatomic) NSString * lawStatement;

@property (copy, nonatomic) NSString * lawIsShow;

@property (copy, nonatomic) NSString * appname;

/* 0不隐藏 1隐藏 */
@property (copy, nonatomic) NSString * ifHidden;

@property (copy, nonatomic) NSString * packetname;

@property (copy, nonatomic) NSString * reUrl;

@property (copy, nonatomic) NSString * remarks;

@property (copy, nonatomic) NSString * result;

@property (copy, nonatomic) NSString * type;

@property (copy, nonatomic) NSString * updateInfo;

@property (copy, nonatomic) NSString * updateTip;

@property (copy, nonatomic) NSString * url;

@property (copy, nonatomic) NSString * version;
@end
