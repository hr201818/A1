//
//  luckView.h
//  Ticket
//
//  Created by pro on 2017/9/5.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface luckView : UIView
-(id)initWithFrame:(CGRect)frame issue:(NSMutableArray *)issueArr results:(NSMutableArray *)resultsArr number:(NSMutableArray *)numberArr values:(NSMutableArray *)valuesArr maxValuesArr:(NSMutableArray *)maxValuesArr evenValue:(NSMutableArray *)evenValueArr listArr:(NSMutableArray *)listArr latticeWidth:(CGFloat)latticeWidth latticeHight:(CGFloat)latticeHight;
@end
