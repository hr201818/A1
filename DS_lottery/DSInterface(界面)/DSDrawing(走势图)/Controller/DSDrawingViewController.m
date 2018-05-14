//
//  DSDrawingViewController.m
//  DS_lottery
//
//  Created by pro on 2018/4/8.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSDrawingViewController.h"
#import "sscReceptacleView.h"
#import "LuckyTwentyEightView.h"
#import "BJhappyView.h"
#import "LuckyLotteryView.h"
#import "LHlotteryView.h"
#import "SSQ_HQView.h"
#import "Header.h"
#import "DSLotteryListViewController.h"
#import "DSAdvertView.h"
#import "DSDrawingDaxiaoView.h"
#import "DSDrawingHeweiView.h"
#import "DSDrawingHezhiView.h"
#import "DSDrawingJiouView.h"
#import "DSChartModal.h"
@interface DSDrawingViewController ()
{
    NSArray *_headerArr;
    NSArray *_totalHeaderArr;
    NSArray *_temaHeaderArr;
    NSArray *_titleArray;
    BOOL isHidden[6];
}

@property (nonatomic,strong) NSMutableArray       * contentArr;     //号码表
@property (nonatomic,strong) NSMutableArray       * rightContentArr;//右边号码表
@property (nonatomic,copy)   NSString             * playGroupId;    //彩种ID
@property (nonatomic,strong) sscReceptacleView    * sscView;        //时时彩,快3
@property (nonatomic,strong) LuckyTwentyEightView * luckyTwentyEightView;//北京28
@property (nonatomic,strong) BJhappyView          * bjHappyView;
@property (nonatomic,strong) LuckyLotteryView     * chongqingView; // 重庆幸运农场
@property (nonatomic,strong) LHlotteryView        * lhLotteryView; // 六合彩
@property (nonatomic,strong) SSQ_HQView           * shuangSeQiuView;
@property (nonatomic,strong) DSAdvertView         * advertView; //广告


@end

@implementation DSDrawingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.playGroupId = @"1";
//    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
//    [dic setValue:@"80" forKey:@"pageSize"];
//    [dic setValue:@"1" forKey:@"pageIndex"];
//    [dic setValue:self.playGroupId forKey:@"playGroupId"];
//    [dic setValue:@"80" forKey:@"pageSize"];
//    [dic setValue:@"1" forKey:@"appVersion"];
//    [dic setValue:@"IOS" forKey:@"clientType"];
//    __weak typeof (self)weakSelf = self;
//    [self showhud];
//    [DSNetWorkRequest postConectWithS:GETHISTORY Parameter:dic Succeed:^(id result) {
//        __strong typeof (weakSelf)strongSelf = weakSelf;
//        [strongSelf hidehud];
//        if (SSUCCESS(result)) {
//            DSChartModal * model = [DSChartModal yy_modelWithJSON:result];
//            DSDrawingHezhiView * jiouView = [[DSDrawingHezhiView alloc]initWithFrame:CGRectMake(0, Navgationbar_HEIGHT, self.view.width, PhoneScreen_HEIGHT - Navgationbar_HEIGHT - Tabbar_HEIGHT)model:model lotteryID:self.playGroupId];
//            [self.view addSubview:jiouView];
//        }
//    } Failure:^(NSError *failure) {
//        __strong typeof (weakSelf)strongSelf = weakSelf;
//        [strongSelf hidehud];
//    }];


    _GroupId = @"1";

    _contentArr = [[NSMutableArray alloc]initWithCapacity:0];
    _rightContentArr = [[NSMutableArray alloc]initWithCapacity:0];

    self.title = @"重庆时时彩";
    if ([_GroupId isEqualToString:@""]) {
        self.navigationItem.title = @"重庆时时彩";
        self.playGroupId = @"1";
    }else{
        self.playGroupId = self.GroupId;
    }



    //导航栏右边的按钮
    UIView * rigthView = [[UIView alloc]init];
    rigthView.frame = CGRectMake(0, 0, 70, 30);
    [self navRightItem:rigthView];

    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(10, 0, 80, 30);
    [rightBtn setTitle:@"彩种" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rigthView addSubview:rightBtn];

    UIImageView * fenleiImg = [[UIImageView alloc]initWithFrame:CGRectMake(12, 6, 16.5, 16.5)];
    [fenleiImg setImage:[UIImage imageNamed:@"fenlei"]];
    [rigthView addSubview:fenleiImg];


    //网络请求
    [self requstDetail];

    /* 广告请求 */
    [self requestAdvert];
}


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
    if([[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"21"]!=nil){
        self.advertView = [[DSAdvertView alloc]initWithFrame:CGRectMake(0, PhoneScreen_HEIGHT - Tabbar_HEIGHT -  IOS_SiZESCALE(147), self.view.width, IOS_SiZESCALE(147))];
        self.advertView.model = [[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"21"];
        self.advertView.backgroundColor = backColor;
        self.advertView.closeBtn.hidden = NO;
        [self.view addSubview:self.advertView];
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGFloat tabH = Tabbar_HEIGHT;
    if (isHidden[4] == NO) {
        self.sscView.frame = CGRectMake(0, Navgationbar_HEIGHT, ScreenW, ScreenH-tabH - Navgationbar_HEIGHT);
    }else if (isHidden[2] == NO){
        self.luckyTwentyEightView.frame = CGRectMake(0, Navgationbar_HEIGHT, ScreenW, ScreenH-tabH- Navgationbar_HEIGHT);
    }else if (isHidden[0] == NO){
        self.bjHappyView.frame =  CGRectMake(0, Navgationbar_HEIGHT, ScreenW, ScreenH-tabH- Navgationbar_HEIGHT);
    }else if (isHidden[1] == NO){
        self.chongqingView.frame=  CGRectMake(0, Navgationbar_HEIGHT, ScreenW, ScreenH-tabH- Navgationbar_HEIGHT);
    }else if (isHidden[3] == NO){
        self.lhLotteryView.frame=  CGRectMake(0, Navgationbar_HEIGHT, ScreenW, ScreenH-tabH- Navgationbar_HEIGHT);
    }
}

-(void)setPlayGroupId:(NSString *)playGroupId {
    _playGroupId = playGroupId;
    [_contentArr removeAllObjects];
    [_rightContentArr removeAllObjects];
    if ([_playGroupId integerValue]==1||[_playGroupId integerValue]==2||[_playGroupId integerValue]==3||[_playGroupId integerValue]==13||[_playGroupId integerValue]==15||[_playGroupId integerValue]==16||[_playGroupId integerValue]==17||[_playGroupId integerValue]==4||[_playGroupId integerValue]==5||[_playGroupId integerValue]==24) {

        if ([_playGroupId integerValue]==4||[_playGroupId integerValue]==5) {
            _titleArray = @[@"百位",@"十位",@"个位"];
        }else{
            _titleArray = @[@"万位",@"千位",@"百位",@"十位",@"个位"];
        }

        if ([_playGroupId integerValue]==24) {
            for (NSInteger i = 1; i < 12; i++) {
                [_contentArr addObject:@(i)];
            }
        }else{
            for (NSInteger i = 0; i < 10; i++) {
                [_contentArr addObject:@(i)];
            }
        }

    }else if ([_playGroupId integerValue]==9||[_playGroupId integerValue]==14||[_playGroupId integerValue]==23){
        _titleArray =@[@"冠军",@"亚军",@"第三名",@"第四名",@"第五名",@"第六名",@"第七名",@"第八名",@"第九名",@"第十名"];
        for (NSInteger i = 1; i < 11; i++) {
            [_contentArr addObject:@(i)];
        }
    }else if ([_playGroupId integerValue]==18||[_playGroupId integerValue]==19||[_playGroupId integerValue]==20||[_playGroupId integerValue]==21){

        _titleArray = @[@"百位",@"十位",@"个位"];
        for (NSInteger i = 1; i < 7; i++) {
            [_contentArr addObject:@(i)];
        }
    }else{
        if ([_playGroupId integerValue]==10||[_playGroupId integerValue]==11) {
            //重庆幸运农场、广东快乐十分
            for (NSInteger i = 1; i < 11; i++) {
                [_contentArr addObject:@(i)];
            }
            for (NSInteger i = 11; i < 21; i++) {
                [_rightContentArr addObject:@(i)];
            }

        }else if ([_playGroupId integerValue]==12){
            //双色球
            for (NSInteger i = 1; i < 34; i++) {
                [_contentArr addObject:@(i)];
            }
            for (NSInteger i = 1; i < 17; i++) {
                [_rightContentArr addObject:@(i)];
            }

        }
        else if ([_playGroupId integerValue]==7){
            //幸运28
            for (NSInteger i = 0; i < 10; i++) {
                [_contentArr addObject:@(i)];
            }
            for (NSInteger i = 1; i < 28; i++) {
                [_rightContentArr addObject:@(i)];
            }
        }else if ([_playGroupId integerValue]==8){
            //北京快乐8
            for (NSInteger i = 1; i < 81; i++) {
                [_contentArr addObject:@(i)];
            }
        }else if ([_playGroupId integerValue]==6){
            //六合彩
            _headerArr =@[@"正码一",@"正码二",@"正码三",@"正码四",@"正码五",@"正码六",@"特码"];
            _totalHeaderArr =@[@"总数",@"总双",@"大小",@"七色波"];
            _temaHeaderArr =@[@"单双",@"大小",@"合单双",@"合大小",@"大小尾"];
        }
    }


    for (NSInteger i = 0; i < 6; i++) {
        isHidden[i]=YES;
    }

    if ([_playGroupId integerValue]==8) {

        [self.view addSubview:self.bjHappyView];

        isHidden[0] = NO;
        _chongqingView.hidden = YES;
        _lhLotteryView.hidden = YES;
        _luckyTwentyEightView.hidden = YES;
        _sscView.hidden = YES;
        _bjHappyView.hidden = NO;
        _shuangSeQiuView.hidden = YES;
    }else if ([_playGroupId integerValue]==10||[_playGroupId integerValue]==11){


        [self.view addSubview:self.chongqingView];

        _chongqingView.playGroupId = _playGroupId;
        isHidden[1] = NO;
        _bjHappyView.hidden = YES;
        _lhLotteryView.hidden = YES;
        _luckyTwentyEightView.hidden = YES;
        _sscView.hidden = YES;
        _chongqingView.hidden = NO;
        _shuangSeQiuView.hidden = YES;
    }else if ([_playGroupId integerValue]==7){

        [self.view addSubview:self.luckyTwentyEightView];

        isHidden[2] = NO;
        _bjHappyView.hidden = YES;
        _chongqingView.hidden = YES;
        _lhLotteryView.hidden = YES;
        _sscView.hidden = YES;
        _luckyTwentyEightView.hidden = NO;
        _shuangSeQiuView.hidden = YES;
    }else if ([_playGroupId integerValue]==6){

        [self.view addSubview:self.lhLotteryView];

        isHidden[3] = NO;
        _bjHappyView.hidden = YES;
        _chongqingView.hidden = YES;
        _luckyTwentyEightView.hidden = YES;
        _sscView.hidden = YES;
        _lhLotteryView.hidden = NO;
        _shuangSeQiuView.hidden = YES;

    }else if ([_playGroupId integerValue]==12){

        [self.view addSubview:self.shuangSeQiuView];

        isHidden[5] = NO;
        _bjHappyView.hidden = YES;
        _chongqingView.hidden = YES;
        _luckyTwentyEightView.hidden = YES;
        _sscView.hidden = YES;
        _lhLotteryView.hidden = YES;
        _shuangSeQiuView.hidden = NO;
    } else{

        [self.view addSubview:self.sscView];
        _sscView.playGroupId = _playGroupId;
        _sscView.titleArray = _titleArray;
        _sscView.contentArr = _contentArr;
        isHidden[4] = NO;
        _sscView.hidden = NO;
        _bjHappyView.hidden = YES;
        _chongqingView.hidden = YES;
        _lhLotteryView.hidden = YES;
        _luckyTwentyEightView.hidden = YES;
        _shuangSeQiuView.hidden = YES;
    }
    [self.view bringSubviewToFront:self.advertView];
}

-(void)movementsParsing:(NSDictionary *)responseObject{

    if (isHidden[4] == NO) {
        [self.sscView movementsParsing:responseObject];
    }else if (isHidden[2] == NO){
        [self.luckyTwentyEightView movementsParsing:responseObject];
    }else if (isHidden[0] == NO){
        [self.bjHappyView movementsParsing:responseObject];
    }else if (isHidden[1] == NO){
        [self.chongqingView movementsParsing:responseObject];
    }else if (isHidden[3] == NO){
        [self.lhLotteryView movementsParsing:responseObject];
    }else if (isHidden[5] == NO){
        [self.shuangSeQiuView movementsParsing:responseObject];
    }
    [self.view bringSubviewToFront:self.advertView];
}
-(void)relodaTableView{
    if (isHidden[4] == NO) {
        [self.sscView.myTableView reloadData];
        [self.sscView.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }else if (isHidden[2] == NO){
        // 幸运28
        [self.luckyTwentyEightView reloadTableView];
    }else if (isHidden[0] == NO){
        // 北京快乐8
        [self.bjHappyView reloadTableView];
    }else if (isHidden[1] == NO){
        [self.chongqingView reloadTableView];
    }else if (isHidden[3] == NO){
        [self.lhLotteryView reloadTableView];
    }else if (isHidden[5] == NO){
        [self.shuangSeQiuView reloadTableView];
    }
    [self.view bringSubviewToFront:self.advertView];
}
-(void)digitalAndNperTag{
    if (isHidden[4] == NO) {
        self.sscView.nperTag=0;
        self.sscView.digital = @"0";
    }else if (isHidden[2] == NO){
        self.luckyTwentyEightView.nperTag=0;
    }else if (isHidden[0] == NO){
        self.bjHappyView.nperTag=0;
    }else if (isHidden[1] == NO){
        self.chongqingView.nperTag=0;
    }else if (isHidden[3] == NO){
        self.lhLotteryView.nperTag=0;
    }else if (isHidden[5] == NO){
        self.shuangSeQiuView.nperTag=0;
    }
}
#pragma mark - 请求
-(void)requstDetail{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@"80" forKey:@"pageSize"];
    [dic setValue:@"1" forKey:@"pageIndex"];
    [dic setValue:self.playGroupId forKey:@"playGroupId"];
    [dic setValue:@"80" forKey:@"pageSize"];
    [dic setValue:@"1" forKey:@"appVersion"];
    [dic setValue:@"IOS" forKey:@"clientType"];
    __weak typeof (self)weakSelf = self;
    [self showhud];
    [DSNetWorkRequest postConectWithS:GETHISTORY Parameter:dic Succeed:^(id result) {
        __strong typeof (weakSelf)strongSelf = weakSelf;
        [strongSelf hidehud];
        if (SSUCCESS(result)) {
                [strongSelf movementsParsing:result];
                [strongSelf relodaTableView];
        }
    } Failure:^(NSError *failure) {
         __strong typeof (weakSelf)strongSelf = weakSelf;
        [strongSelf hidehud];
    }];
}

#pragma  mark - 加载各种彩种的View
-(sscReceptacleView *)sscView{
    if (!_sscView) {
        _sscView =[[sscReceptacleView alloc]initWithFrame:CGRectMake(0, Navgationbar_HEIGHT, ScreenW, PhoneScreen_HEIGHT - Tabbar_HEIGHT -Navgationbar_HEIGHT)];

        _sscView.playGroupId = self.GroupId;
        _sscView.titleArray = _titleArray;
        _sscView.contentArr = _contentArr;
    }
    return _sscView;
}
-(LuckyTwentyEightView *)luckyTwentyEightView{
    if (!_luckyTwentyEightView) {
        _luckyTwentyEightView =[[LuckyTwentyEightView alloc]initWithFrame:CGRectMake(0, Navgationbar_HEIGHT, ScreenW, ScreenH-kViewTop-([tool isBlankString:_GroupId]==YES ? SysTabBarHeight:0)) playGroupId:_playGroupId contentArr:_contentArr rightContentArr:_rightContentArr];
    }
    return _luckyTwentyEightView;
}
-(BJhappyView *)bjHappyView{
    // 北京快乐8
    if (!_bjHappyView) {
        _bjHappyView =[[BJhappyView alloc]initWithFrame:CGRectMake(0, Navgationbar_HEIGHT, ScreenW, ScreenH-kViewTop-([tool isBlankString:_GroupId]==YES ? SysTabBarHeight:0)) playGroupId:_playGroupId contentArr:_contentArr];
    }
    return _bjHappyView;
}
-(LuckyLotteryView *)chongqingView{
    // 重庆幸运农场
    if (!_chongqingView) {
        _chongqingView =[[LuckyLotteryView alloc]initWithFrame:CGRectMake(0, Navgationbar_HEIGHT, ScreenW, ScreenH-kViewTop-([tool isBlankString:_GroupId]==YES ? SysTabBarHeight:0)) playGroupId:_playGroupId contentArr:_contentArr rightContentArr:_rightContentArr];

    }
    return _chongqingView;
}
-(LHlotteryView *)lhLotteryView{
    if (!_lhLotteryView) {
        _lhLotteryView =[[LHlotteryView alloc]initWithFrame:CGRectMake(0, Navgationbar_HEIGHT, ScreenW, ScreenH-kViewTop-([tool isBlankString:_GroupId]==YES ? SysTabBarHeight:0)) playGroupId:_playGroupId headerArr:_headerArr totalHeaderArr:_totalHeaderArr temaHeaderArr:_temaHeaderArr];

    }
    return _lhLotteryView;
}
-(SSQ_HQView *)shuangSeQiuView{
    if (!_shuangSeQiuView) {
        _shuangSeQiuView = [[SSQ_HQView alloc]initWithFrame:CGRectMake(0, Navgationbar_HEIGHT, ScreenW, ScreenH-kViewTop-([tool isBlankString:_GroupId]==YES ? SysTabBarHeight:0)) playGroupId:_playGroupId contentArr:_contentArr rightContentArr:_rightContentArr];
    }
    return _shuangSeQiuView;
}

-(void)rightBtnAction{
    __weak typeof (self) weakSelf = self;
    DSLotteryListViewController * lottery = [[DSLotteryListViewController alloc]init];
    lottery.lotteryIDBlock = ^(NSString *typeId,NSString * titleName) {
        weakSelf.playGroupId = typeId;
        weakSelf.title = titleName;
        [weakSelf digitalAndNperTag];
        [weakSelf requstDetail];
    };
    lottery.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lottery animated:YES];
}

@end
