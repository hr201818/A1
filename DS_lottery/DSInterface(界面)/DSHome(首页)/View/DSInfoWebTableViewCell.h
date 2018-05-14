//
//  DSInfoWebTableViewCell.h
//  DS_lottery
//
//  Created by pro on 2018/4/24.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^WebBlock)(CGFloat webHeight);
@interface DSInfoWebTableViewCell : UITableViewCell
@property (copy, nonatomic) NSString                * webContent;
@property (copy, nonatomic) WebBlock webBlock;
@end
