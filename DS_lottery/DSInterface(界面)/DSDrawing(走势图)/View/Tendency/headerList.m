//
//  shishicai.m
//  chartsTest
//
//  Created by 轩 on 2017/5/18.
//  Copyright © 2017年 pro. All rights reserved.
//

#import "headerList.h"
#import "Header.h"
@interface headerList ()
{
    NSMutableArray *_list;//号码表
    NSArray *_issueArr;//期号
}
@end
@implementation headerList

-(id)initWithFrame:(CGRect)frame list:(NSMutableArray *)listArr{
    self = [super initWithFrame:frame];
    if (self) {
        _issueArr = @[@"期号"];
        _list = [[NSMutableArray alloc]initWithArray:listArr];
        
    }
    return self;
}
- (void)drawRect:(CGRect)rect{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setAlignment:NSTextAlignmentCenter];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] setFill];
    UIRectFill(rect);
    CGFloat widh =  _list.count>10 ? syxwWidth:sscWidth;
    //widh 为格子的高度 7是离上边界的距离 不设置 就会出现显示边界的线不好控制
    for (int i=0; i<=_issueArr.count; i++) {
        if (i<_issueArr.count) {
            NSString *period = _issueArr[i];
            //调用计算字符串的宽高的方法

            CGSize size = [tool CommentSizeContent:period Font:[UIFont systemFontOfSize:11] size:CGSizeMake((widh*3) , widh)];

            [period drawInRect:CGRectMake(0,(widh-size.height)/2.0+widh*i, (widh*3), widh) withAttributes:@{NSParagraphStyleAttributeName:style, NSFontAttributeName:[UIFont systemFontOfSize:11],NSForegroundColorAttributeName:labelTextClor}];

        }
        // 设置画笔颜色
//        CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
//        CGContextSetLineWidth(context, 1);
//        // 画笔的起始坐标
//        CGContextMoveToPoint(context, 0, i*widh);
//        CGContextAddLineToPoint(context, [[UIScreen mainScreen] bounds].size.width, i*widh);
//        CGContextDrawPath(context, kCGPathStroke);

    }

    for (int j=0; j < _list.count; j++) {

        for (int i=0; i<_issueArr.count; i++) {


            NSString *period = [NSString stringWithFormat:@"%@",_list[j]];

            CGSize size = [tool CommentSizeContent:period Font:[UIFont systemFontOfSize:12] size:CGSizeMake(widh, widh)];
            [period drawInRect:CGRectMake((widh*3)+j*widh,(widh-size.height)/2.0+i*widh, widh, widh) withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:labelTextClor}];


            CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
            CGContextSetLineWidth(context, .4);
            CGContextMoveToPoint(context,j*widh+(widh*3), 0);
            CGContextAddLineToPoint(context, j*widh+(widh*3), _issueArr.count*widh);
            CGContextDrawPath(context, kCGPathStroke);

        }
    }
}


@end
