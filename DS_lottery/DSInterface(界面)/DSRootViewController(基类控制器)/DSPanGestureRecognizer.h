//
//  DSPanGestureRecognizer.h
//  DS_lottery
//
//  Created by pro on 2018/4/7.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSPanGestureRecognizer : UIPanGestureRecognizer
@property (readonly, nonatomic) UIEvent *event;

- (CGPoint)beganLocationInView:(UIView *)view;
@end
