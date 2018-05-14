//
//  BaseNavgationController.h
//  DS_lottery
//
//  Created by pro on 2018/4/7.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface BaseNavgationController : UINavigationController<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (readonly, nonatomic) UIPanGestureRecognizer * panGestureRecognizer;

/**
 * 拖拽开关(默认开启)
 */
@property (assign, nonatomic) BOOL  backhandlepan;

/**
 * 全局侧拉(默认开启,关闭后是只有左边才可拉动)
 */
@property (assign, nonatomic) BOOL  overallSituation;

/**
 * 根导航控制器(默认关闭,截图的原因需要添加)
 */
@property (assign, nonatomic) BOOL  moduleRoot;

@end

@protocol ZFPanBackProtocol <NSObject>
- (BOOL)enablePanBack:(BaseNavgationController *)panNavigationController;
- (void)startPanBack:(BaseNavgationController *)panNavigationController;
- (void)finshPanBack:(BaseNavgationController *)panNavigationController;
- (void)resetPanBack:(BaseNavgationController *)panNavigationController;

@end
