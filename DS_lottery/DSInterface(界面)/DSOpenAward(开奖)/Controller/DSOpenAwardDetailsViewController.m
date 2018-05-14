//
//  DSOpenAwardDetailsViewController.m
//  DS_lottery
//
//  Created by pro on 2018/4/25.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSOpenAwardDetailsViewController.h"
#import "DSAdvertTableViewCell.h"
#import "DSOpenAwardListModel.h"
#import "DSOpenAwardTableViewCell.h"
#import "DSOpenAdvertTableViewCell.h"
@interface DSOpenAwardDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView * tableView;

@property (strong, nonatomic) NSMutableArray * listModel;

@end

@implementation DSOpenAwardDetailsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _listModel = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开奖公告详情";
    [self navLeftItem:[DSFuntionTool leftNavBackTarget:self Item:@selector(leftBackAction)]];
    //布局视图
    [self layoutView];

    //请求开奖信息
    [self requestAwardList];

}

-(void)layoutView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Navgationbar_HEIGHT, PhoneScreen_WIDTH, PhoneScreen_HEIGHT - Navgationbar_HEIGHT - Tabbarbottom_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.tableView];
    //刷新
    __weak typeof (self)weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestAwardList];
    }];
}

#pragma mark - 网络请求
/* 获得开奖详情列表 */
-(void)requestAwardList{
    __weak typeof (self)weakSelf = self;
     NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:CLIENTTYPE forKey:@"clientType"];
    [dic setValue:APPVERSION forKey:@"appVersion"];
    [dic setValue:COMPANYSHORTNAME forKey:@"companyShortName"];
    [dic setValue:self.playGroupId forKey:@"playGroupId"];
    [self showhud];
    [DSNetWorkRequest postConectWithS:GETSSCTIMEDATA Parameter:dic Succeed:^(id result) {
        __strong typeof (weakSelf)strongSelf = weakSelf;
        [strongSelf hidehud];
        [strongSelf.tableView.mj_header endRefreshing];
        if (SSUCCESS(result)) {
            [strongSelf.listModel removeAllObjects];
            for (NSDictionary * dic in [result objectForKey:@"sscHistoryList"]) {
                DSOpenAwardModel * model = [DSOpenAwardModel yy_modelWithJSON:dic];
                model.playGroupName = [result objectForKey:@"playGroupName"];
                [strongSelf.listModel addObject:model];
            }
            [strongSelf.tableView reloadData];
            //获取广告
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
    if([[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"36"]!= nil){
        //头图广告位
        DSAdvertView * advertView = [[DSAdvertView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 147)];
        self.tableView.tableHeaderView = advertView;
        advertView.backgroundColor = backColor;
        advertView.model = [[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"36"];
    }
    //非空判断，要不然数组会崩溃
    if([[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"37"] != nil){
        //插入数组中的第5个位置放广告
        if(self.listModel.count>4){
            [self.listModel insertObject:[[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"37"]atIndex:5];
            [self.tableView reloadData];
        }else{
            [self.listModel insertObject:[[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"37"]atIndex:self.listModel.count];
            [self.tableView reloadData];
        }
    }
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
//    //广告位
    if ([[self.listModel[indexPath.row] class] isEqual:[DSHomeBannerModel class]]) {
        static NSString *cellStr = @"adCell";
        DSOpenAdvertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell ==nil) {
            cell = [[DSOpenAdvertTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        cell.model = self.listModel[indexPath.row];
        return cell;
    }else{
        static NSString *cellStr = @"cell";
        DSOpenAwardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell ==nil) {
            cell = [[DSOpenAwardTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.listModel[indexPath.row];
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //广告位
    if ([[self.listModel[indexPath.row] class] isEqual:[DSHomeBannerModel class]]) {
        return IOS_SiZESCALE(50);
    }else{
        DSOpenAwardModel * model = self.listModel[indexPath.row];
        NSArray *array = [model.openCode componentsSeparatedByString:@","];
        if(array.count > 10){
            return IOS_SiZESCALE(115);
        }
        return IOS_SiZESCALE(85);
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 点击事件
-(void)leftBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
