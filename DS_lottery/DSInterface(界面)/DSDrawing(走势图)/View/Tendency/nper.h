//
//  nper.h
//  Ticket
//
//  Created by pro on 2017/7/7.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^nperBtnBlock)(NSInteger btnTag);
@interface nper : UIView
-(id)initWithFrame:(CGRect)frame digital:(NSInteger)digital;
@property (nonatomic, copy) nperBtnBlock nperBtnBlock;
-(void)nperBtnBlock:(nperBtnBlock )nperBtnBlock;


//
- (void)reloadButtonColor:(NSInteger)digital;

@end
