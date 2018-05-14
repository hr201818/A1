//
//  DSOpenAwardTableViewCell.m
//  DS_lottery
//
//  Created by pro on 2018/4/20.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSOpenAwardTableViewCell.h"

@interface DSOpenAwardTableViewCell()

/* 存放开奖结果的View父视图 */
@property (strong, nonatomic)UIView  * backView;
/* 标题 */
@property (strong, nonatomic)UILabel * title;
/* 期号 */
@property (strong, nonatomic)UILabel * dateNumber;
/* 日期 */
@property (strong, nonatomic)UILabel * dateTime;

@end

@implementation DSOpenAwardTableViewCell

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

    UIView * line = [[UIView alloc]init];
    line.backgroundColor = COLORLine;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.bottom.equalTo(@0);
        make.height.equalTo(@0.6);
    }];

    //彩种名称
    self.title = [[UILabel alloc]init];
    self.title.textColor = [UIColor blackColor];
    self.title.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.height.equalTo(@25);
        make.top.equalTo(@15);
        make.width.equalTo(@120);
    }];

    //彩种期数
    self.dateNumber = [[UILabel alloc]init];
    self.dateNumber.textColor = COLORFont151;
    self.dateNumber.textAlignment = NSTextAlignmentCenter;
    self.dateNumber.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.dateNumber];
    [self.dateNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.title.mas_centerY);
        make.width.equalTo(@100);
    }];

    //彩种日期时间
    self.dateTime = [[UILabel alloc]init];
    self.dateTime.textColor = COLORFont151;
    self.dateTime.textAlignment = NSTextAlignmentRight;
    self.dateTime.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.dateTime];
    [self.dateTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.right.equalTo(@(-10));
        make.centerY.equalTo(self.title.mas_centerY);
        make.width.equalTo(@110);
    }];

    //圆球的父视图，方便清除
    self.backView = [[UIView alloc]init];
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.bottom.equalTo(@0);
        make.top.equalTo(self.title.mas_bottom);
    }];

    //箭头
    UIImageView * arrowsIcon = [[UIImageView alloc]init];
    [arrowsIcon setImage:[UIImage imageNamed:@"shezhi_icon_jiantou"]];
    [self.contentView addSubview:arrowsIcon];
    [arrowsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-5));
        make.width.equalTo(@15);
        make.height.equalTo(@15);
        make.centerY.equalTo(@5);
    }];
}

-(void)setModel:(DSOpenAwardModel *)model{
    _model = model;
    self.title.text = model.playGroupName;
    self.dateNumber.text = [NSString stringWithFormat:@"%@期",model.number];
    self.dateTime.text = [DSFuntionTool timestampTo:model.openTime formatter:@"yyyy-MM-dd HH:mm"];
    NSArray *array = [model.openCode componentsSeparatedByString:@","];
    CGFloat left = IOS_SiZESCALE(10);
    CGFloat top = IOS_SiZESCALE(7);
    for (int i = 0; i < array.count; i++) {
        UIButton * number = [UIButton buttonWithType:UIButtonTypeCustom];
        number.userInteractionEnabled = NO;
        number.frame = CGRectMake(left, top, IOS_SiZESCALE(27), IOS_SiZESCALE(27));
        [number setTitle:array[i] forState:UIControlStateNormal];
        [number setBackgroundImage:[UIImage imageNamed:@"redyuan"] forState:UIControlStateNormal];
        [number setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        number.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        //双色球单独处理
        if ([model.playGroupId isEqualToString:@"12"] && i == array.count - 1) {
            [number setBackgroundImage:[UIImage imageNamed:@"lanyuan"] forState:UIControlStateNormal];
        }
        [self.backView addSubview:number];
        if(i == 9){
            left = IOS_SiZESCALE(10);
            top = IOS_SiZESCALE(39);
        }else{
            left += IOS_SiZESCALE(32);
        }
    }
}

-(void)prepareForReuse{
    [super prepareForReuse];
    for (UIView *view in self.backView.subviews) {
        [view removeFromSuperview];
    }
}
@end
