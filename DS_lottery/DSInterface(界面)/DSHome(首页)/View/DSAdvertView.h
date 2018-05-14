//
//  DSAdvertView.h
//  DS_lottery
//
//  Created by pro on 2018/4/20.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSHomeBannerListModel.h"
@interface DSAdvertView : UIView
/* 模型 */
@property (strong, nonatomic) DSHomeBannerModel * model;
/* 关闭按钮 */
@property (strong, nonatomic) UIButton          * closeBtn;
@end
