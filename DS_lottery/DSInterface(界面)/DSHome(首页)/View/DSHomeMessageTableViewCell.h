//
//  DSHomeMessageTableViewCell.h
//  DS_lottery
//
//  Created by pro on 2018/4/17.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSHomeMessageListModel.h"
@interface DSHomeMessageTableViewCell : UITableViewCell

//没有图片的布局
-(void)notImgLayoutViewModel:(DSHomeMessageModel *)model;
//一张图片的布局
-(void)oneImgLayoutViewModel:(DSHomeMessageModel *)model;
//多张图片的布局
-(void)moreImgLayoutViewModel:(DSHomeMessageModel *)model;

@end
