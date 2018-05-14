//
//  DSAdvertTableViewCell.h
//  DS_lottery
//
//  Created by pro on 2018/4/17.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSHomeBannerListModel.h"
#import "DSAdvertView.h"
@interface DSAdvertTableViewCell : UITableViewCell
/* 广告视图 */
@property (strong, nonatomic) DSAdvertView      * AdvertView;
/* 广告数据 */
@property (strong, nonatomic) DSHomeBannerModel * model;

@end
