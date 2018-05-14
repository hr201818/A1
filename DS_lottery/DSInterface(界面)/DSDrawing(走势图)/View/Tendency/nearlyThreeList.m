//
//  nearlyThreeList.m
//  Ticket
//
//  Created by pro on 2017/7/25.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "nearlyThreeList.h"
#import "Header.h"
@interface nearlyThreeList (){
    NSMutableArray *_issueArr;//期号
    NSMutableArray *_resultsArr;//开奖结果
    NSMutableArray *_numberArr;//总次数
    NSMutableArray *_valuesArr;//平均遗漏值
    NSMutableArray *_maxValuesArr;//最大遗漏值
    NSMutableArray *_evenValueArr;//连出值
    NSMutableArray *_frameArr;//保存圆中心的位置、连线
    NSMutableArray *_listArr;//号码表

}

@end


@implementation nearlyThreeList

-(id)initWithFrame:(CGRect)frame issue:(NSMutableArray *)issueArr results:(NSMutableArray *)resultsArr number:(NSMutableArray *)numberArr values:(NSMutableArray *)valuesArr maxValuesArr:(NSMutableArray *)maxValuesArr evenValue:(NSMutableArray *)evenValueArr listArr:(NSMutableArray*)listArr{
    self = [super initWithFrame:frame];
    if (self) {

        _issueArr = [[NSMutableArray alloc]initWithArray:issueArr];
        _resultsArr = [[NSMutableArray alloc]initWithArray:resultsArr];
        _numberArr = [[NSMutableArray alloc]initWithArray:numberArr];
        _valuesArr = [[NSMutableArray alloc]initWithArray:valuesArr];
        _maxValuesArr = [[NSMutableArray alloc]initWithArray:maxValuesArr];
        _evenValueArr = [[NSMutableArray alloc]initWithArray:evenValueArr];
        _frameArr = [[NSMutableArray alloc]initWithCapacity:0];
        _listArr =  [[NSMutableArray alloc]initWithArray:listArr];
        CGRect rect = self.frame;
        rect.size.height = _issueArr.count*sscWidth ;
        self.frame = rect;
    }
    return self;
}
- (void)drawRect:(CGRect)rect{
    [_frameArr removeAllObjects];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setAlignment:NSTextAlignmentCenter];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [COLOR(255, 245, 245) setFill];
    UIRectFill(rect);

    for (int i=0; i<_issueArr.count; i++) {
        if (i%2==0) {
            [[UIColor whiteColor] setFill];
            UIRectFill(CGRectMake(0, i*sscWidth, rect.size.width, sscWidth));
        }
    }
    //listWidth 为格子的高度 7是离上边界的距离 不设置 就会出现显示边界的线不好控制
    for (int i=0; i<=_issueArr.count; i++) {
        if (i<_issueArr.count) {

            NSString *period =[NSString stringWithFormat:@"%@",_issueArr[i]];

            if ([period length]>11) {
                period = [period substringFromIndex:2];
            }

            //            NSString *period = [NSString stringWithFormat:@"%@",_issueArr[i]];
            //调用计算字符串的宽高的方法
            CGSize size = [tool CommentSizeContent:period Font:[UIFont systemFontOfSize:11] size:CGSizeMake(listWidth*2 , sscWidth)];

            [period drawInRect:CGRectMake(0,(sscWidth-size.height)/2.0+sscWidth*i, listWidth*2, sscWidth) withAttributes:@{NSParagraphStyleAttributeName:style, NSFontAttributeName:[UIFont systemFontOfSize:11],NSForegroundColorAttributeName:[Helper getTrendTextColor:i arrCount:_issueArr.count]}];

        }
//        // 设置画笔颜色
//        CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
//        CGContextSetLineWidth(context, .4);
//        // 画笔的起始坐标
//        CGContextMoveToPoint(context, 0, i*sscWidth);
//        CGContextAddLineToPoint(context, [[UIScreen mainScreen] bounds].size.width, i*sscWidth);
//        CGContextDrawPath(context, kCGPathStroke);

    }

    for (int j=0; j < _listArr.count; j++) {

        for (int i=0; i<_issueArr.count; i++) {

            if (i<_issueArr.count-4) {
                NSString *period = [NSString stringWithFormat:@"%@",_listArr[j]];

                CGSize size = [tool CommentSizeContent:period Font:[UIFont systemFontOfSize:12] size:CGSizeMake(listWidth , sscWidth)];
                [period drawInRect:CGRectMake(listWidth*2+j*listWidth,(sscWidth-size.height)/2.0+i*sscWidth, listWidth, sscWidth) withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[Helper getTrendTextColor:i arrCount:_issueArr.count]}];
            }else if (i<_issueArr.count-3&&_numberArr.count>0){

                NSString *period =@"0";
                NSDictionary *dict  = _numberArr[j];
                for (NSString *keys in [dict allKeys]) {
                    if ([keys integerValue]==[_listArr[j] integerValue]) {
                        period = [NSString stringWithFormat:@"%@",dict[keys]];
                    }
                }
                CGSize size = [tool CommentSizeContent:period Font:[UIFont systemFontOfSize:12] size:CGSizeMake(listWidth , sscWidth)];
                [period drawInRect:CGRectMake(listWidth*2+j*listWidth,(sscWidth-size.height)/2.0+i*sscWidth, listWidth, sscWidth) withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[Helper getTrendTextColor:i arrCount:_issueArr.count]}];
            }else if (i<_issueArr.count-2&&_valuesArr.count>0){

                NSString *period =@"0";
                NSDictionary *dict  = _valuesArr[j];
                for (NSString *keys in [dict allKeys]) {
                    if ([keys integerValue]==[_listArr[j] integerValue]) {
                        period = [NSString stringWithFormat:@"%@",dict[keys]];
                    }
                }

                CGSize size = [tool CommentSizeContent:period Font:[UIFont systemFontOfSize:12] size:CGSizeMake(listWidth , sscWidth)];
                [period drawInRect:CGRectMake(listWidth*2+j*listWidth,(sscWidth-size.height)/2.0+i*sscWidth, listWidth, sscWidth) withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[Helper getTrendTextColor:i arrCount:_issueArr.count]}];
            }else if (i<_issueArr.count-1&&_maxValuesArr.count>0){

                NSString *period =@"0";
                NSDictionary *dict  = _maxValuesArr[j];
                for (NSString *keys in [dict allKeys]) {
                    if ([keys integerValue]==[_listArr[j] integerValue]) {
                        period = [NSString stringWithFormat:@"%@",dict[keys]];
                    }
                }
                CGSize size = [tool CommentSizeContent:period Font:[UIFont systemFontOfSize:12] size:CGSizeMake(listWidth , sscWidth)];
                [period drawInRect:CGRectMake(listWidth*2+j*listWidth,(sscWidth-size.height)/2.0+i*sscWidth, listWidth, sscWidth) withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[Helper getTrendTextColor:i arrCount:_issueArr.count]}];
            }else if (i<_issueArr.count&&_evenValueArr.count>0){

                NSString *period =@"0";
                NSDictionary *dict  = _evenValueArr[j];
                for (NSString *keys in [dict allKeys]) {
                    if ([keys integerValue]==[_listArr[j] integerValue]) {
                        period = [NSString stringWithFormat:@"%@",dict[keys]];
                    }
                }
                CGSize size = [tool CommentSizeContent:period Font:[UIFont systemFontOfSize:12] size:CGSizeMake(listWidth , sscWidth)];
                [period drawInRect:CGRectMake(listWidth*2+j*listWidth,(sscWidth-size.height)/2.0+i*sscWidth, listWidth, sscWidth) withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[Helper getTrendTextColor:i arrCount:_issueArr.count]}];
            }

            CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
            CGContextSetLineWidth(context, .4);
            CGContextMoveToPoint(context,i*listWidth+listWidth*2, 0);
            CGContextAddLineToPoint(context, i*listWidth+listWidth*2, _issueArr.count*sscWidth);
            CGContextDrawPath(context, kCGPathStroke);

        }

    }


    // 画填充圆
    for (int i = 0; i<_resultsArr.count; i++) {
        CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
        CGContextSetLineWidth(context, .4);
        NSString *number =  [_listArr[0] integerValue] == 1  ? [tool getTheCorrectNum:_resultsArr[i]]:_resultsArr[i];

        for (NSInteger x = [_listArr[0] integerValue]; x <_listArr.count+1 ; x++) {

            if ([number intValue] ==x) {
                //画圆圈
                //(context, listWidth*2+listWidth*(x-1)+listWidth/2, listWidth*i+listWidth/2, listWidth/3, 0, M_PI*2, 1)

                [_listArr[0] integerValue] == 1  ? CGContextAddArc(context, listWidth*2+listWidth*(x-1)+listWidth/2, sscWidth*i+sscWidth/2, sscWidth/3, 0, M_PI*2, 1):
                CGContextAddArc(context, listWidth*2+listWidth*x+listWidth/2, listWidth*i+listWidth/2, sscWidth/3, 0, M_PI*2, 1);
                //
                CGPoint point = [_listArr[0] integerValue] == 1  ? CGPointMake(listWidth*2+listWidth*(x-1)+listWidth/2, sscWidth*i+sscWidth/2):
                CGPointMake(listWidth*2+listWidth*x+listWidth/2, sscWidth*i+sscWidth/2);
                NSString *str = NSStringFromCGPoint(point);
                //保存圆中心的位置 给下面的连线
                [_frameArr addObject:str];
                CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
                CGContextDrawPath(context, kCGPathStroke);

                //                //填满整个圆
                //                //
                //                [_listArr[0] integerValue] == 1  ? CGContextAddArc (context, listWidth*2+listWidth*(x-1)+listWidth/2, listWidth*i+listWidth/2, listWidth/3, 0, M_PI*2, 1):
                //                CGContextAddArc(context, listWidth*2+listWidth*x+listWidth/2, listWidth*i+listWidth/2, listWidth/3, 0, M_PI*2, 1);
                //                CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
                //                CGContextDrawPath(context, kCGPathFill);
                //                NSString *numberStr = [NSString stringWithFormat:@"%@",number];
                //                CGSize size = [tool CommentSizeContent:numberStr Font:[UIFont zkd_systemFontOfSize:12] size:CGSizeMake(listWidth , listWidth)];
                //                //画内容
                //                //
                //
                //                [numberStr drawInRect: [_listArr[0] integerValue] == 1  ? CGRectMake(listWidth*2+(x-1)*listWidth,(listWidth-size.height)/2.0+i*listWidth, listWidth, listWidth) :CGRectMake(listWidth*2+x*listWidth,(listWidth-size.height)/2.0+i*listWidth, listWidth, listWidth) withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:[UIFont zkd_systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor whiteColor]}];
            }
        }
    }

    for (int i=0; i<_frameArr.count; i++) {
        NSString *str = [_frameArr objectAtIndex:i];
        CGPoint point = CGPointFromString(str);
        // 设置画笔颜色
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextSetLineWidth(context, 1);
        if (i==0) {

            // 画笔的起始坐标
            CGContextMoveToPoint(context, point.x, point.y);

        }else{
            NSString *str1 = [_frameArr objectAtIndex:i-1];
            CGPoint point1 = CGPointFromString(str1);
            CGContextMoveToPoint(context, point1.x, point1.y);
            CGContextAddLineToPoint(context, point.x,  point.y);
        }
        CGContextDrawPath(context, kCGPathStroke);
    }


    for (int i = 0; i<_resultsArr.count; i++) {
        CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
        CGContextSetLineWidth(context, .4);
        NSString *number =  [_listArr[0] integerValue] == 1  ? [tool getTheCorrectNum:_resultsArr[i]]:_resultsArr[i];

        for (NSInteger x = [_listArr[0] integerValue]; x <_listArr.count+1 ; x++) {

            if ([number intValue] ==x) {
                //填满整个圆
                //
                [_listArr[0] integerValue] == 1  ? CGContextAddArc (context, listWidth*2+listWidth*(x-1)+listWidth/2, sscWidth*i+sscWidth/2, sscWidth/3, 0, M_PI*2, 1):
                CGContextAddArc(context, listWidth*2+listWidth*x+listWidth/2, sscWidth*i+sscWidth/2, sscWidth/3, 0, M_PI*2, 1);
                CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
                CGContextDrawPath(context, kCGPathFill);
                NSString *numberStr = [NSString stringWithFormat:@"%@",number];
                CGSize size = [tool CommentSizeContent:numberStr Font:[UIFont systemFontOfSize:12] size:CGSizeMake(listWidth , sscWidth)];
                //画内容
                
                [numberStr drawInRect: [_listArr[0] integerValue] == 1  ? CGRectMake(listWidth*2+(x-1)*listWidth,(sscWidth-size.height)/2.0+i*sscWidth, listWidth, sscWidth) :CGRectMake(listWidth*2+x*listWidth,(sscWidth-size.height)/2.0+i*sscWidth, listWidth, sscWidth) withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor whiteColor]}];
            }
        }
    }
    
}


@end
