//
//  luckView.m
//  Ticket
//
//  Created by pro on 2017/9/5.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "luckView.h"
#import "Header.h"
@interface luckView (){
    NSMutableArray *_issueArr;//期号
    NSMutableArray *_resultsArr;//开奖结果
    NSMutableArray *_numberArr;//总次数
    NSMutableArray *_valuesArr;//平均遗漏值
    NSMutableArray *_maxValuesArr;//最大遗漏值
    NSMutableArray *_evenValueArr;//连出值
    NSMutableArray *_listArr;//号码表
    CGFloat _latticeWidth;
    CGFloat _latticeHight;

}

@end

@implementation luckView

-(id)initWithFrame:(CGRect)frame issue:(NSMutableArray *)issueArr results:(NSMutableArray *)resultsArr number:(NSMutableArray *)numberArr values:(NSMutableArray *)valuesArr maxValuesArr:(NSMutableArray *)maxValuesArr evenValue:(NSMutableArray *)evenValueArr listArr:(NSMutableArray *)listArr latticeWidth:(CGFloat)latticeWidth latticeHight:(CGFloat)latticeHight
{
    self = [super initWithFrame:frame];
    if (self) {
        _latticeWidth = latticeHight;
        _latticeHight = latticeHight;
        _issueArr = [[NSMutableArray alloc]initWithArray:issueArr];
        _resultsArr = [[NSMutableArray alloc]initWithArray:resultsArr];
        _numberArr = [[NSMutableArray alloc]initWithArray:numberArr];
        _valuesArr = [[NSMutableArray alloc]initWithArray:valuesArr];
        _maxValuesArr = [[NSMutableArray alloc]initWithArray:maxValuesArr];
        _evenValueArr = [[NSMutableArray alloc]initWithArray:evenValueArr];
        _listArr =  [[NSMutableArray alloc]initWithArray:listArr];

        CGRect rect = self.frame;
        rect.size.height = _issueArr.count*_latticeHight ;
        self.frame = rect;


    }
    return self;
}
- (void)drawRect:(CGRect)rect{
//
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setAlignment:NSTextAlignmentCenter];
    CGContextRef context = UIGraphicsGetCurrentContext();

    UIFont *font = [UIFont zkd_systemFontOfSize:13];
//
    [[UIColor whiteColor] setFill];
    UIRectFill(rect);

    for (int i=0; i<_issueArr.count; i++) {
        if (i%2==0) {
            [backgColor setFill];
             UIRectFill(CGRectMake(0, i*(cellHeight/2), rect.size.width, cellHeight/2));
        }
    }
//
//
    for (int j=0; j < _listArr.count; j++) {

        for (int i=0; i<_issueArr.count; i++) {

            if (i<_issueArr.count-4) {
                NSString *period = [NSString stringWithFormat:@"%@",_listArr[j]];

                CGSize size = [tool CommentSizeContent:period Font:font size:CGSizeMake(_latticeWidth , _latticeHight)];
                [period drawInRect:CGRectMake(0+j*_latticeWidth,(_latticeHight-size.height)/2.0+i*_latticeHight, _latticeWidth, _latticeHight) withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:font,NSForegroundColorAttributeName:[Helper getTrendTextColor:i arrCount:_issueArr.count]}];
            }else if (i<_issueArr.count-3&&_numberArr.count>0){

                NSString *period =[NSString stringWithFormat:@"%@",_numberArr[j]];

                CGSize size = [tool CommentSizeContent:period Font:font size:CGSizeMake(_latticeWidth , _latticeHight)];
                [period drawInRect:CGRectMake(0+j*_latticeWidth,(_latticeHight-size.height)/2.0+i*_latticeHight, _latticeWidth, _latticeHight) withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:font,NSForegroundColorAttributeName:[Helper getTrendTextColor:i arrCount:_issueArr.count]}];
            }else if (i<_issueArr.count-2&&_valuesArr.count>0){

                NSString *period =[NSString stringWithFormat:@"%@",_valuesArr[j]];
                CGSize size = [tool CommentSizeContent:period Font:font size:CGSizeMake(_latticeWidth , _latticeHight)];
                [period drawInRect:CGRectMake(0+j*_latticeWidth,(_latticeHight-size.height)/2.0+i*_latticeHight, _latticeWidth, _latticeHight) withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:font,NSForegroundColorAttributeName:[Helper getTrendTextColor:i arrCount:_issueArr.count]}];
            }else if (i<_issueArr.count-1&&_maxValuesArr.count>0){

                NSString *period =[NSString stringWithFormat:@"%@",_maxValuesArr[j]];

                CGSize size = [tool CommentSizeContent:period Font:font size:CGSizeMake(_latticeWidth , _latticeHight)];
                [period drawInRect:CGRectMake(0+j*_latticeWidth,(_latticeHight-size.height)/2.0+i*_latticeHight, _latticeWidth, _latticeHight) withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:font,NSForegroundColorAttributeName:[Helper getTrendTextColor:i arrCount:_issueArr.count]}];
            }else if (i<_issueArr.count&&_evenValueArr.count>0){

                NSString *period =[NSString stringWithFormat:@"%@",_evenValueArr[j]];

                CGSize size = [tool CommentSizeContent:period Font:font size:CGSizeMake(_latticeWidth , _latticeHight)];
                [period drawInRect:CGRectMake(0+j*_latticeWidth,(_latticeHight-size.height)/2.0+i*_latticeHight, _latticeWidth, _latticeHight) withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:font,NSForegroundColorAttributeName:[Helper getTrendTextColor:i arrCount:_issueArr.count]}];
            }

            CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
            CGContextSetLineWidth(context, .4);
            CGContextMoveToPoint(context,(j+1)*_latticeHight+0, 0);
            CGContextAddLineToPoint(context, (j+1)*_latticeHight+0, _issueArr.count*_latticeHight);
            CGContextDrawPath(context, kCGPathStroke);

        }
    }

    for (int i = 0; i<_resultsArr.count; i++) {

        NSArray *openArr = _resultsArr[i];

//        NSArray *openArr = [opencode componentsSeparatedByString:@","];

        for (int j=0; j<openArr.count; j++) {
            CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
            CGContextSetLineWidth(context, .4);
            NSString *number = openArr[j];

            for (NSInteger x = 0; x <_listArr.count ; x++) {

                if ([number intValue] ==[_listArr[x] intValue]) {
                    //填满整个圆

                    CGContextAddArc(context, 0+_latticeHight*x+_latticeHight/2, _latticeHight*i+_latticeHight/2, _latticeHight/3, 0, M_PI*2, 1);
                    CGContextSetFillColorWithColor(context, [UIColor cp_minorRedColor].CGColor);
                    CGContextDrawPath(context, kCGPathFill);
                    NSString *numberStr = [NSString stringWithFormat:@"%@",number];
                    CGSize size = [tool CommentSizeContent:numberStr Font:font size:CGSizeMake(_latticeHight , _latticeHight)];
                    //画内容

                    [numberStr drawInRect:CGRectMake(0+x*_latticeHight,(_latticeHight-size.height)/2.0+i*_latticeHight, _latticeHight, _latticeHight)
                           withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor whiteColor]}];
                }
            }
            
        }
        
        
    }
//
}
@end
