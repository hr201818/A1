//
//  BaseTabBarController.m
//  DS_lottery
//
//  Created by pro on 2018/4/7.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "BaseTabBarController.h"
#import "DSTabBar.h"
#import "DSHomeViewController.h"
#import "DSOpenAwardViewController.h"
#import "DSShopViewController.h"
#import "DSDrawingViewController.h"
#import "DSUserViewController.h"
@interface BaseTabBarController ()
@property (strong, nonatomic) DSTabBar *Dtabbar;
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    /* 自定义tabbar */
    self.Dtabbar = [[DSTabBar alloc]init];
    __weak typeof (self)weakSelf = self;
    weakSelf.Dtabbar.selectBlock = ^(NSInteger index) {
        self.selectedIndex = index;
    };
    [self setValue:self.Dtabbar forKeyPath:@"tabBar"];

    /* 首页 */
    DSHomeViewController * HomeView = [[DSHomeViewController alloc]init];
    BaseNavgationController * navHome = [[BaseNavgationController alloc]initWithRootViewController:HomeView];
    navHome.moduleRoot = YES;
    /* 开奖*/
    DSOpenAwardViewController * OpenAward = [[DSOpenAwardViewController alloc]init];
    BaseNavgationController * navOpenAward = [[BaseNavgationController alloc]initWithRootViewController:OpenAward];
    navOpenAward.moduleRoot = YES;
    /* 彩票店 */
    DSShopViewController * Shop = [[DSShopViewController alloc]init];
    BaseNavgationController * navShop = [[BaseNavgationController alloc]initWithRootViewController:Shop];
    navShop.moduleRoot = YES;
    /* 走势图 */
    DSDrawingViewController * Drawing = [[DSDrawingViewController alloc]init];
    BaseNavgationController * navDrawing = [[BaseNavgationController alloc]initWithRootViewController:Drawing];
    navDrawing.moduleRoot = YES;
    /* 个人中心 */
    DSUserViewController * User = [[DSUserViewController alloc]init];
    BaseNavgationController * navUser = [[BaseNavgationController alloc]initWithRootViewController:User];
    navUser.moduleRoot = YES;

    [self setViewControllers: @[navHome,navOpenAward,navShop,navDrawing,navUser]];

    //获取本地信息
    [DSUserInfoData initUserInfoData];
}

-(void)secletIndex:(NSInteger )index{
    [self.Dtabbar selectIndex:index];
}
@end
