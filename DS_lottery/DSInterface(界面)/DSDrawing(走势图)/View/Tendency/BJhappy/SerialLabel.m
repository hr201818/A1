//
//  SerialLabel.m
//  时时彩走势图
//
//  Created by pro on 2017/7/15.
//  Copyright © 2017年 pro. All rights reserved.
//

#import "SerialLabel.h"
#import "Header.h"
@implementation SerialLabel

- (id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {

        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.height-10, frame.size.height-10)];
        _label.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        _label.numberOfLines = 0;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont zkd_systemFontOfSize:13];
        _label.textColor = labelTextClor;
        [self addSubview:_label];


        UIBezierPath *linePath = [UIBezierPath bezierPath];
        //  起点
        [linePath moveToPoint:(CGPoint){frame.size.width,0}];
        // 其他点
        [linePath addLineToPoint:(CGPoint){frame.size.width,frame.size.height}];
        //  设置路径画布
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.lineWidth = 0.5;
        lineLayer.strokeColor = lineColor.CGColor; //   边线颜色
        lineLayer.path = linePath.CGPath;
        lineLayer.fillColor  = nil;   //  默认是black
        //  添加到图层上
        [self.layer addSublayer:lineLayer];


    }

    return self;
}

-(void)setSelectText:(NSString *)selectText{
    _selectText = selectText;
    if ([_selectText isEqualToString:_label.text]) {
        _label.layer.cornerRadius = _label.bounds.size.height/2;
        _label.layer.masksToBounds = YES;
        _label.backgroundColor = [UIColor redColor];
        _label.textColor = [UIColor whiteColor];
        _label.layer.shouldRasterize = YES;

    }
}

//-(CAShapeLayer*)cornerRadiusWithRect:(CGRect)rect
//{
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:rect.size];
//
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
//    //设置大小
//    maskLayer.frame = rect;
//    //设置图形样子
//    maskLayer.path = maskPath.CGPath;
//
//    //maskLayer.strokeColor = [UIColor redColor].CGColor;
//
//    return maskLayer;
//}

@end
