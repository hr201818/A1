//
//  DSLotteryListTableViewCell.m
//  DS_lottery
//
//  Created by pro on 2018/4/24.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSLotteryListTableViewCell.h"

@interface DSLotteryListTableViewCell();

/* 彩种图标 */
@property (strong, nonatomic) UIImageView * headerImg;

/* 彩种标题 */
@property (strong, nonatomic) UILabel     * titleName;

@end

@implementation DSLotteryListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
            [self setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
            [self setLayoutMargins:UIEdgeInsetsZero];
        }
        [self layoutView];
    }
    return self;
}

-(void)layoutView{

    UIView * line = [[UIView alloc]init];
    line.backgroundColor = COLORLine;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.right.equalTo(@0);
        make.height.equalTo(@0.6);
    }];

    self.headerImg = [[UIImageView alloc]init];
    [self.contentView addSubview:self.headerImg];
    [self.headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.centerY.equalTo(@0);
        make.height.and.width.equalTo(@50);
    }];

    self.titleName = [[UILabel alloc]init];
    self.titleName.font = [UIFont systemFontOfSize:15];
    self.titleName.textColor = COLORFont53;
    [self.contentView addSubview:self.titleName];
    [self.titleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImg.mas_right).offset(15);
        make.centerY.equalTo(self.headerImg.mas_centerY);
        make.height.equalTo(@30);
        make.right.equalTo(@(-10));
    }];
}

-(void)loadDataTitle:(NSString *)title typeImg:(NSString *)typeImg{
    [self.headerImg setImage:[UIImage imageNamed:typeImg]];
    self.titleName.text = title;
}

@end
