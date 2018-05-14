//
//  nper.m
//  Ticket
//
//  Created by pro on 2017/7/7.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "nper.h"
#import "Header.h"

#define ButtonTag 888

@implementation nper

-(id)initWithFrame:(CGRect)frame digital:(NSInteger)digital{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = COLOR(235, 235, 235).CGColor;
        
        self.backgroundColor = [UIColor whiteColor];
        
        int hangshu = 1,lieshu = 3,kuan = 40,gao = 35,hangjianju = 5,liejianju = 0;
        
        kuan = frame.size.width/lieshu;

        for (int i = 0; i < hangshu; i++)
        {
            for (int j = 0; j < lieshu; j++)
            {
                int x = j * (kuan + liejianju);
                
                int y = i * (gao + hangjianju) + hangjianju;

                UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
                [btn setTitle:@[@"30期",@"50期",@"80期"][j] forState:UIControlStateNormal];

                btn.frame = CGRectMake(x, y, kuan, gao);
                if (j == digital) {
                    [btn setTitleColor:COLORFontblu forState:UIControlStateNormal];
//                    [btn setBackgroundColor:navColor];
//                    btn.layer.borderWidth = 1;
//                    btn.layer.cornerRadius = 5.0f;
//                    btn.layer.borderColor = [navColor CGColor];
                }else{
                    [btn setTitleColor:labelTextClor forState:UIControlStateNormal];
      
//                    btn.backgroundColor =[UIColor whiteColor];
//                    btn.layer.borderWidth = 1;
//                    btn.layer.cornerRadius = 5.0f;
//                    btn.layer.borderColor = [lineColor CGColor];
                }
                btn.tag = j + ButtonTag;
                btn.titleLabel.font =[UIFont systemFontOfSize:18];
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];

            }
        }

    }
    return self;
}
-(void)btnClick:(UIButton *)btn{
    
    if (_nperBtnBlock) {
        _nperBtnBlock(btn.tag-ButtonTag);
    }
}
- (void)reloadButtonColor:(NSInteger)digital
{
    for (int i = 0; i < 3; i ++) {
        UIButton *button = [self viewWithTag:ButtonTag+i];
        [button setTitleColor:labelTextClor forState:UIControlStateNormal];
        if (button.tag-ButtonTag==digital) {
            [button setTitleColor:COLORFontblu forState:UIControlStateNormal];
        }
    }
}
-(void)nperBtnBlock:(nperBtnBlock)nperBtnBlock{
    _nperBtnBlock = nperBtnBlock;
}
@end
