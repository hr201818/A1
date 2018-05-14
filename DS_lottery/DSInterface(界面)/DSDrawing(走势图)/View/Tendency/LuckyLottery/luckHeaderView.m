//
//  luckHeaderView.m
//  Ticket
//
//  Created by pro on 2017/7/18.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "luckHeaderView.h"
#import "Header.h"
#import "luckLabel.h"
@implementation luckHeaderView

-(id)initWithFrame:(CGRect)frame  title:(NSString *)title content:(NSMutableArray *)contentArray{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor(249, 249, 249, 1);

        UILabel *ti = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,contentArray.count * (cellHeight/2) , frame.size.height/2)];
        ti.text = title;
        ti.textAlignment = NSTextAlignmentCenter;
        ti.font = [UIFont zkd_systemFontOfSize:12];
        ti.textColor = labelTextClor;
        [self addSubview:ti];

        for (int i = 0; i < contentArray.count; i++) {

            NSString *numberStr = [NSString stringWithFormat:@"%@",contentArray[i]];

            luckLabel *num=[[luckLabel alloc]initWithFrame:CGRectMake(i * (cellHeight/2), CGRectGetMaxY(ti.frame), cellHeight/2, frame.size.height/2)];
            num.font = [UIFont zkd_systemFontOfSize:12];
            num.text = numberStr;
            
            [self addSubview:num];
        }

        UIBezierPath *linePath = [UIBezierPath bezierPath];
        //  起点
        [linePath moveToPoint:(CGPoint){frame.size.width,0}];
        // 其他点
        [linePath addLineToPoint:(CGPoint){frame.size.width,frame.size.height}];
        //  设置路径画布
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.lineWidth = 1;
        lineLayer.strokeColor = lineColor.CGColor; //   边线颜色
        lineLayer.path = linePath.CGPath;
        lineLayer.fillColor  = nil;   //  默认是black
        //  添加到图层上
        [self.layer addSublayer:lineLayer];
       
    }
    return self;
}

@end
