//
//  DSHomeLotteryTableViewCell.m
//  DS_lottery
//
//  Created by pro on 2018/4/27.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSHomeLotteryTableViewCell.h"
#import "DSExplainViewController.h"
#import "DSMapViewController.h"
@interface DSHomeLotteryTableViewCell()

@property (strong, nonatomic) UIImageView * headerImg;

@property (strong, nonatomic) UILabel     * titleName;

@property (strong, nonatomic) UILabel     * topHud;

@property (strong, nonatomic) UILabel     * botHud;

@property (strong, nonatomic) UILabel     * timeText;

@property (strong, nonatomic) UIButton    * touzhuBtn;

@property (strong, nonatomic) UIView      * numberBack;

@end

@implementation DSHomeLotteryTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutView];
        self.contentView.backgroundColor = backColor;
    }
    return self;
}

-(void)layoutView{

    UIView * backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(@0);
        make.top.equalTo(@4);
        make.bottom.equalTo(@0);
    }];

    self.headerImg = [[UIImageView alloc]init];
    [self.contentView addSubview:self.headerImg];
    [self.headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@62);
        make.left.equalTo(@(IOS_SiZESCALE(15)));
        make.top.equalTo(@15);
    }];

    self.titleName = [[UILabel alloc]init];
    self.titleName.textColor = COLORFont68;
    self.titleName.text = @"广东快乐十分 第202432432 期开奖";
    self.titleName.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.titleName];
    [self.titleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImg.mas_right).offset(IOS_SiZESCALE(10));
        make.height.equalTo(@20);
        make.top.equalTo(@17);
        make.right.equalTo(@0);
    }];

    self.topHud = [[UILabel alloc]init];
    self.topHud.textColor = COLORFont151;
    self.topHud.font = [UIFont systemFontOfSize:9];
    [self.contentView addSubview:self.topHud];
    [self.topHud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImg.mas_right).offset(IOS_SiZESCALE(10));
        make.height.equalTo(@15);
        make.top.equalTo(self.titleName.mas_bottom).offset(5);
        make.width.equalTo(@120);
    }];

    self.botHud = [[UILabel alloc]init];
    self.botHud.textColor = COLORFont151;
    self.botHud.text = @"当前43期，剩余84期";
    self.botHud.font = [UIFont systemFontOfSize:9];
    [self.contentView addSubview:self.botHud];
    [self.botHud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImg.mas_right).offset(IOS_SiZESCALE(10));
        make.height.equalTo(@15);
        make.top.equalTo(self.topHud.mas_bottom).offset(2);
        make.width.equalTo(@95);
    }];

    self.timeText = [[UILabel alloc]init];
    self.timeText.textColor = COLORFontred;
    self.timeText.text = @"02分07秒";
    self.timeText.font = [UIFont systemFontOfSize:9];
    [self.contentView addSubview:self.timeText];
    [self.timeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.botHud.mas_right).offset(IOS_SiZESCALE(2));
        make.height.equalTo(@15);
        make.centerY.equalTo(self.botHud.mas_centerY);
        make.width.equalTo(@80);
    }];

    self.touzhuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.touzhuBtn.backgroundColor = COLOR(36, 150, 238);
    [self.touzhuBtn setTitle:@"购彩大厅" forState:UIControlStateNormal];
    [self.touzhuBtn addTarget:self action:@selector(touzhuBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.touzhuBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.touzhuBtn.layer.masksToBounds = YES;
    self.touzhuBtn.layer.cornerRadius = IOS_SiZESCALE(12.5);
    [self.touzhuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.touzhuBtn];
    [self.touzhuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(IOS_SiZESCALE(73)));
        make.height.equalTo(@(IOS_SiZESCALE(25)));
        make.right.equalTo(@(IOS_SiZESCALE(-10)));
        make.centerY.equalTo(self.headerImg.mas_centerY).offset(10);
    }];

    self.numberBack = [[UIView alloc]init];
    [self.contentView addSubview:self.numberBack];
    [self.numberBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(@0);
        make.top.equalTo(self.headerImg.mas_bottom).offset(10);
        make.height.equalTo(@30);
    }];

    UIView * line = [[UIView alloc]init];
    line.backgroundColor = COLORLine;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(@0);
        make.bottom.equalTo(@(-35));
        make.height.equalTo(@1);
    }];

    NSArray * array = [NSArray arrayWithObjects:@"历史开奖",@"全部走势",@"玩法说明",nil];
    for (int i = 0; i<3; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        btn.tag = i+1;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:COLORFont83 forState:UIControlStateNormal];
        if(i == 3){
            [btn setTitleColor:COLORFontred forState:UIControlStateNormal];
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:12.5];
        [self.contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(i*PhoneScreen_WIDTH/3));
            make.width.equalTo(@(PhoneScreen_WIDTH/3));
            make.bottom.equalTo(@0);
            make.height.equalTo(@35);
        }];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UpdateTimer) name:TIMERLOTTERY object:nil];


}

-(void)btnAction:(UIButton *)sender{
    if (sender.tag  == 1) {
        BaseTabBarController * tabbar = (BaseTabBarController *)KeyWindows.rootViewController;
        [tabbar secletIndex:1];
    }else if(sender.tag  == 2){
        BaseTabBarController * tabbar = (BaseTabBarController *)KeyWindows.rootViewController;
        [tabbar secletIndex:3];
    }else if(sender.tag  == 3){
        DSExplainViewController * explainVC = [[DSExplainViewController alloc]init];
        explainVC.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:explainVC animated:YES];
    }else{
        [self touzhuBtnAction];
    }
}

-(void)touzhuBtnAction{

    if([[DSUserInfoData initUserInfoData].lawModel.ifHidden isEqualToString:@"0"]){
        if([[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"17"] != nil){
            DSHomeBannerModel * model = [[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"17"];
            [DSFuntionTool openUrl:model.advertisUrl];
        }else{
            DSMapViewController * mapViewVC = [[DSMapViewController alloc]init];
            mapViewVC.typeName = @"附近投注站";
            mapViewVC.hudText = @"请选择附近的彩票网点进行投注";
            mapViewVC.hidesBottomBarWhenPushed = YES;
            [self.viewController.navigationController pushViewController:mapViewVC animated:YES];
        }
    }else{
        DSMapViewController * mapViewVC = [[DSMapViewController alloc]init];
        mapViewVC.typeName = @"附近投注站";
        mapViewVC.hudText = @"请选择附近的彩票网点进行投注";
        mapViewVC.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:mapViewVC animated:YES];
    }
}

-(NSString * )LotteryImg_Id:(NSString *)img_Id{
    self.botHud.hidden = NO;
    [self.timeText mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.botHud.mas_right).offset(IOS_SiZESCALE(2));
        make.height.equalTo(@15);
        make.centerY.equalTo(self.botHud.mas_centerY);
        make.width.equalTo(@80);
    }];
    if([img_Id integerValue] == 1){
        self.topHud.text = @"每10分钟一期，每天120期";
        self.botHud.text = [NSString stringWithFormat:@"当前%ld期，还剩%ld期",[[_model.number substringFromIndex:_model.number.length- 3]integerValue],120 - [[_model.number substringFromIndex:_model.number.length- 3]integerValue]];
        return @"chongqing";
    }else if([img_Id integerValue] == 2){
        self.topHud.text = @"每10分钟一期，每天84期";
        self.botHud.text = [NSString stringWithFormat:@"当前%ld期，还剩%ld期",[[_model.number substringFromIndex:_model.number.length- 3]integerValue],84 - [[_model.number substringFromIndex:_model.number.length- 3]integerValue]];
        return @"tianjing";
    }else if([img_Id integerValue] == 4){
        self.topHud.text = @"每天一期";
        self.botHud.hidden = YES;
        [self.timeText mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.botHud.mas_left);
            make.height.equalTo(@15);
            make.centerY.equalTo(self.botHud.mas_centerY);
            make.width.equalTo(@80);
        }];
        return @"pailie";
    }else if([img_Id integerValue] == 5){
        self.topHud.text = @"每天一期";
        self.botHud.hidden = YES;
        [self.timeText mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.botHud.mas_left);
            make.height.equalTo(@15);
            make.centerY.equalTo(self.botHud.mas_centerY);
            make.width.equalTo(@80);
        }];
        return @"fucai";
    }else if([img_Id integerValue] == 8){
        self.topHud.text = @"每5分钟一期，每天178期";
        self.botHud.text = [NSString stringWithFormat:@"当前%ld期，还剩%ld期",[_model.number integerValue]%178,178 - [_model.number integerValue]%178];
        return @"kuai8";
    }else if([img_Id integerValue] == 10){
        self.topHud.text = @"每10分钟一期，每天96期";
        self.botHud.text = [NSString stringWithFormat:@"当前%ld期，还剩%ld期",[[_model.number substringFromIndex:_model.number.length- 3]integerValue],96 - [[_model.number substringFromIndex:_model.number.length- 3]integerValue]];
        return @"chongqingxingyun";
    }else if([img_Id integerValue] == 11){
        self.topHud.text = @"每10分钟一期，每天84期";
        self.botHud.text = [NSString stringWithFormat:@"当前%ld期，还剩%ld期",[[_model.number substringFromIndex:_model.number.length- 3]integerValue],84 - [[_model.number substringFromIndex:_model.number.length- 3]integerValue]];
        return @"guangdong10";
    }else if([img_Id integerValue] == 12){
        self.topHud.text = @"每周二、四、日 21:20开奖";
        self.botHud.hidden = YES;
        [self.timeText mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.botHud.mas_left);
        }];
        return @"shuangse";
    }else if([img_Id integerValue] == 19){
        self.topHud.text = @"每10分钟一期，每天82期";
        self.botHud.text = [NSString stringWithFormat:@"当前%ld期，还剩%ld期",[[_model.number substringFromIndex:_model.number.length- 3]integerValue],82 - [[_model.number substringFromIndex:_model.number.length- 3]integerValue]];
        return @"hubeikuai3";
    }else if([img_Id integerValue] == 20){
        self.topHud.text = @"每10分钟一期，每天82期";
        self.botHud.text = [NSString stringWithFormat:@"当前%ld期，还剩%ld期",[[_model.number substringFromIndex:_model.number.length- 3]integerValue],82 - [[_model.number substringFromIndex:_model.number.length- 3]integerValue]];
        return @"anhuikuai3";
    }
    return @"";
}

-(void)setModel:(DSOpenAwardModel *)model{
    _model = model;
    [self.headerImg setImage:[UIImage imageNamed:[self LotteryImg_Id:model.playGroupId]]];
    self.titleName.text = [NSString stringWithFormat:@"%@  第 %@ 期开奖",model.playGroupName,model.number];

    NSArray *arrays = [model.openCode componentsSeparatedByString:@","];
    CGFloat left = 20;
    CGFloat top = 0;
    for (int i = 0; i < arrays.count; i++) {
        UIButton * number = [UIButton buttonWithType:UIButtonTypeCustom];
        number.userInteractionEnabled = NO;
        number.frame = CGRectMake(left, top, IOS_SiZESCALE(25), IOS_SiZESCALE(25));
        [number setTitle:arrays[i] forState:UIControlStateNormal];
        [number setBackgroundImage:[UIImage imageNamed:@"redyuan"] forState:UIControlStateNormal];
        [number setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        number.titleLabel.font = [UIFont systemFontOfSize:14];
        //双色球单独处理
        if ([model.playGroupId isEqualToString:@"12"] && i == arrays.count - 1) {
            [number setBackgroundImage:[UIImage imageNamed:@"lanyuan"] forState:UIControlStateNormal];
        }
        [self.numberBack addSubview:number];
        if(i == 9){
            left = 20;
            top = IOS_SiZESCALE(30);
        }else{
            left += IOS_SiZESCALE(32);
        }
    }
    [self UpdateTimer];
}

//倒计时显示
-(void)UpdateTimer{
    switch ([_model.playGroupId integerValue]) {
        case 1:  self.timeText.text= [self remainTimer:[DSAdvertSingleData initAdvertData].id_1] ;break;
        case 2:  self.timeText.text= [self remainTimer:[DSAdvertSingleData initAdvertData].id_2]  ;break;
        case 5:  self.timeText.text= [self remainTimer:[DSAdvertSingleData initAdvertData].id_5]  ;break;
        case 19:  self.timeText.text= [self remainTimer:[DSAdvertSingleData initAdvertData].id_19]  ;break;
        case 20:  self.timeText.text= [self remainTimer:[DSAdvertSingleData initAdvertData].id_20]  ;break;
        case 4:   self.timeText.text= [self remainTimer:[DSAdvertSingleData initAdvertData].id_4]  ;break;
        case 8:   self.timeText.text= [self remainTimer:[DSAdvertSingleData initAdvertData].id_8]  ;break;
        case 12:   self.timeText.text= [self remainTimer:[DSAdvertSingleData initAdvertData].id_12] ;break;
        case 11:  self.timeText.text= [self remainTimer:[DSAdvertSingleData initAdvertData].id_11]  ;break;
        case 10:  self.timeText.text= [self remainTimer:[DSAdvertSingleData initAdvertData].id_10]  ;break;
        default:break;
    }
}

-(NSString * )remainTimer:(NSInteger)time_limit{
    if (time_limit > 0) {
        NSString * hour;
        if (time_limit>=36000) {
            hour = [NSString stringWithFormat:@"%ld",time_limit/3600];
        }else{
            hour = [NSString stringWithFormat:@"0%ld",time_limit /3600];
        }
        NSString * minute;
        if (time_limit%3600 >= 600) {
            minute = [NSString stringWithFormat:@"%ld",time_limit%3600/60];
        }else{
            minute = [NSString stringWithFormat:@"0%ld",time_limit%3600/60];
        }
        NSString * second;
        if (time_limit%3600%60 > 9) {
            second = [NSString stringWithFormat:@"%ld",time_limit%3600%60];
        }else{
            second = [NSString stringWithFormat:@"0%ld",time_limit%3600%60];
        }
        if([hour integerValue] == 0){
            return [NSString stringWithFormat:@"%@分%@秒",minute,second];
        }
        return [NSString stringWithFormat:@"%@小时%@分%@秒",hour,minute,second];
        //        return [NSString stringWithFormat,hour,minute,second];
    }else{
        return @"已结束";
    }
    return @"已结束";
}
-(void)prepareForReuse{
    [super prepareForReuse];
    for (UIView * view in self.numberBack.subviews) {
        [view removeFromSuperview];
    }
}

@end
