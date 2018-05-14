//
//  shshicai.h
//  chartsTest
//
//  Created by 轩 on 2017/5/18.
//  Copyright © 2017年 pro. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^btnBlock)(NSInteger btnTag);
typedef void (^nperTowBtnBlock)(NSInteger nperBtnTag);
@interface shshicai : UIView
-(id)initWithFrame:(CGRect)frame digital:(NSInteger)digital nperTag:(NSInteger)npertag title:(NSArray *)titleArray;
@property (nonatomic, copy) btnBlock btnBlock;
-(void)btnBlock:(btnBlock )btnBlock;

@property (nonatomic, copy) nperTowBtnBlock nperTowBtnBlock;
-(void)nperTowBtnBlock:(nperTowBtnBlock )nperTowBtnBlock;
@end
