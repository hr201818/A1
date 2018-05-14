//
//  DSHomeTopFuntionView.m
//  DS_lottery
//
//  Created by pro on 2018/4/26.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSHomeTopFuntionView.h"
#import "DSExplainViewController.h"
#import "DSKefuViewController.h"
#import "DSMapViewController.h"
@implementation DSHomeTopFuntionView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self layoutView];
    }
    return self;
}

-(void)layoutView{
    NSArray * titleName = @[@"历史开奖",@"全部走势",@"立即兑奖",@"在线客服"];
    CGFloat left = (self.width - IOS_SiZESCALE(80)*4)/5;
    for (int i = 0; i<4; i++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(left, 12, IOS_SiZESCALE(80), IOS_SiZESCALE(80))];
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ico-kj%d",i+1]]];
        [self addSubview:imageView];
        UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(left, IOS_SiZESCALE(100), IOS_SiZESCALE(80), 20)];
        title.text = titleName[i];
        title.font = [UIFont systemFontOfSize:14];
        title.textColor = COLORFont83;
        title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:title];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(left, 0, IOS_SiZESCALE(80), self.height);
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i+1;
        [self addSubview:btn];
        left += (self.width - IOS_SiZESCALE(80)*4)/5 + IOS_SiZESCALE(80);
    }
}

-(void)btnAction:(UIButton *)sender{
    if (sender.tag  == 1) {
        BaseTabBarController * tabbar = (BaseTabBarController *)KeyWindows.rootViewController;
        [tabbar secletIndex:1];
    }else if(sender.tag  == 2){
        BaseTabBarController * tabbar = (BaseTabBarController *)KeyWindows.rootViewController;
        [tabbar secletIndex:3];
    }else if(sender.tag  == 3){
        DSMapViewController * mapViewVC = [[DSMapViewController alloc]init];
        mapViewVC.typeName = @"附近投注站";
        mapViewVC.hudText = @"请选择附近的彩票网点进行兑换";
        mapViewVC.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:mapViewVC animated:YES];
    }else{
        DSKefuViewController * kefuVC = [[DSKefuViewController alloc]init];
        kefuVC.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:kefuVC animated:YES];
    }

}
@end
