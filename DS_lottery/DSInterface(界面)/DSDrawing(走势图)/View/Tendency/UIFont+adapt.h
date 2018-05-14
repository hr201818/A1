//
//  UIFont+adapt.h
//  测试数据——要删除的
//
//  Created by jsb on 16/8/25.
//  Copyright © 2016年 jsb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (adapt)
+(__kindof UIFont*)zkd_systemFontOfSize:(CGFloat)font;
+(__kindof UIFont*)zkd_boldSystemFontOfSize:(CGFloat)font;

+ (CGFloat)fontSizeWithSize:(CGFloat)fontSize;

@end
