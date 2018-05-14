//
//  DSUserCentreTableViewCell.h
//  DS_lottery
//
//  Created by pro on 2018/4/16.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSUserFuntionModel.h"
typedef void(^CellSelectContent)(NSString * titleName);
@interface DSUserCentreTableViewCell : UITableViewCell

@property (strong, nonatomic) NSMutableArray * array;

@property (copy, nonatomic) CellSelectContent cellSelectContent;

@end
