//
//  DSUserCentreTableViewCell.m
//  DS_lottery
//
//  Created by pro on 2018/4/16.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSUserCentreTableViewCell.h"

@interface DSUserCentreTableViewCell ()

@end

@implementation DSUserCentreTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

//        [self layoutView];
    }
    return self;
}

-(void)layoutView{
    //线颜色
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = COLORLine;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@(-0.5));
        make.height.equalTo(@0.5);
    }];

    DSUserFuntionModel * model1 = self.array[0];
    UIView * centreLine = [[UIView alloc]init];
    centreLine.backgroundColor = backColor;
    [self.contentView addSubview:centreLine];
    [centreLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@(10));
        make.bottom.equalTo(@(-10));
        make.width.equalTo(@1);
    }];

    UIImageView * leftImage = [[UIImageView alloc]init];
    [leftImage setImage:[UIImage imageNamed:model1.imageName]];
    [self.contentView addSubview:leftImage];
    [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@(IOS_SiZESCALE(60)));
        make.left.equalTo(@(IOS_SiZESCALE(20)));
        make.centerY.equalTo(@0);
    }];

    UILabel * leftTitle = [[UILabel alloc]init];
    leftTitle.font = [UIFont systemFontOfSize:16];
    leftTitle.text = model1.tilteName;
    leftTitle.textColor = COLORFont53;
    [self.contentView addSubview:leftTitle];
    [leftTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftImage.mas_right).offset(10);
        make.right.equalTo(centreLine.mas_left);
        make.height.equalTo(@25);
        make.top.equalTo(leftImage.mas_top).offset(5);
    }];

    UILabel * leftContent = [[UILabel alloc]init];
    leftContent.font = [UIFont systemFontOfSize:10];
    leftContent.text = model1.content;
    leftContent.textColor = COLOR(250, 4, 28);
    [self.contentView addSubview:leftContent];
    [leftContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftImage.mas_right).offset(10);
        make.right.equalTo(centreLine.mas_left);
        make.height.equalTo(@25);
        make.top.equalTo(leftTitle.mas_bottom).offset(0);
    }];


    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(@0);
        make.right.equalTo(centreLine.mas_left);
    }];

    if(self.array.count>1){
        DSUserFuntionModel * model2 = self.array[1];
        UIImageView * rightImage = [[UIImageView alloc]init];
        [self.contentView addSubview:rightImage];
        [rightImage setImage:[UIImage imageNamed:model2.imageName]];
        [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.equalTo(@(IOS_SiZESCALE(60)));
            make.left.equalTo(centreLine.mas_right).offset(IOS_SiZESCALE(15));
            make.centerY.equalTo(@0);
        }];

        UILabel * rightTitle = [[UILabel alloc]init];
        rightTitle.font = [UIFont systemFontOfSize:16];
        rightTitle.text = model2.tilteName;
        rightTitle.textColor = COLORFont53;
        [self.contentView addSubview:rightTitle];
        [rightTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rightImage.mas_right).offset(10);
            make.right.equalTo(@0);
            make.height.equalTo(@25);
            make.top.equalTo(rightImage.mas_top).offset(5);
        }];

        UILabel * rightContent = [[UILabel alloc]init];
        rightContent.font = [UIFont systemFontOfSize:10];
        rightContent.numberOfLines = 2;
        rightContent.text = model2.content;
        rightContent.textColor = COLOR(250, 4, 28);
        [self.contentView addSubview:rightContent];
        [rightContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rightImage.mas_right).offset(10);
            make.right.offset(-8);
            make.height.equalTo(@25);
            make.top.equalTo(rightTitle.mas_bottom).offset(0);
        }];

        UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:rightBtn];
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(@0);
            make.left.equalTo(centreLine.mas_left);
        }];
    }
}


-(void)setArray:(NSMutableArray *)array{
    _array = array;
    [self layoutView];

}

-(void)prepareForReuse{
    [super prepareForReuse];
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
}

-(void)leftBtnAction{
    if (self.cellSelectContent) {
         DSUserFuntionModel * model = self.array[0];
        self.cellSelectContent(model.tilteName);
    }
}

-(void)rightBtnAction{
    if (self.cellSelectContent) {
        DSUserFuntionModel * model = self.array[1];
        self.cellSelectContent(model.tilteName);
    }
}
@end
