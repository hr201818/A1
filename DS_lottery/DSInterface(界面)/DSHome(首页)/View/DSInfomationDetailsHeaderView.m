//
//  DSInfomationDetailsHeaderView.m
//  DS_lottery
//
//  Created by pro on 2018/4/24.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSInfomationDetailsHeaderView.h"

@interface DSInfomationDetailsHeaderView ()

@property (strong, nonatomic) DSHomeMessageModel * model;

@end


@implementation DSInfomationDetailsHeaderView

- (instancetype)initWithFrame:(CGRect)frame model:(DSHomeMessageModel*)model
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = backColor;
        _model = model;
        [self layoutView];
    }
    return self;
}

-(void)layoutView{
    UIView * backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];

    //标题
    UILabel * titleName = [[UILabel alloc]init];
    titleName.text = _model.title;
    titleName.textColor = COLORFont53;
    titleName.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [backView addSubview:titleName];
    [titleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@5);
        make.left.equalTo(@10);
        make.right.equalTo(@(-10));
        make.height.equalTo(backView.mas_height).multipliedBy(0.5);
    }];

    //时间

    UILabel * date = [[UILabel alloc]init];
    date.text = [DSFuntionTool timestampTo:_model.createTime formatter:@"yyyy-MM-dd HH:mm:ss"];
    date.textColor = COLORFont151;
    date.font = [UIFont systemFontOfSize:12.5];
    [backView addSubview:date];
    [date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.width.equalTo(@170);
        make.bottom.equalTo(@0);
        make.height.equalTo(backView.mas_height).multipliedBy(0.5);
    }];

    //浏览
    UILabel * browse = [[UILabel alloc]init];
    browse.text = @"999人浏览";
    browse.textColor = COLORFont151;
    browse.font = [UIFont systemFontOfSize:12.5];
    browse.textAlignment = NSTextAlignmentRight;
    [backView addSubview:browse];
    [browse mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-10));
        make.width.equalTo(@170);
        make.bottom.equalTo(@0);
        make.height.equalTo(backView.mas_height).multipliedBy(0.5);
    }];
}

@end
