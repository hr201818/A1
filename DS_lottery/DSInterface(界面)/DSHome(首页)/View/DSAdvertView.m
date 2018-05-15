//
//  DSAdvertView.m
//  DS_lottery
//
//  Created by pro on 2018/4/20.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSAdvertView.h"

@interface DSAdvertView()
/* 几星 */
@property (strong, nonatomic) UILabel     * star;
/* 广告图 */
@property (strong, nonatomic) UIImageView * advertImg;
/* 用户关注 */
@property (strong, nonatomic) UILabel     * userNumber;
/* 标签 */
@property (strong, nonatomic) UILabel     * tagType;

@end

@implementation DSAdvertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutView];
        self.height = IOS_SiZESCALE(147);
        self.width = PhoneScreen_WIDTH;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTouch)];
        [self addGestureRecognizer:tap];
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)layoutView{

    self.star = [[UILabel alloc]init];
    self.star.textColor = COLORFont53;
    self.star.font = [UIFont systemFontOfSize:12];
    self.star.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.star];
    [self.star mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.height.equalTo(@(IOS_SiZESCALE(30)));
        make.right.equalTo(@0);
        make.top.equalTo(@0);
    }];

    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeBtn setImage:[UIImage imageNamed:@"cion_close.png"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(@0);
        make.width.equalTo(@25);
        make.height.equalTo(@20);
    }];
    self.closeBtn.hidden = YES;

    self.advertImg = [[UIImageView alloc]init];
    self.advertImg.clipsToBounds = YES;
    self.advertImg.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.advertImg];
    [self.advertImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.star.mas_bottom);
        make.right.left.equalTo(@0);
        make.height.equalTo(@(IOS_SiZESCALE(86)));
    }];

    self.userNumber = [[UILabel alloc]init];
    self.userNumber.textColor = COLORFont151;
    self.userNumber.font = [UIFont systemFontOfSize:10];
    self.userNumber.backgroundColor = [UIColor whiteColor];
    self.userNumber.text = @"    100位彩民关注过";
    [self addSubview:self.userNumber];
    [self.userNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@(-2));
        make.top.equalTo(self.advertImg.mas_bottom);
    }];

    self.tagType = [[UILabel alloc]init];
    self.tagType.textColor = COLORFontblu;
    self.tagType.font = [UIFont systemFontOfSize:10];
    self.tagType.layer.masksToBounds = YES;
    self.tagType.layer.cornerRadius = 5;
    self.tagType.textAlignment = NSTextAlignmentCenter;
    self.tagType.layer.borderColor = COLORFontblu.CGColor;
    self.tagType.layer.borderWidth = 1;
    self.tagType.text = @"广告";
    [self addSubview:self.tagType];
    [self.tagType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@40);
        make.right.equalTo(@(-10));
        make.centerY.equalTo(self.userNumber.mas_centerY);
        make.height.equalTo(@18);
    }];
}

-(void)setModel:(DSHomeBannerModel *)model{
    _model = model;
    self.star.text = [NSString stringWithFormat:@"    %@",model.advertisTitle];
    [self.advertImg sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil];
    self.userNumber.text = [NSString stringWithFormat:@"    %@位彩民关注过",model.advertisFollowNum];
}

/* 关闭按钮事件 */
-(void)closeBtnAction{
    [self removeFromSuperview];
}

-(void)tapTouch{
    [DSFuntionTool openUrl:_model.advertisUrl];
}

@end
