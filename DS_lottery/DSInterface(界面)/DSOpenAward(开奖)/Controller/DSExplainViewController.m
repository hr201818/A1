//
//  DSExplainViewController.m
//  DS_lottery
//
//  Created by pro on 2018/4/26.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSExplainViewController.h"
#import "DSLotteryListViewController.h"
#import "DSGameRuleModel.h"
@interface DSExplainViewController ()
//<SGPageTitleViewDelegate, SGPageContentViewDelegate>
@property (strong, nonatomic) UITableView     * tableView;
@property (strong, nonatomic) SGPageTitleView * pageTitleView;
@property (strong, nonatomic) NSArray         * titleArr;
@property (strong, nonatomic) UILabel         * content;
@property (strong, nonatomic) UIScrollView    * scrollView;
@property (strong, nonatomic) DSGameRuleModel * model;
@property (strong, nonatomic) UIWebView    * webView;
@end

@implementation DSExplainViewController

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"玩法说明";



    [self navLeftItem:[DSFuntionTool leftNavBackTarget:self Item:@selector(leftBackAction)]];

    //布局
    [self layoutView];

    //网络请求
    [self requestData];
}

-(void)layoutView{
    //导航栏右边的按钮
    UIView * rigthView = [[UIView alloc]init];
    rigthView.frame = CGRectMake(0, 0, 100, 30);
    [self navRightItem:rigthView];

    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(25, 0, 80, 30);
    [rightBtn setTitle:@"彩种介绍" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rigthView addSubview:rightBtn];

    UIImageView * fenleiImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 6, 16.5, 16.5)];
    [fenleiImg setImage:[UIImage imageNamed:@"fenlei"]];
    [rigthView addSubview:fenleiImg];


    //选项条
//    self.titleArr = @[@"玩法规则", @"玩法介绍", @"奖项规则"];
//    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
//    configure.bottomSeparatorColor = [UIColor clearColor];
//    configure.titleFont = [UIFont systemFontOfSize:14];
//    configure.titleColor = COLORFont83;
//    configure.titleSelectedColor = COLOR_HOME;
//    configure.indicatorColor = COLOR_HOME;
//    configure.indicatorAnimationTime = 0.1;
//    configure.indicatorAdditionalWidth = 150;
//    configure.titleSelectedFont = [UIFont systemFontOfSize:15];
//    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, Navgationbar_HEIGHT, self.view.width, 45) delegate:self titleNames:self.titleArr configure:configure];
//    [self.view addSubview:self.pageTitleView];

//    UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake(self.view.width/3, 12.5, 1, 20)];
//    line1.backgroundColor = COLORLine;
//    [self.pageTitleView addSubview:line1];
//
//    UIView * line2 = [[UIView alloc]initWithFrame:CGRectMake(self.view.width/3 * 2, 12.5, 1, 20)];
//    line2.backgroundColor = COLORLine;
//    [self.pageTitleView addSubview:line2];
//
//    UIView * line3 = [[UIView alloc]initWithFrame:CGRectMake(0, 44.5, self.view.width, 0.5)];
//    line3.backgroundColor = COLORLine;
//    [self.pageTitleView addSubview:line3];


//    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Navgationbar_HEIGHT, self.view.width, PhoneScreen_HEIGHT - Navgationbar_HEIGHT - Tabbarbottom_HEIGHT)];
//    [self.view addSubview:self.scrollView];
//
//    self.content = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, self.view.width - 25, 1000)];
//    self.content.textColor = COLORFont83;
//    self.content.numberOfLines = 0;
//    self.content.font = [UIFont systemFontOfSize:15];
//    [self.scrollView addSubview:self.content];
//    [self.content sizeToFit];
//    self.scrollView.contentSize = CGSizeMake(0, self.content.height + 20);

    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, Navgationbar_HEIGHT, PhoneScreen_WIDTH, PhoneScreen_HEIGHT - Navgationbar_HEIGHT - Tabbarbottom_HEIGHT)];
//    self.webView.delegate = self;
//    self.webView.scalesPageToFit = YES;
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.scrollView.backgroundColor = [UIColor whiteColor];
//    self.webView.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.webView];
//    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - 网络请求
-(void)requestData{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:CLIENTTYPE forKey:@"clientType"];
    [dic setValue:APPVERSION forKey:@"appVersion"];
    [dic setValue:COMPANYSHORTNAME forKey:@"companyShortName"];
    [dic setValue:self.playGroupId forKey:@"playGroupId"];
    __weak typeof (self)weakSelf = self;
    [self showhud];
    [DSNetWorkRequest postConectWithS:WEBSETTING Parameter:dic Succeed:^(id result) {
        __strong typeof (weakSelf)strongSelf = weakSelf;
        [strongSelf hidehud];
        if (SSUCCESS(result)) {
            strongSelf.model = [DSGameRuleModel yy_modelWithJSON:result];
            [strongSelf.webView loadHTMLString:strongSelf.model.gameInstruction baseURL:nil];
//            strongSelf.content.frame = CGRectMake(15, 20, strongSelf.view.width - 25, 1000);
//            strongSelf.content.text = strongSelf.model.gameInstruction;
//            [strongSelf.content sizeToFit];
//            strongSelf.scrollView.contentSize = CGSizeMake(0, strongSelf.content.height + 20);
        }
    } Failure:^(NSError *failure) {
        __strong typeof (weakSelf)strongSelf = weakSelf;
        [strongSelf hidehud];
    }];
}


#pragma mark - 代理
//- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
//    self.content.frame = CGRectMake(15, 10, self.view.width - 25, 1000);
//    if(selectedIndex == 0){
//        self.content.text = self.model.gameRule;
//    }else if(selectedIndex ==1){
//        self.content.text = self.model.gameInstruction;
//    }else{
//        self.content.text = self.model.rewardsRule;
//    }
//    [self.content sizeToFit];
//    self.scrollView.contentSize = CGSizeMake(0, self.content.height + 20);
//}

#pragma mark - 点击事件

-(void)leftBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnAction{
    __weak typeof (self) weakSelf = self;
    DSLotteryListViewController * lottery = [[DSLotteryListViewController alloc]init];
    lottery.lotteryIDBlock = ^(NSString *typeId,NSString * titleName) {
        weakSelf.playGroupId = typeId;
        [weakSelf requestData];
    };
    [self.navigationController pushViewController:lottery animated:YES];
}

@end
