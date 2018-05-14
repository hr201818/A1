//
//  DSShopTableViewCell.m
//  DS_lottery
//
//  Created by pro on 2018/4/23.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSShopTableViewCell.h"

@interface DSShopTableViewCell()
@property (strong, nonatomic) UIImageView * imageIcon;

@property (strong, nonatomic) UILabel     * title;

@property (strong, nonatomic) UILabel     * content;
@end

@implementation DSShopTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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

    //图片
    self.imageIcon = [[UIImageView alloc]init];
    self.imageIcon.backgroundColor = backColor;
    self.imageIcon.layer.masksToBounds = YES;
    self.imageIcon.layer.cornerRadius = 5;
    self.imageIcon.clipsToBounds = YES;
    self.imageIcon.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.imageIcon];
    [self.imageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.equalTo(@55);
        make.centerY.equalTo(@0);
        make.left.equalTo(@5);
    }];

    //名称
    self.title = [[UILabel alloc]init];
    self.title.textColor = COLORFont53;
    self.title.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageIcon.mas_right).offset(10);
        make.right.equalTo(@0);
        make.height.equalTo(@25);
        make.top.equalTo(@10);
    }];

    //地址
    self.content = [[UILabel alloc]init];
    self.content.textColor = COLORFont151;
    self.content.font = [UIFont systemFontOfSize:13];
    self.content.numberOfLines = 0;
    [self.contentView addSubview:self.content];
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageIcon.mas_right).offset(10);
        make.right.equalTo(@0);
        make.bottom.equalTo(@(-8));
        make.top.equalTo(self.title.mas_bottom).offset(0);
    }];

}

-(void)setModel:(AMapPOI *)model{
    _model = model;
    if(_model.images.count){
        AMapImage * img = [_model.images firstObject];
        [self.imageIcon sd_setImageWithURL:[NSURL URLWithString:img.url] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
    }else{
        self.imageIcon.image = [UIImage imageNamed:@"zhanweitu"];
    }
    self.title.text = _model.name;
    self.content.text = _model.address;

}

@end
