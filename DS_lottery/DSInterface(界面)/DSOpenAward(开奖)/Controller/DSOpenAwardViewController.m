//
//  DSOpenAwardViewController.m
//  DS_lottery
//
//  Created by pro on 2018/4/8.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSOpenAwardViewController.h"
#import "DSOpenAwardListModel.h"
#import "DSOpenAwardTableViewCell.h"
#import "DSOpenAdvertTableViewCell.h"
#import "DSOpenAwardDetailsViewController.h"
#import "DSAdvertView.h"

@interface DSOpenAwardViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView          * tableView;

/* 包含了广告和开奖公告的模型 */
@property (strong, nonatomic) NSMutableArray       * modelList;

@end

@implementation DSOpenAwardViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _modelList = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = backColor;
    self.title = @"开奖公告";

    /* 布局视图*/
    [self layoutView];

    /* 开奖公告请求 */
    [self requestOpenLotteryList];

}

/* 布局视图 */
-(void)layoutView{
    //首页列表
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Navgationbar_HEIGHT, PhoneScreen_WIDTH, PhoneScreen_HEIGHT - Navgationbar_HEIGHT - Tabbar_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //刷新
    __weak typeof (self)weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestOpenLotteryList];
    }];
}

#pragma mark - 网络请求
/*开奖公告请求*/
-(void)requestOpenLotteryList{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:CLIENTTYPE forKey:@"clientType"];
    [dic setValue:APPVERSION forKey:@"version"];
    [dic setValue:COMPANYSHORTNAME forKey:@"companyShortName"];
    __weak typeof (self)weakSelf = self;
    [self showhud];
    [DSNetWorkRequest postConectWithS:GETALLSSCDATA Parameter:dic Succeed:^(id result) {
        __strong typeof (weakSelf)strongSelf = weakSelf;
        [strongSelf hidehud];
        [strongSelf.tableView.mj_header endRefreshing];
        if (SSUCCESS(result)) {
            [strongSelf.modelList removeAllObjects];
            DSOpenAwardListModel * model = [DSOpenAwardListModel yy_modelWithJSON:result];
            for (DSOpenAwardModel * AwardModel in model.resultList) {
                [strongSelf.modelList addObject:AwardModel];
            }
            [strongSelf.tableView reloadData];
            /* 广告获取 */
            [strongSelf requestAdvert];
        }
    } Failure:^(NSError *failure) {
         __strong typeof (weakSelf)strongSelf = weakSelf;
        [strongSelf hidehud];
         [strongSelf.tableView.mj_header endRefreshing];
    }];
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
    if([[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"18"]!= nil){
        //头图广告位
        UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, IOS_SiZESCALE(147)+6)];
        DSAdvertView * advertView = [[DSAdvertView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, IOS_SiZESCALE(147))];
        self.tableView.tableHeaderView = headerView;
        advertView.backgroundColor = backColor;
        advertView.model = [[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"18"];
        [headerView addSubview:advertView];
    }
    //非空判断，要不然数组会崩溃
    if([[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"19"] != nil){
        //插入数组中的第5个位置放广告
        if (self.modelList.count > 5) {
            [self.modelList insertObject:[[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"19"]atIndex:5];
        }
        [self.tableView reloadData];
    }
    if([[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"20"] != nil){
        //最下面广告位
        UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, IOS_SiZESCALE(147)+6)];
        DSAdvertView * advertView = [[DSAdvertView alloc]initWithFrame:CGRectMake(0, 6, self.view.width, IOS_SiZESCALE(147))];
        self.tableView.tableFooterView = footView;
        advertView.backgroundColor = backColor;
        advertView.model = [[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"20"];
        [footView addSubview:advertView];
    }
}

#pragma mark - 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //广告位
    if ([[self.modelList[indexPath.row] class] isEqual:[DSHomeBannerModel class]]) {
        static NSString *cellStr = @"adCell";
        DSOpenAdvertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell ==nil) {
            cell = [[DSOpenAdvertTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        cell.model = self.modelList[indexPath.row];
        return cell;
    }else{
        static NSString *cellStr = @"cell";
        DSOpenAwardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell ==nil) {
            cell = [[DSOpenAwardTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.modelList[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //广告位
    if ([[self.modelList[indexPath.row] class] isEqual:[DSHomeBannerModel class]]) {
        return IOS_SiZESCALE(50);
    }else{
        DSOpenAwardModel * model = self.modelList[indexPath.row];
        NSArray *array = [model.openCode componentsSeparatedByString:@","];
        if(array.count > 10){
            return IOS_SiZESCALE(115);
        }
        return IOS_SiZESCALE(85);
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.modelList[indexPath.row] class] isEqual:[DSHomeBannerModel class]]) {
      DSHomeBannerModel * model=   self.modelList[indexPath.row];
        [DSFuntionTool openUrl:model.advertisUrl];
    }else{
        DSOpenAwardDetailsViewController * oepnAwardVC = [[DSOpenAwardDetailsViewController alloc]init];
        oepnAwardVC.hidesBottomBarWhenPushed = YES;
         DSOpenAwardModel * model = self.modelList[indexPath.row];
        oepnAwardVC.playGroupId = model.playGroupId;
        oepnAwardVC.playGroupName = model.playGroupName;
        [self.navigationController pushViewController:oepnAwardVC animated:YES];
    }
}

@end
