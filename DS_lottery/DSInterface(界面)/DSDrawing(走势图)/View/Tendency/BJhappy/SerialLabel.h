//
//  SerialLabel.h
//  时时彩走势图
//
//  Created by pro on 2017/7/15.
//  Copyright © 2017年 pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SerialLabel : UIView
- (id)initWithFrame:(CGRect)frame;
@property(nonatomic,copy)NSString *selectText;
@property(nonatomic,strong)UILabel *label;

@end
