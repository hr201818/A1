//
//  LuckyLotteryView.m
//  Ticket
//
//  Created by pro on 2017/9/1.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "LuckyLotteryView.h"
#import "Header.h"
#import "luckBaseClass.h"
#import "BJhappyLeftView.h"
#import "luckNewRightView.h"
#import "lotteryNper.h"
#import "DSDrawingViewController.h"
#import "SerialLabel.h"
#import "luckHeaderView.h"
#import "luckView.h"
#import "nper.h"
@interface LuckyLotteryView ()<UITableViewDelegate,UITableViewDataSource>
{
    lotteryNper *n;
}
@property (nonatomic,copy)NSString *pageSize;
@property (nonatomic,copy) NSString *cacheKey;//缓存key
@property (nonatomic, strong) BJhappyLeftView *leftView;
@property (nonatomic, strong) luckNewRightView *rightView;
@property (nonatomic,strong)NSMutableArray *issueArr;//期号
@property (nonatomic,strong)NSMutableArray *resultsArr;//开奖结果
@property (nonatomic,strong)NSMutableArray *numberArr;//总次数
@property (nonatomic,strong)NSMutableArray *valuesArr;//平均遗漏值
@property (nonatomic,strong)NSMutableArray *maxValuesArr;//最大遗漏值
@property (nonatomic,strong)NSMutableArray *evenValueArr;//连出值
@end
@implementation LuckyLotteryView

-(id)initWithFrame:(CGRect)frame playGroupId:(NSString *)playGroupId contentArr:(NSMutableArray *)contentArr rightContentArr:(NSMutableArray *)rightContentArr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentArr = contentArr;
        self.rightContentArr =rightContentArr;
        self.cacheKey=[NSString stringWithFormat:@"playGroupId%@",playGroupId];
        __weak __typeof(self) weakSelf = self;
        self.nperTag = 0;
//        n = [[lotteryNper alloc]initWithFrame:CGRectMake(0,5, ScreenW, 40)];
//        n.backgroundColor =[UIColor whiteColor];
//        [self addSubview:n];
//        [n lotterNperBtnBlock:^(NSInteger btnTag) {
//             weakSelf.pageSize =  btnTag == 0 ? @"30": btnTag == 1 ? @"50":@"80";
//            if ([weakSelf.yyCache containsObjectForKey:weakSelf.cacheKey]==YES) {
//                [weakSelf.yyCache objectForKey:weakSelf.cacheKey withBlock:^(NSString * _Nonnull key, id object)
//                 {
//                     [weakSelf movementsParsing:object];
//                     //主线程刷新
//                     dispatch_async(dispatch_get_main_queue(), ^{
//                        [weakSelf reloadTableView];
//                         [weakSelf.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//                         UIScrollView *myScrollView = (UIScrollView *)[weakSelf.myTableView superview];
//                         myScrollView.contentOffset = CGPointMake(0, 0);
//                     });
//                 }];
//            }else{
////                [(TrendViewController *)[tool getCurrentViewController:weakSelf] requstDetail];
//            }
//        }];

        UILabel *classifyView = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(n.frame), 100, cellHeight*2/3)];
        classifyView.backgroundColor = backgColor;
        classifyView.textAlignment = NSTextAlignmentCenter;
        classifyView.font = [UIFont zkd_systemFontOfSize:14];
        classifyView.textColor = labelTextClor;
        classifyView.text = @"期号";
        [self addSubview:classifyView];

        _leftView = [[BJhappyLeftView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _leftView.backgroundColor = [UIColor orangeColor];
        [self addSubview:_leftView];
        _leftView.sd_layout.leftEqualToView(self).topSpaceToView(classifyView, 0).bottomEqualToView(self).widthIs(CGRectGetWidth(classifyView.frame));


        _myTableView =[[UITableView alloc]initWithFrame:self.frame style:UITableViewStylePlain];
        _myTableView.backgroundColor = self.backgroundColor;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.tableFooterView = [UIView new];
        _myTableView.allowsSelection = NO;
        _myTableView.bounces = NO;
        _myTableView.separatorColor = lineColor;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        _rightView = [[luckNewRightView alloc]init];
        _rightView.backgroundColor = [UIColor whiteColor];
        _rightView.contentArr = _rightContentArr;
        _rightView.playGroupId = self.playGroupId;

        UIScrollView *myScrollView=[[UIScrollView alloc]init];
        myScrollView.bounces=NO;
        myScrollView.contentSize=CGSizeMake(cellHeight/2 * 20, 0);

        [myScrollView addSubview: _myTableView];
        _myTableView.sd_layout.leftSpaceToView(myScrollView, 0).topSpaceToView(myScrollView, 0).widthIs(cellHeight/2 * _contentArr.count).bottomSpaceToView(myScrollView, 0);

        [myScrollView addSubview:_rightView];
        _rightView.sd_layout.leftSpaceToView(_myTableView, 0).topSpaceToView(myScrollView, 0).widthRatioToView(_myTableView, 1).bottomEqualToView(myScrollView);

        [self addSubview:myScrollView];

        myScrollView.sd_layout.leftSpaceToView(_leftView, 0).topEqualToView(classifyView).rightEqualToView(self).bottomSpaceToView(self, 45*kRatio);

        //  30 50 80期
        nper *n = [[nper alloc]initWithFrame:CGRectMake(0, PhoneScreen_HEIGHT - Navgationbar_HEIGHT - Tabbar_HEIGHT - 45 * kRatio, ScreenW, 45*kRatio) digital:self.nperTag];
        [n nperBtnBlock:^(NSInteger btnTag) {
            weakSelf.nperTag = btnTag;
            [n reloadButtonColor:btnTag];
            weakSelf.pageSize =  btnTag == 0 ? @"30": btnTag == 1 ? @"50":@"80";

            [(DSDrawingViewController *)[tool getCurrentViewController:weakSelf] requstDetail];

            
        }];
        [self addSubview:n];
        
        ////////

            __block NSMutableArray *issu = [NSMutableArray array];
            NSString *dat = [[[tool date] componentsSeparatedByString:@" "] firstObject];
            NSString *time = [dat stringByReplacingOccurrencesOfString:@"-" withString:@""];
            for (NSInteger i =1; i < 31; i++) {
                [issu addObject:[NSString stringWithFormat:@"%@%03ld",time,i]];
            }
            [issu addObject:@"出现总次数"];
            [issu addObject:@"平均遗漏值"];
            [issu addObject:@"最大遗漏值"];
            [issu addObject:@"最大连出值"];

            weakSelf.rightView.issueArr =   weakSelf.issueArr =  weakSelf.leftView.leftDataArray = issu;
            weakSelf.numberArr = weakSelf.evenValueArr = weakSelf.maxValuesArr= weakSelf.valuesArr = contentArr;
            weakSelf.rightView.numberArr = weakSelf.rightView.evenValueArr = weakSelf.rightView.maxValuesArr= weakSelf.rightView.valuesArr = _rightContentArr;
            [weakSelf reloadTableView];



    }
    return self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellStr = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.preservesSuperviewLayoutMargins = NO;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    while ([cell.contentView.subviews lastObject] != nil) {
        [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
    }

    luckView *luck = [[luckView alloc]initWithFrame:CGRectMake(0, 0, (cellHeight/2 * _contentArr.count), ScreenW) issue:_issueArr results:_resultsArr number:_numberArr values:_valuesArr maxValuesArr:_maxValuesArr evenValue:_evenValueArr listArr:_contentArr latticeWidth:cellHeight/2 latticeHight:cellHeight/2];
    [cell.contentView addSubview:luck];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return _issueArr.count*cellHeight/2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    luckHeaderView *header = [[luckHeaderView alloc]initWithFrame:CGRectMake(0, 0, _contentArr.count * (cellHeight/2), cellHeight*2/3) title:@"小区" content:_contentArr];
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return cellHeight*2/3;
}


//同步左侧右侧
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offsetY = _myTableView.contentOffset.y;

    CGPoint timeOffsetY = _leftView.leftTableView.contentOffset;

    timeOffsetY.y = offsetY;

    _rightView.myTableView.contentOffset = _leftView.leftTableView.contentOffset = timeOffsetY;

    if(offsetY == 0) {
        _rightView.myTableView.contentOffset =_leftView.leftTableView.contentOffset=CGPointZero;
        
    }
}

-(void)setPlayGroupId:(NSString *)playGroupId{
    _playGroupId = playGroupId;
    self.cacheKey=[NSString stringWithFormat:@"playGroupId%@",_playGroupId];
}

-(void)setNperTag:(NSInteger)nperTag{
    _nperTag = nperTag;
    _pageSize =  _nperTag == 0 ? @"30": _nperTag == 1 ? @"50":@"80";
    UIButton *btn = n.btnArr[_nperTag];
    for (UIButton *button in n.btnArr) {
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.backgroundColor =[UIColor whiteColor];
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 5.0f;
        button.layer.borderColor = [[UIColor grayColor] CGColor];
    }

    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor =navColor;
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 5.0f;
    btn.layer.borderColor = [navColor CGColor];

}
-(void)movementsParsing:(NSDictionary *)json{

    __weak __typeof(self) weakSelf = self;
    [luckBaseClass requstWithSuccess:json nper:[_pageSize integerValue] returnValue:^(NSMutableArray *issueArr, NSMutableArray *resultsArr, NSMutableArray *numberArr, NSMutableArray *valuesArr, NSMutableArray *maxValuesArr, NSMutableArray *evenValueArr) {

        weakSelf.issueArr =issueArr;
        weakSelf.resultsArr=resultsArr;
        weakSelf.numberArr = numberArr;
        weakSelf.valuesArr = valuesArr;
        weakSelf.maxValuesArr = maxValuesArr;
        weakSelf.evenValueArr = evenValueArr;
        weakSelf.leftView.leftDataArray = issueArr;

        weakSelf.rightView.issueArr = issueArr;

        weakSelf.rightView.resultsArr = resultsArr;

        weakSelf.rightView.numberArr = [NSMutableArray arrayWithArray:[numberArr subarrayWithRange:NSMakeRange(_contentArr.count, _rightContentArr.count)]];

        weakSelf.rightView.valuesArr = [NSMutableArray arrayWithArray:[valuesArr subarrayWithRange:NSMakeRange(_contentArr.count, _rightContentArr.count)]];

        weakSelf.rightView.maxValuesArr = [NSMutableArray arrayWithArray:[maxValuesArr subarrayWithRange:NSMakeRange(_contentArr.count, _rightContentArr.count)]];

        weakSelf.rightView.evenValueArr =[NSMutableArray arrayWithArray:[evenValueArr subarrayWithRange:NSMakeRange(_contentArr.count, _rightContentArr.count)]] ;
    }];

}
-(void)reloadTableView{
    [self.myTableView reloadData];
    [self.leftView.leftTableView reloadData];
    [self.rightView.myTableView reloadData];
}

@end
