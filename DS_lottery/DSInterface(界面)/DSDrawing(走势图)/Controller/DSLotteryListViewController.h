//
//  DSLotteryListViewController.h
//  DS_lottery
//
//  Created by pro on 2018/4/24.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^LotteryIDBlock)(NSString* typeId, NSString * titleName);
@interface DSLotteryListViewController : BaseViewController
@property (copy, nonatomic) LotteryIDBlock  lotteryIDBlock;

@end
