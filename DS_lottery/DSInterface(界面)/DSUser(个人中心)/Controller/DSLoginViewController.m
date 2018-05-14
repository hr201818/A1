//
//  DSLoginViewController.m
//  DS_lottery
//
//  Created by pro on 2018/4/23.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSLoginViewController.h"
#import "DSRegisterViewController.h"
#import "DSAdvertView.h"
#import "DSLawViewController.h"
@interface DSLoginViewController ()
/* 账号输入框 */
@property (strong, nonatomic) UITextField * accountField;
/* 密码输入框 */
@property (strong, nonatomic) UITextField * passwordField;

@end

@implementation DSLoginViewController


- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.passwordField.text = @"";
    self.accountField.text = @"";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";

    [self navLeftItem:[DSFuntionTool leftNavBackTarget:self Item:@selector(leftBackAction)]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTouch)];
    [self.view addGestureRecognizer:tap];
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn setTitle:@"注册" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBackAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 50, 30);
    [self navRightItem:rightBtn];

    //视图布局
    [self layoutView];

    //广告数据请求
    [self requestAdvert];
}

-(void)layoutView{
    /* 账号 */
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
    [accountIcon setImage:[UIImage imageNamed:@"userIcon"]];
    [self.view addSubview:accountIcon];
    [accountIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@(IOS_SiZESCALE(25)));
        make.left.equalTo(accountImg.mas_left).offset(IOS_SiZESCALE(15));
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
        make.top.equalTo(accountImg.mas_bottom).offset(10);
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


    /* 登录按钮 */
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn"] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordImg.mas_left);
        make.height.equalTo(@45);
        make.right.equalTo(passwordImg.mas_right);
        make.top.equalTo(self.passwordField.mas_bottom).offset(15);
    }];

    //忘记密码按钮
    UIButton * forgetPassword = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPassword setTitleColor:COLORFontblu forState:UIControlStateNormal];
    [forgetPassword setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPassword addTarget:self action:@selector(forgetPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    forgetPassword.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:forgetPassword];
    [forgetPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_centerX);
        make.top.equalTo(loginBtn.mas_bottom).offset(20);
        make.left.equalTo(@0);
        make.height.equalTo(@30);
    }];

    //注册用户按钮
    UIButton * registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitleColor:COLORFontblu forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(rightBackAction) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setTitle:@"注册用户" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.top.equalTo(loginBtn.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_centerX);
        make.height.equalTo(@30);
    }];

//    if ([DSUserInfoData initUserInfoData].lawModel!= nil &&[[DSUserInfoData initUserInfoData].lawModel.lawIsShow integerValue] == 1) {
//        UIButton * lawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [lawBtn setTitle:@"法律声明" forState:UIControlStateNormal];
//        [lawBtn addTarget:self action:@selector(lawBtnAction) forControlEvents:UIControlEventTouchUpInside];
//        [lawBtn setTitleColor:COLORFont121 forState:UIControlStateNormal];
//        lawBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//        [self.view addSubview:lawBtn];
//        [lawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.equalTo(@100);
//            make.height.equalTo(@40);
//            make.centerX.equalTo(@0);
//            make.top.equalTo(registerBtn.mas_bottom).offset(10);
//        }];
//
//    }
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
    if ([[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"24"] != nil) {
        DSAdvertView * advertView = [[DSAdvertView alloc]initWithFrame:CGRectMake(0, PhoneScreen_HEIGHT - 2 * IOS_SiZESCALE(147) - 10 - Tabbarbottom_HEIGHT, self.view.width, IOS_SiZESCALE(147))];
        advertView.model = [[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"24"];
        advertView.backgroundColor = backColor;
        [self.view addSubview:advertView];
        if ([[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"25"] == nil) {
            advertView.top = PhoneScreen_HEIGHT -  IOS_SiZESCALE(147) - Tabbarbottom_HEIGHT;
        }else{
            UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, PhoneScreen_HEIGHT -  IOS_SiZESCALE(147) - 10 - Tabbarbottom_HEIGHT, self.view.width, 10)];
            line.backgroundColor = backColor;
            [self.view addSubview:line];
        }
    }
    if([[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"25"] != nil){
        DSAdvertView * advertView = [[DSAdvertView alloc]initWithFrame:CGRectMake(0, PhoneScreen_HEIGHT -  IOS_SiZESCALE(147) - Tabbarbottom_HEIGHT, self.view.width, IOS_SiZESCALE(147))];
        advertView.model = [[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"25"];
        advertView.backgroundColor = backColor;
        [self.view addSubview:advertView];
    }
}


-(void)requestLoginInfo{
    /* 判断账号密码是否符合要求 */
    if(![DSFuntionTool isValidateMobile:self.accountField.text]){
        [self hudErrorText:@"手机格式不正确"];
        return;
    }
    if([DSFuntionTool isBlankString:self.accountField.text]){
        [self hudErrorText:@"账号不能为空"];
        return;
    }
    if([DSFuntionTool isBlankString:self.passwordField.text]){
        [self hudErrorText:@"密码不能为空"];
        return;
    }
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setObject:self.accountField.text forKey:@"account"];
    [dic setObject:self.passwordField.text forKey:@"password"];
    [dic setObject:[DSFuntionTool getIPAddress:NO] forKey:@"ip"];
     [dic setObject:@"4" forKey:@"loginType"];
    [dic setValue:CLIENTTYPE forKey:@"clientType"];
    [dic setValue:APPVERSION forKey:@"appVersion"];
    [dic setValue:COMPANYSHORTNAME forKey:@"companyShortName"];
    __weak typeof (self)weakSelf = self;
    [self showhud];
    [DSNetWorkRequest postConectWithS:LOGIN Parameter:dic Succeed:^(id result) {
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


#pragma mark - 点击事件

/* 返回 */
-(void)leftBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

/* 注册 */
-(void)rightBackAction{
    DSRegisterViewController * registerVC = [[DSRegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

/* 登录 */
-(void)loginBtnAction{
    [self requestLoginInfo];
}

/* 忘记密码 */
-(void)forgetPasswordAction{
    [self showMessagetext:@"请联系在线客服"];
}

/* 退出键盘 */
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
