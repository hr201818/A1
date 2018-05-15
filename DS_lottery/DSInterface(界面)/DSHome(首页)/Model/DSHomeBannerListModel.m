//
//  DSHomeBannerListModel.m
//  DS_lottery
//
//  Created by pro on 2018/4/17.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSHomeBannerListModel.h"

@implementation DSHomeBannerListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list"  : [DSHomeBannerModel class]};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    [self changeModel];
    return YES;
}

-(void)changeModel{
    _bannerList = [[NSMutableArray alloc]init];
    _advertList = [[NSMutableArray alloc]init];
    for (DSHomeBannerModel * model in self.list) {
        if([model.locationId integerValue] == 2 ||[model.locationId integerValue] == 3||[model.locationId integerValue] == 4||[model.locationId integerValue] == 5){
             [_bannerList addObject:model];
        }else{
             [_advertList addObject:model];
        }
    }
}

@end

@implementation DSHomeBannerModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    [self changeModel];
    return YES;
}

-(void)changeModel{
    self.imageUrl = [NSString stringWithFormat:@"%@%@.png?",IMGURL,self.advertisImgId];
}

- (NSUInteger)hash
{
    NSString *toHash = [NSString stringWithFormat:@"%@", self.locationId];
    return [toHash hash];
}

- (BOOL)isEqual:(id)object
{
    return [self hash] == [object hash];
}

@end
