//
//  rightView.m
//  Ticket
//
//  Created by pro on 2017/9/5.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "rightView.h"
#import "Header.h"

@interface rightView (){
    NSMutableArray *_issueArr;//期号
    NSMutableArray *_resultsArr;//开奖结果
    NSMutableArray *_numberArr;//总次数
    NSMutableArray *_valuesArr;//平均遗漏值
    NSMutableArray *_maxValuesArr;//最大遗漏值
    NSMutableArray *_evenValueArr;//连出值
    NSMutableArray *_listArr;//号码表

}

@end
@implementation rightView

-(id)initWithFrame:(CGRect)frame issue:(NSMutableArray *)issueArr results:(NSMutableArray *)resultsArr number:(NSMutableArray *)numberArr values:(NSMutableArray *)valuesArr maxValuesArr:(NSMutableArray *)maxValuesArr evenValue:(NSMutableArray *)evenValueArr listArr:(NSMutableArray *)listArr
{
    self = [super initWithFrame:frame];
    if (self) {

        _issueArr = [[NSMutableArray alloc]initWithArray:issueArr];
        _resultsArr = [[NSMutableArray alloc]initWithArray:resultsArr];
        _numberArr = [[NSMutableArray alloc]initWithArray:numberArr];
        _valuesArr = [[NSMutableArray alloc]initWithArray:valuesArr];
        _maxValuesArr = [[NSMutableArray alloc]initWithArray:maxValuesArr];
        _evenValueArr = [[NSMutableArray alloc]initWithArray:evenValueArr];
        _listArr =  [[NSMutableArray alloc]initWithArray:listArr];

        CGRect rect = self.frame;
        rect.size.height = _issueArr.count*cellHeight/2 ;
        self.frame = rect;
    }
    return self;
}
-(void)drawRect:(CGRect)rect{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setAlignment:NSTextAlignmentCenter];
    CGContextRef context = UIGraphicsGetCurrentContext();

    [[UIColor whiteColor] setFill];
    UIRectFill(rect);

    for (int i=0; i<_issueArr.count; i++) {
        if (i%2==0) {
            [backgColor setFill];
            UIRectFill(CGRectMake(0, i*(cellHeight/2), rect.size.width, cellHeight/2));
        }
    }

    UIFont *font = [UIFont zkd_systemFontOfSize:13];

    for (int j=0; j < _listArr.count; j++) {

        for (int i=0; i<_issueArr.count; i++) {

            if (i<_issueArr.count-4) {
                NSString *period = [NSString stringWithFormat:@"%@",_listArr[j]];

                CGSize size = [tool CommentSizeContent:period Font:font size:CGSizeMake(cellHeight/2 , cellHeight/2)];
                [period drawInRect:CGRectMake(0+j*cellHeight/2,(cellHeight/2-size.height)/2.0+i*cellHeight/2, cellHeight/2, cellHeight/2) withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:font,NSForegroundColorAttributeName:labelTextClor}];
            }else if (i<_issueArr.count-3&&_numberArr.count>0){

                NSString *period =[NSString stringWithFormat:@"%@",_numberArr[j]];

                CGSize size = [tool CommentSizeContent:period Font:font size:CGSizeMake(cellHeight/2 , cellHeight/2)];
                [period drawInRect:CGRectMake(0+j*cellHeight/2,(cellHeight/2-size.height)/2.0+i*cellHeight/2, cellHeight/2, cellHeight/2) withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:font,NSForegroundColorAttributeName:[Helper getTrendTextColor:i arrCount:_issueArr.count]}];
            }else if (i<_issueArr.count-2&&_valuesArr.count>0){

                NSString *period =[NSString stringWithFormat:@"%@",_valuesArr[j]];
                CGSize size = [tool CommentSizeContent:period Font:font size:CGSizeMake(cellHeight/2 , cellHeight/2)];
                [period drawInRect:CGRectMake(0+j*cellHeight/2,(cellHeight/2-size.height)/2.0+i*cellHeight/2, cellHeight/2, cellHeight/2) withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:font,NSForegroundColorAttributeName:[Helper getTrendTextColor:i arrCount:_issueArr.count]}];
            }else if (i<_issueArr.count-1&&_maxValuesArr.count>0){

                NSString *period =[NSString stringWithFormat:@"%@",_maxValuesArr[j]];

                CGSize size = [tool CommentSizeContent:period Font:font size:CGSizeMake(cellHeight/2 , cellHeight/2)];
                [period drawInRect:CGRectMake(0+j*cellHeight/2,(cellHeight/2-size.height)/2.0+i*cellHeight/2, cellHeight/2, cellHeight/2) withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:font,NSForegroundColorAttributeName:[Helper getTrendTextColor:i arrCount:_issueArr.count]}];
            }else if (i<_issueArr.count&&_evenValueArr.count>0){

                NSString *period =[NSString stringWithFormat:@"%@",_evenValueArr[j]];

                CGSize size = [tool CommentSizeContent:period Font:font size:CGSizeMake(cellHeight/2 , cellHeight/2)];
                [period drawInRect:CGRectMake(0+j*cellHeight/2,(cellHeight/2-size.height)/2.0+i*cellHeight/2, cellHeight/2, cellHeight/2) withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:font,NSForegroundColorAttributeName:[Helper getTrendTextColor:i arrCount:_issueArr.count]}];
            }
            
            CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
            CGContextSetLineWidth(context, .4);
            CGContextMoveToPoint(context,j*cellHeight/2+0, 0);
            CGContextAddLineToPoint(context, j*cellHeight/2+0, _issueArr.count*cellHeight/2);
            CGContextDrawPath(context, kCGPathStroke);
            
        }
    }


    for (int i = 0; i<_resultsArr.count; i++) {

        NSString *number = _resultsArr[i];

        //        NSArray *openArr = [opencode componentsSeparatedByString:@","];

            CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
            CGContextSetLineWidth(context, .4);

            for (NSInteger x = [_listArr[0] integerValue]; x <_listArr.count+1 ; x++) {

                if ([number intValue] ==x) {
                    //填满整个圆
                    [_listArr[0] integerValue] == 1  ? CGContextAddArc(context, 0+cellHeight/2*(x-1)+cellHeight/2/2, cellHeight/2*i+cellHeight/2/2, cellHeight/2/3, 0, M_PI*2, 1) :
                    CGContextAddArc(context, 0+cellHeight/2*x+cellHeight/2/2, cellHeight/2*i+cellHeight/2/2, cellHeight/2/3, 0, M_PI*2, 1);
                    CGContextSetFillColorWithColor(context, [UIColor cp_minorRedColor].CGColor);
                    CGContextDrawPath(context, kCGPathFill);
                    NSString *numberStr = [NSString stringWithFormat:@"%@",number];
                    CGSize size = [tool CommentSizeContent:numberStr Font:font size:CGSizeMake(cellHeight/2 , cellHeight/2)];
                    //画内容

                    [numberStr drawInRect:[_listArr[0] integerValue] == 1  ?
                     CGRectMake(0+(x-1)*cellHeight/2,(cellHeight/2-size.height)/2.0+i*cellHeight/2, cellHeight/2, cellHeight/2) :
                     CGRectMake(0+x*cellHeight/2,(cellHeight/2-size.height)/2.0+i*cellHeight/2, cellHeight/2, cellHeight/2)
                           withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor whiteColor]}];
                }
            }
        }
}

@end
