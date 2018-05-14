//
//  DSLotteryTableViewCell.m
//  DS_lottery
//
//  Created by pro on 2018/4/17.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSLotteryTableViewCell.h"

@interface DSLotteryTableViewCell()

//底部视图
@property (strong, nonatomic) UIView * backView;

@end

@implementation DSLotteryTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutView];
    }
    return self;
}

-(void)layoutView{
    self.backView = [[UIView alloc]init];
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(@0);
    }];
}

-(void)setLotteryArr:(NSMutableArray *)lotteryArr{
    _lotteryArr = lotteryArr;
    for (int i = 0; i < lotteryArr.count; i++) {
        
        NSDictionary * dic = lotteryArr[i];

        UIView * itemView = [[UIView alloc]init];
        [self.backView addSubview:itemView];
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(i * PhoneScreen_WIDTH/3));
            make.width.equalTo(@(PhoneScreen_WIDTH/3));
            make.top.bottom.equalTo(@0);
        }];

        UIImageView * iconImg = [[UIImageView alloc]init];
        [iconImg setImage:[UIImage imageNamed:[dic objectForKey:@"icon"]]];
        [itemView addSubview:iconImg];
        [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.top.equalTo(@15);
            make.width.height.equalTo(@45);
        }];

        UILabel * name = [[UILabel alloc]init];
        name.textColor = COLORFont53;
        name.textAlignment = NSTextAlignmentCenter;
        name.font = [UIFont systemFontOfSize:13];
        name.text = [dic objectForKey:@"name"];
        [itemView addSubview:name];
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.height.equalTo(@30);
            make.top.equalTo(iconImg.mas_bottom);
        }];
    }
}

-(void)prepareForReuse{
    [super prepareForReuse];
    for (UIView * itemView in  self.backView.subviews) {
        for (UIView * view in itemView.subviews) {
             [view removeFromSuperview];
        }
        [itemView removeFromSuperview];
    }
}
@end
