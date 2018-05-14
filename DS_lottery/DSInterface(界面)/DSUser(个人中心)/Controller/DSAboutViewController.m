//
//  DSAboutViewController.m
//  DS_lottery
//
//  Created by pro on 2018/4/25.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSAboutViewController.h"

@interface DSAboutViewController ()

@end

@implementation DSAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"关于我们";
    [self navLeftItem:[DSFuntionTool leftNavBackTarget:self Item:@selector(leftBackAction)]];

    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Navgationbar_HEIGHT, self.view.width, PhoneScreen_HEIGHT - Navgationbar_HEIGHT - Tabbarbottom_HEIGHT)];
    [self.view addSubview:scrollView];

    UILabel * content = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, self.view.width - 25, 1000)];
    content.text = @"分分时时彩哈哈哈";
    content.textColor = COLORFont83;
    content.numberOfLines = 0;
    content.font = [UIFont systemFontOfSize:15];
    [scrollView addSubview:content];
    [content sizeToFit];
    scrollView.contentSize = CGSizeMake(0, content.height + 20);
}


#pragma mark - 点击事件
-(void)leftBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
