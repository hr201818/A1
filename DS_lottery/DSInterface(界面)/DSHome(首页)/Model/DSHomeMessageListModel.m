//
//  DSHomeMessageListModel.m
//  DS_lottery
//
//  Created by pro on 2018/4/17.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSHomeMessageListModel.h"

@implementation DSHomeMessageListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"articleList"  : [DSHomeMessageModel class]};
}
@end

@implementation DSHomeMessageModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    [self changeModel];
    return YES;
}

-(void)changeModel{
    self.imageId = [NSString stringWithFormat:@"%@%@.png?",IMGURL,self.imageId];
}
@end
