//
//  SaveCachesFile.h
//  DS_lottery
//
//  Created by pro on 2018/4/23.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveCachesFile : NSObject
/**
 *  解归档
 *
 *  fileName 文件名
 *
 *  @return 解完归档后的数据
 */
+ (id)loadDataList:(NSString *)filename;

/**
 *  归档
 *
 *  object   归档的数据
 *  fileName 文件名
 */
+ (BOOL)saveDataList:(id)object fileName:(NSString *)filename;


/**
 *  删除归档
 *
 *  文件名
 */
+ (BOOL)removeFile:(NSString *)filename;
@end
