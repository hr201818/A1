//
//  DSTabbarItem.h
//  DS_lottery
//
//  Created by pro on 2018/4/8.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface DSTabbarItem : UIView

/**
 * defaultimage 默认图片
 * selecteImage 选中图片
 * title        标题
 */
- (instancetype)initWithFrame:(CGRect)frame DefaultImage:(UIImage *)defaultimage SelecteImage:(UIImage *)selecteImage Title:(NSString *)title;

/* 是否选中,默认NO */
@property (assign, nonatomic) BOOL isSelect;

@property (strong, nonatomic) UIImageView * imageView;

@end
