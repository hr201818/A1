//
//  SSQHQTableViewCell.h
//  Ticket
//
//  Created by pro on 2017/11/6.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSQHQTableViewCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier contentArr:(NSMutableArray *)contentArray;
@property(nonatomic,strong)NSArray *openCodeArray;
@property(nonatomic,copy)NSString *TotUpArray;
@end
