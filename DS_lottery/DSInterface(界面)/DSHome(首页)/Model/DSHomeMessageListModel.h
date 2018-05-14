//
//  DSHomeMessageListModel.h
//  DS_lottery
//
//  Created by pro on 2018/4/17.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DSHomeMessageModel;

@interface DSHomeMessageListModel : NSObject

@property (strong, nonatomic) NSMutableArray * articleList;

@end

@interface DSHomeMessageModel : NSObject

@property (copy, nonatomic) NSString * ID;

@property (copy, nonatomic) NSString * title;

@property (copy, nonatomic) NSString * name;

@property (copy, nonatomic) NSString * crux;

@property (copy, nonatomic) NSString * remarks;

@property (copy, nonatomic) NSString * content;

@property (copy, nonatomic) NSString * sort;

@property (copy, nonatomic) NSString * createTime;

@property (copy, nonatomic) NSString * updateTime;

@property (copy, nonatomic) NSString * categoryId;

@property (copy, nonatomic) NSString * imageId;

@property (copy, nonatomic) NSString * exclusive;

@property (copy, nonatomic) NSString * hot;

@property (strong, nonatomic) NSMutableArray * imageIdList;

@end

