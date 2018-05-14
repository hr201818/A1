//
//  BaseNavgationController.m
//  DS_lottery
//
//  Created by pro on 2018/4/7.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//


#import "BaseNavgationController.h"
#import "DSPanGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface BaseNavgationController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) DSPanGestureRecognizer * pan;

@property (strong, nonatomic) UIView                 * backview;

@property (assign, nonatomic) BOOL                     animatedFlag;

@property (strong, nonatomic) UIImageView            * backimage;

@property (strong, nonatomic) NSMutableArray         * imageArray;

@property (strong, nonatomic) UIImage                * fristImg;

@end

@implementation BaseNavgationController

- (void)dealloc
{

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBar.hidden = YES;
    self.interactivePopGestureRecognizer.enabled = NO;
    //添加手势
    self.pan = [[DSPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    self.pan.delegate = self;
    self.pan.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:self.pan];
    self.backhandlepan = YES;

    self.imageArray = [[NSMutableArray alloc]init];
    self.backview = [[UIView alloc]initWithFrame:self.view.frame];
    self.backimage = [[UIImageView alloc]initWithFrame:self.view.frame];
    [self.backview addSubview:self.backimage];

    self.overallSituation = YES;
    self.moduleRoot = NO;

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.viewControllers.count == 1 && self.moduleRoot == YES){
        self.fristImg = nil;
        self.fristImg = [self snapshot:KeyWindows.rootViewController.view];
    }

    [self.imageArray removeAllObjects];
    UIViewController * pushview = [self.viewControllers lastObject];
    [self.imageArray addObject:[self snapshot:pushview.view]];
    // 动画标识，在动画的情况下，禁调用右滑手势
    [self startAnimated:animated];
    [super pushViewController:viewController animated:animated];
    // 修改tabBra的frame
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated;
{

    if (self.viewControllers.count > 2)
    {
        [self.imageArray removeAllObjects];
        UIViewController * pushview = [self.viewControllers objectAtIndex:self.viewControllers.count - 3];
        [self.imageArray addObject:[self snapshot:pushview.view]];
    }
    [self startAnimated:animated];
    return [super popViewControllerAnimated:animated];
}

#pragma mark 手势状态
- (void)pan:(UIPanGestureRecognizer *)pan
{
    UIGestureRecognizerState state = pan.state;
    switch (state)
    {
        case UIGestureRecognizerStatePossible:
        {

        }
        case UIGestureRecognizerStateBegan:
        {
            //将上一页的控制器截图添加到当前控制器的后面
            [self willShowPreViewController];
            //调用代理方法
            [self startPanBack];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {

            CGPoint translationPoint = [self.pan translationInView:self.view];
            //如果手势小于的x坐标0,那就等于0
            if (translationPoint.x < 0)translationPoint.x = 0;
            if (translationPoint.x > self.view.frame.size.width) translationPoint.x = self.view.frame.size.width;
            self.visibleViewController.view.frame = CGRectMake(translationPoint.x, 0, self.visibleViewController.view.frame.size.width, self.visibleViewController.view.frame.size.height);
            self.backview.frame = CGRectMake(-self.view.frame.size.width/3 + translationPoint.x/3, 0, self.view.frame.size.width, self.view.frame.size.height);
            break;
        }
        case UIGestureRecognizerStateFailed:
        {

        }
        case UIGestureRecognizerStateCancelled:
        {

        }
        case UIGestureRecognizerStateEnded:
        {
            //拖动速度
            CGPoint velocity = [self.pan velocityInView:self.view];
            //手指触摸的坐标
            CGPoint touchPoint = [self.pan translationInView:self.view];
            BOOL reset;
            if (touchPoint.x >=self.view.frame.size.width/3 || velocity.x > 1000)
                reset = NO;
            else
                reset = YES;
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            [UIView animateWithDuration:0.3 animations:^{
                if (reset == NO)
                {
                    self.visibleViewController.view.frame = CGRectMake(self.visibleViewController.view.frame.size.width, 0, self.visibleViewController.view.frame.size.width, self.visibleViewController.view.frame.size.height);
                    self.backview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                }
                else
                {
                    self.visibleViewController.view.frame = CGRectMake(0, 0, self.visibleViewController.view.frame.size.width, self.visibleViewController.view.frame.size.height);
                    self.backview.frame = CGRectMake(-self.view.frame.size.width/3, 0, self.view.frame.size.width, self.view.frame.size.height);
                }
            } completion:^(BOOL finished) {
                [self.backview removeFromSuperview];
                self.backimage.image = nil;
                //代理回调拖动是否成功
                [self finshPanBackWithReset:reset];
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                if (!reset)
                {
                    [self popViewControllerAnimated:NO];
                }
            }];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 取出上一层的截图
-(void)willShowPreViewController
{
    if (self.viewControllers.count > 1)
    {
        UIViewController *currentVC = self.viewControllers[self.viewControllers.count - 1];
        currentVC.view.layer.shadowPath =[UIBezierPath bezierPathWithRect:currentVC.view.bounds].CGPath;
        currentVC.view.layer.shadowColor = [UIColor blackColor].CGColor;
        currentVC.view.layer.shadowOffset = CGSizeMake(-0.9,0);
        currentVC.view.layer.shadowRadius = 3.0;
        currentVC.view.layer.shadowOpacity = 0.3;
        currentVC.view.layer.masksToBounds = NO;
        if(self.viewControllers.count == 2 && self.moduleRoot == YES){
             [self.backimage setImage:self.fristImg];
        }else{
             [self.backimage setImage:[self.imageArray lastObject]];
        }
        [currentVC.view.superview insertSubview:self.backview belowSubview:currentVC.view];
    }
}

#pragma mark GestureRecognizer Delegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    if(self.backhandlepan == NO)
        return NO;
    if (self.viewControllers.count < 2)
        return NO;
    if (self.animatedFlag)
        return NO;
    CGPoint touchPoint = [gestureRecognizer locationInView:self.controllerWrapperView];
    if (touchPoint.x < 0 || touchPoint.y < 10 || touchPoint.x > self.view.frame.size.width)
        return NO;
    CGPoint translation = [gestureRecognizer translationInView:self.view];
    if (translation.x <= 0)
        return NO;
    if(self.overallSituation == NO &&touchPoint.x >= 45){
        return NO;
    }
    // 是否是右滑
    BOOL succeed = fabs(translation.y / translation.x) < tan(M_PI/6);
    return succeed;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
     CGPoint touchPoint = [self.pan beganLocationInView:self.controllerWrapperView];
    if(self.backhandlepan == NO)
        return NO;
    if (gestureRecognizer != self.pan)
        return NO;
    if (self.pan.state != UIGestureRecognizerStateBegan)
        return NO;

    if(self.overallSituation == NO &&touchPoint.x >= 45){
        return NO;
    }

    if (otherGestureRecognizer.state != UIGestureRecognizerStateBegan)
    {
        return YES;
    }
    // 点击区域判断 如果在左边 40 以内, 强制手势后退
    if (touchPoint.x < 45) {

        [self cancelOtherGestureRecognizer:otherGestureRecognizer];
        return YES;
    }

    // 如果是scrollview 或者webview,手势禁止
    if ([[otherGestureRecognizer view] isKindOfClass:[UIScrollView class]] || [[otherGestureRecognizer view] isKindOfClass:[UIWebView class]] )
    {
        return NO;
    }

    return NO;
}

- (void)cancelOtherGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    NSSet *touchs = [self.pan.event touchesForGestureRecognizer:otherGestureRecognizer];
    [otherGestureRecognizer touchesCancelled:touchs withEvent:self.pan.event];
}


#pragma mark -
#pragma mark Custom

- (void)startAnimated:(BOOL)animated
{
    self.animatedFlag = YES;
    NSTimeInterval delay = animated ? 0.3 : 0.1;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(finishedAnimated) object:nil];
    [self performSelector:@selector(finishedAnimated) withObject:nil afterDelay:delay];
}

- (void)finishedAnimated
{
    self.animatedFlag = NO;
}

#pragma mark -
#pragma mark GET

- (UIPanGestureRecognizer *)panGestureRecognizer
{
    return self.pan;
}

- (UIView *)controllerWrapperView
{
    return self.visibleViewController.view.superview;
}
#pragma mark -
#pragma mark LCPanBackProtocol

- (BOOL)enablePanBack
{
    BOOL enable = YES;
    if ([self.visibleViewController respondsToSelector:@selector(enablePanBack:)]) {
        UIViewController<ZFPanBackProtocol> * viewController = (UIViewController<ZFPanBackProtocol> *)self.visibleViewController;
        enable = [viewController enablePanBack:self];
    }
    return enable;
}

- (void)startPanBack
{
    if ([self.visibleViewController respondsToSelector:@selector(startPanBack:)]) {
        UIViewController<ZFPanBackProtocol> * viewController = (UIViewController<ZFPanBackProtocol> *)self.visibleViewController;
        [viewController startPanBack:self];
    }
}

- (void)finshPanBackWithReset:(BOOL)reset
{
    if (reset) {
        [self resetPanBack];
    } else {
        [self finshPanBack];
    }
}

- (void)finshPanBack
{
    if ([self.visibleViewController respondsToSelector:@selector(finshPanBack:)]) {
        UIViewController<ZFPanBackProtocol> * viewController = (UIViewController<ZFPanBackProtocol> *)self.visibleViewController;
        [viewController finshPanBack:self];
    }
}

- (void)resetPanBack
{
    if ([self.visibleViewController respondsToSelector:@selector(resetPanBack:)]) {
        UIViewController<ZFPanBackProtocol> * viewController = (UIViewController<ZFPanBackProtocol> *)self.visibleViewController;
        [viewController resetPanBack:self];
    }
}

- (UIImage *)snapshot:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(PhoneScreen_WIDTH, PhoneScreen_HEIGHT), NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
