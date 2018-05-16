//
//  DSHomeViewController.m
//  DS_lottery
//
//  Created by pro on 2018/4/7.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSHomeViewController.h"
#import "DSOpenAwardViewController.h"
#import "DSRegisterModel.h"
#import "DSHomeBannerListModel.h"
#import "DSLotteryTableViewCell.h"
#import "DSHomeMessageListModel.h"
#import "DSAdvertTableViewCell.h"
#import "DSHomeMessageTableViewCell.h"
#import "DSLoginViewController.h"
#import "DSInformationdDetailsViewController.h"
#import "DSHomeTopFuntionView.h"
#import "DSHomeLotteryTableViewCell.h"
#import "DSHomeLotteryAllTableViewCell.h"
#import "DSOpenAwardListModel.h"
@interface DSHomeViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

/* 首页列表 */
@property (strong, nonatomic) UITableView            * tableView;
/* 注册登录按钮 */
@property (strong, nonatomic) UIView                 * rigthView;
@property (strong, nonatomic) UIButton               * rightBtn;
@property (strong, nonatomic) UIImageView            * userImg;
/* 轮播图 */
@property (strong, nonatomic) SDCycleScrollView      * cycleScrollView;
/* 公告栏 */
@property (strong, nonatomic) SDCycleScrollView      * noticeScrollView;
/* 首页资讯 */
@property (strong, nonatomic) DSHomeMessageListModel * messageListModel;
/* 彩种数组 */
@property (strong, nonatomic) NSMutableArray         * listModel;
/* 页码 */
@property (assign, nonatomic) NSInteger                page;

@property (strong, nonatomic) UIView                 * tableViewHeader;
@property (strong, nonatomic) DSHomeTopFuntionView   * topView;
@property (strong, nonatomic) UIImageView            * labaImage;
@property (strong, nonatomic) UIView                 * noticeView;

@end

@implementation DSHomeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _listModel = [[NSMutableArray alloc]init];
        _page = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //布局视图
    [self layoutView];
    //请求轮播图
    [self requestBanner];
    //请求公告栏信息
    [self requestNotice];
    //登录注销接收通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginNotication) name:LOGIN_NOTICATION object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(signOutNotication) name:SIGNOUT object:nil];
    //开奖了，刷新首页信息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestBanner) name:HOMEUPDATE object:nil];

}

#pragma mark - 网络请求
/* 请求轮播图和广告 */
-(void)requestBanner{
     __weak typeof (self)weakSelf = self;
    [[DSAdvertSingleData initAdvertData] requestDataSucceed:^(DSHomeBannerListModel *result) {
        /* 轮播图赋值 */
        [weakSelf bannerDataLoad];
        //首页的列表信息
        [weakSelf requestListData];
    } Failure:^{
        //首页的列表信息
        [weakSelf requestListData];
    }];
    //获取彩种倒计时
    [[DSAdvertSingleData initAdvertData] beginTimer];
}

/* 轮播图赋值 */
-(void)bannerDataLoad{
    NSMutableArray * imgArr = [[NSMutableArray alloc]init];
    [[DSAdvertSingleData initAdvertData].model.bannerList enumerateObjectsUsingBlock:^(DSHomeBannerModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        [imgArr addObject:model.imageUrl];
    }];
    self.cycleScrollView.imageURLStringsGroup = imgArr;

    //如果没有轮播图，隐藏掉
    if([DSAdvertSingleData initAdvertData].model.bannerList.count == 0){
        self.tableViewHeader.height = IOS_SiZESCALE(30) + IOS_SiZESCALE(127) + 6;
        self.cycleScrollView.hidden = YES;
        self.noticeScrollView.top = 0;
        self.labaImage.top = IOS_SiZESCALE(8);
        self.topView.top = IOS_SiZESCALE(30)+6;
    }else{
        self.tableViewHeader.height = IOS_SiZESCALE(160) + IOS_SiZESCALE(127) + 6;
        self.cycleScrollView.hidden = NO;
        self.noticeScrollView.top = IOS_SiZESCALE(130);
        self.labaImage.top = IOS_SiZESCALE(138);
        self.topView.top = IOS_SiZESCALE(160)+6;
    }


    if([[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"1"]!= nil){
        //导航栏左边的按钮 
        UIView * leftView = [[UIView alloc]init];
        leftView.frame = CGRectMake(15, 0, 70, 30);
        [self navLeftItem:leftView];
        UIImageView * leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 20, 20)];
        [leftImg setImage:[UIImage imageNamed:@"ico-index"]];
        [leftView addSubview:leftImg];
        DSHomeBannerModel * bannerM =[[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"1"];
        UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn setTitle:bannerM.advertisTitle forState:UIControlStateNormal];
        leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
        leftBtn.frame = CGRectMake(22, 0, 100, 30);
        [leftView addSubview:leftBtn];
    }
}

/* 请求首页的列表信息 */
-(void)requestListData{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:CLIENTTYPE forKey:@"clientType"];
    [dic setValue:APPVERSION forKey:@"version"];
    [dic setValue:COMPANYSHORTNAME forKey:@"companyShortName"];
    __weak typeof (self)weakSelf = self;
    [DSNetWorkRequest postConectWithS:GETALLSSCDATA Parameter:dic Succeed:^(id result) {
        __strong typeof (weakSelf)strongSelf = weakSelf;
        [strongSelf.tableView.mj_header endRefreshing];
        if (SSUCCESS(result)) {
            [strongSelf ListData:result];
        }
    } Failure:^(NSError *failure) {
         __strong typeof (weakSelf)strongSelf = weakSelf;
        [strongSelf.tableView.mj_header endRefreshing];
    }];
}
/* 首页列表信息赋值 */
-(void)ListData:(id)result{
    [self.listModel removeAllObjects];
    DSOpenAwardListModel * model = [DSOpenAwardListModel yy_modelWithJSON:result];
    NSArray * adarr = [NSArray arrayWithObjects:@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16", nil];
    NSMutableArray * advModelArr = [[NSMutableArray alloc]init];
    for (NSString * ad_id in adarr) {
        if([[DSAdvertSingleData initAdvertData]searchAdvertLocationID:ad_id]!=nil){
            [advModelArr addObject:[[DSAdvertSingleData initAdvertData]searchAdvertLocationID:ad_id]];
        }
    }
    for (int i = 0; i < model.resultList.count; i++) {
        if(advModelArr.count > i){
            [self.listModel addObject:advModelArr[i]];
            [self.listModel addObject:model.resultList[i]];
        }else{
            [self.listModel addObject:model.resultList[i]];
        }
        if(i == model.resultList.count - 1 && i <  advModelArr.count - 1 && advModelArr.count>0){
            [self.listModel addObject:[advModelArr lastObject]];
        }
    }
    //底部加一个广告
    if([[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"31"]!= nil){
        UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, IOS_SiZESCALE(147) + 6)];
        footView.backgroundColor = backColor;
        DSAdvertView * advertView = [[DSAdvertView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 147)];
        advertView.backgroundColor = backColor;
        advertView.model = [[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"31"];
        [footView addSubview:advertView];
        self.tableView.tableHeaderView = footView;
    }
    [self.tableView reloadData];
}

///* 请求首页资讯 */
//-(void)requestHomeMessage{
//    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
//    [dic setValue:CLIENTTYPE forKey:@"clientType"];
//    [dic setValue:APPVERSION forKey:@"appVersion"];
//    [dic setValue:COMPANYSHORTNAME forKey:@"companyShortName"];
//    [dic setValue:[NSString stringWithFormat:@"%ld",self.page] forKey:@"offset"];
//     __weak typeof (self)weakSelf = self;
//    [DSNetWorkRequest postConectWithS:GETAPPNEWS Parameter:dic Succeed:^(id result) {
//        __strong typeof (weakSelf)strongSelf = weakSelf;
//        if (SSUCCESS(result)) {
//            strongSelf.messageListModel = [DSHomeMessageListModel yy_modelWithJSON:result];
//           [strongSelf.tableView reloadData];
//        }
//    } Failure:^(NSError *failure) {
//
//    }];
//}

/* 公告栏信息 */
-(void)requestNotice{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:CLIENTTYPE forKey:@"clientType"];
    [dic setValue:APPVERSION forKey:@"appVersion"];
    [dic setValue:COMPANYSHORTNAME forKey:@"companyShortName"];
    __weak typeof (self)weakSelf = self;
    [DSNetWorkRequest postConectWithS:NOTICI Parameter:dic Succeed:^(id result) {
        __strong typeof (weakSelf)strongSelf = weakSelf;
        if (SSUCCESS(result)) {
            NSMutableArray * array = [[NSMutableArray alloc]init];
            for (NSDictionary * dicc in [result objectForKey:@"noticeList"]) {
                [array addObject:[NSString stringWithFormat:@"        %@",[dicc objectForKey:@"content"]]];
            }
            strongSelf.noticeScrollView.titlesGroup = array;
        }
    } Failure:^(NSError *failure) {

    }];
}

/* 退出登录 */
-(void)requestWriteOff{
    if([DSUserInfoData initUserInfoData].token){
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setObject:[DSUserInfoData initUserInfoData].token forKey:@"token"];
        [dic setObject:[DSUserInfoData initUserInfoData].userId forKey:@"uid"];
        [DSNetWorkRequest postConectWithS:SIGOUT Parameter:dic Succeed:^(id result) {
            if (SSUCCESS(result)) {
                [[DSUserInfoData initUserInfoData]signOutSucceed];
            }else if( [[result objectForKey:@"result"]integerValue] == 108){
                [[DSUserInfoData initUserInfoData]signOutSucceed];
            }
        } Failure:^(NSError *failure) {

        }];
    }else{
        [[DSUserInfoData initUserInfoData]signOutSucceed];
    }
}

/* 布局视图 */
-(void)layoutView{

    self.view.backgroundColor = backColor;
    //标题
    UIImageView * titleImg = [[UIImageView alloc]init];
    [titleImg setImage:[UIImage imageNamed:@"ico-ssclogo"]];
    [self.navBar addSubview:titleImg];
    [titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@115);
        make.height.equalTo(@30);
        make.centerX.equalTo(@0);
        make.bottom.equalTo(@(-8));
    }];

    //导航栏右边的按钮
    self.rigthView = [[UIView alloc]init];
    self.rigthView.frame = CGRectMake(0, 0, 70, 30);
    [self navRightItem:self.rigthView];
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.rightBtn addTarget:self action:@selector(rigthBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn.frame = CGRectMake(-2, 0, 70, 30);
    [self.rigthView addSubview:self.rightBtn];

    self.userImg = [[UIImageView alloc]initWithFrame:CGRectMake(12, 5, 20, 20)];
    [self.userImg setImage:[UIImage imageNamed:@"userLogin"]];
    [self.rigthView addSubview:self.userImg];
    if([DSUserInfoData initUserInfoData].userId){
        [self.rightBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        self.userImg.hidden = YES;
    }

    //首页列表
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Navgationbar_HEIGHT, PhoneScreen_WIDTH, PhoneScreen_HEIGHT - Navgationbar_HEIGHT - Tabbar_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor =[UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.tableView];

    self.tableViewHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, IOS_SiZESCALE(160) + IOS_SiZESCALE(127) + 6)];
    self.tableViewHeader.backgroundColor = backColor;
    self.tableView.tableHeaderView = self.tableViewHeader;
    //刷新
    __weak typeof (self)weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestBanner];
    }];
    //轮播图滚动
    self.cycleScrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, IOS_SiZESCALE(130))];
    self.cycleScrollView.delegate = self;
    self.cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"hs2"];
    self.cycleScrollView.pageDotImage = [UIImage imageNamed:@"baise"];
    self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self.tableViewHeader addSubview:self.cycleScrollView];
    self.cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    self.noticeView = [[UIView alloc]initWithFrame:CGRectMake(0, IOS_SiZESCALE(130), self.view.width, IOS_SiZESCALE(30))];
    self.noticeView.backgroundColor = [UIColor whiteColor];
    [self.tableViewHeader addSubview:self.noticeView];



    //公告栏
    self.noticeScrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, IOS_SiZESCALE(130), self.view.width, IOS_SiZESCALE(30))];
    [self.tableViewHeader addSubview:self.noticeScrollView];
    self.noticeScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.noticeScrollView.onlyDisplayText = YES;
    [self.noticeScrollView disableScrollGesture];
    self.noticeScrollView.userInteractionEnabled = NO;
    self.noticeScrollView.titleLabelTextFont = [UIFont systemFontOfSize:13 * fontsize];
    self.noticeScrollView.titleLabelBackgroundColor = [UIColor whiteColor];
    self.noticeScrollView.titleLabelTextColor = COLORFont83;

    //喇叭
    self.labaImage = [[UIImageView alloc]initWithFrame:CGRectMake(10,IOS_SiZESCALE(138), IOS_SiZESCALE(16), IOS_SiZESCALE(15))];
    [self.labaImage setImage:[UIImage imageNamed:@"laba"]];
    [self.tableViewHeader addSubview:self.labaImage];

    //功能列表
    self.topView = [[DSHomeTopFuntionView alloc]initWithFrame:CGRectMake(0,IOS_SiZESCALE(160)+6 , self.view.width, IOS_SiZESCALE(127))];
    [self.tableViewHeader addSubview:self.topView];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    DSHomeBannerModel * model = [DSAdvertSingleData initAdvertData].model.bannerList[index];
    [DSFuntionTool openUrl:model.advertisUrl];

}

#pragma mark - 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if([self.listModel[indexPath.row] isKindOfClass:[DSHomeBannerModel class]]){
        static NSString *cellStr = @"advertCell1";
        DSAdvertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell ==nil) {
            cell = [[DSAdvertTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        cell.model = self.listModel[indexPath.row];
        return cell;
    }else{
         DSOpenAwardModel * model = self.listModel[indexPath.row];
        if([model.playGroupId isEqualToString:@"1"]||[model.playGroupId isEqualToString:@"2"]){
            static NSString *cellStr = @"cell";
            DSHomeLotteryAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
            if (cell ==nil) {
                cell = [[DSHomeLotteryAllTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
            }
            cell.model = self.listModel[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            static NSString *cellStr = @"cell1";
            DSHomeLotteryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
            if (cell ==nil) {
                cell = [[DSHomeLotteryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
            }
            cell.model = self.listModel[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.listModel[indexPath.row] isKindOfClass:[DSHomeBannerModel class]]){
        return IOS_SiZESCALE(147)+6;
    }else{
        DSOpenAwardModel * model = self.listModel[indexPath.row]; //重庆，天津时时彩
        if([model.playGroupId isEqualToString:@"1"]||[model.playGroupId isEqualToString:@"2"]){
//            return 130 + IOS_SiZESCALE(25) + IOS_SiZESCALE(41) + 15;
             return 130 + IOS_SiZESCALE(25);
        }
        else{ //北京快乐8
            if([model.playGroupId isEqualToString:@"8"]){
                return 130 + IOS_SiZESCALE(55);
            }
        }
        return 130 + IOS_SiZESCALE(25);
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//        // 根据获取的platformType确定所选平台进行下一步操作
//    }];
}



#pragma mark - 点击事件

/* 进入购彩 */
-(void)leftBtnAction{
    DSHomeBannerModel * model = [[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"1"];
    NSLog(@"%@",model.advertisUrl);
    [DSFuntionTool openUrl:model.advertisUrl];
}

/* 注册登录 */
-(void)rigthBtnAction{
    if([self.rightBtn.titleLabel.text isEqualToString:@"退出登录"]){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出登录吗?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self requestWriteOff];
        }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }];
        [alert addAction:defaultAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        DSLoginViewController * login = [[DSLoginViewController alloc]init];
        login.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:login animated:YES];
    }
}

/* 登录接收通知 */
-(void)loginNotication{
    self.userImg.hidden = YES;
    [self.rightBtn setTitle:@"退出登录" forState:UIControlStateNormal];
}
/* 注销后通知接收 */
-(void)signOutNotication{
     self.userImg.hidden = NO;
    [self.rightBtn setTitle:@"登录" forState:UIControlStateNormal];
}
@end
