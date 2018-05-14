//
//  lotteryNper.h
//  Ticket
//
//  Created by pro on 2017/7/18.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^lotterNperBtnBlock)(NSInteger btnTag);
@interface lotteryNper : UIView
-(id)initWithFrame:(CGRect)frame;
-(void)btnClick:(UIButton *)btn;
@property (nonatomic, copy) lotterNperBtnBlock lotterNperBtnBlock;
-(void)lotterNperBtnBlock:(lotterNperBtnBlock )lotterNperBtnBlock;

@property(nonatomic,strong)NSMutableArray *btnArr;//号码表
@end
