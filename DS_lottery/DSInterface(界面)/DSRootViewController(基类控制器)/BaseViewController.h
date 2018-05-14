//
//  BaseViewController.h
//  DS_lottery
//
//  Created by pro on 2018/4/7.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 * 导航条
 */
@property (strong, nonatomic) UIView * navBar;


/**
 * 导航条背景图
 */
@property (strong, nonatomic) UIImageView * navBarImg;

/**
 *左边的视图
 */
-(void)navLeftItem:(UIView*)leftItem;

/**
 *右边的视图
 */
-(void)navRightItem:(UIView*)rightItem;
@end
