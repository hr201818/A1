//
//  LiuHeTotalTableViewCell.m
//  Ticket
//
//  Created by pro on 2017/9/14.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "LiuHeTotalTableViewCell.h"
#import "Header.h"
@interface LiuHeTotalTableViewCell ()
{
    NSMutableArray *contenArr;
}
@end
@implementation LiuHeTotalTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        contenArr = [[NSMutableArray alloc]initWithCapacity:0];

        for (int i = 0; i < 4; i++) {

            UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(i*lhWidthTow, 0, lhWidthTow, cellHeight)];
            numberLabel.textColor = labelTextClor;
            numberLabel.font = [UIFont zkd_systemFontOfSize:14];
            numberLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:numberLabel];
            [contenArr addObject:numberLabel];


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

        UILabel *numberLabel = contenArr[i];
        numberLabel.text = code;

        if (i==3) {
        numberLabel.textColor = [code isEqualToString:@"红波"] ? [UIColor cp_minorRedColor]: [code isEqualToString:@"蓝波"] ? [UIColor cp_blueColor]:[UIColor cp_greenTimeColor];
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
