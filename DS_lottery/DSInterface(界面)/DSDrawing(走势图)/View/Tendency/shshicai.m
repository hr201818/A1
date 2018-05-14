//
//  shshicai.m
//  chartsTest
//
//  Created by 轩 on 2017/5/18.
//  Copyright © 2017年 pro. All rights reserved.
//

#import "shshicai.h"
#import "nper.h"
#import "Header.h"

@implementation shshicai

-(id)initWithFrame:(CGRect)frame digital:(NSInteger)digital nperTag:(NSInteger)npertag title:(NSArray *)titleArray{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 设置scrollView
        UIScrollView *scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
        scrollView.backgroundColor =[UIColor whiteColor];
        // 开始添加按钮
        for (int i=0; i<titleArray.count; i++)
        {
            UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame =CGRectMake(i*(50+10)+5, 5, 50, 30);
            //titleArray[i] 数组取元素
            [button setTitle:titleArray[i]forState:UIControlStateNormal];
            //设置默认状态下的颜色
            if (i==digital) {
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button setBackgroundColor:COLOR(240, 19, 34)];
                button.layer.borderWidth = 1;
                button.layer.cornerRadius = 5.0f;
                button.layer.borderColor = COLOR(240, 19, 34).CGColor;
            }else{
                [button setTitleColor:COLOR(83, 83, 83) forState:UIControlStateNormal];
                button.backgroundColor =[UIColor whiteColor];
                button.layer.borderWidth = 1;
                button.layer.cornerRadius = 5.0f;
                button.layer.borderColor = [lineColor CGColor];
            }

            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i;
            //设置字号
            button.titleLabel.font =[UIFont systemFontOfSize:14];
            [scrollView addSubview:button];
        }
        
        UIButton *button =(UIButton *)[scrollView viewWithTag:digital];
        if (CGRectGetMinX(button.frame) >= ScreenW||button.center.x>= ScreenW) {
            scrollView.contentOffset = CGPointMake(button.center.x, 0);
        }

        //设置scrollView的滑动区间
        scrollView.contentSize =CGSizeMake(titleArray.count*60+10, 40);
        scrollView.showsHorizontalScrollIndicator =NO;
        scrollView.showsVerticalScrollIndicator =NO;
        [self addSubview:scrollView];

        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(scrollView.frame), [[UIScreen mainScreen] bounds].size.width, 0.5)];
        line.backgroundColor = lineColor;
        [self addSubview:line];

//        nper *n = [[nper alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(scrollView.frame) , ScreenW, 35) digital:npertag];
//        [self addSubview:n];
//        [n nperBtnBlock:^(NSInteger btnTag) {
//            if (_nperTowBtnBlock) {
//                _nperTowBtnBlock(btnTag);
//            }
//        }];

        CGRect rect = self.frame;
        rect.size.height = CGRectGetMaxY(line.frame);
        self.frame = rect;
        
    }
    return self;
}

-(void)btnClick:(UIButton *)btn{
    if (_btnBlock) {
        _btnBlock(btn.tag);
    }
}
-(void)btnBlock:(btnBlock)btnBlock{
    _btnBlock = btnBlock;
}
-(void)nperTowBtnBlock:(nperTowBtnBlock)nperTowBtnBlock{
    _nperTowBtnBlock=nperTowBtnBlock;
}
@end
