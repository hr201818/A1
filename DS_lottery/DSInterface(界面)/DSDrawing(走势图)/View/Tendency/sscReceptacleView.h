//
//  sscReceptacleView.h
//  Ticket
//
//  Created by pro on 2017/9/1.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sscReceptacleView : UIView

-(id)initWithFrame:(CGRect)frame;

-(void)movementsParsing:(NSDictionary *)json;
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,copy)NSString *playGroupId;//彩种ID
@property (nonatomic,strong)NSMutableArray *contentArr;//号码表
@property (nonatomic,strong)NSArray *titleArray;//位置内容
@property (nonatomic,copy) NSString *digital;//开奖号码位置
@property (nonatomic,assign)NSInteger nperTag;//点击30、50、80期
@end
