//
//  DSAdvertTableViewCell.m
//  DS_lottery
//
//  Created by pro on 2018/4/17.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSAdvertTableViewCell.h"
@interface DSAdvertTableViewCell()

@end

@implementation DSAdvertTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = backColor;
        [self layoutView];
    }
    return self;
}

-(void)layoutView{
    self.AdvertView = [[DSAdvertView alloc]initWithFrame:CGRectMake(0, 6, PhoneScreen_WIDTH, IOS_SiZESCALE(147))];
    [self.contentView addSubview:self.AdvertView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
//    self.AdvertView.height = IOS_SiZESCALE(147);
}

-(void)setModel:(DSHomeBannerModel *)model{
    _model = model;
    self.AdvertView.model = _model;
}

@end
