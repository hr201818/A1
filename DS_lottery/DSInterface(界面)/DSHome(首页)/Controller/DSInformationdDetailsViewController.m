//
//  DSInformationdDetailsViewController.m
//  DS_lottery
//
//  Created by pro on 2018/4/24.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSInformationdDetailsViewController.h"
#import "DSInfomationDetailsHeaderView.h"
#import "DSAdvertTableViewCell.h"
#import "DSInfoWebTableViewCell.h"

@interface DSInformationdDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView * tableView;

/* webView返回的高 */
@property (assign, nonatomic) NSInteger     webHeight;

@end

@implementation DSInformationdDetailsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webHeight = 0;
    /* 视图布局 */
    [self layoutView];
}

-(void)layoutView{
    //首页列表
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Navgationbar_HEIGHT, PhoneScreen_WIDTH, PhoneScreen_HEIGHT - Navgationbar_HEIGHT - Tabbar_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.tableView];

    //头标题
    DSInfomationDetailsHeaderView * headerView = [[DSInfomationDetailsHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 68) model:self.model];
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellStr = @"advertCell";
        DSAdvertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell ==nil) {
            cell = [[DSAdvertTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        if([DSAdvertSingleData initAdvertData].model.list.count){
            cell.model = [[DSAdvertSingleData initAdvertData].model.list firstObject];
        }
        return cell;
    }else if(indexPath.section == 1){
        static NSString *cellStr = @"webCell";
        DSInfoWebTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell ==nil) {
            cell = [[DSInfoWebTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        cell.webContent = self.model.content;
        __weak typeof (self)weakSelf = self;
        cell.webBlock = ^(CGFloat webHeight) {
            weakSelf.webHeight = webHeight;
            [weakSelf.tableView reloadData];
        };
        return cell;
    }else{
        static NSString *cellStr = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell ==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return IOS_SiZESCALE(147)+10;
    }else if(indexPath.section == 1){
        return  self.webHeight;
    }
    return 46;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
