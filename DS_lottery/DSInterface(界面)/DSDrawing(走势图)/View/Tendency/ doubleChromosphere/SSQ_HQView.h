//
//  SSQ_HQView.h
//  Ticket
//
//  Created by pro on 2017/11/6.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSQ_HQView : UIView
-(id)initWithFrame:(CGRect)frame playGroupId:(NSString *)playGroupId contentArr:(NSMutableArray *)contentArr rightContentArr:(NSMutableArray *)rightContentArr;
-(void)movementsParsing:(NSDictionary *)json;
-(void)reloadTableView;
@property(nonatomic,strong)UITableView *myTableView;
@property (nonatomic,assign)NSInteger nperTag;//点击30、50、80期
@end
