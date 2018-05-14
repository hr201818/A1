//
//  lotteryNper.m
//  Ticket
//
//  Created by pro on 2017/7/18.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "lotteryNper.h"
#import "Header.h"
@interface lotteryNper ()

@end



@implementation lotteryNper

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _btnArr = [[NSMutableArray alloc]initWithCapacity:0];
        int hangshu = 1,lieshu = 3,kuan = 40,gao = 30,hangjianju = 5,liejianju = 10;

        for (int i = 0; i < hangshu; i++)
        {
            for (int j = 0; j < lieshu; j++)
            {
                int x = j * (kuan + liejianju) + 5;

                int y = i * (gao + hangjianju) + hangjianju;

                UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
                [btn setTitle:@[@"30期",@"50期",@"80期"][j] forState:UIControlStateNormal];

                btn.frame = CGRectMake(x, y, kuan, gao);
                if (j==0) {
                    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    btn.backgroundColor =navColor;
                    btn.layer.borderWidth = 1;
                    btn.layer.cornerRadius = 5.0f;
                    btn.layer.borderColor = [navColor CGColor];
                }else{
                    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                    btn.backgroundColor =[UIColor whiteColor];
                    btn.layer.borderWidth = 1;
                    btn.layer.cornerRadius = 5.0f;
                    btn.layer.borderColor = [[UIColor grayColor] CGColor];
                }
                btn.tag = j;
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];
                [_btnArr addObject:btn];

            }
        }

    }
    return self;
}
-(void)btnClick:(UIButton *)btn{

    for (UIButton *button in _btnArr) {
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.backgroundColor =[UIColor whiteColor];
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 5.0f;
        button.layer.borderColor = [[UIColor grayColor] CGColor];
    }

    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor =navColor;
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 5.0f;
    btn.layer.borderColor = [navColor CGColor];


    if (_lotterNperBtnBlock) {
        _lotterNperBtnBlock(btn.tag);
    }
}
-(void)lotterNperBtnBlock:(lotterNperBtnBlock)lotterNperBtnBlock{
    _lotterNperBtnBlock = lotterNperBtnBlock;
}


@end
