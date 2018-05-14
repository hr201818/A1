//
//  DSOpenAdvertTableViewCell.m
//  DS_lottery
//
//  Created by pro on 2018/4/25.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSOpenAdvertTableViewCell.h"

@interface DSOpenAdvertTableViewCell()

@property (strong, nonatomic) UIImageView * advertImg;

@end

@implementation DSOpenAdvertTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /* 布局视图*/
        [self layoutView];
    }
    return self;
}

-(void)layoutView{
    self.advertImg = [[UIImageView alloc]init];
    [self.contentView addSubview:self.advertImg];
    [self.advertImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.bottom.top.equalTo(@0);
    }];
}

-(void)setModel:(DSHomeBannerModel *)model{
    _model = model;
    [self.advertImg sd_setImageWithURL:[NSURL URLWithString:model.advertisUrl] placeholderImage:nil];
}
@end
