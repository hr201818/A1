//
//  DSUserViewController.m
//  DS_lottery
//
//  Created by pro on 2018/4/8.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSUserViewController.h"
#import "DSUserCentreTableViewCell.h"
#import "DSLoginViewController.h"
#import "DSAdvertTableViewCell.h"
#import "DSKefuViewController.h"
#import "DSLawViewController.h"
#import "DSAboutViewController.h"
#import "DSUserFuntionModel.h"
@interface DSUserViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView    * tableView;
/* 个人中心功能 */
@property (strong, nonatomic) NSMutableArray * modelList;
/* 登录注册按钮 */
@property (strong, nonatomic) UIButton       * loginBtn;
/* 存放广告的数组 */
@property (strong, nonatomic) NSMutableArray * advertArray;
/* 登录后的用户信息 */
@property (strong, nonatomic) UILabel        * userText;
/* 用户头像 */
@property (strong, nonatomic) UIImageView    * headerImg;
/*右边退出登录按钮*/
@property (strong, nonatomic) UIButton * rightQuitLogin;
@end

@implementation DSUserViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _advertArray = [[NSMutableArray alloc]init];
        _modelList = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";

    self.navBar.backgroundColor = [UIColor clearColor];
    self.navBarImg.hidden = YES;
    self.view.backgroundColor = backColor;
    //个人中心功能配置
    [self configData];
    //视图布局
    [self layoutView];
    //广告数据请求
    [self requestAdvert];
    //接收登录注销通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginNotication) name:LOGIN_NOTICATION object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(signOutNotication) name:SIGNOUT object:nil];
}

-(void)configData{
    NSMutableArray * funtionArray = [NSMutableArray arrayWithObjects:@"版本",@"清除缓存",@"关于我们",@"联系我们", nil];
    NSMutableArray * iamgeArray = [NSMutableArray arrayWithObjects:@"ico-edition.png",@"ico-delete.png",@"ico-about.png",@"ico-contact.png",nil];
     NSMutableArray * contentArray = [NSMutableArray arrayWithObjects:@"V1.0",@"清除缓存更健康",@"了解我们",@"美女客服7*24小时在线",nil];
//    if ([DSUserInfoData initUserInfoData].lawModel!= nil &&[[DSUserInfoData initUserInfoData].lawModel.lawIsShow integerValue] == 1) {
//        [funtionArray insertObject:@"法律声明" atIndex:3];
//        [iamgeArray insertObject:@"ico-about.png" atIndex:3];
//        [contentArray insertObject:@"请勿触犯法律" atIndex:3];
//    }
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (int i = 0; i < funtionArray.count; i++) {
        DSUserFuntionModel * model = [[DSUserFuntionModel alloc]init];
        model.tilteName = funtionArray[i];
        model.imageName = iamgeArray[i];
        model.content = contentArray[i];
        [arr addObject:model];
        if((i+1)%2 == 0 && i != funtionArray.count - 1){
            [self.modelList addObject:arr];
            arr = [[NSMutableArray array]init];
        }else if(i == funtionArray.count - 1){
            [self.modelList addObject:arr];
        }
    }
}

#pragma mark - 视图布局
-(void)layoutView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = backColor;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(@0);
        make.height.equalTo(@(PhoneScreen_HEIGHT - Tabbar_HEIGHT));
        make.top.equalTo(@(0));
    }];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, IOS_SiZESCALE(195) + navgation_top)];
    headerView.backgroundColor = backColor;
    self.tableView.tableHeaderView = headerView;

    //背景橙图
    UIImageView * topImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, IOS_SiZESCALE(64))];
    [topImg setImage:[UIImage imageNamed:@"navbar"]];
    [headerView addSubview:topImg];
    UIImageView * botImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, IOS_SiZESCALE(64), self.view.width, IOS_SiZESCALE(113))];
    [botImg setImage:[UIImage imageNamed:@"userTop"]];
    [headerView addSubview:botImg];

    UIView * userbackView = [[UIView alloc]init];
    userbackView.backgroundColor = [UIColor whiteColor];
    userbackView.layer.masksToBounds = YES;
    userbackView.layer.cornerRadius = IOS_SiZESCALE(55);
    [headerView addSubview:userbackView];
    [userbackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-13));
        make.left.equalTo(@(IOS_SiZESCALE(10)));
        make.right.equalTo(@(-10));
        make.height.equalTo(@(IOS_SiZESCALE(110)));
    }];

    //用户头像
    self.headerImg = [[UIImageView alloc]init];
    [self.headerImg setImage:[UIImage imageNamed:@"header-1"]];
    [userbackView addSubview:self.headerImg];
    [self.headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(65));
        make.height.equalTo(@(65));
        make.centerY.equalTo(userbackView.mas_centerY);
        make.left.equalTo(@(IOS_SiZESCALE(25)));
    }];
    self.headerImg.hidden = YES;

//    //分享按钮
//    UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
//    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    shareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [self.navBar addSubview:shareBtn];
//    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@80);
//        make.height.equalTo(@32);
//        make.centerY.equalTo(@10);
//        make.right.equalTo(@(-10));
//    }];
//    //分享图片
//    UIImageView * shareImg = [[UIImageView alloc]init];
//    [shareImg setImage:[UIImage imageNamed:@"fenx.png"]];
//    [self.navBar addSubview:shareImg];
//    [shareImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(@(-40));
//        make.width.and.height.equalTo(@30);
//        make.centerY.equalTo(shareBtn.mas_centerY);
//    }];

    //登录注册按钮
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.backgroundColor = COLOR_HOME;
    [self.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 5;
    [userbackView addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@95);
        make.centerY.equalTo(@0);
        make.height.equalTo(@35);
        make.centerX.equalTo(@0);
    }];

    //退出登录按钮
    self.rightQuitLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightQuitLogin.frame = CGRectMake(0, 0, 70, 30);
    [self.rightQuitLogin setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.rightQuitLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightQuitLogin.titleLabel.font = [UIFont systemFontOfSize:15];
    [self navRightItem:self.rightQuitLogin];
    [self.rightQuitLogin addTarget:self action:@selector(requestWriteOff) forControlEvents:UIControlEventTouchUpInside];
    self.rightQuitLogin.hidden = YES;


    self.userText = [[UILabel alloc]init];
    self.userText.font = [UIFont systemFontOfSize:14 * fontsize];
    self.userText.textColor = COLORFont83;
    self.userText.textAlignment = NSTextAlignmentLeft;
    [userbackView addSubview:self.userText];
    [self.userText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(260));
        make.left.equalTo(self.headerImg.mas_right).offset(15);
        make.height.equalTo(@25);
        make.centerY.equalTo(@0);
    }];
    //判断登录状态
    [self userLoginState];
}

#pragma mark- 网络请求
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
    //非空判断，不然数组会闪退
    if ([[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"22"] != nil) {
        [self.advertArray addObject:[[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"22"]];
    }
    if([[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"23"] != nil){
        [self.advertArray addObject:[[DSAdvertSingleData initAdvertData] searchAdvertLocationID:@"23"]];
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

/* 退出登录 */
-(void)requestWriteOff{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出登录吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return self.advertArray.count;
    }
    return self.modelList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellStr = @"cell";
        DSUserCentreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell ==nil) {
            cell = [[DSUserCentreTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        cell.array = self.modelList[indexPath.row];
        __weak typeof (self)weakSelf = self;
        cell.cellSelectContent = ^(NSString *titleName) {
            [weakSelf cellCilckActionTitleName:titleName];
        };
        return cell;
    }else{
        static NSString *cellStr = @"advertCell1";
        DSAdvertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell ==nil) {
            cell = [[DSAdvertTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        if(indexPath.row == 0){
            cell.AdvertView.top = 12;
        }else{
             cell.AdvertView.top = 6;
        }
          cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.advertArray[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return IOS_SiZESCALE(95);
    }
    if (indexPath.row == 0) {
        return IOS_SiZESCALE(147)+12;
    }
    return IOS_SiZESCALE(147)+6;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {

    }else{

    }
}


/* 登录 */
-(void)loginAction{
    if ([self.loginBtn.titleLabel.text isEqualToString:@"退出登录"]) {
        [self requestWriteOff];
    }else{
        DSLoginViewController * loginVC = [[DSLoginViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

/* 登录后通知接收 */
-(void)loginNotication{
    [self userLoginState];
}

/* 注销后通知接收 */
-(void)signOutNotication{
    [self userLoginState];
}
/* 判断登录状态 */
-(void)userLoginState{
    //判断是否登录
    if([DSUserInfoData initUserInfoData].userId){
        self.headerImg.hidden = NO;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"尊敬的会员 %@ 欢迎光临!",[DSUserInfoData initUserInfoData].userId]];
        NSRange strRange = {6,[[DSUserInfoData initUserInfoData].userId length]};
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:COLOR(44, 193, 247)
                                 range:strRange];
        self.userText.attributedText = attributedString;
       [self.loginBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        self.loginBtn.hidden = YES;
        self.rightQuitLogin.hidden = NO;
    }else{
        self.headerImg.hidden = YES;
        self.userText.text = @"";
         self.loginBtn.hidden = NO;
        self.rightQuitLogin.hidden = YES;
        [self.loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
    }
}

//选中的功能
-(void)cellCilckActionTitleName:(NSString *)titleName{
    if ([titleName isEqualToString:@"联系我们"]) {
        DSKefuViewController * kefuVC = [[DSKefuViewController alloc]init];
        kefuVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:kefuVC animated:YES];
    }else if([titleName isEqualToString:@"关于我们"]){
        DSAboutViewController * AboutVC = [[DSAboutViewController alloc]init];
        AboutVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:AboutVC animated:YES];
    }else if([titleName isEqualToString:@"版本"]){

    }else if([titleName isEqualToString:@"法律声明"]){
        DSLawViewController * lawVC = [[DSLawViewController alloc]init];
        lawVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:lawVC animated:YES];
    }else if([titleName isEqualToString:@"清除缓存"]){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"当前有%.2fM缓存,确定要清除吗？",[DSFuntionTool readCacheSize]] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [DSFuntionTool clearFile];
            [self hudSuccessText:@"清理成功"];
            [self.tableView reloadData];
        }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }];
        [alert addAction:defaultAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
