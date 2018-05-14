//
//  DSLotteryListViewController.m
//  DS_lottery
//
//  Created by pro on 2018/4/24.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSLotteryListViewController.h"
#import "DSLotteryListTableViewCell.h"
#import "DSLotteryModel.h"
@interface DSLotteryListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView    * tableView;

@property (strong, nonatomic) NSMutableArray * listArray;

@end

@implementation DSLotteryListViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _listArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    self.title = @"彩种选择";

    [self navLeftItem:[DSFuntionTool leftNavBackTarget:self Item:@selector(backAction)]];

    //加载本地数据
    [self loadData];
    //视图布局
    [self layoutView];
}

/* 加载数据 */
-(void)loadData{
    //获取彩种资源文件
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"homeLotteryList" ofType:@"plist"];
    NSMutableArray * arr = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    for (NSDictionary * dic in arr) {
        DSLotteryModel * model = [DSLotteryModel yy_modelWithJSON:dic];
        [self.listArray addObject:model];
    }
}

/* 视图布局 */
-(void)layoutView{

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Navgationbar_HEIGHT, self.view.width, PhoneScreen_HEIGHT - Tabbarbottom_HEIGHT - Navgationbar_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark - 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cell";
    DSLotteryListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell ==nil) {
        cell = [[DSLotteryListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    DSLotteryModel * model = self.listArray[indexPath.row];
    [cell loadDataTitle:model.name typeImg:model.icon];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DSLotteryModel * model = self.listArray[indexPath.row];
    if (self.lotteryIDBlock) {
        self.lotteryIDBlock(model.type,model.name);
    }
    [self backAction];
}

#pragma mark - 点击事件
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
