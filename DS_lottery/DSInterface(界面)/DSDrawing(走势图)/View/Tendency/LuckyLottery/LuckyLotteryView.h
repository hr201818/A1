//
//  LuckyLotteryView.h
//  Ticket
//
//  Created by pro on 2017/9/1.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LuckyLotteryView : UIView

-(id)initWithFrame:(CGRect)frame playGroupId:(NSString *)playGroupId contentArr:(NSMutableArray *)contentArr rightContentArr:(NSMutableArray *)rightContentArr;
-(void)movementsParsing:(NSDictionary *)json;
-(void)reloadTableView;
@property(nonatomic,strong)UITableView *myTableView;
@property (nonatomic,copy)NSString *playGroupId;//彩种ID
@property (nonatomic,assign)NSInteger nperTag;//点击30、50、80期
@property (nonatomic,strong)NSMutableArray *contentArr;//号码表
@property (nonatomic,strong)NSMutableArray *rightContentArr;//号码表
@end
