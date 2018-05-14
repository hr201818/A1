//
//  lhcBaseClass.m
//  Ticket
//
//  Created by pro on 2017/7/19.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "lhcBaseClass.h"
#import "Header.h"
@implementation lhcBaseClass
+(void)requstWithSuccess:(NSDictionary *)dict nper:(NSInteger)nper returnValue:(void (^)(NSMutableArray *issueArr,NSMutableArray *resultsArr,NSMutableArray *totalArr,NSMutableArray *temaArr))block{
    NSMutableArray *_issueArr =[NSMutableArray new];
    NSMutableArray *_resultsArr =[NSMutableArray new];
    NSMutableArray *_totalArr =[NSMutableArray new];
    NSMutableArray *_temaArr =[NSMutableArray new];


    NSArray *arr = dict[@"sscHistoryList"];
    if (nper>=arr.count) {
        nper = arr.count;
    }
    for (NSDictionary *json in [arr subarrayWithRange:NSMakeRange(0, nper)]) {
        [_issueArr addObject:json[@"number"]];

        [_resultsArr addObject:[json[@"openCode"] componentsSeparatedByString:@","]];
        
    }




    for (NSArray *aa in _resultsArr) {

        NSInteger i = 0;

        NSMutableArray *tArr = [NSMutableArray new];

//        NSMutableArray *redArray = [NSMutableArray new];
//        NSMutableArray *blueArray = [NSMutableArray new];
//        NSMutableArray *greenArray = [NSMutableArray new];

        for (NSString *nu in aa) {

            i=[nu integerValue]+i;

//            [[HttpHelper shareHelper].redArray  containsObject:@([nu integerValue])] == YES ? [redArray addObject:[NSString stringWithFormat:@"%@",nu]] :[[HttpHelper shareHelper].blueArray  containsObject:@([nu integerValue])] == YES ? [blueArray addObject:[NSString stringWithFormat:@"%@",nu]] : [greenArray addObject:[NSString stringWithFormat:@"%@",nu]];
        }

        [tArr addObject:[NSString stringWithFormat:@"%ld",i]];
        [tArr addObject:[tool parity:i] == NO ? @"总和单":@"总和双"];
        [tArr addObject:i >= 175 ? @"总和大":@"总和小"];

        float a=0,b=0,c=0;
        for (NSInteger j=0; j < aa.count; j++) {

            NSString *nu = aa[j];

            if (j==aa.count-1) {

                if ([[HttpHelper shareHelper].redArray  containsObject:@([nu integerValue])]==YES) {
                    a += 1.5;
                }else if ([[HttpHelper shareHelper].blueArray  containsObject:@([nu integerValue])] == YES){
                    b += 1.5;
                }else{
                    c += 1.5;
                }

            }else{
                if ([[HttpHelper shareHelper].redArray  containsObject:@([nu integerValue])]==YES) {
                    a ++;
                }else if ([[HttpHelper shareHelper].blueArray  containsObject:@([nu integerValue])] == YES){
                    b ++;
                }else{
                    c ++;
                }
            }
        }

        if ((a==b&&c==1.5)||(a==c&&b==1.5)||(c==b&&a==1.5)) {
            [tArr addObject:@"和"];
        }else if (a>b&&a>c){
            [tArr addObject:@"红波"];
        }else if (b>a&&b>c){
            [tArr addObject:@"蓝波"];
        }else if (c>a&&c>b){
            [tArr addObject:@"绿波"];
        }


//        if (redArray.count > blueArray.count&&redArray.count>greenArray.count) {
//            [tArr addObject:@"红波"];
//        }else if (blueArray.count > redArray.count&&blueArray.count>greenArray.count){
//            [tArr addObject:@"蓝波"];
//        }else if (greenArray.count > redArray.count&&greenArray.count>blueArray.count){
//            [tArr addObject:@"绿波"];
//        }else if (redArray.count == blueArray.count&&greenArray.count<blueArray.count){
//            [tArr addObject:@"红波"];
//        }else if (redArray.count == greenArray.count&&blueArray.count<greenArray.count){
//            [tArr addObject:@"红波"];
//        }else if (blueArray.count == greenArray.count&&redArray.count<greenArray.count){
//            [tArr addObject:@"蓝波"];
//        }
         [_totalArr addObject:tArr];
    }


    for (NSArray *aa in _resultsArr) {
        NSMutableArray *teArr = [NSMutableArray new];
        NSInteger tema = [[aa lastObject] integerValue];
        NSInteger unitPlace = tema / 1 % 10;//个位
        NSInteger tenPlace = tema / 10 % 10;//十位
        [teArr addObject:tema == 49 ? @"和":[tool parity:tema]==YES ? @"双":@"单"];
        [teArr addObject:tema == 49 ? @"和": tema >= 25 ? @"大":@"小"];
        [teArr addObject:tema == 49 ? @"和":[tool parity:unitPlace+tenPlace]==YES ? @"合双":@"合单"];
        [teArr addObject:tema == 49 ? @"和":unitPlace+tenPlace >= 7 ? @"合大":@"合小"];
        [teArr addObject:tema == 49 ? @"和":unitPlace >= 5 ? @"尾大":@"尾小"];
         [_temaArr addObject:teArr];
    }


    if (block) {
        block(_issueArr,
              _resultsArr,
              _totalArr,
              _temaArr);
    }


}
@end
