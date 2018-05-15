//
//  BaseViewController.m
//  DS_lottery
//
//  Created by pro on 2018/4/7.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
/**
 * 标题名称
 */
@property (strong, nonatomic) UILabel * titleName;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, PhoneScreen_WIDTH, Navgationbar_HEIGHT)];
    self.navBar.backgroundColor = COLOR_HOME;
    self.navBarImg = [[UIImageView alloc]initWithFrame:self.navBar.frame];
    [self.navBarImg setImage:[UIImage imageNamed:@"navbar"]];
    [self.navBar addSubview:self.navBarImg];

    self.titleName = [[UILabel alloc]init];
    self.titleName.textColor = [UIColor whiteColor];
    self.titleName.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    self.titleName.textAlignment = NSTextAlignmentCenter;
    [self createNav];

    if ([self respondsToSelector:@selector( setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}


- (void)createNav{
    // 在主线程异步加载，使下面的方法最后执行，防止其他的控件挡住了导航栏
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view addSubview:self.navBar];
//        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, self.navBar.height - 0.5, PhoneScreen_WIDTH, 0.5)];
//        line.backgroundColor = COLOR_Alpha(53, 53, 53, 0.5);
//        [self.navBar addSubview:line];
        self.titleName.frame = CGRectMake(self.navBar.width/3 - 30, Statusbar_HEIGHT, self.navBar.width/3 + 60, self.navBar.height - Statusbar_HEIGHT);
        [self.navBar addSubview:self.titleName];

    });
}

-(void)setTitle:(NSString *)title{
    self.titleName.text = title;
}


/*左边的视图 */
-(void)navLeftItem:(UIButton*)leftItem{
    [self.navBar addSubview:leftItem];
    leftItem.width = leftItem.width > PhoneScreen_WIDTH/3 - 20? PhoneScreen_WIDTH/3 - 20:leftItem.width;
    leftItem.height = leftItem.height > 30 ? 30 : leftItem.height;

    leftItem.frame = CGRectMake(leftItem.left, (Navgationbar_HEIGHT - Statusbar_HEIGHT -leftItem.height)/2+Statusbar_HEIGHT , leftItem.width, leftItem.height);
}

/*右边的视图 */
-(void)navRightItem:(UIButton*)rightItem{
    [self.navBar addSubview:rightItem];
    rightItem.width = rightItem.width > PhoneScreen_WIDTH/3 - 20? PhoneScreen_WIDTH/3 - 20:rightItem.width;
    rightItem.height = rightItem.height > 30 ? 30 : rightItem.height;
    rightItem.frame = CGRectMake(self.view.width - rightItem.width - 15, (Navgationbar_HEIGHT - Statusbar_HEIGHT -rightItem.height)/2+ Statusbar_HEIGHT , rightItem.width, rightItem.height);
}


@end
