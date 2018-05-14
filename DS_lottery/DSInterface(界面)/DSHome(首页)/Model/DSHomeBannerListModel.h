//
//  DSHomeBannerListModel.h
//  DS_lottery
//
//  Created by pro on 2018/4/17.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DSHomeBannerModel;

@interface DSHomeBannerListModel : NSObject

@property (strong, nonatomic) NSMutableArray * list;

@property (strong, nonatomic) NSMutableArray * bannerList;

@property (strong, nonatomic) NSMutableArray * advertList;

@end

@interface DSHomeBannerModel : NSObject

@property (copy, nonatomic) NSString * locationId;

@property (copy, nonatomic) NSString * advertisTitle;

@property (copy, nonatomic) NSString * advertisUrl;

@property (copy, nonatomic) NSString * advertisImgId;

@property (copy, nonatomic) NSString * davertisImgData;

@property (copy, nonatomic) NSString * advertisClickNum;

@property (copy, nonatomic) NSString * advertisFollowNum;

@property (copy, nonatomic) NSString * version;

@property (copy, nonatomic) NSString * openType;
@end
