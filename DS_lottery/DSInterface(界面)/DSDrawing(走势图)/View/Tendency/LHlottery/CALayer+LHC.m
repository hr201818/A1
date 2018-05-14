//
//  CALayer+LHC.m
//  Ticket
//
//  Created by pro on 2017/9/13.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "CALayer+LHC.h"
#import <CoreText/CoreText.h>
#import "Header.h"
@implementation CALayer (LHC)
- (void)setupTextLayerWithNumberText:(NSString *)numberText NumberFontSize:(CGFloat)NumberFontSize NumberFontColor:(UIColor *)NumberFontColor zodiacText:(NSString *)zodiacText zodiacFontSize:(CGFloat)zodiacFontSize zodiacFontColor:(UIColor *)zodiacFontColor{

    CGMutablePathRef letters = CGPathCreateMutable();

    CTFontRef font = CTFontCreateWithName(CFSTR("HelveticaNeue-UltraLight"), NumberFontSize, NULL);
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           (__bridge id)font, kCTFontAttributeName,
                           nil];

    NSAttributedString *str = [[NSAttributedString alloc] initWithString:numberText
                                                              attributes:attrs];
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)str);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);

    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++) {

        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);

        for (CFIndex glyphIndex = 0; glyphIndex < CTRunGetGlyphCount(run); glyphIndex++) {

            CGGlyph glyph;
            CGPoint position;
            CFRange currentRange = CFRangeMake(glyphIndex, 1);
            CTRunGetGlyphs(run, currentRange, &glyph);
            CTRunGetPositions(run, currentRange, &position);

            CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
            CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
            CGPathAddPath(letters, &t, letter);
            CGPathRelease(letter);
        }
    }
    CFRelease(line);

    // 创建椭圆形贝塞尔曲线路径
    UIBezierPath *oval = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.bounds.size.width/2, self.bounds.size.width/2)];
    // 创建CAShapeLayer
    CAShapeLayer *shapeLayer    = [CAShapeLayer layer];
    // 设置尺寸,
    shapeLayer.bounds            = CGRectMake(0, 0, self.bounds.size.width/2, self.bounds.size.width/2);
    // 设置位置(设置的是shapeLayer的中心点位置)
    shapeLayer.position =  CGPointMake(self.bounds.size.width/2, self.bounds.size.height/3);
    //     shapeLayer.bounds = CGPathGetBoundingBox(oval.CGPath);
    // 设置背景颜色
    //        shapeLayer.backgroundColor  = [UIColor greenColor].CGColor;
    // 设置填充颜色(注意, 这里不是设置背景颜色)
    shapeLayer.fillColor        = NumberFontColor.CGColor;
    // 设置边框颜色(路径颜色)
    //    shapeLayer.strokeColor      = [UIColor blueColor].CGColor;

    // 关联ShapeLayer和贝塞尔曲线
    shapeLayer.path = oval.CGPath;
    // 显示
    [self addSublayer:shapeLayer];



    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:letters];

    CFRelease(letters);
    CFRelease(font);

    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = CGRectMake(0, 0, self.bounds.size.width/2, self.bounds.size.height/2);
    pathLayer.position = shapeLayer.position;
    pathLayer.bounds = CGPathGetBoundingBox(path.CGPath);
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [UIColor whiteColor].CGColor;
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 1.0f;
    pathLayer.lineJoin = kCALineJoinBevel;

    [self animationTextLayerWithText:zodiacText fontSize:zodiacFontSize fontColor:zodiacFontColor];

    [self addSublayer:pathLayer];

}
-(void)animationTextLayerWithText:(NSString *)text fontSize:(CGFloat)fontSize fontColor:(UIColor *)fontColor {

    CGMutablePathRef letters = CGPathCreateMutable();

    CTFontRef font = CTFontCreateWithName(CFSTR("HelveticaNeue-UltraLight"), fontSize, NULL);
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           (__bridge id)font, kCTFontAttributeName,
                           nil];

    NSAttributedString *str = [[NSAttributedString alloc] initWithString:text
                                                              attributes:attrs];
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)str);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);

    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++) {

        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);

        for (CFIndex glyphIndex = 0; glyphIndex < CTRunGetGlyphCount(run); glyphIndex++) {

            CGGlyph glyph;
            CGPoint position;
            CFRange currentRange = CFRangeMake(glyphIndex, 1);
            CTRunGetGlyphs(run, currentRange, &glyph);
            CTRunGetPositions(run, currentRange, &position);
            CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
            CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
            CGPathAddPath(letters, &t, letter);
            CGPathRelease(letter);
        }
    }
    CFRelease(line);
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:letters];

    CFRelease(letters);
    CFRelease(font);

    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = CGRectMake(0, 0, self.bounds.size.width/2, self.bounds.size.width/2);
    pathLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/3+self.bounds.size.width/2);
    pathLayer.bounds = CGPathGetBoundingBox(path.CGPath);
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = fontColor.CGColor;
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 1.0f;
    pathLayer.lineJoin = kCALineJoinBevel;
    
    [self addSublayer:pathLayer];


    //   创建一个路径对象
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    //  起点
    [linePath moveToPoint:(CGPoint){self.bounds.size.width,0}];
    // 其他点
    [linePath addLineToPoint:(CGPoint){self.bounds.size.width,self.bounds.size.height}];
    //  设置路径画布
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 1.0;
    lineLayer.strokeColor = lineColor.CGColor; //   边线颜色
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor  = nil;   //  默认是black
    //  添加到图层上
    [self addSublayer:lineLayer];
}
@end
