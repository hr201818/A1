//
//  SSQHQTableViewCell.m
//  Ticket
//
//  Created by pro on 2017/11/6.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "SSQHQTableViewCell.h"
#import "Header.h"
@interface SSQHQTableViewCell ()
{
    NSMutableArray *numberArr;

    NSMutableArray *caArr;

}
@end
@implementation SSQHQTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier contentArr:(NSMutableArray *)contentArray{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        numberArr = [[NSMutableArray alloc]initWithCapacity:0];
        caArr = [[NSMutableArray alloc]initWithCapacity:0];

        NSLog(@">>>>>>%@",contentArray);

        for (int i = 0; i < contentArray.count; i++) {
            UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(i*(cellHeight/2), 0, (cellHeight/2), cellHeight/2)];

            numberLabel.text = [NSString stringWithFormat:@"%@",contentArray[i]];
            numberLabel.textColor = [Helper getTrendTextColor:i arrCount:contentArray.count];
            numberLabel.font = [UIFont zkd_systemFontOfSize:14];
            numberLabel.textAlignment = NSTextAlignmentCenter;

            CGFloat w = [tool CommentSizeContent:@"99" Font:[UIFont zkd_systemFontOfSize:14] size:CGSizeMake(MAXFLOAT, MAXFLOAT)].height+5;

            // 创建椭圆形贝塞尔曲线路径
            UIBezierPath *oval = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, w, w)];
            // 创建CAShapeLayer
            CAShapeLayer *shapeLayer    = [CAShapeLayer layer];
            // 设置尺寸,
            shapeLayer.bounds            = CGRectMake(0, 0, w, w);
            // 设置位置(设置的是shapeLayer的中心点位置)
            shapeLayer.position =  numberLabel.center;
            shapeLayer.fillColor  = [UIColor clearColor].CGColor;
            // 关联ShapeLayer和贝塞尔曲线
            shapeLayer.path = oval.CGPath;
            // 显示
            [self.contentView.layer addSublayer:shapeLayer];
            [caArr addObject:shapeLayer];

            [self.contentView addSubview:numberLabel];
            [numberArr addObject:numberLabel];

            UIBezierPath *linePath = [UIBezierPath bezierPath];
            //  起点
            [linePath moveToPoint:(CGPoint){CGRectGetWidth(numberLabel.frame)*i,0}];
            // 其他点
            [linePath addLineToPoint:(CGPoint){CGRectGetWidth(numberLabel.frame)*i,cellHeight}];
            //  设置路径画布
            CAShapeLayer *lineLayer = [CAShapeLayer layer];
            lineLayer.lineWidth = 1;
            lineLayer.strokeColor = lineColor.CGColor; //   边线颜色
            lineLayer.path = linePath.CGPath;
            lineLayer.fillColor  = nil;   //  默认是black
            //  添加到图层上
            [self.contentView.layer addSublayer:lineLayer];

        }

    }
    return self;
}
-(void)setOpenCodeArray:(NSArray *)openCodeArray{
    _openCodeArray = openCodeArray;

    for (UILabel *numberLabel in numberArr) {
        CAShapeLayer *shapeLayer = caArr[[numberArr indexOfObject:numberLabel]];
        numberLabel.textColor =labelTextClor;
        shapeLayer.fillColor  = self.backgroundColor.CGColor;
        for (NSString * code in _openCodeArray) {
            if ([numberLabel.text integerValue]==[code integerValue]) {
                numberLabel.textColor =[UIColor whiteColor];
                shapeLayer.fillColor  = [UIColor cp_minorRedColor].CGColor;
            }
        }
    }

}
-(void)setTotUpArray:(NSString *)TotUpArray{
    _TotUpArray = TotUpArray;

    for (UILabel *numberLabel in numberArr) {
        CAShapeLayer *shapeLayer = caArr[[numberArr indexOfObject:numberLabel]];
        numberLabel.textColor = labelTextClor;
        shapeLayer.fillColor  = self.backgroundColor.CGColor;
        if ([numberLabel.text integerValue]==[_TotUpArray integerValue]) {
            numberLabel.textColor =[UIColor whiteColor];
            shapeLayer.fillColor  = [UIColor cp_blueColor].CGColor;
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
