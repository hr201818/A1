//
//  DSDrawingViewController.h
//  DS_lottery
//
//  Created by pro on 2018/4/8.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "BaseViewController.h"
#import <UIKit/UIKit.h>
@interface DSDrawingViewController : BaseViewController
-(void)requstDetail;
@property (nonatomic,copy)NSString *GroupId;//彩种ID

@property (nonatomic,assign) BOOL  isShowRightBtn;
@end
