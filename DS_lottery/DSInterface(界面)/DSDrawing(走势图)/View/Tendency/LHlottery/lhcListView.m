//
//  lhcListView.m
//  Ticket
//
//  Created by pro on 2017/9/6.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "lhcListView.h"
#import "Header.h"
#import "CALayer+LHC.h"
@interface lhcListView (){
    NSMutableArray *_issueArr;//期号
    NSMutableArray *_resultsArr;//开奖结果
    NSMutableArray *_listArr;//总和标题内容
}
@end

@implementation lhcListView

-(id)initWithFrame:(CGRect)frame issue:(NSMutableArray *)issueArr results:(NSMutableArray *)resultsArr listArr:(NSMutableArray*)listArr
{
    self = [super initWithFrame:frame];
    if (self) {

        _issueArr = [[NSMutableArray alloc]initWithArray:issueArr];
        _resultsArr = [[NSMutableArray alloc]initWithArray:resultsArr];
        _listArr =  [[NSMutableArray alloc]initWithArray:listArr];

//        for (int i = 0; i<_resultsArr.count; i++) {
//
//            NSArray *openArr = _resultsArr[i];
//            for (int j=0; j<openArr.count; j++) {
//                NSString *number = openArr[j];
//                for (NSInteger x = 0; x <_listArr.count ; x++) {
//
//                    if (x==j) {
//                        CALayer *_animationLayer = [CALayer layer];
//                        _animationLayer.frame = CGRectMake(x*lhWidth,i*cellHeight, lhWidth, cellHeight);
//                        [self.layer addSublayer:_animationLayer];
//
//                        NSString *zodiac = [HttpHelper shareHelper].zodiacDic[[tool getTheCorrectNum:number]];
//                        UIColor *colo =[[HttpHelper shareHelper].redArray  containsObject:@([number integerValue])] == YES ? [UIColor cp_minorRedColor] :[[HttpHelper shareHelper].blueArray  containsObject:@([number integerValue])] == YES ? [UIColor cp_blueColor] : [UIColor cp_greenTimeColor];
//                        [_animationLayer setupTextLayerWithNumberText:number NumberFontSize:[UIFont fontSizeWithSize:14] NumberFontColor:colo zodiacText:zodiac zodiacFontSize:[UIFont fontSizeWithSize:14] zodiacFontColor:[UIColor detailColor]];
//
//                        _animationLayer.backgroundColor = [UIColor whiteColor].CGColor;
//                        if (i%2==0) {
//                            _animationLayer.backgroundColor = backgColor.CGColor;
//                        }
//                    }
//                }
//            }
//        }

        CGRect rect = self.frame;
        rect.size.height = _issueArr.count*cellHeight;
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
            UIRectFill(CGRectMake(0, i*(cellHeight), rect.size.width, cellHeight));
        }
    }

    UIFont *font = [UIFont zkd_systemFontOfSize:13];
    for (int i = 0; i<_resultsArr.count; i++) {

        NSArray *openArr = _resultsArr[i];

        for (int j=0; j<openArr.count; j++) {
            CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
            CGContextSetLineWidth(context, .4);
            NSString *number = openArr[j];

            for (NSInteger x = 0; x <_listArr.count ; x++) {

                if (x==j) {


                    CGContextAddArc(context, lhWidth*x+lhWidth/2, cellHeight*i+cellHeight/2/1.5, cellHeight/2/2.5, 0, M_PI*2, 1);
                    CGContextSetFillColorWithColor(context, ([[HttpHelper shareHelper].redArray  containsObject:@([number integerValue])] == YES ? [UIColor cp_minorRedColor] :[[HttpHelper shareHelper].blueArray  containsObject:@([number integerValue])] == YES ? [UIColor cp_blueColor] : [UIColor cp_greenTimeColor]).CGColor);
                    CGContextDrawPath(context, kCGPathFill);

    //画内容
                    NSString *numberStr = [NSString stringWithFormat:@"%@",number];
                    CGSize size = [tool CommentSizeContent:numberStr Font:font size:CGSizeMake(lhWidth , cellHeight)];

                    [numberStr drawInRect:
                     CGRectMake(x*lhWidth,(cellHeight/2-size.height)/2.0+i*cellHeight+5, lhWidth, cellHeight)
                           withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor whiteColor]}];



                    NSString *zodiac = [HttpHelper shareHelper].zodiacDic[[tool getTheCorrectNum:numberStr]];
                    CGSize Zsize = [tool CommentSizeContent:zodiac Font:font size:CGSizeMake(lhWidth , cellHeight)];
                    //画内容

                    [zodiac drawInRect:
                     CGRectMake(x*lhWidth,(cellHeight/2-Zsize.height)/2.0+i*cellHeight+cellHeight/2-3, lhWidth, cellHeight)
                           withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:font,NSForegroundColorAttributeName: labelTextClor}];

                    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
                    CGContextSetLineWidth(context, .4);
                    CGContextMoveToPoint(context,j*lhWidth+0, 0);
                    CGContextAddLineToPoint(context, j*lhWidth+0, _issueArr.count*cellHeight);
                    CGContextDrawPath(context, kCGPathStroke);

                }
                
            }
            
            
        }
    }
    
    
}


@end
