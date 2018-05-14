//
//  lhcNumberLabelView.m
//  Ticket
//
//  Created by pro on 2017/7/19.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "lhcNumberLabelView.h"
#import "Header.h"
@implementation lhcNumberLabelView

- (id)initWithFrame:(CGRect)frame labelText:(NSString *)number{

    self = [super initWithFrame:frame];
    if (self) {

        UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (frame.size.height/3), (frame.size.height/3))];
        numberLabel.center = CGPointMake(frame.size.width/2, (frame.size.height)/4 + 6);
        numberLabel.layer.cornerRadius = numberLabel.bounds.size.height/2;
        numberLabel.layer.masksToBounds = YES;
        numberLabel.layer.shouldRasterize = YES;
        numberLabel.textColor = [UIColor whiteColor];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.font = [UIFont zkd_systemFontOfSize:12];
        numberLabel.text = number;

        numberLabel.backgroundColor = [[HttpHelper shareHelper].redArray  containsObject:@([number integerValue])] == YES ? [UIColor cp_minorRedColor] :[[HttpHelper shareHelper].blueArray  containsObject:@([number integerValue])] == YES ? [UIColor cp_blueColor] : [UIColor cp_greenTimeColor];
        [self addSubview:numberLabel];


       UILabel * _label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(numberLabel.frame), CGRectGetMaxY(numberLabel.frame), numberLabel.bounds.size.width, frame.size.height/2)];
        _label.text = [HttpHelper shareHelper].zodiacDic[[tool getTheCorrectNum:numberLabel.text]];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont zkd_systemFontOfSize:12];
        _label.textColor = [UIColor grayColor];
        [self addSubview:_label];
        _label.sd_layout.centerXEqualToView(numberLabel).topSpaceToView(numberLabel, 3).widthRatioToView(numberLabel, 1).autoHeightRatio(0);

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
