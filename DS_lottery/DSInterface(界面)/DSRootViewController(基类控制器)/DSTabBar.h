//
//  DSTabBar.h
//  DS_lottery
//
//  Created by pro on 2018/4/7.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectBlock)(NSInteger);

@interface DSTabBar : UITabBar

@property (copy, nonatomic)SelectBlock selectBlock;

//给外部执行调用
-(void)selectIndex:(NSInteger)index;
@end
