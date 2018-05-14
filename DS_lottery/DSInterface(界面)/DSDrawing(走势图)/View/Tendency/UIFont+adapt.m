//
//  UIFont+adapt.m
//  测试数据——要删除的
//
//  Created by jsb on 16/8/25.
//  Copyright © 2016年 jsb. All rights reserved.
//

#import "UIFont+adapt.h"
#import "SDiPhoneVersion.h"
#import <objc/message.h>

@implementation UIFont (adapt)

+(UIFont*)zkd_boldSystemFontOfSize:(CGFloat)font{

    if ([SDiPhoneVersion deviceSize] == iPhone35inch){
        font=font-2;}
    else if ([SDiPhoneVersion deviceSize] == iPhone4inch){
        font=font-2;}
    else if([SDiPhoneVersion deviceSize] == iPhone47inch){
        font=font;}
    else if([SDiPhoneVersion deviceSize] == iPhone55inch){
        font= font+2;}
    UIFont *adaptFont = [UIFont boldSystemFontOfSize:font];
    return adaptFont;
}

+ (UIFont*)zkd_systemFontOfSize:(CGFloat)font{
    
    if ([SDiPhoneVersion deviceSize] == iPhone35inch){
        font=font-2;}
    else if ([SDiPhoneVersion deviceSize] == iPhone4inch){
        font=font-2;}
    else if([SDiPhoneVersion deviceSize] == iPhone47inch){
        font=font;}
    else if([SDiPhoneVersion deviceSize] == iPhone55inch){
        font= font+2;}

    UIFont *adaptFont = [UIFont systemFontOfSize:font];
    return adaptFont;
}


+ (CGFloat)fontSizeWithSize:(CGFloat)fontSize
{
    if ([SDiPhoneVersion deviceSize] == iPhone35inch){
        fontSize=fontSize-2;}
    else if ([SDiPhoneVersion deviceSize] == iPhone4inch){
        fontSize=fontSize-2;}
    else if([SDiPhoneVersion deviceSize] == iPhone47inch){
        fontSize=fontSize;}
    else if([SDiPhoneVersion deviceSize] == iPhone55inch){
        fontSize= fontSize+2;}
    return fontSize;
}


@end
