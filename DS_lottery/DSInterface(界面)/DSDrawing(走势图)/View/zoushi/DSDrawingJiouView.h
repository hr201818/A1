//
//  DSDrawingJiouView.h
//  DS_lottery
//
//  Created by pro on 2018/5/10.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSChartModal.h"
@interface DSDrawingJiouView : UIView
- (instancetype)initWithFrame:(CGRect)frame model:(DSChartModal *)model lotteryID:(NSString *)lotteryID;
@end
