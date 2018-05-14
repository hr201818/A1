//
//  SaveCachesFile.m
//  DS_lottery
//
//  Created by pro on 2018/4/23.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "SaveCachesFile.h"
#define FolderName @"DS"
@implementation SaveCachesFile
+ (id)loadDataList:(NSString *)filename
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0]stringByAppendingPathComponent:FolderName];
    NSFileManager *manager = [[NSFileManager alloc]init];
    if (![manager fileExistsAtPath:path])
    {
        NSError *error ;
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error)
        {

        }
    }
    NSString * fileDirectory = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.arc",filename]];
    //解档
    return [NSKeyedUnarchiver unarchiveObjectWithFile:fileDirectory];
}

+ (BOOL)saveDataList:(id)object fileName:(NSString *)filename
{
    //归档对象
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0]stringByAppendingPathComponent:FolderName];
    NSFileManager *manager = [[NSFileManager alloc]init];
    if (![manager fileExistsAtPath:path])
    {
        NSError *error ;
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error)
        {

        }
    }
    NSString* fileDirectory = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.arc",filename]];
    BOOL success = [NSKeyedArchiver archiveRootObject:object toFile:fileDirectory];

    if (success)
    {
        return YES;
    }
    return NO;
}

+ (BOOL)removeFile:(NSString *)filename
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0]stringByAppendingPathComponent:FolderName];
    NSFileManager *manager = [[NSFileManager alloc]init];
    if (![manager fileExistsAtPath:path])
    {
        return YES;
    }

    NSString* fileDirectory = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.arc",filename]];

    BOOL success = [manager removeItemAtPath:fileDirectory error:nil];
    if (success)
    {
        NSLog(@"归档删除成功");
        return YES;
    }
    else
    {
        return NO;
    }
}
@end
