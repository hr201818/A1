//
//  lhcTotalView.h
//  Ticket
//
//  Created by pro on 2017/7/19.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lhcTotalView : UIView
-(id)init;
@property (nonatomic,strong)NSMutableArray *issueArr;//期号
@property (nonatomic,strong)NSMutableArray *totalArr;//总和
@property (nonatomic,strong)NSMutableArray *totalHeaderArr;
@property(nonatomic,strong)UITableView *myTableView;
@end
