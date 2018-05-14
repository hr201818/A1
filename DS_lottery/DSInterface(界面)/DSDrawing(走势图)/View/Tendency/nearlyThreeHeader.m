//
//  nearlyThreeHeader.m
//  Ticket
//
//  Created by pro on 2017/7/25.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "nearlyThreeHeader.h"
#import "Header.h"
@interface nearlyThreeHeader ()
{
    NSMutableArray *_list;//号码表
    NSArray *_issueArr;//期号
}
@end

@implementation nearlyThreeHeader

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

    [COLOR(255, 245, 245) setFill];
    UIRectFill(rect);
    //sscWidth 为格子的高度 7是离上边界的距离 不设置 就会出现显示边界的线不好控制
    for (int i=0; i<=_issueArr.count; i++) {
        if (i<_issueArr.count) {
            NSString *period = _issueArr[i];
            //调用计算字符串的宽高的方法

            CGSize size = [tool CommentSizeContent:period Font:[UIFont systemFontOfSize:12] size:CGSizeMake(listWidth*2 , sscWidth)];

            [period drawInRect:CGRectMake(0,(sscWidth-size.height)/2.0+sscWidth*i, listWidth*2, sscWidth) withAttributes:@{NSParagraphStyleAttributeName:style, NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:labelTextClor}];

        }
        // 设置画笔颜色
//        CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
//        CGContextSetLineWidth(context, 1);
//        // 画笔的起始坐标
//        CGContextMoveToPoint(context, 0, i*sscWidth);
//        CGContextAddLineToPoint(context, [[UIScreen mainScreen] bounds].size.width, i*sscWidth);
//        CGContextDrawPath(context, kCGPathStroke);

    }

    for (int j=0; j < _list.count; j++) {

        for (int i=0; i<_issueArr.count; i++) {


            NSString *period = [NSString stringWithFormat:@"%@",_list[j]];

            CGSize size = [tool CommentSizeContent:period Font:[UIFont systemFontOfSize:12] size:CGSizeMake(listWidth, sscWidth)];
            [period drawInRect:CGRectMake(listWidth*2+j*listWidth,(sscWidth-size.height)/2.0+i*sscWidth, listWidth, sscWidth) withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:labelTextClor}];


            CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
            CGContextSetLineWidth(context, .4);
            CGContextMoveToPoint(context,j*listWidth+listWidth*2, 0);
            CGContextAddLineToPoint(context, j*listWidth+listWidth*2, _issueArr.count*sscWidth);
            CGContextDrawPath(context, kCGPathStroke);
            
        }
    }
}


@end
