//
//  DSKefuViewController.m
//  DS_lottery
//
//  Created by pro on 2018/4/25.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSKefuViewController.h"

@interface DSKefuViewController ()

@property (strong, nonatomic) UIWebView * webView;

@end

@implementation DSKefuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"在线客服";
    [self navLeftItem:[DSFuntionTool leftNavBackTarget:self Item:@selector(leftBackAction)]];
    //视图布局
    [self layoutView];
    //网络请求
    [self requestURL];
}

-(void)layoutView{
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, Navgationbar_HEIGHT, PhoneScreen_WIDTH, PhoneScreen_HEIGHT - Navgationbar_HEIGHT - Tabbarbottom_HEIGHT)];
    self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];
}

#pragma mark - 网络请求
-(void)requestURL{
    __weak typeof (self)weakSelf = self;
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:CLIENTTYPE forKey:@"clientType"];
    [dic setValue:APPVERSION forKey:@"appVersion"];
    [dic setValue:COMPANYSHORTNAME forKey:@"companyShortName"];
    [DSNetWorkRequest postConectWithS:GETKEFU Parameter:dic Succeed:^(id result) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        if (SSUCCESS(result)) {
            [strongSelf.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:result[@"kefuUrl"]]]];
        }
    } Failure:^(NSError *failure) {

    }];
}

#pragma mark - 点击事件
-(void)leftBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
