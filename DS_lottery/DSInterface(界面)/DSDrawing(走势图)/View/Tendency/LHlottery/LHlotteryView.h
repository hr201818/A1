//
//  LHlotteryView.h
//  Ticket
//
//  Created by pro on 2017/9/1.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHlotteryView : UIView
/*
 NSArray *_headerArr;
 NSArray *_totalHeaderArr;
 NSArray *_temaHeaderArr;
 */
-(id)initWithFrame:(CGRect)frame playGroupId:(NSString *)playGroupId headerArr:(NSArray *)headerArr totalHeaderArr:(NSArray *)totalHeaderArr temaHeaderArr:(NSArray *)temaHeaderArr;

-(void)movementsParsing:(NSDictionary *)json;

-(void)reloadTableView;
@property(nonatomic,strong)UITableView *myTableView;
@property (nonatomic,assign)NSInteger nperTag;//点击30、50、80期
@end
