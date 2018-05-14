//
//  TotUpTableViewCell.h
//  Ticket
//
//  Created by pro on 2017/11/6.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TotUpTableViewCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier contentArr:(NSMutableArray *)contentArr;
@property(nonatomic,strong)NSArray *openCodeArray;
-(void)setopenCodeArray:(NSArray *)openCodeArray index:(NSInteger) index;
@end
