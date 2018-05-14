//
//  DSHomeMessageTableViewCell.m
//  DS_lottery
//
//  Created by pro on 2018/4/17.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSHomeMessageTableViewCell.h"

@interface DSHomeMessageTableViewCell()


@end

@implementation DSHomeMessageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

//没有图片的布局
-(void)notImgLayoutViewModel:(DSHomeMessageModel *)model{
    UILabel * title = [[UILabel alloc]init];
    title.text = model.title;
    title.numberOfLines = 2;
    title.textColor = COLORFont53;
    title.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@(-10));
        make.top.equalTo(@12);
        make.height.equalTo(@(IOS_SiZESCALE(50)));
    }];
    UILabel * hot = [[UILabel alloc]init];
    hot.layer.masksToBounds = YES;
    hot.layer.cornerRadius = 2;
    hot.layer.borderWidth = 0.5;
    hot.textColor = COLOR(248, 0, 7);
    hot.layer.borderColor = COLOR(248, 0, 7).CGColor;
    hot.textAlignment = NSTextAlignmentCenter;
    hot.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:hot];
    [hot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@30);
        make.height.equalTo(@15);
        make.top.equalTo(title.mas_bottom).offset(3);
        make.left.equalTo(title.mas_left);
    }];
    if([model.hot integerValue] == 1){
         hot.text = @"热门";
    }if([model.exclusive integerValue] == 1){
        hot.text = @"置顶";
    }

    UILabel * comment = [[UILabel alloc]init];
    comment.textColor = COLORFont151;
    comment.text = [NSString stringWithFormat:@"%d评论",arc4random() % 2000];
    comment.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:comment];
    [comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.left.equalTo(hot.mas_right).offset(5);
        make.centerY.equalTo(hot.mas_centerY);
        make.width.equalTo(@([DSFuntionTool calculateWidthWithContent:comment.text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11.0]}height:20]));
    }];

    UILabel * timer = [[UILabel alloc]init];
    timer.textColor = COLORFont151;
    timer.text = [self timerDate:model.updateTime];
    timer.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:timer];
    [timer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.left.equalTo(comment.mas_right).offset(5);
        make.centerY.equalTo(hot.mas_centerY);
        make.right.equalTo(@0);
    }];

    UIView * line = [[UIView alloc]init];
    line.backgroundColor = COLORLine;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.right.equalTo(@(-5));
        make.height.equalTo(@(0.5));
        make.bottom.equalTo(@0);
    }];


}

//一张图片的布局
-(void)oneImgLayoutViewModel:(DSHomeMessageModel *)model{
    UILabel * title = [[UILabel alloc]init];
    title.text = model.title;
    title.numberOfLines = 2;
    title.textColor = COLORFont53;
    title.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@(-10));
        make.top.equalTo(@12);
        make.height.equalTo(@(IOS_SiZESCALE(50)));
    }];
    UILabel * hot = [[UILabel alloc]init];
    hot.layer.masksToBounds = YES;
    hot.layer.cornerRadius = 2;
    hot.layer.borderWidth = 0.5;
    hot.textColor = COLOR(248, 0, 7);
    hot.layer.borderColor = COLOR(248, 0, 7).CGColor;
    hot.textAlignment = NSTextAlignmentCenter;
    hot.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:hot];
    [hot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@30);
        make.height.equalTo(@15);
        make.bottom.equalTo(@(-10));
        make.left.equalTo(title.mas_left);
    }];
    if([model.hot integerValue] == 1){
        hot.text = @"热门";
    }if([model.exclusive integerValue] == 1){
        hot.text = @"置顶";
    }

    UILabel * comment = [[UILabel alloc]init];
    comment.textColor = COLORFont151;
    comment.text = [NSString stringWithFormat:@"%d评论",arc4random() % 2000];
    comment.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:comment];
    [comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.left.equalTo(hot.mas_right).offset(5);
        make.centerY.equalTo(hot.mas_centerY);
        make.width.equalTo(@([DSFuntionTool calculateWidthWithContent:comment.text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11.0]}height:20]));
    }];

    UILabel * timer = [[UILabel alloc]init];
    timer.textColor = COLORFont151;
    timer.text = [self timerDate:model.updateTime];
    timer.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:timer];
    [timer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.left.equalTo(comment.mas_right).offset(5);
        make.centerY.equalTo(hot.mas_centerY);
        make.right.equalTo(@0);
    }];

    UIImageView * img = [[UIImageView alloc]init];
    img.backgroundColor = backColor;
    img.clipsToBounds = YES;
    img.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:img];
    [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@.png",IMGURL,model.imageIdList[0]]] placeholderImage:nil];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(IOS_SiZESCALE(190)));
        make.bottom.equalTo(hot.mas_top).offset(IOS_SiZESCALE(-8));
        make.left.equalTo(@(15));
        make.right.equalTo(@(-15));
    }];

    UIView * line = [[UIView alloc]init];
    line.backgroundColor = COLORLine;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.right.equalTo(@(-5));
        make.height.equalTo(@(0.5));
        make.bottom.equalTo(@0);
    }];
}

//多张图片的布局
-(void)moreImgLayoutViewModel:(DSHomeMessageModel *)model{
    UILabel * title = [[UILabel alloc]init];
    title.text = model.title;
    title.numberOfLines = 2;
    title.textColor = COLORFont53;
    title.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@(-10));
        make.top.equalTo(@12);
        make.height.equalTo(@(IOS_SiZESCALE(50)));
    }];
    UILabel * hot = [[UILabel alloc]init];
    hot.layer.masksToBounds = YES;
    hot.layer.cornerRadius = 2;
    hot.layer.borderWidth = 0.5;
    hot.textColor = COLOR(248, 0, 7);
    hot.layer.borderColor = COLOR(248, 0, 7).CGColor;
    hot.textAlignment = NSTextAlignmentCenter;
    hot.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:hot];
    [hot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@30);
        make.height.equalTo(@15);
        make.bottom.equalTo(@(-10));
        make.left.equalTo(title.mas_left);
    }];
    if([model.hot integerValue] == 1){
        hot.text = @"热门";
    }if([model.exclusive integerValue] == 1){
        hot.text = @"置顶";
    }

    UILabel * comment = [[UILabel alloc]init];
    comment.textColor = COLORFont151;
    comment.text = [NSString stringWithFormat:@"%d评论",arc4random() % 2000];
    comment.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:comment];
    [comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.left.equalTo(hot.mas_right).offset(5);
        make.centerY.equalTo(hot.mas_centerY);
        make.width.equalTo(@([DSFuntionTool calculateWidthWithContent:comment.text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11.0]}height:20]));
    }];

    UILabel * timer = [[UILabel alloc]init];
    timer.textColor = COLORFont151;
    timer.text = [self timerDate:model.updateTime];
    timer.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:timer];
    [timer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.left.equalTo(comment.mas_right).offset(5);
        make.centerY.equalTo(hot.mas_centerY);
        make.right.equalTo(@0);
    }];

    UIView * line = [[UIView alloc]init];
    line.backgroundColor = COLORLine;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.right.equalTo(@(-5));
        make.height.equalTo(@(0.5));
        make.bottom.equalTo(@0);
    }];

    CGFloat left = 15;
    CGFloat width = (PhoneScreen_WIDTH - 40)/3;
    for (int i = 0; i < 3; i++) {
        UIImageView * img = [[UIImageView alloc]init];
        img.backgroundColor = backColor;
        [self.contentView addSubview:img];
        img.clipsToBounds = YES;
        img.contentMode = UIViewContentModeScaleAspectFill;
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@.png",IMGURL,model.imageIdList[i]]] placeholderImage:nil];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(IOS_SiZESCALE(74)));
            make.bottom.equalTo(hot.mas_top).offset(IOS_SiZESCALE(-8));
            make.left.equalTo(@(left));
            make.width.equalTo(@(width));
        }];
        left+= width+5;
    }
}

-(void)prepareForReuse{
    [super prepareForReuse];
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
}

/* 返回时间 */
-(NSString *)timerDate:(NSString * )timer{
    if ([[DSFuntionTool currentTimeStr]integerValue] > [timer integerValue]) {
        NSInteger differ = [[DSFuntionTool currentTimeStr] integerValue] - [timer integerValue];
        if(differ < 1000*60){
            return @"刚刚";
        }else if(differ >= 1000*60 &&  differ<=1000*60 * 60){
            return [NSString stringWithFormat:@"%ld分钟前",differ/1000*60];
        }else if(differ > 1000*60 * 60 &&  differ<=1000*60 * 60 * 24){
            return [NSString stringWithFormat:@"%ld小时前",differ/(1000*60*60)];
        }else{
            return [DSFuntionTool timestampTo:timer formatter:@"yyyy-MM-dd HH:mm:ss"];
        }
    }else{
        return @"";
    }
}


@end
