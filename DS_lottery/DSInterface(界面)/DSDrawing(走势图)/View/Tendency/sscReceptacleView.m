//
//  sscReceptacleView.m
//  Ticket
//
//  Created by pro on 2017/9/1.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "sscReceptacleView.h"
#import "Header.h"
#import "sscList.h"
#import "nearlyThreeList.h"
#import "shshicai.h"
#import "nearlyThreeHeader.h"
#import "sscBaseClass.h"
#import "headerList.h"
#import "DSDrawingViewController.h"
#import "nper.h"
@interface sscReceptacleView ()<UITableViewDelegate,UITableViewDataSource,SGPageTitleViewDelegate, SGPageContentViewDelegate>
{
   
    NSString *_pageSize;//期数
   
   
}
@property (nonatomic,strong)NSMutableArray *issueArr;//期号
@property (nonatomic,strong)NSMutableArray *resultsArr;//开奖结果
@property (nonatomic,strong)NSMutableArray *numberArr;//总次数
@property (nonatomic,strong)NSMutableArray *valuesArr;//平均遗漏值
@property (nonatomic,strong)NSMutableArray *maxValuesArr;//最大遗漏值
@property (nonatomic,strong)NSMutableArray *evenValueArr;//连出值

@property (nonatomic,copy)NSString *cacheKey;

@property (nonatomic,strong)NSURLSessionDataTask *dataTask;
//@property (nonatomic,strong) YYCache *yyCache;//缓存
@end

@implementation sscReceptacleView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _issueArr = [[NSMutableArray alloc]initWithCapacity:0];
        _resultsArr = [[NSMutableArray alloc]initWithCapacity:0];
        _numberArr = [[NSMutableArray alloc]initWithCapacity:0];
        _valuesArr = [[NSMutableArray alloc]initWithCapacity:0];
        _maxValuesArr = [[NSMutableArray alloc]initWithCapacity:0];
        _evenValueArr = [[NSMutableArray alloc]initWithCapacity:0];
        _contentArr = [[NSMutableArray alloc]initWithCapacity:0];

        _digital = @"0";
//        self.playGroupId = @"1";
        self.nperTag =0;

        


        _myTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, self.height) style:UITableViewStylePlain];
        _myTableView.backgroundColor = self.backgroundColor;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.tableFooterView = [UIView new];
        _myTableView.bounces = NO;
        _myTableView.separatorColor = lineColor;
        [self addSubview:_myTableView];


    }
    return self;
}
-(void)setContentArr:(NSMutableArray *)contentArr{
    _contentArr = contentArr;
        [_issueArr removeAllObjects];
        [_numberArr removeAllObjects];
        [_evenValueArr removeAllObjects];
        [_maxValuesArr removeAllObjects];
        [_valuesArr removeAllObjects];
        NSString *dat = [[[tool date] componentsSeparatedByString:@" "] firstObject];
        NSString *time = [dat stringByReplacingOccurrencesOfString:@"-" withString:@""];
        for (NSInteger i =1; i < 31; i++) {
            [_issueArr addObject:[NSString stringWithFormat:@"%@%03ld",time,i]];
        }

        for (NSString *list in _contentArr) {
            NSInteger i = [_contentArr indexOfObject:list];
            [_numberArr addObject:@{@(i):@(0)}];
            [_evenValueArr addObject:@{@(i):@(0)}];
            [_maxValuesArr addObject:@{@(i):@(0)}];
            [_valuesArr addObject:@{@(i):@(0)}];
        }

        [_issueArr addObject:@"出现总次数"];
        [_issueArr addObject:@"平均遗漏值"];
        [_issueArr addObject:@"最大遗漏值"];
        [_issueArr addObject:@"最大连出值"];
        [_myTableView reloadData];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellStr = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    while ([cell.contentView.subviews lastObject] != nil) {
        [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    if ([_playGroupId integerValue]==1||[_playGroupId integerValue]==2||[_playGroupId integerValue]==3||[_playGroupId integerValue]==4||[_playGroupId integerValue]==5||[_playGroupId integerValue]==13||[_playGroupId integerValue]==15||[_playGroupId integerValue]==16||[_playGroupId integerValue]==17||[_playGroupId integerValue]==9||[_playGroupId integerValue]==14||[_playGroupId integerValue]==23||[_playGroupId integerValue]==24){

        sscList *cha = [[sscList alloc]initWithFrame:CGRectMake(0, 10, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) issue:_issueArr results:_resultsArr number:_numberArr values:_valuesArr maxValuesArr:_maxValuesArr evenValue:_evenValueArr listArr:_contentArr];
        [cell.contentView addSubview:cha];

    }else if ([_playGroupId integerValue]==18||[_playGroupId integerValue]==19||[_playGroupId integerValue]==20||[_playGroupId integerValue]==21){
        
        // 快3
        nearlyThreeList *cha = [[nearlyThreeList alloc]initWithFrame:CGRectMake(0, 10, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) issue:_issueArr results:_resultsArr number:_numberArr values:_valuesArr maxValuesArr:_maxValuesArr evenValue:_evenValueArr listArr:_contentArr];
        [cell.contentView addSubview:cha];

    }    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _issueArr.count*(_contentArr.count > 10 ? syxwWidth:sscWidth) + 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return (_contentArr.count > 10 ? syxwWidth:sscWidth)+40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, (_contentArr.count > 10 ? syxwWidth:sscWidth)+40+40)];
    view.backgroundColor = [UIColor whiteColor];

    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.bottomSeparatorColor = [UIColor clearColor];
    configure.indicatorAdditionalWidth = 100;
    configure.titleFont = [UIFont systemFontOfSize:13];
    configure.titleColor = COLORFont53;
    configure.indicatorAnimationTime = 0;
    configure.titleSelectedColor = COLOR_HOME;
    configure.indicatorColor = COLOR_HOME;
    configure.titleSelectedFont = [UIFont systemFontOfSize:13];
    SGPageTitleView * pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 50) delegate:self titleNames:_titleArray configure:configure];
    pageTitleView.selectedIndex = [_digital integerValue];
    pageTitleView.isDelegate = NO;
    pageTitleView.backgroundColor = [UIColor whiteColor];
    [view addSubview:pageTitleView];
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = COLOR(210, 210, 210);
    [pageTitleView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.bottom.equalTo(@0);
        make.height.equalTo(@0.5);
    }];


//    __weak typeof (self)weakSelf = self;
//    shshicai *ss = [[shshicai alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 40) digital:[_digital integerValue] nperTag:_nperTag title:_titleArray];
//    ss.backgroundColor = [UIColor whiteColor];
//    [view addSubview:ss];
//
//    [ss btnBlock:^(NSInteger btnTag) {
//        _digital = [NSString stringWithFormat:@"%ld",btnTag];
//        weakSelf.nperTag = 0;
//            [(DSDrawingViewController *)[tool getCurrentViewController:weakSelf] requstDetail];
//    }];
    if ([_playGroupId integerValue]==18||[_playGroupId integerValue]==19||[_playGroupId integerValue]==20||[_playGroupId integerValue]==21) {

        nearlyThreeHeader *v = [[nearlyThreeHeader alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(pageTitleView.frame), [[UIScreen mainScreen] bounds].size.width, (_contentArr.count > 10 ? syxwWidth:sscWidth)) list:_contentArr];
        v.backgroundColor = [UIColor whiteColor];
        [view addSubview:v];

    }else{

        headerList *v = [[headerList alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(pageTitleView.frame), [[UIScreen mainScreen] bounds].size.width, (_contentArr.count > 10 ? syxwWidth:sscWidth)) list:_contentArr];
        [view addSubview:v];
    }
    return view;
}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex{
    _digital = [NSString stringWithFormat:@"%ld",selectedIndex];
    self.nperTag = 0;
    [(DSDrawingViewController *)[tool getCurrentViewController:self] requstDetail];
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    nper *n = [[nper alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 35) digital:self.nperTag];

    __weak typeof(self)weakSelf = self;
    
    [n nperBtnBlock:^(NSInteger btnTag) {
        weakSelf.nperTag = btnTag;
            [(DSDrawingViewController *)[tool getCurrentViewController:weakSelf] requstDetail];
    }];
    return n;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 45*kRatio;
}

-(void)setPlayGroupId:(NSString *)playGroupId{
    _playGroupId = playGroupId;
}
-(void)setNperTag:(NSInteger)nperTag{
    _nperTag = nperTag;
    _pageSize =  _nperTag == 0 ? @"30": _nperTag == 1 ? @"50":@"80";
}
-(void)movementsParsing:(NSDictionary *)json{

    __weak __typeof(self) weakSelf = self;
    if ([tool arrIsNull:weakSelf.contentArr]==YES) {
        [sscBaseClass requstWithSuccess:json numberLength:_contentArr location:[_digital integerValue] nper:[_pageSize integerValue] returnValue:^(NSMutableArray *issueArr, NSMutableArray *resultsArr, NSMutableArray *numberArr, NSMutableArray *valuesArr, NSMutableArray *maxValuesArr, NSMutableArray *evenValueArr) {
            weakSelf.issueArr =issueArr;
            [weakSelf.issueArr addObject:@"出现总次数"];
            [weakSelf.issueArr addObject:@"平均遗漏值"];
            [weakSelf.issueArr addObject:@"最大遗漏值"];
            [weakSelf.issueArr addObject:@"最大连出值"];
            weakSelf.resultsArr=resultsArr;
            weakSelf.numberArr = numberArr;
            weakSelf.valuesArr = valuesArr;
            weakSelf.maxValuesArr = maxValuesArr;
            weakSelf.evenValueArr = evenValueArr;
        }];
    }
}

@end
