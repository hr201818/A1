//
//  lhcTemaView.h
//  Ticket
//
//  Created by pro on 2017/7/19.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lhcTemaView : UIView
-(id)init;
@property (nonatomic,strong)NSMutableArray *issueArr;//期号
@property (nonatomic,strong)NSMutableArray *temaArr;//特码
@property (nonatomic,strong)NSMutableArray *temaHeaderArr;//号码表
@property(nonatomic,strong)UITableView *temaTableView;
@end
