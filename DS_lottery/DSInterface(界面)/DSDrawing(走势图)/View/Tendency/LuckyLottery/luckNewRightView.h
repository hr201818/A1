//
//  luckNewRightView.h
//  Ticket
//
//  Created by pro on 2017/9/5.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface luckNewRightView : UIView
-(id)init;


@property (nonatomic,strong)NSMutableArray *contentArr;//号码表
@property(nonatomic,strong)UITableView *myTableView;

@property (nonatomic,assign)NSInteger nperTag;//点击30、50、80期

@property (nonatomic,strong)NSMutableArray *issueArr;//期号
@property (nonatomic,strong)NSMutableArray *resultsArr;//开奖结果
@property (nonatomic,strong)NSMutableArray *numberArr;//总次数
@property (nonatomic,strong)NSMutableArray *valuesArr;//平均遗漏值
@property (nonatomic,strong)NSMutableArray *maxValuesArr;//最大遗漏值
@property (nonatomic,strong)NSMutableArray *evenValueArr;//连出值
@property(nonatomic,copy)NSString *playGroupId;


@end
