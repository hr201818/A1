//
//  DSRegisterViewController.m
//  DS_lottery
//
//  Created by pro on 2018/4/23.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSRegisterViewController.h"
#import "DSLawViewController.h"
#import "DSAdvertView.h"
@interface DSRegisterViewController ()

/* 手机号 */
@property (strong, nonatomic) UITextField * accountField;

/* 密码 */
@property (strong, nonatomic) UITextField * passwordField;

/* 再一次输入密码 */
@property (strong, nonatomic) UITextField * againPasswordField;

@end

@implementation DSRegisterViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.passwordField.text = @"";
    self.accountField.text = @"";
    self.againPasswordField.text = @"";
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"注册";

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTouch)];
    [self.view addGestureRecognizer:tap];

    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn setTitle:@"登录" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(leftBackAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 50, 30);
    [self navRightItem:rightBtn];

    
    [self navLeftItem:[DSFuntionTool leftNavBackTarget:self Item:@selector(leftBackAction)]];

    /* 视图布局 */
    [self layoutView];

    //广告数据请求
    [self requestAdvert];
}

/* 视图布局 */
-(void)layoutView{
    /* 手机号 */
    UIImageView * accountImg = [[UIImageView alloc]init];
    [accountImg setImage:[UIImage imageNamed:@"loginquan"]];
    [self.view addSubview:accountImg];
    [accountImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(IOS_SiZESCALE(350)));
        make.height.equalTo(@(IOS_SiZESCALE(44)));
        make.centerX.equalTo(@0);
        make.top.equalTo(@(Navgationbar_HEIGHT + 24));
    }];

    UIImageView * accountIcon = [[UIImageView alloc]init];
    [accountIcon setImage:[UIImage imageNamed:@"phoneIcon"]];
    [self.view addSubview:accountIcon];
    [accountIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(IOS_SiZESCALE(13)));
        make.height.equalTo(@(IOS_SiZESCALE(27)));
        make.left.equalTo(accountImg.mas_left).offset(IOS_SiZESCALE(24));
        make.centerY.equalTo(accountImg.mas_centerY);
    }];

    UIView * accountLine = [[UIView alloc]init];
    accountLine.backgroundColor = COLORLine;
    [self.view addSubview:accountLine];
    [accountLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(IOS_SiZESCALE(20)));
        make.left.equalTo(accountImg.mas_left).offset(IOS_SiZESCALE(55));
        make.centerY.equalTo(accountImg.mas_centerY);
        make.width.equalTo(@0.7);
    }];

    /* 手机号输入框*/
    self.accountField = [[UITextField alloc]init];
    self.accountField.font = [UIFont systemFontOfSize:16];
    self.accountField.placeholder = @"输入手机号码";
    self.accountField.keyboardType = UIKeyboardTypePhonePad;
    self.accountField.textColor = COLORFont83;
    [self.view addSubview:self.accountField];
//    [self.accountField becomeFirstResponder];
    [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountLine.mas_right).offset(10);
        make.right.equalTo(@(-30));
        make.height.equalTo(accountImg.mas_height);
        make.centerY.equalTo(accountImg.mas_centerY);
    }];

    /* 密码 */
    UIImageView * passwordImg = [[UIImageView alloc]init];
    [passwordImg setImage:[UIImage imageNamed:@"loginquan"]];
    [self.view addSubview:passwordImg];
    [passwordImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(IOS_SiZESCALE(350)));
        make.height.equalTo(@(IOS_SiZESCALE(44)));
        make.centerX.equalTo(@0);
        make.top.equalTo(accountImg.mas_bottom).offset(IOS_SiZESCALE(45));
    }];

    UIImageView * passwordIcon = [[UIImageView alloc]init];
    [passwordIcon setImage:[UIImage imageNamed:@"password"]];
    [self.view addSubview:passwordIcon];
    [passwordIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(IOS_SiZESCALE(16.5)));
        make.height.equalTo(@(IOS_SiZESCALE(23.5)));
        make.left.equalTo(passwordImg.mas_left).offset(IOS_SiZESCALE(21));
        make.centerY.equalTo(passwordImg.mas_centerY);
    }];

    UIView * passwordLine = [[UIView alloc]init];
    passwordLine.backgroundColor = COLORLine;
    [self.view addSubview:passwordLine];
    [passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(IOS_SiZESCALE(20)));
        make.left.equalTo(passwordImg.mas_left).offset(IOS_SiZESCALE(55));
        make.centerY.equalTo(passwordImg.mas_centerY);
        make.width.equalTo(@0.7);
    }];

    /* 输入密码输入框 */
    self.passwordField = [[UITextField alloc]init];
    self.passwordField.font = [UIFont systemFontOfSize:16];
    self.passwordField.placeholder = @"输入密码";
    self.passwordField.secureTextEntry = YES;
    self.passwordField.textColor = COLORFont83;
    [self.view addSubview:self.passwordField];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordLine.mas_right).offset(10);
        make.right.equalTo(@(-30));
        make.height.equalTo(passwordImg.mas_height);
        make.centerY.equalTo(passwordImg.mas_centerY);
    }];

    /* 再次输入密码 */
    UIImageView * againPasswordImg = [[UIImageView alloc]init];
    [againPasswordImg setImage:[UIImage imageNamed:@"loginquan"]];
    [self.view addSubview:againPasswordImg];
    [againPasswordImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(IOS_SiZESCALE(350)));
        make.height.equalTo(@(IOS_SiZESCALE(44)));
        make.centerX.equalTo(@0);
        make.top.equalTo(passwordImg.mas_bottom).offset(IOS_SiZESCALE(10));
    }];

    UIImageView * againPasswordIcon = [[UIImageView alloc]init];
    [againPasswordIcon setImage:[UIImage imageNamed:@"password"]];
    [self.view addSubview:againPasswordIcon];
    [againPasswordIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(IOS_SiZESCALE(16.5)));
        make.height.equalTo(@(IOS_SiZESCALE(23.5)));
        make.left.equalTo(againPasswordImg.mas_left).offset(IOS_SiZESCALE(21));
        make.centerY.equalTo(againPasswordImg.mas_centerY);
    }];

    UIView * againPasswordLine = [[UIView alloc]init];
    againPasswordLine.backgroundColor = COLORLine;
    [self.view addSubview:againPasswordLine];
    [againPasswordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(IOS_SiZESCALE(20)));
        make.left.equalTo(againPasswordImg.mas_left).offset(IOS_SiZESCALE(55));
        make.centerY.equalTo(againPasswordImg.mas_centerY);
        make.width.equalTo(@0.7);
    }];

    self.againPasswordField = [[UITextField alloc]init];
    self.againPasswordField.font = [UIFont systemFontOfSize:15];
    self.againPasswordField.placeholder = @"重复输入密码";
    self.againPasswordField.secureTextEntry = YES;
    self.againPasswordField.textColor = COLORFont83;
    [self.view addSubview:self.againPasswordField];
    [self.againPasswordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(againPasswordLine.mas_right).offset(10);
        make.right.equalTo(@(-30));
        make.height.equalTo(againPasswordImg.mas_height);
        make.centerY.equalTo(againPasswordImg.mas_centerY);
    }];

    //图标
    UIImageView * gouImg = [[UIImageView alloc]init];
    [gouImg setImage:[UIImage imageNamed:@"agreement"]];
    [self.view addSubview:gouImg];
    [gouImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@16);
        make.height.equalTo(@14.5);
        make.top.equalTo(self.againPasswordField.mas_bottom).offset(20);
        make.left.equalTo(@15);
    }];

    //条例提示
    UILabel * hudtext = [[UILabel alloc]init];
    hudtext.font = [UIFont systemFontOfSize:12];
    hudtext.textColor = COLORFont151;
    [self.view addSubview:hudtext];
    [hudtext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(gouImg.mas_right).offset(5);
        make.width.equalTo(@120);
        make.height.equalTo(@20);
        make.centerY.equalTo(gouImg.mas_centerY);
    }];

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"我已同意本站协议"];
    NSRange strRange = {4,[@"本站协议" length]};
    [attributedString addAttribute:NSForegroundColorAttributeName
                   value:COLOR(249, 62, 91)
                   range:strRange];
    hudtext.attributedText = attributedString;

//    if ([DSUserInfoData initUserInfoData].lawModel!= nil &&[[DSUserInfoData initUserInfoData].lawModel.lawIsShow integerValue] == 1) {
//        UIButton * lawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [lawBtn setTitle:@"法律声明" forState:UIControlStateNormal];
//        [lawBtn addTarget:self action:@selector(lawBtnAction) forControlEvents:UIControlEventTouchUpInside];
//        [lawBtn setTitleColor:COLORFont121 forState:UIControlStateNormal];
//        lawBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//        [self.view addSubview:lawBtn];
//        [lawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.equalTo(@70);
//            make.height.equalTo(@40);
//            make.right.equalTo(@(-5));
//            make.centerY.equalTo(hudtext.mas_centerY);
//        }];
//
//    }


    /* 完成按钮 */
    UIButton * doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn"] forState:UIControlStateNormal];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.height.equalTo(@45);
        make.right.equalTo(@(-15));
        make.top.equalTo(hudtext.mas_bottom).offset(25);
    }];
}

#pragma mark - 网络请求
/* 请求广告 */
-(void)requestAdvert{
    /* 没有广告的情况的再去请求 */
    if (![DSAdvertSingleData initAdvertData].model.advertList.count) {
        __weak typeof (self)weakSelf = self;
        [[DSAdvertSingleData initAdvertData] requestDataSucceed:^(DSHomeBannerListModel *result) {
            [weakSelf loadData];
        } Failure:^{

        }];
    }else{
        [self loadData];
    }
}
/* 加载广告 */
-(void)loadData{
    //非空判断，不然数组会闪退
    if ([[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"26"] != nil) {
        DSAdvertView * advertView = [[DSAdvertView alloc]initWithFrame:CGRectMake(0, PhoneScreen_HEIGHT - IOS_SiZESCALE(147) - Tabbarbottom_HEIGHT , self.view.width, IOS_SiZESCALE(147))];
        advertView.model = [[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"26"];
        advertView.backgroundColor = backColor;
        [self.view addSubview:advertView];
    }
}

-(void)requestRegisterInfo{
    if(![DSFuntionTool isValidateMobile:self.accountField.text]){
        [self hudErrorText:@"手机格式不正确"];
        return;
    }
    if([DSFuntionTool isBlankString:self.passwordField.text]){
        [self hudErrorText:@"密码不能为空"];
        return;
    }
    if([DSFuntionTool isBlankString:self.againPasswordField.text]){
        [self hudErrorText:@"确认密码不能为空"];
        return;
    }
    if(![self.passwordField.text isEqualToString:self.againPasswordField.text]){
        [self hudErrorText:@"两次密码不一致"];
        return;
    }
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setObject:self.accountField.text forKey:@"phone"];
    [dic setObject:self.passwordField.text forKey:@"password"];
    [dic setObject:[DSFuntionTool getIPAddress:NO] forKey:@"ip"];
    [dic setValue:CLIENTTYPE forKey:@"clientType"];
    [dic setValue:APPVERSION forKey:@"appVersion"];
    [dic setValue:COMPANYSHORTNAME forKey:@"companyShortName"];
    __weak typeof (self)weakSelf = self;
    [self showhud];
    [DSNetWorkRequest postConectWithS:REGISTER Parameter:dic Succeed:^(id result) {
        __strong typeof (self)strongSelf = weakSelf;
        [strongSelf hidehud];
        if (SSUCCESS(result)) {
            [DSUserInfoData initUserInfoData].token = [result objectForKey:@"token"];
            NSString * userId = [(NSNumber *)[result objectForKey:@"userId"] stringValue];
            [DSUserInfoData initUserInfoData].userId = userId;
            [[DSUserInfoData initUserInfoData] loginSucceed];
            [strongSelf.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [strongSelf hudErrorText:[result objectForKey:@"description"]];
        }
    } Failure:^(NSError *failure) {
         __strong typeof (self)strongSelf = weakSelf;
        [strongSelf hidehud];
        [strongSelf hudErrorText:@"数据错误"];
    }];
}


#pragma  mark - 点击事件
/* 返回 */
-(void)leftBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

/* 完成 */
-(void)doneAction{
    [self requestRegisterInfo];
}

/* 键盘回收 */
-(void)tapTouch{
    HidenKeybory;
}

/* 法律声明 */
-(void)lawBtnAction{
    DSLawViewController * lawVC = [[DSLawViewController alloc]init];
    lawVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lawVC animated:YES];
}
@end
