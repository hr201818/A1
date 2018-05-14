//
//  LiuHeTableViewCell.m
//  Ticket
//
//  Created by pro on 2017/9/14.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "LiuHeTableViewCell.h"
#import "Header.h"

@interface LiuHeTableViewCell ()
{
    NSMutableArray *numberArr;
    NSMutableArray *zodiacArr;
    NSMutableArray *caArr;

}
@end
@implementation LiuHeTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        numberArr = [[NSMutableArray alloc]initWithCapacity:0];
        zodiacArr= [[NSMutableArray alloc]initWithCapacity:0];
        caArr = [[NSMutableArray alloc]initWithCapacity:0];

        for (int i = 0; i < 7; i++) {

            UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(i*lhWidth, 0, lhWidth, cellHeight/2)];
            numberLabel.center = CGPointMake(numberLabel.center.x, numberLabel.center.y+numberLabel.center.y/4);
            numberLabel.textColor = [UIColor whiteColor];
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

            UILabel *zodiacLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(numberLabel.frame), CGRectGetMaxY(numberLabel.frame), CGRectGetWidth(numberLabel.frame), CGRectGetHeight(numberLabel.frame))];
            zodiacLabel.center = CGPointMake(numberLabel.center.x, numberLabel.center.y+w);
            zodiacLabel.textColor = labelTextClor;
            zodiacLabel.font = numberLabel.font;
            zodiacLabel.textAlignment = numberLabel.textAlignment;
            [self.contentView addSubview:zodiacLabel];
            [zodiacArr addObject:zodiacLabel];


            UIBezierPath *linePath = [UIBezierPath bezierPath];
            //  起点
            [linePath moveToPoint:(CGPoint){CGRectGetWidth(numberLabel.frame)*(i+1),0}];
            // 其他点
            [linePath addLineToPoint:(CGPoint){CGRectGetWidth(numberLabel.frame)*(i+1),cellHeight}];
            //  设置路径画布
            CAShapeLayer *lineLayer = [CAShapeLayer layer];
            lineLayer.lineWidth = 1.0;
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

    for (int i = 0; i < _openCodeArray.count; i++) {
        NSString * code = _openCodeArray[i];
        UILabel *numberLabel = numberArr[i];
        UILabel *zodiacLabel = zodiacArr[i];
        numberLabel.text = code;
        zodiacLabel.text =[HttpHelper shareHelper].zodiacDic[[tool getTheCorrectNum:code]];

        CAShapeLayer *shapeLayer = caArr[i];
        // 设置填充颜色(注意, 这里不是设置背景颜色)
        shapeLayer.fillColor  = ([[HttpHelper shareHelper].redArray  containsObject:@([code integerValue])] == YES ? [UIColor cp_minorRedColor] :[[HttpHelper shareHelper].blueArray  containsObject:@([code integerValue])] == YES ? [UIColor cp_blueColor] : [UIColor cp_greenTimeColor]).CGColor;
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
