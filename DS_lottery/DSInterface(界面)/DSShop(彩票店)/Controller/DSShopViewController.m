//
//  DSShopViewController.m
//  DS_lottery
//
//  Created by pro on 2018/4/8.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSShopViewController.h"
#import "DSOpenAwardViewController.h"
#import "DSShopTableViewCell.h"
#import "DSAdvertTableViewCell.h"
#import "DSAdvertView.h"
#import "DSMapViewController.h"
@interface DSShopViewController ()<SGPageTitleViewDelegate, SGPageContentViewDelegate,AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView       * tableView;
/* 选项条 */
@property (nonatomic, strong) SGPageTitleView   * pageTitleView;
/* 选项条标题数组 */
@property (nonatomic, strong) NSArray           * titleArr;
/* 高德地图搜索类 */
@property (nonatomic, strong) AMapSearchAPI     * search;
/* 高德地图搜索条件 */
@property (nonatomic, strong) AMapPOIKeywordsSearchRequest *request;
@property (nonatomic, strong) AMapPOIKeywordsSearchRequest *requestMore;
/* 存放地图点模型数组 */
@property (nonatomic, strong) NSMutableArray    * response;
/* 分页 */
@property (nonatomic, assign) NSInteger           page;
/* 记录当前的城市名称 */
@property (nonatomic,copy)    NSString          * city;
@end

@implementation DSShopViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _response = [[NSMutableArray alloc]init];
        _titleArr = [[NSMutableArray alloc]init];
        _page = 1;
        _city = @"武汉";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"连锁彩店";
    //视图布局
    [self layoutView];

}

/* 视图布局 */
-(void)layoutView{

    //选项条
    self.titleArr = @[@"武汉", @"北京", @"上海", @"广州", @"成都"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.bottomSeparatorColor = [UIColor clearColor];
    configure.titleFont = [UIFont systemFontOfSize:16];
    configure.titleColor = COLORFont121;
    configure.titleSelectedColor = COLOR_HOME;
    configure.indicatorColor = COLOR_HOME;
    configure.indicatorAnimationTime = 0.1;
    configure.titleSelectedFont = [UIFont systemFontOfSize:17];
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, Navgationbar_HEIGHT, self.view.width, 44) delegate:self titleNames:self.titleArr configure:configure];
    self.pageTitleView.backgroundColor = backColor;
    [self.view addSubview:self.pageTitleView];


    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,Navgationbar_HEIGHT + 44, self.view.width, PhoneScreen_HEIGHT - Navgationbar_HEIGHT - Tabbar_HEIGHT - 44) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    __weak typeof (self)weakSelf = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page =1;
        [weakSelf requestData];
    }];
    //加载
    self.tableView.mj_footer =  [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestDataMore];
    }];
}

#pragma mark - 网络请求
/*刷新*/
-(void)requestData{
    //搜索城市彩票点
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    self.request = [[AMapPOIKeywordsSearchRequest alloc] init];
    self.request.requireExtension    = YES;
    self.request.cityLimit           = YES;
    self.request.requireSubPOIs      = YES;
    self.request.keywords            = @"投注站";
    self.request.offset              = 10;
    self.request.page                = self.page;
    self.request.city = self.city;
    [self.search AMapPOIKeywordsSearch:self.request];
}

/*加载更多 */
-(void)requestDataMore{
    //搜索城市彩票点
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    self.requestMore = [[AMapPOIKeywordsSearchRequest alloc] init];
    self.requestMore.requireExtension    = YES;
    self.requestMore.cityLimit           = YES;
    self.requestMore.requireSubPOIs      = YES;
    self.requestMore.keywords            = @"投注站";
    self.requestMore.offset              = 10;
    self.requestMore.page                = self.page+1;
    self.requestMore.city = self.city;
    [self.search AMapPOIKeywordsSearch:self.requestMore];
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
//    //非空判断，不然数组会崩溃
//    if([[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"26"] != nil){
//        //插入数组中的第5个位置放广告
//        if (self.response.count > 5) {
//            [self.response insertObject:[[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"26"]atIndex:5];
//        }else{
//            [self.response insertObject:[[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"26"]atIndex:0];
//        }
//        [self.tableView reloadData];
//    }
}


#pragma mark - 代理
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    self.city = self.titleArr[selectedIndex];
    self.page = 1;
    [self showhud];
    [self requestData];

}

/* 获得城市的彩票店信息 */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    [self hidehud];
    if(request == self.request){
        [self.tableView.mj_header endRefreshing];
        self.tableView.mj_footer.state = MJRefreshStateIdle;
        if (response.pois.count == 0)
        {
            return;
        }
        [self.response removeAllObjects];
        for (int i= 0; i < response.pois.count; i++) {
            AMapPOI * model =  response.pois[i];
            [self.response addObject:model];
        }
        [self.tableView reloadData];
        /* 请求广告 */
        [self requestAdvert];
    }else{
        if (response.pois.count == 0)
        {
            self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
            return;
        }
        [self.tableView.mj_footer endRefreshing];
        for (int i= 0; i < response.pois.count; i++) {
            AMapPOI * model =  response.pois[i];
            [self.response addObject:model];
        }
        self.page++;
        [self.tableView reloadData];
    }
}
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    [self hidehud];
    [self hudErrorText:@"请求发生错误"];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];

}

#pragma mark - 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.response.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //广告位
    if ([[self.response[indexPath.row] class] isEqual:[DSHomeBannerModel class]]) {
        static NSString *cellStr = @"adCell";
        DSAdvertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell ==nil) {
            cell = [[DSAdvertTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        cell.AdvertView.top = 0;
        cell.model = self.response[indexPath.row];
        return cell;
    }else{
        static NSString *cellStr = @"cell";
        DSShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell ==nil) {
            cell = [[DSShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        cell.model = self.response[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.response[indexPath.row] class] isEqual:[DSHomeBannerModel class]]) {
        return IOS_SiZESCALE(147);
    }else{
        return 78;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([[self.response[indexPath.row] class] isEqual:[DSHomeBannerModel class]]) {

    }else{
        AMapPOI * model = self.response[indexPath.row];
        NSString * imgUrl = @"";
        if(model.images.count){
            AMapImage * img = [model.images firstObject];
            imgUrl = img.url;
        }
        DSMapViewController * mapView = [[DSMapViewController alloc]init];
        mapView.hidesBottomBarWhenPushed = YES;
        mapView.imageUrl = imgUrl;
        mapView.longitude = model.location.longitude;
        mapView.latitude = model.location.latitude;
        mapView.typeName = model.name;
        [self.navigationController pushViewController:mapView animated:YES];
    }
}

#pragma mark - 点击事件
-(void)btnAction{

}

@end
