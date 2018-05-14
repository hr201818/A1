//
//  LiuHeTemaTableViewCell.h
//  Ticket
//
//  Created by pro on 2017/9/15.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiuHeTemaTableViewCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property(nonatomic,strong)NSArray *openCodeArray;
@end
